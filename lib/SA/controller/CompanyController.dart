import 'package:absent_project/SA/services/ApiService.dart';

import '../model/Companies.dart';

class CompanyController{
  static final ApiService _apiService = ApiService();

  static Future<List<Companies>> getCompany() async {
    try {
      return await _apiService.getCompany();
    } catch (error) {
      throw Exception('Failed to fetch company');
    }
  }
}