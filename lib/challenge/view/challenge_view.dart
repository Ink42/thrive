import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:thrive/challenge/widgets/challenge_options.dart';
import 'package:thrive/challenge/widgets/display_activities.dart';
import 'package:thrive/challenge/widgets/heatmap.dart';

class ChallengeView extends StatelessWidget {
  const ChallengeView({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Challenge Calendar",
          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const MyHeatMap(),
              // AlertWidget(),
              const SizedBox(height: 30),
              challengeOptions(),
              const SizedBox(height: 30),
              Text(
                "Activities on ${DateTime.now().toLocal().toString().split(' ')[0]}",
                style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              displayActivities(),
            ],
          ),
        ),
      ),
    );
  }
}

