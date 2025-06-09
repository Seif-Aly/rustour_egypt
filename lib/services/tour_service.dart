import 'package:dio/dio.dart';
import '../models/tour.dart';
import '../models/tour_search_request.dart';
import 'api_client.dart';

class TourService {
  TourService(this._api);
  final ApiClient _api;

  Dio get _dio => _api.dio;

  Future<List<Tour>> getAll() async {
    final res = await _dio.get('/tours');
    return (res.data as List)
        .map((e) => Tour.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<Tour>> search(TourSearchRequest req) async {
    final res = await _dio.post('/tours/search', data: req.toJson());
    return (res.data as List)
        .map((e) => Tour.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<Tour> getById(int id) async {
    final res = await _dio.get('/tours/$id');
    return Tour.fromJson(res.data as Map<String, dynamic>);
  }
}
