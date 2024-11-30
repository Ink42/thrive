import 'package:flutter/material.dart';
import 'package:thrive/home/widgets/build_snap_shot.dart';
import 'package:thrive/home/widgets/expandable_calender.dart';

class HomePage extends StatelessWidget {
  static const String id = "/HomePage";

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thrive"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const ExpandableCalender(),
              const SizedBox(height: 20),
              _buildSectionHeader("Today's Snapshot", "See More"),
              const SizedBox(height: 10),
              buildSnapshotSection(MediaQuery.sizeOf(context)),
              const SizedBox(height: 20),
              _buildSectionHeader("Recent Activities", "See More"),
              const SizedBox(height: 10),
              _buildRecentActivities(),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSectionHeader(String heading, String linkTitle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          heading,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(
          onPressed: () {
          
          },
          child: Text(
            linkTitle,
            style: const TextStyle(color: Colors.blue),
          ),
        ),
      ],
    );
  }


  Widget _buildRecentActivities() {
    return SizedBox(
      height: 150, 
      child: ListView.builder(
        itemCount: 3,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (_, index) {
          return ListTile(
            leading: const Icon(Icons.directions_walk, color: Colors.green),
            title: Text("Activity ${index + 1} - Walking"),
            subtitle: Text("Distance: ${index + 2} km"),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
            },
          );
        },
      ),
    );
  }
}
