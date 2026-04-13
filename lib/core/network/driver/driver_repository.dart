import 'package:dio/dio.dart';
import '../../constants/api_constants.dart';
import '../../constants/demo_constants.dart';
import 'driver_models.dart';

abstract class DriverRepository {
  Future<List<DriverTaskSummary>> getAssignedTasks();
  Future<DriverTaskDetail> getTaskDetail(String id);
  Future<void> acceptTask(String id);
  Future<void> completeTask(String id, {String? mediaToken});
  Future<void> failTask(String id);
}

class DriverRepositoryImpl implements DriverRepository {
  final Dio dio;

  DriverRepositoryImpl({required this.dio});

  @override
  Future<List<DriverTaskSummary>> getAssignedTasks() async {
    if (kDemoMode) {
      return _mockGetAssignedTasks();
    }

    try {
      final response = await dio.get(ApiConstants.driverTasks);
      return (response.data as List)
          .map((e) => DriverTaskSummary.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to fetch tasks');
    }
  }

  @override
  Future<DriverTaskDetail> getTaskDetail(String id) async {
    if (kDemoMode) {
      return _mockGetTaskDetail(id);
    }

    try {
      final response = await dio.get('${ApiConstants.driverTaskById}$id');
      return DriverTaskDetail.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['message'] ?? 'Failed to fetch task detail');
    }
  }

  @override
  Future<void> acceptTask(String id) async {
    if (kDemoMode) {
      return _mockAcceptTask(id);
    }

    try {
      await dio.post(
          '${ApiConstants.driverTaskById}$id${ApiConstants.driverTaskAccept}');
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to accept task');
    }
  }

  @override
  Future<void> completeTask(String id, {String? mediaToken}) async {
    if (kDemoMode) {
      return _mockCompleteTask(id);
    }

    try {
      await dio.post(
        '${ApiConstants.driverTaskById}$id${ApiConstants.driverTaskComplete}',
        data: CompleteTaskRequest(mediaToken: mediaToken).toJson(),
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to complete task');
    }
  }

  @override
  Future<void> failTask(String id) async {
    if (kDemoMode) {
      return _mockFailTask(id);
    }

    try {
      await dio.post(
          '${ApiConstants.driverTaskById}$id${ApiConstants.driverTaskFail}');
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['message'] ?? 'Failed to report task failure');
    }
  }

  // Demo mode mock methods
  List<DriverTaskSummary> _mockGetAssignedTasks() {
    return DemoData.driverTasks;
  }

  DriverTaskDetail _mockGetTaskDetail(String id) {
    return DemoData.getTaskDetail(id);
  }

  void _mockAcceptTask(String id) {
    // No-op in demo mode
  }

  void _mockCompleteTask(String id) {
    // No-op in demo mode
  }

  void _mockFailTask(String id) {
    // No-op in demo mode
  }
}
