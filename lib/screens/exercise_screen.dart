import 'package:flutter/material.dart';

import '../models/wger_exercise.dart';
import 'exercise_detail_screen.dart';

class ExerciseScreen extends StatefulWidget {
  const ExerciseScreen({super.key});

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  final TextEditingController _searchController =
      TextEditingController();

  String selectedCategory = 'All';

  final List<String> categories = [
    'All',
    'Chest',
    'Back',
    'Legs',
    'Shoulders',
    'Arms',
  ];

  // Data sementara sebelum integrasi Wger API.
  final List<WgerExercise> exercises = [
    WgerExercise(
      id: 1,
      name: 'Push Up',
      description:
          'A bodyweight exercise that trains the chest, shoulders, and triceps.',
      category: 'Chest',
      muscles: ['Chest', 'Triceps', 'Shoulders'],
      equipment: [],
    ),
    WgerExercise(
      id: 2,
      name: 'Bench Press',
      description:
          'A strength exercise that targets the chest, shoulders, and triceps.',
      category: 'Chest',
      muscles: ['Chest', 'Triceps'],
      equipment: ['Barbell', 'Bench'],
    ),
    WgerExercise(
      id: 3,
      name: 'Pull Up',
      description:
          'An upper body exercise that strengthens the back and arms.',
      category: 'Back',
      muscles: ['Back', 'Biceps'],
      equipment: ['Pull-up Bar'],
    ),
    WgerExercise(
      id: 4,
      name: 'Barbell Row',
      description:
          'A compound exercise that develops back strength and muscle.',
      category: 'Back',
      muscles: ['Back', 'Biceps'],
      equipment: ['Barbell'],
    ),
    WgerExercise(
      id: 5,
      name: 'Squat',
      description:
          'A fundamental lower body exercise that targets the legs and glutes.',
      category: 'Legs',
      muscles: ['Quadriceps', 'Glutes', 'Hamstrings'],
      equipment: ['Barbell'],
    ),
    WgerExercise(
      id: 6,
      name: 'Lunges',
      description:
          'A lower body exercise that improves leg strength and balance.',
      category: 'Legs',
      muscles: ['Quadriceps', 'Glutes'],
      equipment: [],
    ),
    WgerExercise(
      id: 7,
      name: 'Shoulder Press',
      description:
          'An upper body exercise that focuses on shoulder strength.',
      category: 'Shoulders',
      muscles: ['Shoulders', 'Triceps'],
      equipment: ['Dumbbell'],
    ),
    WgerExercise(
      id: 8,
      name: 'Bicep Curl',
      description:
          'An isolation exercise designed to strengthen the biceps.',
      category: 'Arms',
      muscles: ['Biceps'],
      equipment: ['Dumbbell'],
    ),
  ];

  List<WgerExercise> get filteredExercises {
    final query = _searchController.text.toLowerCase();

    return exercises.where((exercise) {
      final matchesSearch =
          exercise.name.toLowerCase().contains(query);

      final matchesCategory =
          selectedCategory == 'All' ||
          exercise.category == selectedCategory;

      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercise Library'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              _buildSearchBar(),
              _buildCategoryFilter(),
              _buildExerciseList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Explore Exercises',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Discover exercises and build your strength.',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade400,
            ),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              const Icon(
                Icons.fitness_center,
                color: Color(0xFF2563EB),
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '${filteredExercises.length} Exercises Available',
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: _searchController,
        onChanged: (_) => setState(() {}),
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Search exercises...',
          prefixIcon: const Icon(Icons.search),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    _searchController.clear();
                    setState(() {});
                  },
                )
              : null,
          filled: true,
          fillColor: const Color(0xFF1F2937),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  
  Widget _buildCategoryFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 14,
      ),
      child: Wrap(
        spacing: 8,
        runSpacing: 10,
        children: categories.map((category) {
          final isSelected = selectedCategory == category;

          return ChoiceChip(
            label: Text(category),
            selected: isSelected,
            onSelected: (_) {
              setState(() {
                selectedCategory = category;
              });
            },
            selectedColor: const Color(0xFF2563EB),
            backgroundColor: const Color(0xFF1F2937),
            labelStyle: TextStyle(
              color: isSelected
                  ? Colors.white
                  : Colors.grey.shade300,
              fontWeight: FontWeight.w600,
            ),
            side: BorderSide.none,
          );
        }).toList(),
      ),
    );
  }


  Widget _buildExerciseList() {
    final items = filteredExercises;

    if (items.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.search_off,
                size: 55,
                color: Colors.grey.shade500,
              ),
              const SizedBox(height: 12),
              const Text(
                'No Exercises Found',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Try another keyword or category.',
                style: TextStyle(color: Colors.grey.shade400),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
      itemCount: items.length,
      separatorBuilder: (_, _) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final exercise = items[index];

        return _buildExerciseCard(exercise);
      },
    );
  }

  Widget _buildExerciseCard(WgerExercise exercise) {
    return Card(
      color: const Color(0xFF1F2937),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ExerciseDetailScreen(
                exercise: exercise,
              ),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.fitness_center,
                  color: Color(0xFF3B82F6),
                  size: 28,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      exercise.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      exercise.category,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF60A5FA),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      exercise.muscles.join(', '),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.chevron_right,
                color: Colors.grey.shade400,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
