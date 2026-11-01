import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/workout_schedule_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 28),
              _buildWelcomeCard(),
              const SizedBox(height: 24),
              _buildSectionTitle('Workout Overview'),
              const SizedBox(height: 12),
              _buildOverview(),
              const SizedBox(height: 28),
              _buildSectionTitle('Choose Your Training Style'),
              const SizedBox(height: 12),
              _buildWorkoutTemplates(),
              const SizedBox(height: 28),
              _buildSectionTitle('Quick Access'),
              const SizedBox(height: 12),
              _buildQuickAccess(),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(11),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 0, 0, 0),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Image.asset(
            'assets/images/Logo.png.png',
            width: 35,
            height: 35,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 12),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GYMPLANNER',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              Text(
                'Your personal workout planner',
                style: TextStyle(
                  color: mutedColor,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const CircleAvatar(
          backgroundColor: cardColor,
          child: Icon(
            Icons.person_outline,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  
  Widget _buildWelcomeCard() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final imageWidth = constraints.maxWidth * 0.62;

        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: const Alignment(0.45, 0.35),
              radius: 1.15,
              colors: [
                blue.withValues(alpha: 0.22),
                blue.withValues(alpha: 0.09),
                Colors.transparent,
              ],
              stops: const [0.0, 0.58, 1.0],
            ),
          ),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              // Background glow
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: const Alignment(0.9, 0.2),
                      radius: 0.85,
                      colors: [
                        blue.withValues(alpha: 0.16),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              // Athlete image with soft fading edges
              Positioned(
                right: -12,
                top: -12,
                bottom: -12,
                width: imageWidth,
                child: ShaderMask(
                  blendMode: BlendMode.dstIn,
                  shaderCallback: (bounds) {
                    return const RadialGradient(
                      center: Alignment(0.58, 0.48),
                      radius: 0.78,
                      colors: [
                        Colors.black,
                        Colors.black,
                        Colors.transparent,
                      ],
                      stops: [0.0, 0.62, 1.0],
                    ).createShader(bounds);
                  },
                  child: Image.asset(
                    'assets/images/athlete_dumbbell.jpg',
                    fit: BoxFit.cover,
                    alignment: Alignment.topCenter,
                  ),
                ),
              ),

              // Text content
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 4,
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 62,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'Build Your\nStrength.\nReach Your Goals.',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 23,
                              height: 1.22,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Plan your workouts and stay consistent '
                            'with your fitness journey.',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.78),
                              fontSize: 12,
                              height: 1.45,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Row(
                            children: [
                              Icon(
                                Icons.bolt,
                                color: Color(0xFF60A5FA),
                                size: 18,
                              ),
                              SizedBox(width: 7),
                              Flexible(
                                child: Text(
                                  'Stay Strong. Stay Consistent.',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Expanded(
                      flex: 38,
                      child: SizedBox(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
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

  Widget _buildOverview() {
    return Consumer<WorkoutScheduleProvider>(
      builder: (context, provider, child) {
        final scheduleCount = provider.schedules.length;

        return Row(
          children: [
            Expanded(
              child: _buildStatCard(
                icon: Icons.calendar_month,
                title: 'Total Schedules',
                value: provider.isLoading ? '...' : '$scheduleCount',
                description: 'Saved workout plans',
                color: blue,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildStatCard(
                icon: Icons.fitness_center,
                title: 'Training Plans',
                value: '3',
                description: 'Available templates',
                color: const Color(0xFF059669),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required String description,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.06),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 25),
          const SizedBox(height: 14),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(
              color: mutedColor,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutTemplates() {
    return Column(
      children: [
        _buildTemplateCard(
          title: 'Push Pull Legs',
          subtitle: 'Train by movement groups',
          icon: Icons.fitness_center,
          tag: 'PPL',
        ),
        const SizedBox(height: 10),
        _buildTemplateCard(
          title: 'Upper Lower',
          subtitle: 'Separate upper and lower body',
          icon: Icons.accessibility_new,
          tag: 'U/L',
        ),
        const SizedBox(height: 10),
        _buildTemplateCard(
          title: 'Bro Split',
          subtitle: 'Focus on one muscle group',
          icon: Icons.sports_gymnastics,
          tag: 'BRO',
        ),
      ],
    );
  }

  Widget _buildTemplateCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required String tag,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: blue.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: blue, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: mutedColor,
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: blue.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              tag,
              style: const TextStyle(
                color: Color(0xFF60A5FA),
                fontWeight: FontWeight.bold,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccess() {
    return Row(
      children: [
        Expanded(
          child: _buildAccessCard(
            icon: Icons.calendar_month,
            title: 'Schedule',
            subtitle: 'Manage your plans',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildAccessCard(
            icon: Icons.search,
            title: 'Exercises',
            subtitle: 'Explore exercises',
          ),
        ),
      ],
    );
  }

  Widget _buildAccessCard({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: blue, size: 26),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            subtitle,
            style: const TextStyle(
              color: mutedColor,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}
