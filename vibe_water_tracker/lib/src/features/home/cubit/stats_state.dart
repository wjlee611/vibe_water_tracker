part of 'stats_cubit.dart';

abstract class StatsState extends Equatable {
  const StatsState();

  @override
  List<Object> get props => [];
}

class StatsInitial extends StatsState {}

class StatsLoading extends StatsState {
  final bool isLoading;

  const StatsLoading({this.isLoading = true});

  @override
  List<Object> get props => [isLoading];
}

class StatsLoaded extends StatsState {
  final double todayIntake;
  final double weeklyIntake;
  final double monthlyIntake;
  final double totalIntake;

  const StatsLoaded({
    required this.todayIntake,
    required this.weeklyIntake,
    required this.monthlyIntake,
    required this.totalIntake,
  });

  @override
  List<Object> get props => [
        todayIntake,
        weeklyIntake,
        monthlyIntake,
        totalIntake,
      ];
}

class StatsError extends StatsState {
  final String message;

  const StatsError(this.message);

  @override
  List<Object> get props => [message];
}