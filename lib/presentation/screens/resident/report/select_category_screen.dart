import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_routes.dart';

class SelectCategoryScreen extends StatefulWidget {
  const SelectCategoryScreen({super.key});

  @override
  State<SelectCategoryScreen> createState() => _SelectCategoryScreenState();
}

class _SelectCategoryScreenState extends State<SelectCategoryScreen> {
  int? _selectedIndex;

  final List<Map<String, dynamic>> _categories = [
    {'icon': Icons.delete_outline, 'label': 'Бытовой мусор'},
    {'icon': Icons.recycling, 'label': 'Пластик'},
    {'icon': Icons.description_outlined, 'label': 'Бумага'},
    {'icon': Icons.wine_bar, 'label': 'Стекло'},
    {'icon': Icons.iron, 'label': 'Металл'},
    {'icon': Icons.battery_charging_full, 'label': 'Опасные отходы'},
    {'icon': Icons.grass, 'label': 'Органика'},
    {'icon': Icons.weekend_outlined, 'label': 'Крупногабарит'},
    {'icon': Icons.construction, 'label': 'Строительный'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Выберите категорию'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                ),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final isSelected = _selectedIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected ? AppColors.primary : AppColors.border,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _categories[index]['icon'],
                            size: 32,
                            color: isSelected ? AppColors.primary : AppColors.textSecondary,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _categories[index]['label'],
                            textAlign: TextAlign.center,
                            style: AppTextStyles.caption.copyWith(
                              color: isSelected ? AppColors.primary : AppColors.textSecondary,
                              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            
            Padding(
              padding: const EdgeInsets.all(24),
              child: SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _selectedIndex != null ? () {
                    Navigator.pushNamed(context, AppRoutes.confirmLocation);
                  } : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _selectedIndex != null ? AppColors.primary : AppColors.border,
                  ),
                  child: const Text(
                    'Далее',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
