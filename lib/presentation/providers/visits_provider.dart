import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trackly/data/models/app_models.dart';
import 'package:trackly/presentation/providers/notification_provider.dart';
import 'package:trackly/presentation/providers/repository_provider.dart';
import '../../domain/entities/visit.dart';

import '../../core/errors/exceptions.dart';

part 'visits_provider.g.dart';

@riverpod
class VisitsNotifier extends _$VisitsNotifier {
  @override
  FutureOr<List<Visit>> build() async {
    final repository = ref.read(visitsRepositoryProvider);
    return repository.getVisits();
  }

  Future<void> addVisit(Visit visit) async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(visitsRepositoryProvider);
      await repository.createVisit(visit);

      // Refresh the list after adding
      ref.invalidateSelf();

      // Show success notification
      ref
          .read(notificationNotifierProvider.notifier)
          .showSuccess('Visit added successfully');
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);

      // Show error notification
      final errorMessage = _getErrorMessage(error);
      ref.read(notificationNotifierProvider.notifier).showError(errorMessage);
      rethrow;
    }
  }

  // Future<void> updateVisit(Visit visit) async {
  //   state = const AsyncValue.loading();
  //   try {
  //     final repository = ref.read(visitsRepositoryProvider);
  //     await repository.updateVisit(visit);

  //     // Refresh the list after updating
  //     ref.invalidateSelf();

  //     ref
  //         .read(notificationProvider.notifier)
  //         .showSuccess('Visit updated successfully');
  //   } catch (error, stackTrace) {
  //     state = AsyncValue.error(error, stackTrace);

  //     final errorMessage = _getErrorMessage(error);
  //     ref.read(notificationProvider.notifier).showError(errorMessage);
  //     rethrow;
  //   }
  // }

  // Future<void> deleteVisit(int visitId) async {
  //   // Optimistically remove from UI
  //   final currentState = state;
  //   if (currentState is AsyncData<List<Visit>>) {
  //     final updatedVisits =
  //         currentState.value.where((v) => v.id != visitId).toList();
  //     state = AsyncData(updatedVisits);
  //   }

  //   try {
  //     final repository = ref.read(visitsRepositoryProvider);
  //     await repository.deleteVisit(visitId);

  //     ref
  //         .read(notificationProvider.notifier)
  //         .showSuccess('Visit deleted successfully');
  //   } catch (error, stackTrace) {
  //     // Revert optimistic update on error
  //     state = currentState;

  //     final errorMessage = _getErrorMessage(error);
  //     ref.read(notificationProvider.notifier).showError(errorMessage);
  //     rethrow;
  //   }
  // }

  Future<void> refreshVisits() async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(visitsRepositoryProvider);
      final visits = await repository.getVisits();
      state = AsyncValue.data(visits);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  String _getErrorMessage(dynamic error) {
    if (error is ServerException) {
      return 'Server error: ${error.message}';
    } else if (error is NetworkException) {
      return 'Network error: Please check your connection';
    } else if (error is CacheException) {
      return 'Storage error: ${error.message}';
    } else {
      return 'An unexpected error occurred';
    }
  }
}

@riverpod
class FilteredVisitsNotifier extends _$FilteredVisitsNotifier {
  @override
  FutureOr<List<Visit>> build() async {
    final visits = await ref.watch(visitsNotifierProvider.future);
    final filter = ref.watch(visitFilterProvider);
    final searchQuery = ref.watch(searchQueryProvider);

    return _applyFiltersAndSearch(visits, filter, searchQuery);
  }

  List<Visit> _applyFiltersAndSearch(
    List<Visit> visits,
    VisitFilterModel filter,
    String searchQuery,
  ) {
    var filteredVisits = visits;

    // Apply status filter
    if (filter.status != null) {
      filteredVisits =
          filteredVisits
              .where((visit) => visit.status == filter.status)
              .toList();
    }

    // Apply date range filter
    if (filter.startDate != null) {
      filteredVisits =
          filteredVisits
              .where((visit) => visit.visitDate.isAfter(filter.startDate!))
              .toList();
    }
    if (filter.endDate != null) {
      filteredVisits =
          filteredVisits
              .where((visit) => visit.visitDate.isBefore(filter.endDate!))
              .toList();
    }

    // Apply customer filter
    if (filter.customerId != null) {
      filteredVisits =
          filteredVisits
              .where((visit) => visit.customerId == filter.customerId)
              .toList();
    }

    // Apply search query
    if (searchQuery.isNotEmpty) {
      final query = searchQuery.toLowerCase();
      filteredVisits =
          filteredVisits.where((visit) {
            return visit.location.toLowerCase().contains(query) ||
                visit.notes.toLowerCase().contains(query) ||
                visit.status.toLowerCase().contains(query);
          }).toList();
    }

    // Sort by visit date (most recent first)
    filteredVisits.sort((a, b) => b.visitDate.compareTo(a.visitDate));

    return filteredVisits;
  }
}

// Filter and search state providers
@riverpod
class VisitFilter extends _$VisitFilter {
  @override
  VisitFilterModel build() => const VisitFilterModel();

  void updateStatus(String? status) {
    state = state.copyWith(status: status);
  }

  void updateDateRange(DateTime? startDate, DateTime? endDate) {
    state = state.copyWith(startDate: startDate, endDate: endDate);
  }

  void updateCustomer(int? customerId) {
    state = state.copyWith(customerId: customerId);
  }

  void clearFilters() {
    state = const VisitFilterModel();
  }
}

@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';

  void updateQuery(String query) {
    state = query;
  }

  void clearQuery() {
    state = '';
  }
}

@riverpod
class VisitStats extends _$VisitStats {
  @override
  FutureOr<VisitStatsModel> build() async {
    final visits = await ref.watch(visitsNotifierProvider.future);
    return VisitStatsModel.fromVisits(visits); // Auto-calculated stats
  }
}

// Individual visit provider
@riverpod
class VisitDetail extends _$VisitDetail {
  @override
  FutureOr<Visit?> build(int visitId) async {
    final visits = await ref.watch(visitsNotifierProvider.future);
    return visits.firstWhere(
      (visit) => visit.id == visitId,
      orElse: () => throw Exception('Visit not found'),
    );
  }
}
