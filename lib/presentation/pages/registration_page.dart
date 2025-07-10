import 'package:flutter/material.dart';
import 'package:week_1_assignment/presentation/pages/email_password_page.dart';
import 'package:week_1_assignment/presentation/pages/personal_info_page.dart';
import 'package:week_1_assignment/presentation/pages/review_page.dart';
import 'package:week_1_assignment/shared/styled_text.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarSection(),
      body: MainBodySection(),
    );
  }

//Main Body Section
  //ignore: non_constant_identifier_names
  Column MainBodySection() {
    return Column(
      children: [
        Container(height: 1, color: Colors.grey[300]),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              PersonalInfoPage(tabController: _tabController),
              EmailPasswordPage(tabController: _tabController),
              ReviewPage(tabController: _tabController),
            ],
          ),
        ),
      ],
    );
  }

//Appbar Section
  //ignore: non_constant_identifier_names
  AppBar AppbarSection() {
    return AppBar(
      title: const SectionHeader('Registration'),
      centerTitle: true,
    );
  }
}
