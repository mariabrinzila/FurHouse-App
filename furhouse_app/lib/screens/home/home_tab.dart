import 'package:flutter/material.dart';

import 'package:furhouse_app/screens/home/home_pet_grid.dart';

import 'package:furhouse_app/common/constants/colors.dart';
import 'package:furhouse_app/common/functions/exception_code_handler.dart';

import 'package:furhouse_app/models/petVM.dart';

import 'package:furhouse_app/services/pets.dart';

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
  late Map<String, PetVM> petMap = <String, PetVM>{};

  Widget childWidget = const Center(
    child: CircularProgressIndicator(
      color: darkerBlueColor,
    ),
  );

  @override
  void initState() {
    _getAllPets().then((value) {
      setState(() {
        petMap = value;
      });
    });

    super.initState();
  }

  Future<Map<String, PetVM>> _getAllPets() async {
    try {
      var pets = await Pets().getAllPets();

      return pets;
    } catch (e) {
      otherExceptionsHandler(context, e.toString());

      return <String, PetVM>{};
    }
  }

  @override
  Widget build(BuildContext context) {
    if (petMap.isNotEmpty) {
      childWidget = HomePetGrid(
        petMap: petMap,
      );
    }

    return childWidget;
  }
}
