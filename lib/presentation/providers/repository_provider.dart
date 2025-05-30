import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trackly/data/models/app_models.dart';
import 'package:trackly/domain/repositories/visits_repository_implementation.dart';
import 'package:trackly/presentation/providers/activities_provider.dart';
import 'package:trackly/presentation/providers/customer_provider.dart';
import 'package:trackly/presentation/providers/visits_provider.dart';
import '../../domain/repositories/visits_repository.dart';
import '../../data/datasources/visits_remote_datasource.dart';
import '../../data/datasources/visits_local_datasource.dart';
import '../../core/services/connectivity_service.dart';
import '../../core/network/api_client.dart';

// Core service providers
final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});

final connectivityServiceProvider = Provider<ConnectivityService>((ref) {
  final service = ConnectivityService();
  ref.onDispose(service.dispose);
  return service;
});

final visitsLocalDataSourceProvider = Provider<VisitsLocalDatasource>((ref) {
  return VisitsLocalDatasource();
});

final visitsRemoteDataSourceProvider = Provider<VisitsRemoteDatasource>((ref) {
  final apiClient = ref.read(apiClientProvider);
  return VisitsRemoteDatasource(apiClient);
});

// Repository provider
final visitsRepositoryProvider = Provider<VisitsRepository>((ref) {
  final remoteDataSource = ref.read(visitsRemoteDataSourceProvider);
  final localDataSource = ref.read(visitsLocalDataSourceProvider);
  final connectivityService = ref.read(connectivityServiceProvider);

  return VisitsRepositoryImplementation(
    remoteDataSource,
    localDataSource,
    connectivityService,
  );
});

// Convenience providers for commonly used data
final customersProvider = Provider((ref) {
  return ref.watch(customersNotifierProvider);
});

final activitiesProvider = Provider((ref) {
  return ref.watch(activitiesNotifierProvider);
});

final visitStatsProvider = FutureProvider<VisitStatsModel>((ref) async {
  final visits = await ref.watch(visitsNotifierProvider.future);
  return VisitStatsModel.fromVisits(visits);
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final visitFilterProvider =
    StateNotifierProvider<VisitFilterNotifier, VisitFilterModel>((ref) {
      return VisitFilterNotifier();
    });

class VisitFilterNotifier extends StateNotifier<VisitFilterModel> {
  VisitFilterNotifier() : super(const VisitFilterModel());

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
