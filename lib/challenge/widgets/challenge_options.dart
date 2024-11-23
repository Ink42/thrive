

import 'package:flutter/material.dart';
import 'package:thrive/challenge/view/map_view.dart';

class challengeOptions extends StatelessWidget {
  const challengeOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton.icon(
          icon: const Icon(Icons.map),
          onPressed: () => Navigator.pushNamed(context,MapView.id),
          label: const Text("Start Challenge"),
        ),
        MaterialButton(
          color: Colors.amber,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          onPressed: () {
          },
          child: const Text(
            "Add Challenge",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
