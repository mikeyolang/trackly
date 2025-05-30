
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trackly/data/models/app_models.dart';
import '../../domain/entities/visit.dart';

part 'form_state_provider.g.dart';

@riverpod
class VisitFormNotifier extends _$VisitFormNotifier {
  @override
  VisitFormState build() => const VisitFormState();

  void updateCustomerId(int? customerId) {
    state = state.copyWith(customerId: customerId);
  }

  void updateVisitDate(DateTime? visitDate) {
    state = state.copyWith(visitDate: visitDate);
  }

  void updateLocation(String location) {
    state = state.copyWith(location: location);
  }

  void updateNotes(String notes) {
    state = state.copyWith(notes: notes);
  }

  void updateActivities(List<String> activities) {
    state = state.copyWith(selectedActivities: activities);
  }

  void updateStatus(String status) {
    state = state.copyWith(status: status);
  }

  void setFormValid(bool isValid) {
    state = state.copyWith(isValid: isValid);
  }

  void resetForm() {
    state = const VisitFormState();
  }

  Visit toVisit() {
    return Visit(
      customerId: state.customerId!,
      visitDate: state.visitDate ?? DateTime.now(),
      location: state.location,
      notes: state.notes,
      activitiesDone: state.selectedActivities,
      status: state.status,
    );
  }

  void loadVisit(Visit visit) {
    state = VisitFormState(
      customerId: visit.customerId,
      visitDate: visit.visitDate,
      location: visit.location,
      notes: visit.notes,
      selectedActivities: visit.activitiesDone,
      status: visit.status,
      isValid: true,
    );
  }
}
