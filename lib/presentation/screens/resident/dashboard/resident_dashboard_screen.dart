import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_gradients.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../bloc/profile/profile_bloc.dart';
import '../../../bloc/waste_event/waste_event_bloc.dart';
import '../map/city_map_screen.dart';
import '../history/resident_history_screen.dart';
import '../profile/resident_profile_screen.dart';

class ResidentDashboardScreen extends StatefulWidget {
  const ResidentDashboardScreen({super.key});

  @override
  State<ResidentDashboardScreen> createState() =>
      _ResidentDashboardScreenState();
}

class _ResidentDashboardScreenState extends State<ResidentDashboardScreen> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // Use addPostFrameCallback to safely access context after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileBloc>().add(ProfileFetchRequested());
      context.read<WasteEventBloc>().add(FetchAllWasteEvents());
    });
  }

  final List<Widget> _screens = [
    const ResidentHomeTab(), // Created below in same file for now or import
    const CityMapScreen(), // Reuse existing
    const ResidentHistoryScreen(), // Reuse existing
    const ResidentProfileScreen(), // Reuse existing
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // For transparent nav bar feeling
      body: _screens[_currentIndex],
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.takePhoto);
              },
              backgroundColor: AppColors.primary,
              icon: const Icon(Icons.camera_alt),
              label: const Text('Сообщить'),
            ).animate().scale(delay: 500.ms)
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
          indicatorColor: AppColors.primary.withOpacity(0.1),
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home, color: AppColors.primary),
              label: 'Главная',
            ),
            NavigationDestination(
              icon: Icon(Icons.map_outlined),
              selectedIcon: Icon(Icons.map, color: AppColors.primary),
              label: 'Карта',
            ),
            NavigationDestination(
              icon: Icon(Icons.history_outlined),
              selectedIcon: Icon(Icons.history, color: AppColors.primary),
              label: 'История',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person, color: AppColors.primary),
              label: 'Профиль',
            ),
          ],
        ),
      ),
    );
  }
}

class ResidentHomeTab extends StatelessWidget {
  const ResidentHomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Collapsible Header
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            backgroundColor: AppColors.primary,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: AppGradients.resident,
                ),
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
                        'Сделаем город чище вместе',
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
                _buildSectionHeader('Статистика'),
                const SizedBox(height: 16),
                BlocBuilder<WasteEventBloc, WasteEventState>(
                  builder: (context, state) {
                    int total = 0;
                    int solved = 0;
                    if (state is WasteEventsLoaded) {
                      total = state.events.length;
                      solved = state.events
                          .where(
                            (e) =>
                                e.status == 'RESOLVED' ||
                                e.status == 'COMPLETED',
                          )
                          .length;
                    }
                    return Row(
                      children: [
                        Expanded(
                          child: _buildStatCard(
                            'Заявок',
                            total.toString(),
                            Colors.orange,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _buildStatCard(
                            'Решено',
                            solved.toString(),
                            Colors.green,
                          ),
                        ),
                      ],
                    ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2);
                  },
                ),

                const SizedBox(height: 32),

                _buildSectionHeader('Последние заявки'),
                const SizedBox(height: 16),

                BlocBuilder<WasteEventBloc, WasteEventState>(
                  builder: (context, state) {
                    if (state is WasteEventLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is WasteEventError) {
                      return Center(child: Text(state.message));
                    }
                    if (state is WasteEventsLoaded) {
                      if (state.events.isEmpty) {
                        return const Center(child: Text('Нет заявок'));
                      }
                      // Show top 3 recent
                      final recent = state.events.take(3).toList();
                      return Column(
                        children: recent.asMap().entries.map((entry) {
                          final e = entry.value;
                          final index = entry.key;
                          Color statusColor = Colors.orange;
                          if (e.status == 'IN_PROGRESS' ||
                              e.status == 'ASSIGNED')
                            statusColor = Colors.blue;
                          if (e.status == 'RESOLVED' || e.status == 'COMPLETED')
                            statusColor = Colors.green;

                          return _buildRecentItem(
                            title: e.title,
                            address:
                                'Координаты: ${e.latitude}, ${e.longitude}',
                            date: e.createdAt,
                            status: e.status,
                            statusColor: statusColor,
                            delay: (400 + (index * 100)).ms,
                          );
                        }).toList(),
                      );
                    }
                    return const SizedBox();
                  },
                ),

                const SizedBox(
                  height: 80,
                ), // Bottom padding for FAB and Nav Bar
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

  Widget _buildStatCard(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: color.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentItem({
    required String title,
    required String address,
    required String date,
    required String status,
    required Color statusColor,
    required Duration delay,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: statusColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.delete_outline, color: statusColor),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  address,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                date,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(delay: delay).slideX(begin: 0.1, end: 0);
  }
}
