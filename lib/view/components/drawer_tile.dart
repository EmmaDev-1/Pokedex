import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  final String title;
  final Widget leading;
  final void Function()? onTap;
  const DrawerTile({
    super.key,
    required this.title,
    required this.leading,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20.0),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height * 0.02,
            fontWeight: FontWeight.bold,
            fontFamily: 'QuickSand-Bold',
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        leading: leading,
        onTap: onTap,
      ),
    );
  }
}
