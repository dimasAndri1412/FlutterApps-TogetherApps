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
      //  decoration: BoxDecoration(
      //    color: Colors.red[100],
      //    borderRadius: BorderRadius.circular(20)
      //  ),
        // height: 200,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 35, 
                  backgroundColor: Colors.grey[300],
                  child: Icon(
                    Icons.cancel, 
                    color: Colors.red,
                    size: 50,
                  ),
                )
              ),
              SizedBox(height: 10,),
              Center(
                child: Text("lalala",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Center(
                child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}