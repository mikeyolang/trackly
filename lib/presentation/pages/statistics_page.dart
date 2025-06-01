import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trackly/domain/entities/visit.dart';
import 'package:trackly/presentation/providers/visits_provider.dart';
import 'package:intl/intl.dart';

class StatisticsPage extends ConsumerStatefulWidget {
  const StatisticsPage({super.key});

  @override
  ConsumerState<StatisticsPage> createState() => _StatisticsPageState();
}

class _StatisticsPageState extends ConsumerState<StatisticsPage>
    with TickerProviderStateMixin {
  bool _showBarChart = true;
  String _selectedPeriod = 'month';
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final visitsAsync = ref.watch(visitsNotifierProvider);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? const Color(0xFF0A0A0B) : const Color(0xFFF8FAFC),
      body: CustomScrollView(
        slivers: [
          // Modern App Bar
          SliverAppBar(
            floating: false,
            pinned: true,

            automaticallyImplyLeading: false,
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              title: Container(
                margin: const EdgeInsets.only(left: 20, bottom: 3),
                child: Text(
                  'Analytics',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      theme.colorScheme.primary.withOpacity(0.1),
                      theme.colorScheme.secondary.withOpacity(0.05),
                    ],
                  ),
                ),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      _showBarChart
                          ? Icons.donut_small_rounded
                          : Icons.bar_chart_rounded,
                      key: ValueKey(_showBarChart),
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  onPressed: () {
                    setState(() => _showBarChart = !_showBarChart);
                    _animationController.reset();
                    _animationController.forward();
                  },
                  tooltip: 'Switch Chart Type',
                ),
              ),
            ],
          ),

          // Content
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Modern Period Selection
                    _buildPeriodSelector(theme),
                    const SizedBox(height: 10),

                    // Charts and Content
                    visitsAsync.when(
                      data: (visits) => _buildContent(visits, theme),
                      loading: () => _buildLoadingState(),
                      error:
                          (error, stack) => _buildErrorState(error.toString()),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPeriodSelector(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children:
            ['month', 'quarter', 'year'].map((period) {
              final isSelected = _selectedPeriod == period;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedPeriod = period),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 10,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? theme.colorScheme.primary
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow:
                          isSelected
                              ? [
                                BoxShadow(
                                  color: theme.colorScheme.primary.withOpacity(
                                    0.3,
                                  ),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                              : null,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _getPeriodIcon(period),
                          size: 18,
                          color:
                              isSelected
                                  ? Colors.white
                                  : theme.colorScheme.onSurface.withOpacity(
                                    0.6,
                                  ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          _getPeriodLabel(period),
                          style: TextStyle(
                            color:
                                isSelected
                                    ? Colors.white
                                    : theme.colorScheme.onSurface.withOpacity(
                                      0.8,
                                    ),
                            fontWeight:
                                isSelected ? FontWeight.w600 : FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
      ),
    );
  }

  Widget _buildContent(List<Visit> visits, ThemeData theme) {
    final filteredVisits = _getFilteredVisits(visits);

    if (filteredVisits.isEmpty) {
      return _buildEmptyState();
    }

    return Column(
      children: [
        // Summary Cards
        _buildModernSummaryCards(filteredVisits, theme),
        const SizedBox(height: 32),

        // Chart Section
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 20,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Visit Distribution',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      _getPeriodLabel(_selectedPeriod),
                      style: TextStyle(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                height: 300,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child:
                      _showBarChart
                          ? _buildModernBarChart(filteredVisits, theme)
                          : _buildModernPieChart(filteredVisits, theme),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildModernSummaryCards(List<Visit> visits, ThemeData theme) {
    final totalVisits = visits.length;
    final completedVisits =
        visits.where((v) => v.status.toLowerCase() == 'completed').length;
    final pendingVisits = totalVisits - completedVisits;
    final completionRate =
        totalVisits > 0 ? (completedVisits / totalVisits * 100) : 0.0;

    final cards = [
      _SummaryCardData(
        title: 'Total Visits',
        value: totalVisits.toString(),
        icon: Icons.calendar_today_rounded,
        color: theme.colorScheme.primary,
        trend: '+12%',
      ),
      _SummaryCardData(
        title: 'Completed',
        value: completedVisits.toString(),
        icon: Icons.check_circle_rounded,
        color: const Color(0xFF10B981),
        trend: '+8%',
      ),
      _SummaryCardData(
        title: 'Pending',
        value: pendingVisits.toString(),
        icon: Icons.schedule_rounded,
        color: const Color(0xFFF59E0B),
        trend: '-5%',
      ),
      _SummaryCardData(
        title: 'Success Rate',
        value: '${completionRate.toStringAsFixed(0)}%',
        icon: Icons.trending_up_rounded,
        color: const Color(0xFF8B5CF6),
        trend: '+3%',
      ),
    ];

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate the number of columns based on width
        final crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio:
                constraints.maxWidth > 600 ? 1.5 : 1.3, // Adjusted ratio
          ),
          itemCount: cards.length,
          itemBuilder: (context, index) {
            final card = cards[index];
            return _buildModernSummaryCard(card, theme);
          },
        );
      },
    );
  }

  Widget _buildModernSummaryCard(_SummaryCardData data, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: data.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(data.icon, color: data.color, size: 20),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFF10B981).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  data.trend,
                  style: const TextStyle(
                    color: Color(0xFF10B981),
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            data.value,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.w800,
              color: theme.colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            data.title,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.6),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModernBarChart(List<Visit> visits, ThemeData theme) {
    final Map<String, int> statusCounts = {};
    for (var visit in visits) {
      statusCounts[visit.status] = (statusCounts[visit.status] ?? 0) + 1;
    }

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY:
            statusCounts.values.reduce((a, b) => a > b ? a : b).toDouble() *
            1.2,
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            tooltipBorder: BorderSide(
              color: theme.colorScheme.outline.withOpacity(0.2),
            ),
            tooltipBorderRadius: BorderRadius.circular(12),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: theme.colorScheme.outline.withOpacity(0.1),
              strokeWidth: 1,
            );
          },
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                final status = statusCounts.keys.elementAt(value.toInt());
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    status,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: theme.colorScheme.onSurface.withOpacity(0.7),
                    ),
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: TextStyle(
                    fontSize: 11,
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                );
              },
            ),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        barGroups:
            statusCounts.entries.map((entry) {
              final color =
                  entry.key.toLowerCase() == 'completed'
                      ? const Color(0xFF10B981)
                      : entry.key.toLowerCase() == 'pending'
                      ? const Color(0xFFF59E0B)
                      : Colors.redAccent;

              return BarChartGroupData(
                x: statusCounts.keys.toList().indexOf(entry.key),
                barRods: [
                  BarChartRodData(
                    toY: entry.value.toDouble(),
                    gradient: LinearGradient(
                      colors: [color, color.withOpacity(0.7)],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                    width: 32,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(6),
                    ),
                  ),
                ],
              );
            }).toList(),
      ),
    );
  }

  Widget _buildModernPieChart(List<Visit> visits, ThemeData theme) {
    final Map<String, int> statusCounts = {};
    for (var visit in visits) {
      statusCounts[visit.status] = (statusCounts[visit.status] ?? 0) + 1;
    }

    return PieChart(
      PieChartData(
        sectionsSpace: 4,
        centerSpaceRadius: 60,
        startDegreeOffset: -90,
        sections:
            statusCounts.entries.map((entry) {
              final color =
                  entry.key.toLowerCase() == 'completed'
                      ? const Color(0xFF10B981)
                      : entry.key.toLowerCase() == 'pending'
                      ? const Color(0xFFF59E0B)
                      : Colors.redAccent;

              return PieChartSectionData(
                color: color,
                value: entry.value.toDouble(),
                title: '${entry.value}',
                radius: 80,
                titleStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
                badgeWidget: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    entry.key,
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                ),
                badgePositionPercentageOffset: 1.3,
              );
            }).toList(),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(),
          SizedBox(height: 16),
          Text('Loading analytics...'),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 48,
            color: Colors.red.withOpacity(0.7),
          ),
          const SizedBox(height: 16),
          Text('Error loading data'),
          const SizedBox(height: 8),
          Text(
            error,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.analytics_outlined,
            size: 64,
            color: Colors.grey.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          const Text(
            'No visits found',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            'No visits found for the selected period',
            style: TextStyle(color: Colors.grey.withOpacity(0.7)),
          ),
        ],
      ),
    );
  }

  List<Visit> _getFilteredVisits(List<Visit> visits) {
    final DateTime now = DateTime.now();
    return visits.where((visit) {
      switch (_selectedPeriod) {
        case 'month':
          return visit.visitDate.year == now.year &&
              visit.visitDate.month == now.month;
        case 'quarter':
          final startQuarter = DateTime(now.year, (now.month - 1) ~/ 3 * 3 + 1);
          return visit.visitDate.isAfter(startQuarter);
        case 'year':
          return visit.visitDate.year == now.year;
        default:
          return true;
      }
    }).toList();
  }

  IconData _getPeriodIcon(String period) {
    switch (period) {
      case 'month':
        return Icons.calendar_month_rounded;
      case 'quarter':
        return Icons.calendar_view_month_rounded;
      case 'year':
        return Icons.calendar_today_rounded;
      default:
        return Icons.calendar_month_rounded;
    }
  }

  String _getPeriodLabel(String period) {
    switch (period) {
      case 'month':
        return 'This Month';
      case 'quarter':
        return 'Quarter';
      case 'year':
        return 'Year';
      default:
        return 'Month';
    }
  }
}

class _SummaryCardData {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final String trend;

  _SummaryCardData({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.trend,
  });
}
