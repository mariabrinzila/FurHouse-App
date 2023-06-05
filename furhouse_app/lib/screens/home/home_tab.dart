import 'package:flutter/material.dart';

import 'package:furhouse_app/common/constants/colors.dart';
import 'package:furhouse_app/common/widget_templates/pet_card_button.dart';

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
    return RawScrollbar(
      thumbVisibility: true,
      thumbColor: darkerBlueColor,
      thickness: 6,
      radius: const Radius.circular(20),
      scrollbarOrientation: ScrollbarOrientation.right,
      minThumbLength: 5,
      child: GridView.count(
        crossAxisCount: 2,
        children: List.generate(
          20,
          (index) {
            return Container(
              margin: const EdgeInsets.only(
                top: 25,
                left: 15,
                right: 15,
              ),
              child: const PetCardButton(),
            );
          },
        ),
      ),
    );
  }
}
