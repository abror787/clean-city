import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/models/report_data.dart';

class SelectCategoryScreen extends StatefulWidget {
  final ReportData reportData;

  const SelectCategoryScreen({super.key, required this.reportData});

  @override
  State<SelectCategoryScreen> createState() => _SelectCategoryScreenState();
}

class _SelectCategoryScreenState extends State<SelectCategoryScreen> {
  int? _selectedIndex;

  // Categories matching Swagger WasteCategory enum
  final List<Map<String, dynamic>> _categories = [
    {
      'key': 'HOUSEHOLD',
      'icon': Icons.delete_outline,
      'label': 'Бытовой мусор',
    },
    {'key': 'PLASTIC', 'icon': Icons.recycling, 'label': 'Пластик'},
    {'key': 'PAPER', 'icon': Icons.description_outlined, 'label': 'Бумага'},
    {'key': 'GLASS', 'icon': Icons.wine_bar, 'label': 'Стекло'},
    {'key': 'METAL', 'icon': Icons.iron, 'label': 'Металл'},
    {
      'key': 'HAZARDOUS',
      'icon': Icons.battery_charging_full,
      'label': 'Опасные отходы',
    },
    {'key': 'ORGANIC', 'icon': Icons.grass, 'label': 'Органика'},
    {'key': 'BULKY', 'icon': Icons.weekend_outlined, 'label': 'Крупногабарит'},
    {
      'key': 'CONSTRUCTION',
      'icon': Icons.construction,
      'label': 'Строительный',
    },
  ];

  void _proceed() {
    if (_selectedIndex != null) {
      final category = _categories[_selectedIndex!]['key'] as String;
      final updatedData = widget.reportData.copyWith(category: category);
      Navigator.pushNamed(
        context,
        AppRoutes.confirmLocation,
        arguments: updatedData,
      );
    }
  }

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
                        color: isSelected
                            ? AppColors.primary.withOpacity(0.1)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primary
                              : AppColors.border,
                          width: isSelected ? 2 : 1,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            _categories[index]['icon'],
                            size: 32,
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.textSecondary,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            _categories[index]['label'],
                            textAlign: TextAlign.center,
                            style: AppTextStyles.caption.copyWith(
                              color: isSelected
                                  ? AppColors.primary
                                  : AppColors.textSecondary,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
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
                  onPressed: _selectedIndex != null ? _proceed : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor: AppColors.border,
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
