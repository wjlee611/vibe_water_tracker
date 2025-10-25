import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_water_tracker/src/data/repositories/intake_repository.dart';

class IntakeCubit extends Cubit<int> {
  final IntakeRepository _intakeRepository;

  IntakeCubit(this._intakeRepository) : super(0);

  Future<void> loadInitialIntake() async {
    try {
      final intake = await _intakeRepository.getTodayIntake();
      emit(intake);
    } catch (e) {
      // Handle error, maybe emit an error state
    }
  }

  Future<void> updateIntake(int changeAmount) async {
    final currentIntake = state;
    final newTotalIntake = currentIntake + changeAmount;

    if (newTotalIntake < 0) {
      return; // Cannot have negative intake
    }

    emit(newTotalIntake);

    try {
      await _intakeRepository.updateIntake(newTotalIntake, changeAmount);
    } catch (e) {
      // If the update fails, revert the state
      emit(currentIntake);
      // Optionally, rethrow the exception or handle it
    }
  }
}
