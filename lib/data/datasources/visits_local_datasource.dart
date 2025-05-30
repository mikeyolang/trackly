import 'package:hive/hive.dart';
import 'package:trackly/core/errors/exceptions.dart';
import 'package:trackly/domain/entities/activity.dart';
import 'package:trackly/domain/entities/customer.dart';
import 'package:trackly/domain/entities/visit.dart';

class VisitsLocalDatasource {
  static const String _visitsBoxName = 'visits_box';
  static const String _customerBoxName = 'customer_box';
  static const String _activitiesBoxName = 'activities_box';
  static const String _offlineVisitsBoxName = 'offline_visits_box';
  static const String _lastSyncKey = 'last_sync_timestamp';

  Box<Map>? _visitsBox;
  Box<Map>? _customersBox;
  Box<Map>? _activitiesBox;
  Box<Map>? _offlineVisitsBox;

  // Initiallizing Hive Boxes

  Future<void> init() async {
    try {
      _visitsBox = await Hive.openBox<Map>(_visitsBoxName);
      _customersBox = await Hive.openBox<Map>(_customerBoxName);
      _activitiesBox = await Hive.openBox<Map>(_activitiesBoxName);
      _offlineVisitsBox = await Hive.openBox<Map>(_offlineVisitsBoxName);
    } catch (e) {
      throw Exception("Failed to initialize Loca Storage: $e");
    }
  }

  // Visits Methods

  Future<List<Visit>> getCachedVisits() async {
    try {
      await _ensureInitialized();

      final visitsData = _visitsBox?.values;

      return visitsData!
          .map((data) => Visit.fromJson(Map<String, dynamic>.from(data)))
          .toList()
        ..sort((a, b) => b.visitDate.compareTo(a.visitDate));
    } catch (e) {
      throw CacheException("Failed to fetch cached visits: ${e.toString()}");
    }
  }

  Future<void> cacheVisits(List<Visit> visits) async {
    try {
      await _ensureInitialized();
      await _visitsBox!.clear();

      for (int i = 0; i < visits.length; i++) {
        await _visitsBox!.put(i, visits[i].toJson());
      }

      await _updateLastSyncTimestamp();
    } catch (e) {
      throw CacheException('Failed to cache visits: $e');
    }
  }

  Future<void> cacheVisit(Visit visit) async {
    try {
      await _ensureInitialized();
      // Use visit ID as key, or generate one if null
      final key = visit.id ?? DateTime.now().millisecondsSinceEpoch;
      await _visitsBox!.put(key, visit.toJson());
    } catch (e) {
      throw CacheException('Failed to cache visit: $e');
    }
  }

  Future<Visit?> getCachedVisit(int id) async {
    try {
      await _ensureInitialized();
      final visitData = _visitsBox!.get(id);
      if (visitData != null) {
        return Visit.fromJson(Map<String, dynamic>.from(visitData));
      }
      return null;
    } catch (e) {
      throw CacheException('Failed to get cached visit: $e');
    }
  }

  // Offline visits methods
  Future<void> storeOfflineVisit(Visit visit) async {
    try {
      await _ensureInitialized();
      final key = DateTime.now().millisecondsSinceEpoch.toString();
      final visitWithOfflineFlag = visit.copyWith(
        // Add offline flag to the visit data
        notes: '${visit.notes}\n[OFFLINE_CREATED]',
      );
      await _offlineVisitsBox!.put(key, visitWithOfflineFlag.toJson());
    } catch (e) {
      throw CacheException('Failed to store offline visit: $e');
    }
  }

  Future<List<Visit>> getOfflineVisits() async {
    try {
      await _ensureInitialized();
      final offlineVisitsData = _offlineVisitsBox!.values.toList();
      return offlineVisitsData
          .map((data) => Visit.fromJson(Map<String, dynamic>.from(data)))
          .toList();
    } catch (e) {
      throw CacheException('Failed to get offline visits: $e');
    }
  }

  Future<void> clearOfflineVisits() async {
    try {
      await _ensureInitialized();
      await _offlineVisitsBox!.clear();
    } catch (e) {
      throw CacheException('Failed to clear offline visits: $e');
    }
  }

