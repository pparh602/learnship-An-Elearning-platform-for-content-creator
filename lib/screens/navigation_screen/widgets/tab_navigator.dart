import 'package:flutter/material.dart';
import 'package:learnship/core/config/custom_router.dart';
import 'package:learnship/core/enums/enums.dart';
import 'package:learnship/screens/screens.dart';

class TabNavigator extends StatelessWidget {
  static const String tabNavigatorRoot = '/';
  final GlobalKey<NavigatorState> navigatorKey;
  final BottomNavItem item;

  const TabNavigator({
    Key key,
    @required this.navigatorKey,
    @required this.item,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final routeBuilder = _routeBuilders();
    return Navigator(
      key: navigatorKey,
      initialRoute: tabNavigatorRoot,
      onGenerateInitialRoutes: (_, initialRoute) {
        return [
          MaterialPageRoute(
            settings: RouteSettings(name: tabNavigatorRoot),
            builder: (context) => routeBuilder[initialRoute](context),
          ),
        ];
      },
      onGenerateRoute: CustomRouter.onGenerateNestedRoute,
    );
  }

  Map<String, WidgetBuilder> _routeBuilders() {
    return {tabNavigatorRoot: (context) => _getScreens(context, item)};
  }

  Widget _getScreens(BuildContext context, BottomNavItem item) {
    switch (item) {
      case BottomNavItem.home:
        return HomeScreen();
      case BottomNavItem.feed:
        return FeedScreen();
      case BottomNavItem.create:
        return CreateCourseScreen();
      case BottomNavItem.questRoom:
        return QuestRoomScreen();
      case BottomNavItem.profile:
        return ProfileScreen();
      default:
        return Scaffold();
    }
  }
}
