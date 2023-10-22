import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:furhouse_app/screens/home/home.dart';

import 'package:furhouse_app/common/constants/colors.dart';

import 'package:furhouse_app/common/functions/exception_code_handler.dart';
import 'package:furhouse_app/common/functions/confirm_action.dart';

import 'package:furhouse_app/common/widget_templates/pet_information_container.dart';

import 'package:furhouse_app/models/pet_VM.dart';

import 'package:furhouse_app/services/authentication.dart';
import 'package:furhouse_app/services/pets.dart';

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
  String petDescription = "No description";

  @override
  void initState() {
    if (widget.petObject.description != null &&
        widget.petObject.description!.isNotEmpty) {
      petDescription = widget.petObject.description as String;
    }

    super.initState();
  }

  void _onDeletePet(BuildContext context) async {
    final confirmed = await confirmActionDialog(
        context, "Are you sure you want to delete ${widget.petObject.name}?");

    if (confirmed == "no") {
      return;
    }

    final message = await Pets().delete(widget.petObject.petId,
        widget.petObject.userEmail, widget.petObject.name);

    if (message == "Success") {
      if (context.mounted) {
        _navigateToHome(context);
      }
    } else {
      if (context.mounted) {
        addPetExceptionHandler(context, message);
      }
    }
  }

  void _navigateToHome(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const Home(
          selectedTabIndex: 0,
        ),
      ),
    );
  }

  void _onUpdatePet(BuildContext context) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Home(
          selectedTabIndex: 1,
          currentPet: widget.petObject,
          petPhotoURL: widget.petPhotoURL,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ageUnit = widget.petObject.ageUnit.toLowerCase();

    if (widget.petObject.ageValue == 1) {
      var unitLength = widget.petObject.ageUnit.length;

      ageUnit =
          widget.petObject.ageUnit.substring(0, unitLength - 1).toLowerCase();
    }

    var date = DateTime.parse(widget.petObject.dateAdded);
    var addedDate = DateFormat.yMMMMd().format(date);

    var currentUser = Authentication().getCurrentUser();

    Widget submitButtons = SizedBox(
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
            Icon(
              Icons.pets,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Adopt pet",
            ),
          ],
        ),
      ),
    );

    if (currentUser != null &&
        currentUser.email != null &&
        currentUser.email == widget.petObject.userEmail) {
      submitButtons = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 120,
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
              onPressed: () {
                _onUpdatePet(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.edit,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Edit",
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 120,
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
              onPressed: () {
                _onDeletePet(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    CupertinoIcons.delete_solid,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Delete",
                  ),
                ],
              ),
            ),
          ),
        ],
      );
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
                      text:
                          "${widget.petObject.name}, ${widget.petObject.category}",
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    PetInformationContainer(
                      containerHeight: 30,
                      containerWidth: 150,
                      text: "${widget.petObject.ageValue} $ageUnit old",
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
                      containerWidth: 130,
                      text: widget.petObject.gender,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    PetInformationContainer(
                      containerHeight: 30,
                      containerWidth: 220,
                      text: "Added on $addedDate",
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
                      text: widget.petObject.details == "None"
                          ? "No details"
                          : widget.petObject.details,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    PetInformationContainer(
                      containerHeight: 30,
                      containerWidth: 150,
                      text: "${widget.petObject.priority} priority",
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
                submitButtons,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
