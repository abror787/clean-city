import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../bloc/auth/auth_bloc.dart';
import '../../../bloc/profile/profile_bloc.dart';

class DriverProfileScreen extends StatelessWidget {
  const DriverProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль водителя'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.secondary,
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
                      Text('ID: ${p.id}', style: AppTextStyles.body),
                      Text(p.email, style: AppTextStyles.body),
                    ],
                  );
                }
                return const Text('Петр Петров', style: AppTextStyles.h2);
              },
            ),
            const SizedBox(height: 32),
            
            _buildStatItem('Выполнено', '145'),
            
            const SizedBox(height: 32),
            
            ListTile(
              leading: const Icon(Icons.history),
              title: const Text('История выплат'),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Настройки'),
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.driverSettings);
              },
            ),
            const Divider(),
            
             TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(AuthLogoutRequested());
                Navigator.pushReplacementNamed(context, AppRoutes.driverLogin);
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
            color: AppColors.secondary,
          ),
        ),
        Text(
          label,
          style: AppTextStyles.caption,
        ),
      ],
    );
  }
}
