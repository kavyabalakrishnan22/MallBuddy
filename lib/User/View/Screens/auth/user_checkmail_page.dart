import 'package:flutter/material.dart';
import 'package:mall_bud/Widgets/Constants/colors.dart';



class UserCheckMailScreen extends StatelessWidget {
  const UserCheckMailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [SizedBox(height: 200,),
              // Email Icon
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: defaultBlue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(Icons.email_rounded, size: 80, color: defaultBlue),
              ),
              // SizedBox(height: 10),

              // Title
              Text(
                "Check your mail",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),

              // Description
              Text(
                "We have sent a password recovery instruction to your email.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              SizedBox(height: 24),

              // "Open Email App" Button
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: defaultBlue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 40),
                ),
                child: Text("Open email app", style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
              SizedBox(height: 16),

              // "Skip" Option
              TextButton(
                onPressed: () {},
                child: Text("Skip, I'll confirm later", style: TextStyle(fontSize: 14, color: Colors.black54)),
              ),
              // SizedBox(height: 400),

              // Bottom Help Text
               Column(
                 children: [ SizedBox(height: 280),    // SizedBox(height: 400),
                   Text("Did not receive the email? Check your spam filter, or",style: TextStyle(fontSize: 14, color: Colors.black54),),
                    Text("try another email address",style: TextStyle(color: defaultBlue, fontWeight: FontWeight.bold),)
                    // textAlign: TextAlign.center,
                    // text: TextSpan(
                    //   text: "Did not receive the email? Check your spam filter, or ",
                    //   style: TextStyle(fontSize: 14, color: Colors.black54),
                    //   children: [
                    //     TextSpan(
                    //       text: "try another email address",
                    //       style: TextStyle(color: defaultBlue, fontWeight: FontWeight.bold),
                    //     ),
                    //   ],
                    // ),
                                 
                 ],
               ),
            ],
          ),
        ),
      ),
    );
  }
}
