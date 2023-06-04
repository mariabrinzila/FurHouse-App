import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:furhouse_app/common/widget_templates/pet-information-container.dart';

class PetPage extends StatefulWidget {
  const PetPage({
    super.key,
  });

  @override
  State<PetPage> createState() {
    return _PetPageState();
  }
}

class _PetPageState extends State<PetPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
              Image.asset(
                'assets/images/cat.jpg',
                width: 210,
                height: 260,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  PetInformationContainer(
                    containerHeight: 30,
                    containerWidth: 200,
                    text: 'Persephone', //name
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  PetInformationContainer(
                    containerHeight: 30,
                    containerWidth: 150,
                    text: 'Female', //gender
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  PetInformationContainer(
                    containerHeight: 30,
                    containerWidth: 100,
                    text: 'Months', //age unit
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  PetInformationContainer(
                    containerHeight: 30,
                    containerWidth: 90,
                    text: '10', //age value
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  PetInformationContainer(
                    containerHeight: 30,
                    containerWidth: 150,
                    text: 'Roddent', // category
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  PetInformationContainer(
                    containerHeight: 30,
                    containerWidth: 360,
                    text: 'Belgian Shepherd Groenendael', //breed
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  PetInformationContainer(
                    containerHeight: 50,
                    containerWidth: 360,
                    text:
                        '1600 Amphitheatre Pkwy, Mountain View, United States, 94043', //address
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  PetInformationContainer(
                    containerHeight: 30,
                    containerWidth: 200,
                    text: 'Sterilized', //details
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  PetInformationContainer(
                    containerHeight: 30,
                    containerWidth: 150,
                    text: 'Medium', //priority
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  PetInformationContainer(
                    containerHeight: 50,
                    containerWidth: 360,
                    text: 'A cute cat with short legs and an adorable face',
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
    );
  }
}
