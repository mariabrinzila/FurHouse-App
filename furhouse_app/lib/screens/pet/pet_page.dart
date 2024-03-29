import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:furhouse_app/screens/home/home.dart';

import 'package:furhouse_app/common/constants/colors.dart';
import 'package:furhouse_app/common/constants/others.dart';

import 'package:furhouse_app/common/functions/exception_code_handler.dart';
import 'package:furhouse_app/common/functions/confirm_action.dart';

import 'package:furhouse_app/common/widget_templates/pet_information_container.dart';

import 'package:furhouse_app/models/pet_VM.dart';

import 'package:furhouse_app/services/users.dart';
import 'package:furhouse_app/services/pets.dart';

class PetPage extends StatefulWidget {
  final PetVM petObject;
  final String petPhotoURL;
  final bool fromSettings;

  const PetPage({
    super.key,
    required this.petObject,
    required this.petPhotoURL,
    required this.fromSettings,
  });

  @override
  State<PetPage> createState() {
    return _PetPageState();
  }
}

class _PetPageState extends State<PetPage> {
  late String ageUnit;
  String petDescription = "noDescription";

  @override
  void initState() {
    if (widget.petObject.description != null &&
        widget.petObject.description!.isNotEmpty) {
      petDescription = widget.petObject.description as String;
    }

    super.initState();
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

  void _onDeletePet(BuildContext context) async {
    var readyToDelete = AppLocalizations.of(context)?.readyToDelete ?? "";

    final confirmed = await confirmActionDialog(
        context, "$readyToDelete ${widget.petObject.name}?");

    if (confirmed == "no") {
      return;
    }

    final message = await Pets().delete(widget.petObject.petId,
        widget.petObject.userEmail, widget.petObject.name);

    if (message == "Success") {
      if (notificationService != null) {
        await notificationService?.showLocalNotification(
          id: currentNotificationID,
          title: "Deleted pet",
          body: "You have just deleted ${widget.petObject.name}!",
          payload: "A pet has been deleted",
        );

        currentNotificationID++;
      }

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

  void _onAdoptPet(BuildContext context) async {
    var readyToAdopt = AppLocalizations.of(context)?.readyToAdopt ?? "";

    final confirmed = await confirmActionDialog(
        context, "$readyToAdopt ${widget.petObject.name}?");

    if (confirmed == "no") {
      return;
    }

    var currentUser = Users().getCurrentUser();
    var userEmail = currentUser != null ? (currentUser.email ?? "") : "";
    var isEmailVerified = currentUser?.emailVerified ?? false;

    if (!isEmailVerified) {
      if (context.mounted) {
        actionDoneDialog(context,
            "Your email must be verified to adopt a pet! Go to Settings -> Account to verify your email.");
      }

      return;
    }

    final message = await Pets().updateAdoptPet(
      widget.petObject.petId,
      userEmail,
    );

    if (message == "Success") {
      if (notificationService != null) {
        await notificationService?.showLocalNotification(
          id: currentNotificationID,
          title: "Adopted pet",
          body: "You have just adopted ${widget.petObject.name}!",
          payload: "A pet has been adopted",
        );

        currentNotificationID++;
      }

      if (context.mounted) {
        _navigateToHome(context);
      }
    } else {
      if (context.mounted) {
        addPetExceptionHandler(context, message);
      }
    }
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

    var currentUser = Users().getCurrentUser();
    var adoptButton = true;

    Widget submitButtons = SizedBox(
      width: 200,
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
          _onAdoptPet(context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.pets,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              AppLocalizations.of(context)?.adoptPet ?? "",
            ),
          ],
        ),
      ),
    );

    if (currentUser != null &&
        currentUser.email != null &&
        currentUser.email == widget.petObject.userEmail) {
      adoptButton = false;

      submitButtons = Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 140,
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
                children: [
                  const Icon(
                    Icons.edit,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    AppLocalizations.of(context)?.edit ?? "",
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 140,
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
                children: [
                  const Icon(
                    CupertinoIcons.delete_solid,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    AppLocalizations.of(context)?.delete ?? "",
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    var addedOn = AppLocalizations.of(context)?.addedOn ?? "";
    var none = AppLocalizations.of(context)?.none ?? "";
    var noDetails = AppLocalizations.of(context)?.noDetails ?? "";

    var priority = AppLocalizations.of(context)?.priority ?? "";
    priority = priority.toLowerCase();

    if (petDescription == "noDescription") {
      petDescription = AppLocalizations.of(context)?.noDescription ?? "";
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
                          "${widget.petObject.name}, ${widget.petObject.category.toLowerCase()}",
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    PetInformationContainer(
                      containerHeight: 30,
                      containerWidth: 150,
                      text: "${widget.petObject.ageValue} $ageUnit",
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
                      text: "$addedOn $addedDate",
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
                      text: widget.petObject.details == none
                          ? noDetails
                          : widget.petObject.details,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    PetInformationContainer(
                      containerHeight: 30,
                      containerWidth: 150,
                      text: "${widget.petObject.priority} $priority",
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
                if (!widget.fromSettings ||
                    (widget.fromSettings && !adoptButton)) ...[
                  submitButtons,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
