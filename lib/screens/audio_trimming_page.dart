import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/apps_colors.dart';
import '../widgets/custom_button.dart';

class AudioTrimmingPage extends StatefulWidget {
  const AudioTrimmingPage({super.key});

  @override
  State<AudioTrimmingPage> createState() => _AudioTrimmingPageState();
}

class _AudioTrimmingPageState extends State<AudioTrimmingPage> {
  // In a real implementation you would determine these from the audio duration.
  double _start = 0;
  double _end = 10;

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
          'Trim Audio',
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
                'Select the exact part of the audio you want to generate transcript for.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.border),
                ),
                child: const Center(
                  child: Text(
                    'Waveform / timeline preview goes here',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Start: ${_formatSeconds(_start)}   •   End: ${_formatSeconds(_end)}',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
              ),
              RangeSlider(
                values: RangeValues(_start, _end),
                min: 0,
                max: 60,
                divisions: 60,
                activeColor: AppColors.primary,
                onChanged: (values) {
                  setState(() {
                    _start = values.start;
                    _end = values.end;
                  });
                },
              ),
              const Spacer(),
              CustomButton(
                text: 'Generate Transcript',
                onPressed: () async {
                  // TODO: send audio + trim positions to backend Whisper endpoint.
                  const transcript = '';
                  Navigator.pop(context, transcript);
                },
                icon: Icons.graphic_eq,
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatSeconds(double value) {
    final duration = Duration(seconds: value.round());
    return DateFormat('s').format(
      DateTime(0).add(duration),
    );
  }
}


