import 'package:absent_project/SA/services/ApiService.dart';

import '../model/Projects.dart';

class ProjectController{
  static final ApiService _apiService = ApiService();

  static Future<List<Projects>> getProjectByCompanyIdAndDivisionId(int companyId, int divisionId) async{
    try{
      return await _apiService.getProjectByCompanyIdAndDivisionId(companyId, divisionId);
    }catch (error){
      throw Exception("Failed to fetch project");
    }
  }

  static Future<bool> addNewProjectAndAssignUser(int userId, String projectName) async{
    try{
      return await _apiService.addNewProjectAndAssignUser(userId, projectName);
    }catch (error){
      throw Exception("Failed to fetch project");
    }
  }
}