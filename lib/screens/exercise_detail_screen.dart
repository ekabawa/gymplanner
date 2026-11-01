
import 'package:flutter/material.dart';

import '../models/wger_exercise.dart';

class ExerciseDetailScreen extends StatelessWidget {
  final WgerExercise exercise;

  const ExerciseDetailScreen({
    super.key,
    required this.exercise,
  });

  static const Color navy = Color(0xFF111827);
  static const Color blue = Color(0xFF2563EB);
  static const Color cardColor = Color(0xFF1F2937);
  static const Color mutedColor = Color(0xFF9CA3AF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: navy,
      appBar: AppBar(
        backgroundColor: navy,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Exercise Details',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildExerciseHeader(),
            const SizedBox(height: 28),
            _buildSectionTitle('Description'),
            const SizedBox(height: 12),
            _buildDescription(),
            const SizedBox(height: 24),
            _buildSectionTitle('Target Muscles'),
            const SizedBox(height: 12),
            _buildChipList(exercise.muscles),
            const SizedBox(height: 24),
            _buildSectionTitle('Equipment'),
            const SizedBox(height: 12),
            _buildChipList(exercise.equipment),
            const SizedBox(height: 24),
            _buildSectionTitle('Exercise Category'),
            const SizedBox(height: 12),
            _buildCategoryCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildExerciseHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(22),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.fitness_center,
            color: Colors.white,
            size: 42,
          ),
          const SizedBox(height: 18),
          Text(
            exercise.name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Exercise ID: ${exercise.id}',
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
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

  Widget _buildDescription() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        exercise.description.trim().isEmpty
            ? 'No description available.'
            : exercise.description,
        style: const TextStyle(
          color: mutedColor,
          fontSize: 13,
          height: 1.6,
        ),
      ),
    );
  }

  Widget _buildChipList(List<String> items) {
    if (items.isEmpty) {
      return const Text(
        'No information available.',
        style: TextStyle(
          color: mutedColor,
          fontSize: 13,
        ),
      );
    }

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: items.map((item) {
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 13,
            vertical: 9,
          ),
          decoration: BoxDecoration(
            color: blue.withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            item,
            style: const TextStyle(
              color: Color(0xFF60A5FA),
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildCategoryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.category_outlined,
            color: blue,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              exercise.category.isEmpty
                  ? 'Uncategorized'
                  : exercise.category,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
