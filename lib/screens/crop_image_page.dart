import 'package:flutter/material.dart';

import '../utils/apps_colors.dart';
import '../widgets/custom_button.dart';

class CropImagePage extends StatelessWidget {
  const CropImagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: AppColors.textPrimary,
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Crop Image',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Crop the area which you want to search to get better results.',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.cardBackground,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: const Center(
                    child: Text(
                      'Image cropper UI goes here',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              CustomButton(
                text: 'Extract Text from Image',
                onPressed: () async {
                  // TODO: run OCR on cropped image and return extracted text
                  const extractedText = '';
                  Navigator.pop(context, extractedText);
                },
                icon: Icons.text_fields,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


