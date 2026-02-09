import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../../core/constants/app_routes.dart';
import '../../../../core/models/report_data.dart';
import '../../../../core/network/media/media_repository.dart';
import '../../../../core/network/waste_event/waste_event_models.dart';
import '../../../bloc/waste_event/waste_event_bloc.dart';
import '../../../../core/di/injection_container.dart' as di;

class AdditionalDetailsScreen extends StatefulWidget {
  final ReportData reportData;

  const AdditionalDetailsScreen({super.key, required this.reportData});

  @override
  State<AdditionalDetailsScreen> createState() =>
      _AdditionalDetailsScreenState();
}

class _AdditionalDetailsScreenState extends State<AdditionalDetailsScreen> {
  final TextEditingController _commentController = TextEditingController();
  bool _isSubmitting = false;

  Future<void> _submitReport() async {
    if (_isSubmitting) return;

    setState(() => _isSubmitting = true);

    try {
      String? mediaToken;

      // Step 1: Upload image if exists
      if (widget.reportData.imageFile != null) {
        final mediaRepo = di.sl<MediaRepository>();
        final uploadResponse = await mediaRepo.uploadImage(
          widget.reportData.imageFile!,
        );
        mediaToken = uploadResponse.token;
        debugPrint('📸 Image uploaded, token: $mediaToken');
      }

      // Step 2: Create waste report request
      final request = WasteReportRequest(
        category: widget.reportData.category ?? 'HOUSEHOLD',
        description: _commentController.text.isNotEmpty
            ? _commentController.text
            : 'Без описания',
        latitude: widget.reportData.latitude ?? 0.0,
        longitude: widget.reportData.longitude ?? 0.0,
        mediaToken: mediaToken,
      );

      // Step 3: Submit via BLoC
      if (mounted) {
        context.read<WasteEventBloc>().add(ReportWasteRequested(request));
      }
    } catch (e) {
      setState(() => _isSubmitting = false);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Ошибка: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WasteEventBloc, WasteEventState>(
      listener: (context, state) {
        if (state is WasteEventSuccess) {
          // Navigate to success screen
          Navigator.pushNamedAndRemoveUntil(
            context,
            AppRoutes.reportSuccess,
            (route) => route.settings.name == AppRoutes.residentDashboard,
          );
        } else if (state is WasteEventError) {
          setState(() => _isSubmitting = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message), backgroundColor: Colors.red),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Детали'), centerTitle: true),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Дополнительная информация',
                  style: AppTextStyles.h2,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Опишите проблему подробнее, чтобы мы могли быстрее ее решить',
                  style: AppTextStyles.caption,
                ),
                const SizedBox(height: 24),

                // Image Preview
                if (widget.reportData.imageFile != null) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(
                      widget.reportData.imageFile!,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],

                // Category Badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Категория: ${widget.reportData.category ?? "Не выбрана"}',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Location Info
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.grey, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        '${widget.reportData.latitude?.toStringAsFixed(4)}, ${widget.reportData.longitude?.toStringAsFixed(4)}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Comment Field
                TextField(
                  controller: _commentController,
                  maxLines: 5,
                  enabled: !_isSubmitting,
                  decoration: InputDecoration(
                    hintText:
                        'Например: "Мусор лежит уже неделю, запах сильный..."',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.border),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: AppColors.primary,
                        width: 2,
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 24),

                // Submit Button
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _isSubmitting ? null : _submitReport,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isSubmitting
                        ? const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              ),
                              SizedBox(width: 12),
                              Text('Отправка...'),
                            ],
                          )
                        : const Text(
                            'Отправить заявку',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }
}
