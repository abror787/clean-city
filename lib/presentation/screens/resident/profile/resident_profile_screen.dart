import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../bloc/auth/auth_bloc.dart';
import '../../../bloc/profile/profile_bloc.dart';

class ResidentProfileScreen extends StatelessWidget {
  const ResidentProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.residentSettings);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Avatar
            const CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.primary,
              child: Icon(Icons.person, size: 50, color: Colors.white),
            ),
            const SizedBox(height: 16),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state.status == ProfileStatus.loading) {
                  return const CircularProgressIndicator();
                }
                if (state.status == ProfileStatus.success && state.profile != null) {
                  final p = state.profile!;
                  return Column(
                    children: [
                      Text('${p.firstName} ${p.lastName}', style: AppTextStyles.h2),
                      Text(p.email, style: AppTextStyles.body),
                      if (p.phone != null) Text(p.phone!, style: AppTextStyles.body),
                    ],
                  );
                }
                return const Text('Иван Иванов', style: AppTextStyles.h2);
              },
            ),
            const SizedBox(height: 32),
            
            // Stats
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatItem('Всего', '12'),
                _buildStatItem('В работе', '2'),
                _buildStatItem('Решено', '10'),
              ],
            ),
            const SizedBox(height: 32),
            
            // Menu
            _buildMenuItem(Icons.notifications_outlined, 'Уведомления', () {}),
            _buildMenuItem(Icons.language, 'Язык', () {}),
            _buildMenuItem(Icons.privacy_tip_outlined, 'Конфиденциальность', () {}),
            _buildMenuItem(Icons.help_outline, 'Помощь', () {}),
            
            const SizedBox(height: 24),
            
            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthLogoutRequested());
                Navigator.pushReplacementNamed(context, AppRoutes.residentLogin);
              },
              child: const Text(
                'Выйти',
                style: TextStyle(color: AppColors.error, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        Text(
          label,
          style: AppTextStyles.caption,
        ),
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: AppColors.textPrimary),
      title: Text(title, style: AppTextStyles.body),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.textSecondary),
      onTap: onTap,
    );
  }
}
