import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_gradients.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../bloc/driver/driver_task_bloc.dart';
import '../../../bloc/profile/profile_bloc.dart';
import '../profile/driver_profile_screen.dart';
import '../tasks/driver_task_history_screen.dart';

class DriverDashboardScreen extends StatefulWidget {
  const DriverDashboardScreen({super.key});

  @override
  State<DriverDashboardScreen> createState() => _DriverDashboardScreenState();
}

class _DriverDashboardScreenState extends State<DriverDashboardScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Use addPostFrameCallback to safely access context after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileBloc>().add(ProfileFetchRequested());
      context.read<DriverTaskBloc>().add(FetchDriverTasks());
    });
  }

  final List<Widget> _screens = [
    const DriverTasksTab(),
    const DriverTaskHistoryScreen(),
    const DriverProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _screens[_currentIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          backgroundColor: Colors.white,
          elevation: 0,
          indicatorColor: AppColors.secondary.withOpacity(0.1),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.list_alt_outlined),
              selectedIcon: Icon(Icons.list_alt, color: AppColors.secondary),
              label: 'Задания',
            ),
            NavigationDestination(
              icon: Icon(Icons.history_outlined),
              selectedIcon: Icon(Icons.history, color: AppColors.secondary),
              label: 'История',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person, color: AppColors.secondary),
              label: 'Профиль',
            ),
          ],
        ),
      ),
    );
  }
}

class DriverTasksTab extends StatelessWidget {
  const DriverTasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Header
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.secondary,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(gradient: AppGradients.driver),
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BlocBuilder<ProfileBloc, ProfileState>(
                        builder: (context, state) {
                          String name = '...';
                          if (state.status == ProfileStatus.success &&
                              state.profile != null) {
                            name = state.profile!.firstName;
                          }
                          return Text(
                            'Привет, $name!',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ).animate().fadeIn().slideX();
                        },
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Готов к работе?',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ).animate().fadeIn(delay: 200.ms).slideX(),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Content
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildSectionHeader('Текущие задания'),
                const SizedBox(height: 16),

                BlocBuilder<DriverTaskBloc, DriverTaskState>(
                  builder: (context, state) {
                    if (state is DriverTaskLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is DriverTaskError) {
                      return Center(child: Text(state.message));
                    }
                    if (state is DriverTasksLoaded) {
                      if (state.tasks.isEmpty) {
                        return const Center(
                          child: Text('Нет назначенных заданий'),
                        );
                      }
                      return Column(
                        children: state.tasks.asMap().entries.map((entry) {
                          final task = entry.value;
                          final index = entry.key;
                          return _buildTaskCard(
                            context,
                            id: task.id,
                            address: task.title,
                            description: 'Статус: ${task.status}',
                            distance: task.createdAt,
                            isPriority: false,
                            // Could be derived from status if needed
                            delay: (300 + (index * 100)).ms,
                          );
                        }).toList(),
                      );
                    }
                    return const SizedBox();
                  },
                ),

                const SizedBox(height: 80),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildTaskCard(
    BuildContext context, {
    required String id,
    required String address,
    required String description,
    required String distance,
    required bool isPriority,
    required Duration delay,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, AppRoutes.taskDetails, arguments: id);
          },
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.secondary.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.location_on,
                    color: AppColors.secondary,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        address,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: TextStyle(
                          color: isPriority
                              ? AppColors.error
                              : AppColors.textSecondary,
                          fontSize: 12,
                          fontWeight: isPriority
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        distance,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: AppColors.border,
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: delay).slideY(begin: 0.2);
  }
}
