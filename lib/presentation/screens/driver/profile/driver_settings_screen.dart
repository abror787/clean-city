import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_routes.dart';

class DriverSettingsScreen extends StatefulWidget {
  const DriverSettingsScreen({super.key});

  @override
  State<DriverSettingsScreen> createState() => _DriverSettingsScreenState();
}

class _DriverSettingsScreenState extends State<DriverSettingsScreen> {
  bool _notificationsEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Настройки'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Уведомления', style: AppTextStyles.body),
            subtitle: const Text('Получать пуш-уведомления о заданиях', style: AppTextStyles.caption),
            value: _notificationsEnabled,
            onChanged: (bool value) {
              setState(() {
                _notificationsEnabled = value;
              });
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Язык / Language', style: AppTextStyles.body),
            subtitle: Text(context.locale.languageCode.toUpperCase(), style: AppTextStyles.caption),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              _showLanguageBottomSheet(context);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Редактировать профиль', style: AppTextStyles.body),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.editProfile);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Сменить пароль', style: AppTextStyles.body),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              Navigator.pushNamed(context, AppRoutes.editProfile);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Выйти', style: TextStyle(color: Colors.red)),
            onTap: () {
              // Navigate to Role Selection or Login
              Navigator.pushNamedAndRemoveUntil(context, AppRoutes.roleSelection, (route) => false);
            },
          ),
        ],
      ),
    );
  }

  void _showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Text('🇷🇺', style: TextStyle(fontSize: 24)),
                title: const Text('Русский'),
                trailing: context.locale.languageCode == 'ru' ? const Icon(Icons.check, color: Colors.green) : null,
                onTap: () {
                  context.setLocale(const Locale('ru'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Text('🇺🇸', style: TextStyle(fontSize: 24)),
                title: const Text('English'),
                trailing: context.locale.languageCode == 'en' ? const Icon(Icons.check, color: Colors.green) : null,
                onTap: () {
                  context.setLocale(const Locale('en'));
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Text('🇺🇿', style: TextStyle(fontSize: 24)),
                title: const Text('O\'zbek'),
                trailing: context.locale.languageCode == 'uz' ? const Icon(Icons.check, color: Colors.green) : null,
                onTap: () {
                  context.setLocale(const Locale('uz'));
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
