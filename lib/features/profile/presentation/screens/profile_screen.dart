import 'package:flutter/material.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_options.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            spacing: 14,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(),
              Avatar(),
              ProfileName(),
              UserEmail(),
              SizedBox(),
              ProfileActions(),
              AppInfoSection(),
            ],
          ),
        ),
      ),
    );
  }
}
