import 'package:http/http.dart' as http;
import '../../Keys.dart';

class MemberRequestPaidLeaveController {
  //fungsi untuk melakukan penyimpanan data//
  save() async {
    final response = await http.post(
      Uri.parse("http://192.168.2.159/FlutterAPI/approvals/member/paid_leave/setUserApproval.php"),
      body: {
        "name": namePaidLeave.text,
        "position": positionPaidLeave.text,
        "department": departmentPaidLeave.text,
        "types_leave": typePaidLeave.text,
        "reason_leave": reasonPaidLeave.text,
        "name_of_pic": picPaidLeave.text,
        "phone_number": phonePaidLeave.text,
        "shift": shiftPaidLeave.text,
        "date_start_leave": startDatePaidLeave.text,
        "date_end_leave": endDatePaidLeave.text,
        "date_back_to_work": onDutyPaidLeave.text,
      },
    );
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}