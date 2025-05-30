// ignore_for_file: await_only_futures

import 'package:trackly/core/services/connectivity_service.dart';
import 'package:trackly/data/datasources/visits_local_datasource.dart';
import 'package:trackly/data/datasources/visits_remote_datasource.dart';
import 'package:trackly/domain/entities/activity.dart';
import 'package:trackly/domain/entities/customer.dart';
import 'package:trackly/domain/entities/visit.dart';
import 'package:trackly/domain/repositories/visits_repository.dart';

class VisitsRepositoryImplementation implements VisitsRepository {
  final VisitsRemoteDatasource _remoteDataSource;
  final VisitsLocalDatasource _localDataSource;
  final ConnectivityService _connectivityService;

  VisitsRepositoryImplementation(
    this._remoteDataSource,
    this._localDataSource,
    this._connectivityService,
  );
  @override
  Future<List<Visit>> getVisits() async {
    try {
      if (_connectivityService.isConnected) {
        final visits = await _remoteDataSource.getVisits();
        await _localDataSource.cacheVisits(visits);
        return visits;
      } else {
        return await _localDataSource.getCachedVisits();
      }
    } catch (e) {
      // Fallback to cached data
      return await _localDataSource.getCachedVisits();
    }
  }

  @override
  Future<Visit> createVisit(Visit visit) async {
    try {
      if (await _connectivityService.isConnected) {
        final createdVisit = await _remoteDataSource.createVisit(visit);
        await _localDataSource.cacheVisit(createdVisit);
        return createdVisit;
      } else {
        // Store offline and sync later
        await _localDataSource.storeOfflineVisit(visit);
        return visit;
      }
    } catch (e) {
      await _localDataSource.storeOfflineVisit(visit);
      rethrow;
    }
  }

  @override
  Future<List<Visit>> searchVisits(String query) async {
    final visits = await getVisits();
    return visits
        .where(
          (visit) =>
              visit.location.toLowerCase().contains(query.toLowerCase()) ||
              visit.notes.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  @override
  Future<List<Activity>> getActivities() async {
    if (_connectivityService.isConnected) {
      return await _remoteDataSource.getActivities();
    } else {
      return await _localDataSource.getCachedActivities();
    }
  }

  @override
  Future<List<Customer>> getCustomers() async {
    if (_connectivityService.isConnected) {
      return await _remoteDataSource.getCustomers();
    } else {
      return await _localDataSource.getCachedCustomers();
    }
  }
}
