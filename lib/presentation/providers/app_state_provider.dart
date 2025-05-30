import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:trackly/core/constants/enums.dart';
import 'package:trackly/data/models/app_models.dart';

part 'app_state_provider.g.dart';

@riverpod
class AppState extends _$AppState {
  @override
  AppStateModel build() => const AppStateModel();

  void setLoading(bool isLoading) {
    state = state.copyWith(isLoading: isLoading);
  }

  void setError(String? error) {
    state = state.copyWith(error: error);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }
}

