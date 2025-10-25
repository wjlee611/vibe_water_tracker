import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vibe_water_tracker/src/features/home/cubit/intake_cubit.dart';

class WaterIntakeTab extends StatelessWidget {
  const WaterIntakeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return BlocBuilder<IntakeCubit, double>(
      builder: (context, intake) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Today\'s Intake',
                style: textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(
                '${intake.toInt()} ml',
                style: textTheme.displayLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      context.read<IntakeCubit>().updateIntake(10.0);
                    },
                    child: const Text('호록\n+10ml'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<IntakeCubit>().updateIntake(30.0);
                    },
                    child: const Text('꼴깍\n+30ml'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.read<IntakeCubit>().updateIntake(50.0);
                    },
                    child: const Text('꿀꺽\n+50ml'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  context.read<IntakeCubit>().updateIntake(-30.0);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                child: const Text('조록\n-30ml'),
              ),
            ],
          ),
        );
      },
    );
  }
}
