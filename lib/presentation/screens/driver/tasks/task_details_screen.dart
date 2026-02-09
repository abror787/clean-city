import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_routes.dart';

class TaskDetailsScreen extends StatefulWidget {
  const TaskDetailsScreen({super.key});

  @override
  State<TaskDetailsScreen> createState() => _TaskDetailsScreenState();
}

class _TaskDetailsScreenState extends State<TaskDetailsScreen> {
  // 0: New, 1: In Progress
  int _status = 0; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Детали задания'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Map Placeholder
          Container(
            height: 250,
            width: double.infinity,
            color: Colors.grey[300],
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.map, size: 64, color: Colors.grey),
                  Text('Маршрут к точке'),
                ],
              ),
            ),
          ),
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ул. Амира Темура, 108',
                              style: AppTextStyles.h2,
                            ),
                            Text(
                              '1.2 км от вас',
                              style: AppTextStyles.caption,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.error.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.error),
                        ),
                        child: const Text(
                          'Высокий',
                          style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Info Cards
                  _buildInfoCard(Icons.delete_outline, 'Тип мусора', 'Бытовой мусор'),
                  const SizedBox(height: 16),
                  _buildInfoCard(Icons.access_time, 'Время создания', '12 Окт 14:30'),
                  const SizedBox(height: 16),
                  _buildInfoCard(Icons.person_outline, 'Заявитель', 'Иван И.'),
                  
                  const SizedBox(height: 24),
                  
                  const Text('Описание', style: AppTextStyles.h3),
                  const SizedBox(height: 8),
                  const Text(
                    'Мусор лежит возле дороги уже третий день. Просьба убрать.',
                    style: AppTextStyles.body,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Photo from Resident
                  const Text('Фото от жителя', style: AppTextStyles.h3),
                  const SizedBox(height: 16),
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Icon(Icons.image, size: 48, color: Colors.grey),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Action Button
          Padding(
            padding: const EdgeInsets.all(24),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  if (_status == 0) {
                    setState(() {
                      _status = 1;
                    });
                  } else {
                    Navigator.pushNamed(context, AppRoutes.proofPhoto);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _status == 0 ? AppColors.secondary : AppColors.cleaned,
                ),
                child: Text(
                  _status == 0 ? 'Принять в работу' : 'Завершить',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.secondary),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: AppTextStyles.caption),
            Text(value, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w500)),
          ],
        ),
      ],
    );
  }
}
