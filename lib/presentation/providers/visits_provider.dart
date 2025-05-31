import 'package:flutter/material.dart';
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
    debugPrint('Building VisitsNotifier');
    // Immediately start loading the visits
    _loadInitialVisits();
    // Return empty list initially to avoid null
    return [];
  }

  Future<void> _loadInitialVisits() async {
    try {
      final repository = ref.read(visitsRepositoryProvider);
      final visits = await repository.getVisits();
      debugPrint('Fetched ${visits.length} visits');
      state = AsyncValue.data(visits);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }

  Future<void> searchVisits(String query) async {
    if (query.isEmpty) {
      refreshVisits();
      return;
    }

    final currentVisits = await future;
    final filteredVisits =
        currentVisits
            .where(
              (visit) =>
                  visit.location.toLowerCase().contains(query.toLowerCase()) ||
                  visit.notes.toLowerCase().contains(query.toLowerCase()) ||
                  visit.status.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

    state = AsyncValue.data(filteredVisits);
  }

  Future<void> addVisit(Visit visit) async {
    try {
      final repository = ref.read(visitsRepositoryProvider);
      final newVisit = await repository.createVisit(visit);
      state = AsyncValue.data([...state.value ?? [], newVisit]);
      ref
          .read(notificationNotifierProvider.notifier)
          .showSuccess('Visit added successfully');
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      ref
          .read(notificationNotifierProvider.notifier)
          .showError('Failed to add visit');
    }
  }

  Future<void> refreshVisits() async {
    try {
      final repository = ref.read(visitsRepositoryProvider);
      final visits = await repository.getVisits();
      state = AsyncValue.data(visits);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      ref.read(notificationNotifierProvider.notifier);
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
