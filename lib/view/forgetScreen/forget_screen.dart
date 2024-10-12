import 'package:flutter/material.dart';
import 'package:martify/utils/constants/sizes.dart';
import 'package:martify/view/forgetScreen/widget/forget_form.dart';
import 'package:martify/view/forgetScreen/widget/forget_heading.dart';

class ForgetScreen extends StatelessWidget {
  const ForgetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(MSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //Heading
                  ForgetHeading(),
                  //Form
                  ForgetForm()
                ],
              ))),
    );
  }
}
