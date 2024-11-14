import 'dart:convert';
import 'package:absent_project/RevampRegistrations/materialRewvamp/dropDownCompanyValues.dart';
import 'package:absent_project/RevampRegistrations/materialRewvamp/dropDownDivionsValues.dart';
import 'package:absent_project/RevampRegistrations/materialRewvamp/dropDownPositionValues.dart';
import 'package:http/http.dart' as http;

class dropDownRegistrationList {

  Future<List<dropDownPositionValueList>?> getDropDownPositionValues() async{
    var valuePosition = await http.get(
      Uri.parse(
        "http://192.168.2.159:8080/FlutterAPI/readPostions.php"
      )
    );
    var respDropDownPositionValues = jsonDecode(
      valuePosition.body
    );
    List<dropDownPositionValueList> dropDownPositionListing = [];
    for (var p in respDropDownPositionValues) {
      dropDownPositionValueList listingPosition = dropDownPositionValueList(
        p['position_name']
      );
      dropDownPositionListing.add(listingPosition);
    }
    return dropDownPositionListing;
  }


  Future<List<dropDownDivisionListValues>?> getDivisionListValues() async{
    var valueDivision = await http.get(
        Uri.parse(
        "http://192.168.2.159:8080/FlutterAPI/readDivision.php"
      )
    );
    var respDropDownDivisionValues = jsonDecode(
      valueDivision.body
    );
    List<dropDownDivisionListValues> dropDownDivisionListing = [];
    for (var d in respDropDownDivisionValues) {
      dropDownDivisionListValues listingDivision = dropDownDivisionListValues(
        d['division_name']
      );
      dropDownDivisionListing.add(listingDivision);
    }
    return dropDownDivisionListing;
  }


  Future<List<dropDownCompanyValuesList>?> getCompanyListValues() async {
    var valueCompany = await http.get(
      Uri.parse(
        "http://192.168.2.159:8080/FlutterAPI/readCompany.php"
      )
    );
    var respDropDownCompanyValues = jsonDecode(
      valueCompany.body
    );
    List<dropDownCompanyValuesList> dropDownCompanyListing = [];
    for(var c in respDropDownCompanyValues) {
      dropDownCompanyValuesList listingCompany = dropDownCompanyValuesList(
        c['company_name']
      );
      dropDownCompanyListing.add(listingCompany);
    }
    return dropDownCompanyListing;
  }
}