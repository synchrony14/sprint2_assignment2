import 'package:flutter/material.dart';
import 'package:week_1_assignment/presentation/screens/details/details_screen.dart';
import 'package:week_1_assignment/shared/styled_text.dart';

class CardContent extends StatelessWidget {
  const CardContent({super.key});
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: _CardContentColumn(),
    );
  }
}

//Main Body Section
class _CardContentColumn extends StatelessWidget {
  const _CardContentColumn();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        _ProfileCard(),
      ],
    );
  }
}

//Main Card Section
class _ProfileCard extends StatelessWidget {
  const _ProfileCard();
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      height: 380,
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.all(28),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF1A1824), Color(0xFF6E6A83)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          padding: const EdgeInsets.all(32),
          child: const _ProfileCardBody(),
        ),
      ),
    );
  }
}

//Card Content Section
class _ProfileCardBody extends StatelessWidget {
  const _ProfileCardBody();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        _ProfileAvatar(),
        SizedBox(height: 16),
        _ProfileInfo(),
        SizedBox(height: 12),
        _ViewDetailsButton(),
      ],
    );
  }
}

//Avatar Section
class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar();
  @override
  Widget build(BuildContext context) {
    return const CircleAvatar(
      radius: 60,
      backgroundColor: Colors.grey,
      backgroundImage: AssetImage('assets/images/profile_pic.jpg'),
    );
  }
}

//Info Section
class _ProfileInfo extends StatelessWidget {
  const _ProfileInfo();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        StyledText('JB Garcia'),
        StyledText('Flutter Developer'),
      ],
    );
  }
}

//Button Section
class _ViewDetailsButton extends StatelessWidget {
  const _ViewDetailsButton();
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const DetailsScreen()),
        );
      },
      child: const Text('View Details'),
    );
  }
}
