import 'package:flutter/material.dart';
import 'package:week_1_assignment/presentation/screens/home/widgets/card_content.dart';
import 'package:week_1_assignment/shared/styled_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: _HomeAppBar(),
      body: _HomeBody(),
    );
  }
}

//AppBar Section
  class _HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
    const _HomeAppBar();
    @override
    Widget build(BuildContext context) {
      return AppBar(
        automaticallyImplyLeading: false,
        title: const AppbarTitleText('Home Screen'),
        centerTitle: true,
        elevation: 0,
      );
    }
    @override
    Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  }

//Main Body Section
  class _HomeBody extends StatelessWidget {
    const _HomeBody();
    @override
    Widget build(BuildContext context) {
      return _HomeBodyContent();
    }
  }

//Body Content Section
  class _HomeBodyContent extends StatelessWidget {
    const _HomeBodyContent();
    @override
    Widget build(BuildContext context) {
      return Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: CardContent(),
              ),
            ),
          ),
        ],
      );
    }
  }
