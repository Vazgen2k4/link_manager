import 'package:flutter/material.dart';
import 'package:link_manager/ui/router/app_hero_tags.dart';
import 'package:link_manager/ui/router/app_routes.dart';
import 'package:link_manager/ui/theme/app_colors.dart';
import 'package:link_manager/ui/widgets/alerts/app_dialogs.dart';
import 'package:link_manager/ui/widgets/custom_appbar/custom_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  final List<AppTab> _tabs = AppRoutes.homeTabs;

  int _currentIndex = 0;

  void _onTap(int index) {
    if (index == _currentIndex || index >= _tabs.length) return;

    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        isHomePage: true,
        title: AppRoutes.homeTabs[_currentIndex].getTitle(context),
      ),
      body: PageView.builder(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: _onPageChanged,
        itemCount: _tabs.length,
        itemBuilder: (context, index) => _tabs[index].child,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.main,
        selectedItemColor: AppColors.text,
        unselectedItemColor: AppColors.text.withOpacity(0.1),
        currentIndex: _currentIndex,
        onTap: _onTap,
        items: _tabs
            .map((tab) => BottomNavigationBarItem(
                  icon: Icon(tab.icon),
                  label: tab.name,
                ))
            .toList(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        elevation: 4,
        shape: RoundedRectangleBorder(
          side: BorderSide(
            color: AppColors.background,
            width: 4,
          ),
          borderRadius: BorderRadius.circular(100),
        ),
        heroTag: AppHeroTags.button,
        child: const Icon(Icons.add),
        onPressed: () async {
          await AppDialogs.addFolderDialog(context);
        },
      ),
    );
  }
}
