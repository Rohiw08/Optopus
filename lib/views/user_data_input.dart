import 'package:flutter/material.dart';
import 'package:optopus/core/common/create_button.dart';
import 'package:optopus/core/utils/button_text.dart';

class DownloadPdfScreen extends StatelessWidget {
  const DownloadPdfScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use Scaffold for overall app structure
      body: SafeArea(
        child: Center(
          // Center content within the SafeArea
          child: Column(
            // Use Column for vertical alignment
            mainAxisAlignment:
                MainAxisAlignment.center, // Center children vertically
            children: [
              CustomButtonText("Download report in PDF format"),
              const SizedBox(height: 10),
              CreateButton(
                height: 40,
                width: 150,
                text: "Download",
                onPressed: () {},
                icon: Icons.file_download_outlined,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
