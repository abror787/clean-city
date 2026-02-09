import 'package:dio/dio.dart';
import '../../constants/api_constants.dart';
import 'waste_event_models.dart';

abstract class WasteEventRepository {
  Future<List<PublicWasteEventResponse>> getAllEvents();
  Future<List<PublicWasteEventResponse>> getMyEvents();
  Future<PublicWasteEventResponse> reportWaste(WasteReportRequest request);
  Future<PublicWasteEventResponse> getEventById(int id);
}

class WasteEventRepositoryImpl implements WasteEventRepository {
  final Dio dio;

  WasteEventRepositoryImpl({required this.dio});

  @override
  Future<List<PublicWasteEventResponse>> getAllEvents() async {
    try {
      final response = await dio.get(ApiConstants.wasteEvents);
      return (response.data as List)
          .map((e) => PublicWasteEventResponse.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to fetch events');
    }
  }

  @override
  Future<List<PublicWasteEventResponse>> getMyEvents() async {
    try {
      final response = await dio.get(ApiConstants.myWasteEvents);
      return (response.data as List)
          .map((e) => PublicWasteEventResponse.fromJson(e))
          .toList();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to fetch my events');
    }
  }

  @override
  Future<PublicWasteEventResponse> reportWaste(WasteReportRequest request) async {
    try {
      final response = await dio.post(
        ApiConstants.wasteEvents,
        data: request.toJson(),
      );
      return PublicWasteEventResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to report waste');
    }
  }

  @override
  Future<PublicWasteEventResponse> getEventById(int id) async {
    try {
      final response = await dio.get('${ApiConstants.wasteEventById}$id');
      return PublicWasteEventResponse.fromJson(response.data);
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to fetch event detail');
    }
  }
}
