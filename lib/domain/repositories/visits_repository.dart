import 'package:trackly/domain/entities/activity.dart';
import 'package:trackly/domain/entities/customer.dart';
import 'package:trackly/domain/entities/visit.dart';

abstract class VisitsRepository {
  Future<List<Visit>> getVisits();
  Future<Visit> createVisit(Visit visit);
  Future<List<Customer>> getCustomers();
  Future<List<Activity>> getActivities();
  Future<List<Visit>> searchVisits(String query);
}
