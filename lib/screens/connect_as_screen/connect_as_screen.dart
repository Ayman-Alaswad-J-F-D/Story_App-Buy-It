import 'package:flutter/material.dart';

import '../../widget/app_drawer_widget/custom_drawer.dart';
import '../../widget/custom_app_bar.dart';
import 'components/connect_as_body.dart';

class ConnectAsScreen extends StatelessWidget {
  const ConnectAsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(textTitle: "Connect As"),
      drawer: const CustomDrawer(),
      body: ConnectAsBody(),
    );
  }
}
