import 'dart:convert';
import 'dart:io';

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

      var result =
          (response.data as List).map((json) => Visit.fromJson(json)).toList();

      return result;
    } catch (e) {
      throw ServerException(
        "Failed to fetch visits: ",
      );
    }
  }

  Future<Visit> createVisit(Visit visit) async {
    try {
      final response = await _apiClient.dio.post(
        '/visits',
        data: jsonEncode(visit.toJson()),
      );

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
