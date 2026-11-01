import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/workout_schedule_provider.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  static const Color navy = Color(0xFF111827);
  static const Color blue = Color(0xFF2563EB);
  static const Color cardColor = Color(0xFF1F2937);
  static const Color mutedColor = Color(0xFF9CA3AF);

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WorkoutScheduleProvider>().fetchSchedules();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: navy,
      appBar: AppBar(
        backgroundColor: navy,
        elevation: 0,
        title: const Text(
          'Workout Schedule',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<WorkoutScheduleProvider>().fetchSchedules();
            },
            icon: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
            tooltip: 'Refresh schedules',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Consumer<WorkoutScheduleProvider>(
        builder: (context, provider, child) {
          return RefreshIndicator(
            color: blue,
            backgroundColor: cardColor,
            onRefresh: provider.fetchSchedules,
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
              children: [
                _buildHeader(),
                const SizedBox(height: 22),
                _buildScheduleOverview(provider),
                const SizedBox(height: 28),
                _buildSectionTitle('My Workout Plans'),
                const SizedBox(height: 14),

                if (provider.isLoading)
                  _buildLoading(),

                if (!provider.isLoading &&
                    provider.errorMessage != null)
                  _buildError(provider),

                if (!provider.isLoading &&
                    provider.errorMessage == null &&
                    provider.schedules.isEmpty)
                  _buildEmptyState(),

                if (!provider.isLoading &&
                    provider.errorMessage == null &&
                    provider.schedules.isNotEmpty)
                  ...provider.schedules.map(
                    (schedule) => _buildScheduleCard(
                      name: schedule.name,
                      template: schedule.templateType,
                      description: schedule.description,
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  
Widget _buildHeader() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          const Expanded(
            child: Text(
              'Plan Your Training',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'Create Schedule form will be available '
                    'in the CRUD implementation stage.',
                  ),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            icon: const Icon(Icons.add, size: 18),
            label: const Text('Add Schedule'),
            style: ElevatedButton.styleFrom(
              backgroundColor: blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 8),
      const Text(
        'Organize your workout routines and stay consistent '
        'with your fitness goals.',
        style: TextStyle(
          color: mutedColor,
          fontSize: 13,
          height: 1.5,
        ),
      ),
    ],
  );
}



Widget _buildScheduleOverview(
  WorkoutScheduleProvider provider,
) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: const LinearGradient(
        colors: [
          Color(0xFF2563EB),
          Color(0xFF1E40AF),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        Container(
          padding: const EdgeInsets.all(13),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(14),
          ),
          child: const Icon(
            Icons.calendar_month,
            color: Colors.white,
            size: 30,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Total Workout Schedules',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                provider.isLoading
                    ? 'Loading...'
                    : '${provider.schedules.length} Plans',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 3),
              const Text(
                'Your personal training plans',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}


  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildScheduleCard({
    required String name,
    required String template,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.05),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: blue.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(13),
            ),
            child: const Icon(
              Icons.fitness_center,
              color: Color(0xFF60A5FA),
              size: 25,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  description.isEmpty
                      ? 'No description available'
                      : description,
                  style: const TextStyle(
                    color: mutedColor,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 9),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: blue.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    template,
                    style: const TextStyle(
                      color: Color(0xFF60A5FA),
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right,
            color: mutedColor,
          ),
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 55),
      child: Center(
        child: CircularProgressIndicator(
          color: blue,
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 45,
      ),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: const Column(
        children: [
          Icon(
            Icons.calendar_month_outlined,
            color: Color(0xFF60A5FA),
            size: 55,
          ),
          SizedBox(height: 18),
          Text(
            'No Workout Schedules Yet',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            'Your workout plans will appear here '
            'once you create your first schedule.',
            style: TextStyle(
              color: mutedColor,
              fontSize: 12,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildError(WorkoutScheduleProvider provider) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Column(
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.redAccent,
            size: 45,
          ),
          const SizedBox(height: 12),
          const Text(
            'Failed to Load Schedules',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            provider.errorMessage!,
            style: const TextStyle(
              color: mutedColor,
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: provider.fetchSchedules,
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }
}
