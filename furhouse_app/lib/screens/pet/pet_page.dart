import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:furhouse_app/common/constants/colors.dart';
import 'package:furhouse_app/common/widget_templates/pet_information_container.dart';

import 'package:furhouse_app/models/petVM.dart';

class PetPage extends StatefulWidget {
  final PetVM petObject;
  final String petPhotoURL;

  const PetPage({
    super.key,
    required this.petObject,
    required this.petPhotoURL,
  });

  @override
  State<PetPage> createState() {
    return _PetPageState();
  }
}

class _PetPageState extends State<PetPage> {
  late String ageUnit;
  String petDescription = 'No description';

  @override
  void initState() {
    if (widget.petObject.description != null &&
        widget.petObject.description!.isNotEmpty) {
      petDescription = widget.petObject.description as String;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ageUnit = widget.petObject.ageUnit.toLowerCase();

    if (widget.petObject.ageValue == 1) {
      var unitLength = widget.petObject.ageUnit.length;

      ageUnit =
          widget.petObject.ageUnit.substring(0, unitLength - 1).toLowerCase();
    }

    return RawScrollbar(
      thumbVisibility: true,
      thumbColor: darkerBlueColor,
      thickness: 6,
      radius: const Radius.circular(20),
      scrollbarOrientation: ScrollbarOrientation.right,
      minThumbLength: 10,
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 5,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: Container(
            alignment: Alignment.topCenter,
            margin: const EdgeInsets.only(
              top: 25,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 280,
                  height: 240,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Image.network(
                      widget.petPhotoURL,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PetInformationContainer(
                      containerHeight: 30,
                      containerWidth: 200,
                      text: widget.petObject.name,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    PetInformationContainer(
                      containerHeight: 30,
                      containerWidth: 150,
                      text: '${widget.petObject.ageValue} $ageUnit old',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PetInformationContainer(
                      containerHeight: 30,
                      containerWidth: 200,
                      text: widget.petObject.gender,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    PetInformationContainer(
                      containerHeight: 30,
                      containerWidth: 150,
                      text: widget.petObject.category,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PetInformationContainer(
                      containerHeight: 30,
                      containerWidth: 360,
                      text: widget.petObject.breed,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PetInformationContainer(
                      containerHeight: 50,
                      containerWidth: 360,
                      text: widget.petObject.location,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PetInformationContainer(
                      containerHeight: 30,
                      containerWidth: 200,
                      text: widget.petObject.details,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    PetInformationContainer(
                      containerHeight: 30,
                      containerWidth: 150,
                      text: '${widget.petObject.priority} priority',
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PetInformationContainer(
                      containerHeight: 50,
                      containerWidth: 360,
                      text: petDescription,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 180,
                  height: 35,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 2, 23, 41),
                      shadowColor: Colors.black,
                      elevation: 10,
                      textStyle: GoogleFonts.merriweather(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.pets),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Adopt pet',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
