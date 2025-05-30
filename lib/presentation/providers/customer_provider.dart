import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trackly/presentation/providers/repository_provider.dart';
import '../../domain/entities/customer.dart';
import '../../domain/repositories/visits_repository.dart';

part 'customer_provider.g.dart';

@riverpod
class CustomersNotifier extends _$CustomersNotifier {
  @override
  FutureOr<List<Customer>> build() async {
    final repository = ref.read(visitsRepositoryProvider);
    return repository.getCustomers();
  }

  Future<void> refreshCustomers() async {
    state = const AsyncValue.loading();
    try {
      final repository = ref.read(visitsRepositoryProvider);
      final customers = await repository.getCustomers();
      state = AsyncValue.data(customers);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}

@riverpod
Customer? customerById(CustomerByIdRef ref, int customerId) {
  final customers = ref.watch(customersNotifierProvider);
  return customers.when(
    data:
        (customersList) => customersList.firstWhere(
          (customer) => customer.id == customerId,
          orElse: () => throw Exception('Customer not found'),
        ),
    loading: () => null,
    error: (_, __) => null,
  );
}
