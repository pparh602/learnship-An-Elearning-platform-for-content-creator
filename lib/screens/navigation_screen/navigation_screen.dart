import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnship/core/enums/enums.dart';
import 'package:learnship/screens/navigation_screen/cubit/bottom_nav_bar_cubit.dart';

import 'widgets/bottom_nav_bar.dart';
import 'widgets/tab_navigator.dart';

class NavigationScreen extends StatelessWidget {
  static const String routeName = '/nav';
  static Route route() {
    return PageRouteBuilder(
      settings: const RouteSettings(name: routeName),
      pageBuilder: (_, __, ___) => BlocProvider<BottomNavBarCubit>(
        create: (_) => BottomNavBarCubit(),
        child: NavigationScreen(),
      ),
    );
  }

  final Map<BottomNavItem, IconData> items = const {
    BottomNavItem.home: Icons.home,
    BottomNavItem.feed: Icons.map,
    BottomNavItem.create: Icons.add,
    BottomNavItem.questRoom: Icons.group_rounded,
    BottomNavItem.profile: Icons.account_circle,
  };

  final Map<BottomNavItem, GlobalKey<NavigatorState>> navigatorKeys = {
    BottomNavItem.home: GlobalKey<NavigatorState>(),
    BottomNavItem.feed: GlobalKey<NavigatorState>(),
    BottomNavItem.create: GlobalKey<NavigatorState>(),
    BottomNavItem.questRoom: GlobalKey<NavigatorState>(),
    BottomNavItem.profile: GlobalKey<NavigatorState>(),
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBarCubit, BottomNavBarState>(
      builder: (context, state) {
        return Scaffold(
          bottomNavigationBar: BottomNavBar(
            items: items,
            selectedItem: state.selectedItem,
            onTap: (index) {
              final selectedItem = BottomNavItem.values[index];
              context
                  .read<BottomNavBarCubit>()
                  .updateSelectedItem(selectedItem);

              _selectBottomNavItem(
                  context, selectedItem, selectedItem == state.selectedItem);
            },
          ),
          body: Stack(
            children: items
                .map(
                  (item, _) => MapEntry(
                    item,
                    _buildOffstageNavigator(item, item == state.selectedItem),
                  ),
                )
                .values
                .toList(),
          ),
        );
      },
    );
  }

  void _selectBottomNavItem(
      BuildContext context, BottomNavItem selectedItem, bool isSameItem) {
    if (isSameItem) {
      //For navigating top of the screen  Example : Home Course List Page -> Detail Page so when user tap on Current Nav Item so it get the first Course List Route.
      navigatorKeys[selectedItem]
          .currentState
          .popUntil((route) => route.isFirst);
    }
  }

  Widget _buildOffstageNavigator(
    BottomNavItem currentItem,
    bool isSelected,
  ) {
    return Offstage(
      offstage: !isSelected,
      child: TabNavigator(
        navigatorKey: navigatorKeys[currentItem],
        item: currentItem,
      ),
    );
  }
}
