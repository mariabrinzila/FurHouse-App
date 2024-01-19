import 'package:flutter/cupertino.dart';

import 'package:furhouse_app/common/constants/colors.dart';

import 'package:furhouse_app/common/functions/exception_code_handler.dart';

import 'package:furhouse_app/common/widget_templates/user_card_button.dart';

import 'package:furhouse_app/models/user_VM.dart';

import 'package:furhouse_app/services/users.dart';

class Admin extends StatefulWidget {
  const Admin({
    super.key,
  });

  @override
  State<Admin> createState() {
    return _AdminState();
  }
}

class _AdminState extends State<Admin> {
  final ScrollController _homeScrollbar = ScrollController();

  List<UserVM> userList = <UserVM>[];

  Color addedPetsButtonColor = lightBlueColor;
  Color adoptedPetsButtonColor = darkBlueColor;

  late Widget content;

  @override
  void initState() {
    _getAllUsers().then((value) {
      setState(() {
        userList = value;
      });
    });

    super.initState();
  }

  Future<List<UserVM>> _getAllUsers() async {
    try {
      var currentUser = Users().getCurrentUser();
      String currentUserEmail = currentUser?.email ?? "";

      var users = await Users().readAllUsers(currentUserEmail);

      return users;
    } catch (e) {
      otherExceptionsHandler(context, e.toString());

      return <UserVM>[];
    }
  }

  Widget _generateListItemContainer(int index) {
    return Container(
      margin: const EdgeInsets.only(
        top: 5,
        bottom: 15,
        left: 15,
        right: 15,
      ),
      child: UserCardButton(
        user: userList.elementAt(index),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (userList.isEmpty) {
      return Center(
        child: CupertinoActivityIndicator(
          color: darkerBlueColor,
          radius: 30,
        ),
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        Expanded(
          child: RawScrollbar(
            thumbVisibility: true,
            thumbColor: darkerBlueColor,
            thickness: 6,
            radius: const Radius.circular(20),
            scrollbarOrientation: ScrollbarOrientation.right,
            minThumbLength: 5,
            controller: _homeScrollbar,
            child: GridView.count(
              crossAxisCount: 2,
              controller: _homeScrollbar,
              children: List.generate(
                userList.length,
                (index) {
                  return _generateListItemContainer(index);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
