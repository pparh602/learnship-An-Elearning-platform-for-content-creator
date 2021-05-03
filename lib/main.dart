import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learnship/screens/screens.dart';
import 'package:learnship/logic/debug/simple_bloc_observer.dart';
import 'core/config/custom_router.dart';
import 'data/repositories/repositories.dart';
import 'logic/bloc/blocs.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  EquatableConfig.stringify = kDebugMode;
  Bloc.observer = SimpleBlocObserver();
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AuthRepository>(
          create: (_) => AuthRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) =>
                AuthBloc(authRepository: context.read<AuthRepository>()),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Instagram',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: Colors.grey[50],
            appBarTheme: AppBarTheme(
              brightness: Brightness.light,
              color: Colors.white,
              iconTheme: const IconThemeData(color: Colors.black),
              textTheme: const TextTheme(
                headline6: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          onGenerateRoute: CustomRouter.onGenerateRoute,
          initialRoute: SplashScreen.routeName,
        ),
      ),
    );
  }
}

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'BottomAppBar with FAB'),
//     );
//   }
// }
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => new _MyHomePageState();
// }
// class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
//   int _lastSelected = 0;
//   TextEditingController searchController = TextEditingController();

//   YoutubeAPI ytApi = YoutubeAPI(API_KEY);
//   List<YT_API> ytResult = [];

//   callAPI() async {
//     ytResult = await ytApi.search(searchController.text);
//     ytResult = await ytApi.nextPage();
//     ytResult = await ytApi.nextPage();
//     setState(() {});
//   }

//   @override
//   void initState() {
//     super.initState();
//     //callAPI();
//     print('hello');
//   }

//   final List _children = [
//     HomeScreen(),
//     FeedScreen(),
//     QuestRoomScreen(),
//     BookmarkScreen(),
//   ];

//   void _selectedTab(int index) {
//     setState(() {
//       _lastSelected = index;
//     });
//   }

//   void _selectedFab(int index) {
//     setState(() {
//       _lastSelected = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: _children[_lastSelected],
//         bottomNavigationBar: ConvexAppBar(
//           items: [
//             TabItem(icon: Icons.home, title: 'Home'),
//             TabItem(icon: Icons.map, title: 'Feed'),
//             TabItem(icon: Icons.add, title: 'Add'),
//             TabItem(icon: Icons.message, title: 'Quest Room'),
//             TabItem(icon: Icons.people, title: 'Profile'),
//           ],
//           initialActiveIndex: 0, //optional, default as 0
//           onTap: (int i) => _selectedTab(i),
//         ),
//       ),
//     );
//   }
// }
