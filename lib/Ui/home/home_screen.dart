import 'package:evently_app/Ui/home/tabs/favorite/favorite_tab.dart';
import 'package:evently_app/Ui/home/tabs/home/home_tab.dart';
import 'package:evently_app/Ui/home/tabs/profile/profile_screen.dart';
import 'package:evently_app/l10n/app_localizations.dart';
import 'package:evently_app/utils/app_colors.dart';
import 'package:evently_app/utils/app_routes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<Widget> tabsList = [
    HomeTab(),
    FavoriteTab(),
    ProfileScreen()

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabsList[selectedIndex],
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.pushNamed(context, AppRoutes.add_event_screen);
      },
        child: Icon(Icons.add, color: AppColors.whiteColor, size: 25,),),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          selectedIndex = index;
          setState(() {});
        },
        items: [
          _builtbottomNavigationBarItem(
            selectedIcon: Icon(Icons.home),
            unselectedIcon: Icon(Icons.home_outlined),
            lable: AppLocalizations.of(context)!.home,
            isSelected: selectedIndex == 0,
          ),
          _builtbottomNavigationBarItem(
            selectedIcon: Icon(Icons.favorite),
            unselectedIcon: Icon(Icons.favorite_outline),
            lable: AppLocalizations.of(context)!.favorite,
            isSelected: selectedIndex == 1,
          ),
          _builtbottomNavigationBarItem(
            selectedIcon: Icon(Icons.person),
            unselectedIcon: Icon(Icons.person_outline),
            lable: AppLocalizations.of(context)!.profile,
            isSelected: selectedIndex == 2,
          ),
        ],
      ),

    );
  }

  BottomNavigationBarItem _builtbottomNavigationBarItem({
    required Widget selectedIcon,
    required Widget unselectedIcon,
    required String lable,
    required bool isSelected,
  }) {
    return BottomNavigationBarItem(
      icon: isSelected ? selectedIcon : unselectedIcon,
      label: lable,
    );
  }
}