  Future<void> removeOfflineVisit(String key) async {
    try {
      await _ensureInitialized();
      await _offlineVisitsBox!.delete(key);
    } catch (e) {
      throw CacheException('Failed to remove offline visit: $e');
    }
  }

  // Customers methods
  Future<List<Customer>> getCachedCustomers() async {
    try {
      await _ensureInitialized();
      final customersData = _customersBox!.values.toList();
      return customersData
          .map((data) => Customer.fromJson(Map<String, dynamic>.from(data)))
          .toList()
        ..sort((a, b) => a.name.compareTo(b.name)); // Sort alphabetically
    } catch (e) {
      throw CacheException('Failed to get cached customers: $e');
    }
  }

  Future<void> cacheCustomers(List<Customer> customers) async {
    try {
      await _ensureInitialized();
      await _customersBox!.clear();

      for (int i = 0; i < customers.length; i++) {
        await _customersBox!.put(customers[i].id, customers[i].toJson());
      }
    } catch (e) {
      throw CacheException('Failed to cache customers: $e');
    }
  }

  Future<Customer?> getCachedCustomer(int id) async {
    try {
      await _ensureInitialized();
      final customerData = _customersBox!.get(id);
      if (customerData != null) {
        return Customer.fromJson(Map<String, dynamic>.from(customerData));
      }
      return null;
    } catch (e) {
      throw CacheException('Failed to get cached customer: $e');
    }
  }

  // Activities methods
  Future<List<Activity>> getCachedActivities() async {
    try {
      await _ensureInitialized();
      final activitiesData = _activitiesBox!.values.toList();
      return activitiesData
          .map((data) => Activity.fromJson(Map<String, dynamic>.from(data)))
          .toList()
        ..sort(
          (a, b) => a.description.compareTo(b.description),
        ); // Sort alphabetically
    } catch (e) {
      throw CacheException('Failed to get cached activities: $e');
    }
  }

  Future<void> cacheActivities(List<Activity> activities) async {
    try {
      await _ensureInitialized();
      await _activitiesBox!.clear();

      for (int i = 0; i < activities.length; i++) {
        await _activitiesBox!.put(activities[i].id, activities[i].toJson());
      }
    } catch (e) {
      throw CacheException('Failed to cache activities: $e');
    }
  }

  Future<Activity?> getCachedActivity(int id) async {
    try {
      await _ensureInitialized();
      final activityData = _activitiesBox!.get(id);
      if (activityData != null) {
        return Activity.fromJson(Map<String, dynamic>.from(activityData));
      }
      return null;
    } catch (e) {
      throw CacheException('Failed to get cached activity: $e');
    }
  }

  // Utility methods
  Future<DateTime?> getLastSyncTimestamp() async {
    try {
      await _ensureInitialized();
      final timestamp = _visitsBox!.get(_lastSyncKey);
      if (timestamp != null) {
        return DateTime.fromMillisecondsSinceEpoch(timestamp as int);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<void> _updateLastSyncTimestamp() async {
    try {
      await _visitsBox!.put(
        _lastSyncKey,
        DateTime.now().millisecondsSinceEpoch as Map,
      );
    } catch (e) {
      // Ignore sync timestamp errors
    }
  }

  Future<void> clearAllCache() async {
    try {
      await _ensureInitialized();
      await Future.wait([
        _visitsBox!.clear(),
        _customersBox!.clear(),
        _activitiesBox!.clear(),
        _offlineVisitsBox!.clear(),
      ]);
    } catch (e) {
      throw CacheException('Failed to clear cache: $e');
    }
  }

  Future<bool> hasOfflineData() async {
    try {
      await _ensureInitialized();
      return _offlineVisitsBox!.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<void> _ensureInitialized() async {
    if (_visitsBox == null ||
        _customersBox == null ||
        _activitiesBox == null ||
        _offlineVisitsBox == null) {
      await init();
    }
  }

  Future<void> close() async {
    await Future.wait([
      _visitsBox?.close() ?? Future.value(),
      _customersBox?.close() ?? Future.value(),
      _activitiesBox?.close() ?? Future.value(),
      _offlineVisitsBox?.close() ?? Future.value(),
    ]);
  }
}
