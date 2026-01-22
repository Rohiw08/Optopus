import 'package:flutter/material.dart';
import 'package:optopus/core/utils/button_text.dart';
import 'package:optopus/core/common/create_button.dart';

// Generate a random invitation code
String generateInvitationCode() {
  return "jgjvbhahblkSJVkDASLSVCHVBA";
}

// Show the invitation dialog
void showInvitationDialog(BuildContext context) async {
  generateInvitationCode();

  await showDialog(
    context: context,
    builder: (_) => AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      content: Builder(
        builder: (context) {
          return SizedBox(
            height: 200,
            width: 400,
            child: Column(
              children: [
                const Text("Invite people to this workspace"),
                const SizedBox(height: 20),
                const CustomButtonText("Enter email IDs"),
                const SizedBox(height: 20),
                TextField(
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).dividerColor,
                        width: 0.1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Theme.of(context).dividerColor,
                        width: 0.1,
                      ),
                    ),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.surface,
                  ),
                ),
                const SizedBox(height: 20),
                CreateButton(
                  height: 40,
                  width: 100,
                  text: "Send",
                  onPressed: () {},
                  icon: Icons.send,
                ),
              ],
            ),
          );
        },
      ),
    ),
  );
}
