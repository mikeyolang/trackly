import 'dart:convert';
import 'dart:io';

import 'package:trackly/core/constants/print_styles.dart';
import 'package:trackly/core/errors/exceptions.dart';
import 'package:trackly/core/network/api_client.dart';
import 'package:trackly/domain/entities/activity.dart';
import 'package:trackly/domain/entities/customer.dart';
import 'package:trackly/domain/entities/visit.dart';

class VisitsRemoteDatasource {
  final ApiClient _apiClient;
  VisitsRemoteDatasource(this._apiClient);

  /// Fetches all visits from the remote API.

  Future<List<Visit>> getVisits() async {
    try {
      final response = await _apiClient.dio.get('/visits');
      beautifulLogger.debug("Raw API Response: ${response.data}");

      if (response.data == null) {
        throw ServerException("Response data is null");
      }

      if (response.data is! List) {
        beautifulLogger.error(
          "Response data is not a List: ${response.data.runtimeType}",
        );
        throw ServerException("Invalid response format");
      }

      final List<Visit> visits = [];
      for (var item in response.data) {
        try {
          final visit = Visit.fromJson(item);
          visits.add(visit);
        } catch (e, stack) {
          beautifulLogger.error("Error parsing visit: $e\nStack: $stack");
        }
      }

      beautifulLogger.success("Successfully parsed ${visits.length} visits");
      return visits;
    } catch (e, stack) {
      beautifulLogger.error("Failed to fetch visits: $e\nStack: $stack");
      throw ServerException("Failed to fetch visits: ${e.toString()}");
    }
  }

  Future<Visit> createVisit(Visit visit) async {
    beautifulLogger.debug("The Visis $visit");
    try {
      final response = await _apiClient.dio.post(
        '/visits',
        data: jsonEncode(visit.toJson()),
      );
      beautifulLogger.debug("$visit");
      beautifulLogger.success("Created visit with ID: ${response.data['id']}");

      return Visit.fromJson(response.data);
    } catch (e) {
      throw ServerException(
        "Failed to create visit: ${e is SocketException ? 'No Internet connection' : e.toString()}",
      );
    }
  }

  // Customer-related api calls

  Future<List<Customer>> getCustomers() async {
    try {
      final response = await _apiClient.dio.get('/customers');

      return (response.data as List)
          .map((json) => Customer.fromJson(json))
          .toList();
    } catch (e) {
      throw ServerException(
        "Failed to fetch customers: ${e is SocketException ? 'No Internet connection' : e.toString()}",
      );
    }
  }

  Future<List<Activity>> getActivities() async {
    try {
      final response = await _apiClient.dio.get('/activities');

      return (response.data as List)
          .map((json) => Activity.fromJson(json))
          .toList();
    } catch (e) {
      throw ServerException(
        "Failed to fetch activities: ${e is SocketException ? 'No Internet connection' : e.toString()}",
      );
    }
  }
}
