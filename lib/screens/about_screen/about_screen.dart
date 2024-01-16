import 'package:flutter/material.dart';
import 'package:store_app/app/constants/strings.dart';
import 'package:store_app/theme/styles.dart';
import 'package:store_app/widget/custom_app_bar.dart';

import '../../widget/app_drawer_widget/custom_drawer.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(textTitle: "About"),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Expanded(child: Image.asset(iconAppImage)),
            const Flexible(
              child: Text(
                "Your path to learning English, step by step Cambridge English Qualifications are in-depth exams that make learning English enjoyable, effective and rewarding. Our unique approach encourages continuous progression with a clear path to improve language skills. We have qualifications for schools, general and higher education, and business.",
                style: TextStyles.font15SecondPrimaryRegular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
