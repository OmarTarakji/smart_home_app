import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smart_home/core/constants/images.dart';
import 'package:smart_home/core/utils/extensions.dart';
import 'package:smart_home/features/fingerprint/domain/add_fingerprint_response.dart';

class AddFingerprintOverlay extends StatelessWidget {
  const AddFingerprintOverlay(this.addResponse, {super.key});
  final AddFingerprintResponse addResponse;

  @override
  Widget build(BuildContext context) {
    return Container(
      // Fill the entire screen
      color: Colors.black26,
      // Center the content within the container
      child: Center(
        // Wrap the content with a Material widget to provide default text styling
        child: Material(
          type: MaterialType.transparency, // Make Material widget transparent
          child: Container(
            margin: const EdgeInsets.all(30),
            constraints: const BoxConstraints(
              minWidth: 280,
              maxWidth: 400,
              minHeight: 200,
              maxHeight: 300,
            ),
            decoration: BoxDecoration(
              color: context.colorScheme.surface,
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(Images.FINGERPRINT, height: 100),
                const SizedBox(height: 20),
                Text(addResponse.state.title),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
