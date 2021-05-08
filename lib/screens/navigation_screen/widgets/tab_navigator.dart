import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnship/core/config/custom_router.dart';
import 'package:learnship/core/enums/enums.dart';
import 'package:learnship/data/repositories/repositories.dart';
import 'package:learnship/logic/bloc/blocs.dart';
import 'package:learnship/logic/cubit/cubits.dart';
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
        return BlocProvider(
          create: (context) => ProfileBloc(
            authBloc: context.read<AuthBloc>(),
            userRepository: context.read<UserRepository>(),
          )..add(
              ProfileLoadUser(userId: context.read<AuthBloc>().state.user.uid),
            ),
          child: HomeScreen(),
        );
      case BottomNavItem.feed:
        return FeedScreen();
      case BottomNavItem.create:
        return BlocProvider(
          create: (context) => CreatePostCubit(
            postRepository: context.read<PostRepository>(),
            storageRepository: context.read<StorageRepository>(),
            authBloc: context.read<AuthBloc>(),
          ),
          child: CreateCourseScreen(),
        );
      case BottomNavItem.questRoom:
        return QuestRoomScreen();
      case BottomNavItem.profile:
        return BlocProvider(
          create: (_) => ProfileBloc(
            authBloc: context.read<AuthBloc>(),
            userRepository: context.read<UserRepository>(),
          )..add(
              ProfileLoadUser(userId: context.read<AuthBloc>().state.user.uid),
            ),
          child: ProfileScreen(),
        );
      default:
        return Scaffold();
    }
  }
}
