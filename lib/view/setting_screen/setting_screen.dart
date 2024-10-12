import 'package:flutter/material.dart';
import 'package:martify/view/setting_screen/widgets/body_setting.dart';
import 'package:martify/view/setting_screen/widgets/main_setting_heading.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        children: [
          //Header
          MainSettingHeading(),
          //Body
          BodySetting()
        ],
      ),
    );
  }
}
