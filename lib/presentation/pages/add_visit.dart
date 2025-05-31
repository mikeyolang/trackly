import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trackly/core/constants/print_styles.dart';
import 'package:trackly/domain/entities/activity.dart';
import 'package:trackly/domain/entities/customer.dart';
import 'package:trackly/domain/entities/visit.dart';
import 'package:trackly/presentation/providers/repository_provider.dart';
import 'package:trackly/presentation/providers/visits_provider.dart';

class AddVisitPage extends ConsumerStatefulWidget {
  const AddVisitPage({super.key});

  @override
  ConsumerState<AddVisitPage> createState() => _AddVisitPageState();
}

class _AddVisitPageState extends ConsumerState<AddVisitPage>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
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
    final customersAsync = ref.watch(customersProvider);
    final activitiesAsync = ref.watch(activitiesProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: theme.primaryColor,
        title: Text(
          'Add New Visit',
          style: theme.textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.primaryColor,
          ),
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
            child: FilledButton.icon(
              onPressed: _isLoading ? null : _saveVisit,
              icon:
                  _isLoading
                      ? SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: theme.colorScheme.onPrimary,
                        ),
                      )
                      : const Icon(Icons.check_rounded, size: 18),
              label: Text(_isLoading ? 'Saving...' : 'Save Visit'),
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
      body: customersAsync.when(
        data:
            (customers) => activitiesAsync.when(
              data: (activities) => _buildForm(customers, activities),
              loading: () => _buildLoadingState('Loading activities...'),
              error:
                  (error, _) => _buildErrorState(
                    'Unable to load activities',
                    'Please check your connection and try again.',
                    () => ref.refresh(activitiesProvider),
                  ),
            ),
        loading: () => _buildLoadingState('Loading customers...'),
        error:
            (error, _) => _buildErrorState(
              'Unable to load customers',
              'Please check your connection and try again.',
              () => ref.refresh(customersProvider),
            ),
      ),
    );
  }

  Widget _buildLoadingState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(
            message,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String title, String subtitle, VoidCallback onRetry) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 64,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              subtitle,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            FilledButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh_rounded),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(List<Customer> customers, List<Activity> activities) {
    final theme = Theme.of(context);

    return FadeTransition(
      opacity: _fadeAnimation,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: FormBuilder(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionHeader('Visit Details', Icons.location_on_rounded),
                const SizedBox(height: 16),

                _buildModernDropdown(
                  name: 'customer_id',
                  label: 'Select Customer',
                  icon: Icons.person_rounded,
                  items:
                      customers
                          .map(
                            (customer) => DropdownMenuItem(
                              value: customer.id,
                              child: Text(customer.name),
                            ),
                          )
                          .toList(),
                  validator:
                      (value) =>
                          value == null ? 'Please select a customer' : null,
                ),

                const SizedBox(height: 20),

                _buildModernDateTimePicker(
                  name: 'visit_date',
                  label: 'Visit Date & Time',
                  icon: Icons.event_rounded,
                ),

                const SizedBox(height: 20),

                _buildModernTextField(
                  name: 'location',
                  label: 'Location',
                  icon: Icons.place_rounded,
                  hint: 'Enter the visit location',
                  validator:
                      (value) =>
                          value?.isEmpty == true
                              ? 'Location is required'
                              : null,
                ),

                const SizedBox(height: 32),

                _buildModernDropdown(
                  name: 'status',
                  label: 'Visit Status',
                  icon: Icons.assignment_turned_in_rounded,
                  items: [
                    DropdownMenuItem(value: 'Pending', child: Text('Pending')),
                    DropdownMenuItem(
                      value: 'Completed',
                      child: Text('Completed'),
                    ),
                    DropdownMenuItem(
                      value: 'Cancelled',
                      child: Text('Cancelled'),
                    ),
                  ],
                  validator:
                      (value) =>
                          value == null ? 'Please select a status' : null,
                ),
                const SizedBox(height: 20),
                _buildSectionHeader('Activities', Icons.checklist_rounded),
                const SizedBox(height: 16),

                _buildModernCheckboxGroup(activities),

                const SizedBox(height: 32),

                _buildSectionHeader('Additional Notes', Icons.note_rounded),
                const SizedBox(height: 16),

                _buildModernTextField(
                  name: 'notes',
                  label: 'Notes',
                  icon: Icons.edit_note_rounded,
                  hint: 'Add any additional notes about the visit',
                  maxLines: 4,
                ),

                const SizedBox(height: 40),

                // Bottom save button for better UX
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: FilledButton.icon(
                    onPressed: _isLoading ? null : _saveVisit,
                    icon:
                        _isLoading
                            ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: theme.colorScheme.onPrimary,
                              ),
                            )
                            : const Icon(Icons.save_rounded),
                    label: Text(_isLoading ? 'Saving Visit...' : 'Save Visit'),
                    style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: theme.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, size: 20, color: theme.primaryColor),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildModernDropdown<T>({
    required String name,
    required String label,
    required IconData icon,
    required List<DropdownMenuItem<T>> items,
    String? Function(T?)? validator,
  }) {
    return FormBuilderDropdown<T>(
      name: name,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
      items: items,
    );
  }

  Widget _buildModernDateTimePicker({
    required String name,
    required String label,
    required IconData icon,
  }) {
    return FormBuilderDateTimePicker(
      name: name,
      initialValue: DateTime.now(),
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }

  Widget _buildModernTextField({
    required String name,
    required String label,
    required IconData icon,
    String? hint,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return FormBuilderTextField(
      name: name,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
            width: 2,
          ),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
      ),
    );
  }

  Widget _buildModernCheckboxGroup(List<Activity> activities) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.shade50,
      ),
      child: FormBuilderCheckboxGroup<String>(
        name: 'activities_done',
        decoration: const InputDecoration(
          labelText: 'Select completed activities',
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(16),
        ),
        options:
            activities
                .map(
                  (activity) => FormBuilderFieldOption(
                    value: activity.id.toString(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Text(
                        activity.description,
                        style: theme.textTheme.bodyMedium,
                      ),
                    ),
                  ),
                )
                .toList(),
      ),
    );
  }

  Future<void> _saveVisit() async {
    if (!_formKey.currentState!.saveAndValidate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.warning_rounded, color: Colors.white),
              SizedBox(width: 12),
              Text('Please fill in all required fields'),
            ],
          ),
          backgroundColor: Colors.orange.shade600,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final formData = _formKey.currentState!.value;
      final visit = Visit(
        customerId: formData['customer_id'],
        visitDate: formData['visit_date'],
        status: formData['status'] ?? 'pending',
        location: formData['location'],
        notes: formData['notes'] ?? '',
        activitiesDone: List<String>.from(formData['activities_done'] ?? []),
      );

      beautifulLogger.error("Visit data: ${visit.toJson()}");

      await ref.read(visitsNotifierProvider.notifier).addVisit(visit);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle_rounded, color: Colors.white),
                SizedBox(width: 12),
                Text('Visit saved successfully!'),
              ],
            ),
            backgroundColor: Colors.green.shade600,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.error_rounded, color: Colors.white),
                const SizedBox(width: 12),
                Expanded(child: Text('Error: $e')),
              ],
            ),
            backgroundColor: Colors.red.shade600,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            duration: const Duration(seconds: 4),
          ),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }
}
