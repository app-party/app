import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:party_app/global/routes/route_names.dart';

class MenuItem {
  IconData icon;
  VoidCallback fn;

  MenuItem({required this.fn, required this.icon});
}

class BottomMenu extends StatefulWidget {
  final String route;

  BottomMenu({Key? key, required this.route}) : super(key: key);

  @override
  _BottomMenuState createState() => _BottomMenuState();
}

class _BottomMenuState extends State<BottomMenu> {
  Map<String, MenuItem> items = {};
  final ButtonStyle _iconStyle = ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.zero),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
    ),
  );

  @override
  void initState() {
    items = {
      "events": MenuItem(fn: () {}, icon: Icons.liquor_rounded),
      RouteNames.HOME: MenuItem(fn: () => Get.back(), icon: Icons.home_rounded),
      RouteNames.PROFILE: MenuItem(
          fn: () {
            if (widget.route != RouteNames.HOME) {
              Get.offNamed(RouteNames.PROFILE);
              return;
            }
            Get.toNamed(RouteNames.PROFILE);
          },
          icon: Icons.face_rounded)
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 32,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.keys
            .map((item) => item == widget.route
                ? currentSelected(items[item]!)
                : defaultItem(items[item]!))
            .toList(),
      ),
    );
  }

  Widget currentSelected(MenuItem item) {
    return TextButton(
      onPressed: () {},
      child: Ink(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient:
              LinearGradient(colors: [Color(0xFFEE4F43), Color(0xFFEE5075)]),
        ),
        child: Icon(
          item.icon,
          color: Colors.white,
        ),
      ),
      style: _iconStyle,
    );
  }

  Widget defaultItem(MenuItem item) {
    return TextButton(
      onPressed: item.fn,
      child: Icon(
        item.icon,
        color: Color(0xFF111111),
      ),
      style: _iconStyle,
    );
  }
}
