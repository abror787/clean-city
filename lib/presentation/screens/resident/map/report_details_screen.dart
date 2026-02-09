import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class ReportDetailsScreen extends StatelessWidget {
  const ReportDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Заявка #12345'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status Badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.reported.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.reported),
              ),
              child: const Text(
                'Новая заявка',
                style: TextStyle(color: AppColors.reported, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 16),
            
            // Photo
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Center(
                child: Icon(Icons.image, size: 64, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 24),
            
            // Info Sections
            _buildInfoSection('Категория', 'Бытовой мусор', Icons.delete_outline),
            _buildInfoSection('Адрес', 'ул. Амира Темура, 108', Icons.location_on_outlined),
            _buildInfoSection('Дата', '12 Окт 2023, 14:30', Icons.access_time),
            
            const SizedBox(height: 24),
            const Text('Описание', style: AppTextStyles.h3),
            const SizedBox(height: 8),
            const Text(
              'Мусор лежит возле дороги уже третий день. Просьба убрать.',
              style: AppTextStyles.body,
            ),
            
            const SizedBox(height: 32),
            
            // Timeline (Simplified)
            const Text('История статусов', style: AppTextStyles.h3),
            const SizedBox(height: 16),
            _buildTimelineItem('Создано', '12 Окт 14:30', true),
            _buildTimelineItem('В работе', '---', false),
            _buildTimelineItem('Выполнено', '---', false),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: AppColors.textSecondary, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.caption),
                const SizedBox(height: 4),
                Text(value, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(String status, String date, bool isActive) {
    return Row(
      children: [
        Column(
          children: [
            Container(
              height: 12,
              width: 12,
              decoration: BoxDecoration(
                color: isActive ? AppColors.primary : Colors.grey[300],
                shape: BoxShape.circle,
              ),
            ),
            Container(
              height: 24,
              width: 2,
              color: Colors.grey[300],
            ),
          ],
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                status,
                style: TextStyle(
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  color: isActive ? Colors.black : Colors.grey,
                ),
              ),
            ],
          ),
        ),
        Text(date, style: AppTextStyles.caption),
      ],
    );
  }
}
