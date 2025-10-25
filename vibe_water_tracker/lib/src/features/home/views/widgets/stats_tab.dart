import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_water_tracker/src/features/home/cubit/stats_cubit.dart';

class StatsTab extends StatefulWidget {
  const StatsTab({super.key});

  @override
  State<StatsTab> createState() => _StatsTabState();
}

class _StatsTabState extends State<StatsTab> {
  @override
  void initState() {
    super.initState();
    // Load stats when the widget is first initialized
    context.read<StatsCubit>().loadStats();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<StatsCubit, StatsState>(
      builder: (context, state) {
        if (state is StatsLoading || state is StatsInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is StatsError) {
          return Center(child: Text('Error: ${state.message}'));
        } else if (state is StatsLoaded) {
          return RefreshIndicator(
            onRefresh: () => context.read<StatsCubit>().loadStats(),
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'My Stats',
                          style: textTheme.titleLarge,
                        ),
                        const Divider(),
                        ListTile(
                          title: const Text('Today'),
                          trailing: Text('${state.todayIntake} ml',
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        ListTile(
                          title: const Text('This Week'),
                          trailing: Text('${state.weeklyIntake} ml',
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                        ListTile(
                          title: const Text('This Month'),
                          trailing: Text('${state.monthlyIntake} ml',
                              style: const TextStyle(fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TMI (Total Member Intake)',
                          style: textTheme.titleLarge,
                        ),
                        const Divider(),
                        ListTile(
                          title: const Text('All Users\' Total'),
                          trailing: Text(
                            '${(state.totalIntake / 1000).toStringAsFixed(2)} L',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink(); // Fallback for unexpected states
      },
    );
  }
}
