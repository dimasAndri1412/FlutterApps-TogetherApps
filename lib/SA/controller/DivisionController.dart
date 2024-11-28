import 'package:absent_project/SA/services/ApiService.dart';

import '../model/Divisions.dart';

class DivisionController{
  static final ApiService _apiService = ApiService();

  static Future<List<Divisions>> getDivisionsByCompanyId(int companyId) async {
    try {
      return await _apiService.getDivisionsByCompanyId(companyId);
    } catch (error) {
      throw Exception('Failed to fetch division');
    }
  }
}