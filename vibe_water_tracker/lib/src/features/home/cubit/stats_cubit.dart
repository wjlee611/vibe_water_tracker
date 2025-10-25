import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:vibe_water_tracker/src/data/repositories/intake_repository.dart';

part 'stats_state.dart';

class StatsCubit extends Cubit<StatsState> {
  final IntakeRepository _intakeRepository;

  StatsCubit(this._intakeRepository) : super(StatsInitial());

  Future<void> loadStats() async {
    try {
      emit(const StatsLoading(isLoading: true));
      final todayIntake = await _intakeRepository.getTodayIntake();
      final weeklyIntake = await _intakeRepository.getWeeklyIntake();
      final monthlyIntake = await _intakeRepository.getMonthlyIntake();
      final totalIntake = await _intakeRepository.getTotalIntake();

      emit(StatsLoaded(
        todayIntake: todayIntake,
        weeklyIntake: weeklyIntake,
        monthlyIntake: monthlyIntake,
        totalIntake: totalIntake,
      ));
    } catch (e) {
      emit(StatsError(e.toString()));
    }
  }
}