import 'package:flutter/material.dart';

class RejectedReasonDialog extends StatelessWidget {
  const RejectedReasonDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        // width: 100,
       decoration: BoxDecoration(
         color: Colors.red[100],
         borderRadius: BorderRadius.circular(20)
       ),
        height: 200,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Icon(Icons.not_interested, color: Colors.red, size: 80,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 25, left: 10),
                    child: Text("Reason :",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, left: 10),
                    child: Text("gaboleh ya",
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}