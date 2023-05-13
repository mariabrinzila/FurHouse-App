import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({
    super.key,
  });

  @override
  State<HomeTab> createState() {
    return _HomeContentState();
  }
}

class _HomeContentState extends State<HomeTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Text(
            'Home content',
          )
        ],
      ),
    );
  }
}
