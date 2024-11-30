




  import 'package:flutter/material.dart';

Widget buildSnapshotSection(Size size,) {
    return Column(
      children: [
        Row(
          children: [
            _SnapshotTile(
              title: "Distance",
              value: "${12} km",
              icon: Icons.roundabout_left,
              color: Colors.amber,
              height: size.height * 0.2,
              
            ),
            const SizedBox(width: 8),
            _SnapshotTile(
              title: "Steps",
              value: "${8761}",
              icon: Icons.directions_walk_sharp,
              color: Colors.grey.shade400,
              height: size.height * 0.2,
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            _SnapshotTile(
              title: "Duration",
              value: "${768} min",
              icon: Icons.timer,
              color: Colors.grey.shade400,
              height: size.height * 0.2,
            ),
          ],
        ),
      ],
    );
  }

  class _SnapshotTile extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;
  final double height;

  const _SnapshotTile({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              child: Icon(icon),
            ),
            const SizedBox(height: 10),
            Text( title, style: const TextStyle(fontSize: 20)),
            Text(value, style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}