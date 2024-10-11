import 'package:req_sys_finale/core/constants/animation_asset_constants.dart';
import 'package:req_sys_finale/custom_widgets/custom_button/general_button.dart';
import 'package:req_sys_finale/features/auth/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart'; // Add Lottie animations for aesthetic appeal

class UserProfileNotFound extends StatelessWidget {
  const UserProfileNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Lottie Animation for a modern touch
              Lottie.asset(
                AnimationAsset.noAccountAnimation,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              // Main Message
              const Text(
                "Oops! User Profile Not Found",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              // Subtext Message
              const Text(
                "We couldn't find the user you're looking for. Please contact the admin for assistance.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              // Action Button to navigate back or retry
              GeneralButton(
                onTap: () async {
                  await AuthServices.signOut();
                },
                btnColor: Colors.redAccent,
                borderRadius: 10,
                width: 200,
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.logout,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text(
                      'SignOut',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
