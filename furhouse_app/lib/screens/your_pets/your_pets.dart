import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class YourPets extends StatefulWidget {
  const YourPets({
    super.key,
  });

  @override
  State<YourPets> createState() {
    return _YourPetsState();
  }
}

class _YourPetsState extends State<YourPets> {
  Widget content = const Center(
    child: Text(
      "Your adopted pets here",
    ),
  );

  void _adoptedPets() {
    setState(() {
      content = const Center(
        child: Text(
          "Your adopted pets here",
        ),
      );
    });
  }

  void _addedPets() {
    setState(() {
      content = const Center(
        child: Text(
          "Your added pets here",
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: () {
                _adoptedPets();
              },
              child: const Text(
                "Adopted pets",
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _addedPets();
              },
              child: const Text(
                "Added pets",
              ),
            ),
          ],
        ),
        content,
      ],
    );
  }
}
