import 'dart:async';
import 'package:trackly/core/constants/enums.dart';
import 'package:trackly/core/services/connectivity_service.dart';
import 'package:trackly/data/datasources/visits_local_datasource.dart';
import 'package:trackly/data/datasources/visits_remote_datasource.dart';
import 'package:trackly/domain/entities/visit.dart';

class SyncService {
  final ConnectivityService _connectivityService;
  final VisitsLocalDatasource _localDataSource;
  final VisitsRemoteDatasource _remoteDataSource;

  Timer? _syncTimer;
  bool _isSyncing = false;

  // Stream controller for sync status
  final StreamController<SyncStatus> _syncStatusController =
      StreamController<SyncStatus>.broadcast();
  Stream<SyncStatus> get syncStatusStream => _syncStatusController.stream;

  SyncService(
    this._connectivityService,
    this._localDataSource,
    this._remoteDataSource,
  ) {
    _initSync();
  }

  void _initSync() {
    // Listen to connectivity changes
    _connectivityService.connectivityStream.listen((isConnected) {
      if (isConnected && !_isSyncing) {
        _syncOfflineData();
      }
    });

    // Periodic sync every 5 minutes when online
    _syncTimer = Timer.periodic(const Duration(minutes: 5), (_) {
      if (_connectivityService.isConnected && !_isSyncing) {
        _syncOfflineData();
      }
    });
  }

  Future<void> _syncOfflineData() async {
    if (_isSyncing) return;

    try {
      _isSyncing = true;
      _syncStatusController.add(SyncStatus.syncing);

      // Check if we have offline data to sync
      final hasOfflineData = await _localDataSource.hasOfflineData();
      if (!hasOfflineData) {
        _syncStatusController.add(SyncStatus.completed);
        return;
      }

      // Get offline visits
      final offlineVisits = await _localDataSource.getOfflineVisits();

      if (offlineVisits.isEmpty) {
        _syncStatusController.add(SyncStatus.completed);
        return;
      }

      // Sync each offline visit
      final List<String> failedSyncs = [];
      for (final visit in offlineVisits) {
        try {
          // Remove the offline flag from notes
          final cleanedVisit = visit.copyWith(
            notes: visit.notes.replaceAll('\n[OFFLINE_CREATED]', ''),
          );

          // Try to sync with server
          await _remoteDataSource.createVisit(cleanedVisit);

          // Remove from offline storage on success
          final key =
              visit.createdAt?.millisecondsSinceEpoch.toString() ??
              DateTime.now().millisecondsSinceEpoch.toString();
          await _localDataSource.removeOfflineVisit(key);
        } catch (e) {
          // Keep track of failed syncs
          failedSyncs.add(visit.id?.toString() ?? 'unknown');
        }
      }

      if (failedSyncs.isEmpty) {
        _syncStatusController.add(SyncStatus.completed);
      } else {
        _syncStatusController.add(SyncStatus.failed);
      }
    } catch (e) {
      _syncStatusController.add(SyncStatus.failed);
    } finally {
      _isSyncing = false;
    }
  }

  Future<void> forceSyncOfflineData() async {
    if (_connectivityService.isConnected) {
      await _syncOfflineData();
    } else {
      _syncStatusController.add(SyncStatus.noConnection);
    }
  }

  Future<int> getOfflineVisitsCount() async {
    try {
      final offlineVisits = await _localDataSource.getOfflineVisits();
      return offlineVisits.length;
    } catch (e) {
      return 0;
    }
  }

  Future<DateTime?> getLastSyncTime() async {
    return await _localDataSource.getLastSyncTimestamp();
  }

  void dispose() {
    _syncTimer?.cancel();
    _syncStatusController.close();
    _isSyncing = false;
  }
}
