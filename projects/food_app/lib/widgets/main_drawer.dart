import 'package:flutter/material.dart';
import 'package:food_app/utils/app_routes.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    Widget createItem(IconData icon, String label, void Function() onTap) {
      return ListTile(
        leading: Icon(
          icon,
          size: 26,
        ),
        title: Text(
          label,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: Theme.of(context).textTheme.titleLarge!.fontFamily,
          ),
        ),
        onTap: onTap,
      );
    }

    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 120,
            padding: const EdgeInsets.all(20),
            color: Theme.of(context).colorScheme.primary,
            alignment: Alignment.bottomRight,
            child: const Text(
              'Let\'s cook',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w900,
                fontSize: 30,
              ),
            ),
          ),
          createItem(
            Icons.restaurant,
            'Meals',
            () {},
          ),
          createItem(
            Icons.settings,
            'Settings',
            () => Navigator.of(context).pushNamed(AppRoutes.settings),
          ),
        ],
      ),
    );
  }
}
