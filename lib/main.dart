import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/layout/news_layout/news_layout.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/mode_cubit.dart';
import 'package:news_app/shared/cubit/mode_states.dart';
import 'package:news_app/shared/network/local/cache_helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';


void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();
  bool isDark = CacheHelper.getBoolean(key: 'isDark') ?? false;
  runApp(MyApp(isDark!));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  const MyApp(this.isDark, {Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => NewsCubit()
            ..getSports(),
        ),
        BlocProvider(
          create: (BuildContext context) => ModeCubit()
            ..changeAppMode(
              fromShared: isDark,
            ),
        ),
      ],
      child: BlocConsumer<ModeCubit, ModeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              scaffoldBackgroundColor: Colors.white,
              primarySwatch: Colors.deepOrange,
              colorScheme: ColorScheme.light(
                background: Colors.white,
              ),
              brightness: Brightness.light,
              textTheme: TextTheme(
                titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 30,
                ),
                titleMedium: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    overflow: TextOverflow.ellipsis),
              ),
              canvasColor: Colors.white,
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: const Color(0xFFde2821),
                selectionColor: const Color(0xFFde2821).withOpacity(0.5),
                selectionHandleColor: const Color(0xFFde2821),
              ),
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                backgroundColor: Colors.white,
                elevation: 0,
                scrolledUnderElevation: 0,
                shadowColor: Colors.transparent,
                actionsIconTheme: IconThemeData(color: Colors.black),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                selectedItemColor: Colors.deepOrange,
                showUnselectedLabels: true,
                unselectedItemColor: Colors.black,
                elevation: 15,
                unselectedLabelStyle: TextStyle(color: Colors.black),
              ),
            ),
            darkTheme: ThemeData(
              scaffoldBackgroundColor: HexColor('18191A'),
              primarySwatch: Colors.deepOrange,
              colorScheme: ColorScheme.dark(
                background: HexColor('18191A'),
              ),
              brightness: Brightness.dark,
              textTheme: TextTheme(
                titleLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: 30,
                ),
                titleMedium: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    overflow: TextOverflow.ellipsis),
              ),
              canvasColor: HexColor('18191A'),
              textSelectionTheme: TextSelectionThemeData(
                cursorColor: const Color(0xFFde2821),
                selectionColor: const Color(0xFFde2821).withOpacity(0.5),
                selectionHandleColor: const Color(0xFFde2821),
              ),
              appBarTheme: AppBarTheme(
                titleTextStyle: const TextStyle(color: Colors.grey),
                titleSpacing: 20.0,
                backgroundColor: HexColor('18191A'),
                scrolledUnderElevation: 0,
                shadowColor: Colors.transparent,
                elevation: 0,
                actionsIconTheme: const IconThemeData(color: Colors.grey),
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('18191A'),
                  statusBarIconBrightness: Brightness.light,
                ),
              ),
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                backgroundColor: HexColor('18191A'),
                selectedItemColor: Colors.deepOrange,
                showUnselectedLabels: true,
                unselectedItemColor: Colors.grey,
                elevation: 15,
                unselectedLabelStyle: const TextStyle(color: Colors.grey),
              ),
            ),
            themeMode: ModeCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light ,
            home: Directionality(
                textDirection: TextDirection.rtl,
                child: NewsLayout()
            ),
          );
        },
      ),
    );
  }
}

