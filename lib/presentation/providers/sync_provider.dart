import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trackly/core/constants/enums.dart';
import 'package:trackly/core/network/api_client.dart';
import 'package:trackly/core/services/connectivity_service.dart';
import 'package:trackly/core/services/sync_service.dart';
import 'package:trackly/data/datasources/visits_local_datasource.dart';
import 'package:trackly/data/datasources/visits_remote_datasource.dart';


final syncServiceProvider = Provider<SyncService>((ref) {
  final connectivityService = ref.read(connectivityServiceProvider);
  final localDataSource = ref.read(visitsLocalDataSourceProvider);
  final remoteDataSource = ref.read(visitsRemoteDataSourceProvider);

  final syncService = SyncService(
    connectivityService,
    localDataSource,
    remoteDataSource,
  );

  ref.onDispose(syncService.dispose);
  return syncService;
});

final syncStatusProvider = StreamProvider<SyncStatus>((ref) {
  final syncService = ref.read(syncServiceProvider);
  return syncService.syncStatusStream;
});

final offlineVisitsCountProvider = FutureProvider<int>((ref) async {
  final syncService = ref.read(syncServiceProvider);
  return await syncService.getOfflineVisitsCount();
});

// Provider instances for dependency injection
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

final apiClientProvider = Provider<ApiClient>((ref) {
  return ApiClient();
});
