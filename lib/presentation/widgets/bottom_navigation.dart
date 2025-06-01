// Creating the modern bottom navigation widget for the app
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedIndexProvider = StateProvider<int>((ref) => 0);

class BottomNavigation extends ConsumerStatefulWidget {
  const BottomNavigation({super.key});

  @override
  ConsumerState<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends ConsumerState<BottomNavigation>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(selectedIndexProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.1 : 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color:
                isDark
                    ? const Color(0xFF1C1C1E).withOpacity(0.95)
                    : Colors.white.withOpacity(0.95),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color:
                  isDark
                      ? Colors.white.withOpacity(0.1)
                      : Colors.black.withOpacity(0.05),
              width: 0.5,
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                (isDark ? Colors.white : Colors.black).withOpacity(0.02),
                Colors.transparent,
              ],
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Row(
              children: [
                _buildNavItem(
                  context: context,
                  index: 0,
                  icon: Icons.list_alt_rounded,
                  activeIcon: Icons.list_alt_rounded,
                  label: 'Visits',
                  isSelected: selectedIndex == 0,
                  onTap: () => _onItemTapped(0),
                ),
                _buildNavItem(
                  context: context,
                  index: 1,
                  icon: Icons.analytics_outlined,
                  activeIcon: Icons.analytics_rounded,
                  label: 'Analytics',
                  isSelected: selectedIndex == 1,
                  onTap: () => _onItemTapped(1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color:
                isSelected
                    ? theme.colorScheme.primary.withOpacity(0.15)
                    : Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border:
                isSelected
                    ? Border.all(
                      color: theme.colorScheme.primary.withOpacity(0.2),
                      width: 1,
                    )
                    : null,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon with animation
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                padding: EdgeInsets.all(isSelected ? 4 : 2),
                decoration: BoxDecoration(
                  color:
                      isSelected
                          ? theme.colorScheme.primary.withOpacity(0.1)
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  isSelected ? activeIcon : icon,
                  size: isSelected ? 26 : 24,
                  color:
                      isSelected
                          ? theme.colorScheme.primary
                          : (isDark ? Colors.white : Colors.black).withOpacity(
                            0.6,
                          ),
                ),
              ),
              const SizedBox(height: 4),

              // Label with animation
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: isSelected ? 12 : 11,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color:
                      isSelected
                          ? theme.colorScheme.primary
                          : (isDark ? Colors.white : Colors.black).withOpacity(
                            0.7,
                          ),
                ),
                child: Text(label),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    ref.read(selectedIndexProvider.notifier).state = index;
    _animationController.forward().then((_) {
      _animationController.reverse();
    });

    // Add haptic feedback
    HapticFeedback.lightImpact();
  }
}

// Alternative Modern Floating Navigation Bar
class FloatingBottomNavigation extends ConsumerStatefulWidget {
  const FloatingBottomNavigation({super.key});

  @override
  ConsumerState<FloatingBottomNavigation> createState() =>
      _FloatingBottomNavigationState();
}

class _FloatingBottomNavigationState
    extends ConsumerState<FloatingBottomNavigation>
    with TickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );
    _slideController.forward();
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(selectedIndexProvider);
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SlideTransition(
      position: _slideAnimation,
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withOpacity(0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(isDark ? 0.4 : 0.1),
              blurRadius: 30,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  isDark ? const Color(0xFF2C2C2E) : Colors.white,
                  isDark ? const Color(0xFF1C1C1E) : const Color(0xFFF8F9FA),
                ],
              ),
              border: Border.all(
                color:
                    isDark
                        ? Colors.white.withOpacity(0.1)
                        : Colors.black.withOpacity(0.05),
                width: 0.5,
              ),
            ),
            child: Row(
              children: [
                _buildFloatingNavItem(
                  context: context,
                  index: 0,
                  icon: Icons.home_rounded,
                  activeIcon: Icons.home_rounded,
                  label: 'Visits',
                  isSelected: selectedIndex == 0,
                  onTap: () => _onFloatingItemTapped(0),
                ),
                _buildFloatingNavItem(
                  context: context,
                  index: 1,
                  icon: Icons.bar_chart_rounded,
                  activeIcon: Icons.bar_chart_rounded,
                  label: 'Analytics',
                  isSelected: selectedIndex == 1,
                  onTap: () => _onFloatingItemTapped(1),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingNavItem({
    required BuildContext context,
    required int index,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated indicator dot
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: isSelected ? 6 : 0,
                height: 6,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(height: 4),

              // Icon with pulse animation
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 200),
                tween: Tween<double>(begin: 0.0, end: isSelected ? 1.0 : 0.0),
                builder: (context, value, child) {
                  return Transform.scale(
                    scale: 1.0 + (value * 0.1),
                    child: Icon(
                      isSelected ? activeIcon : icon,
                      size: 28,
                      color: Color.lerp(
                        Colors.grey.withOpacity(0.6),
                        theme.colorScheme.primary,
                        value,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 4),

              // Label
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                  color:
                      isSelected
                          ? theme.colorScheme.primary
                          : Colors.grey.withOpacity(0.7),
                ),
                child: Text(label),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onFloatingItemTapped(int index) {
    ref.read(selectedIndexProvider.notifier).state = index;
    HapticFeedback.selectionClick();
  }
}
