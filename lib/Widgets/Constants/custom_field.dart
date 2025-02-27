import 'package:flutter/material.dart';

import 'colors.dart';

class CustomTextForm extends StatelessWidget {
  String hintText;
  TextEditingController? controller;

  CustomTextForm({super.key, required this.hintText, this.controller,});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,

          border:
          OutlineInputBorder(

              borderRadius: BorderRadius.circular(10)
          )),
    );
  }
}
class Shopgridview extends StatelessWidget {
  String icon;
  String title;
  Shopgridview({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: () {},
        child: Column(
            children: [
              Container(
                height: 220,width: 190,
                decoration: BoxDecoration(
                  color: greyColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child:
                  Image.asset(icon),
                ),
              ),
              SizedBox(height: 5,),
              Text(title,textAlign: TextAlign.center,),
            ],
            ),
        );

  }}
