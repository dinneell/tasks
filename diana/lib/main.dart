import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'screens/todo_screen.dart';
import 'screens/statistics_screen.dart';
import 'screens/categories_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/help_screen.dart';
import 'screens/about_screen.dart';
import 'screens/auth/login_screen.dart';
import 'screens/auth/register_screen.dart';
import 'cubits/todo_api_cubit.dart';
import 'service_locator.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('todoBox');
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetIt.I<TodoCubit>()),
        BlocProvider(create: (_) => GetIt.I<ThemeCubit>()),
        BlocProvider(create: (_) => TodoApiCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeMode,
            home: const HomeScreen(),
            routes: {
              '/todo': (context) => const TodoScreen(),
              '/settings': (context) => const SettingsScreen(),
              '/profile': (context) => const ProfileScreen(),
              '/statistics': (context) => const StatisticsScreen(),
              '/categories': (context) => const CategoriesScreen(),
              '/notifications': (context) => const NotificationsScreen(),
              '/help': (context) => const HelpScreen(),
              '/about': (context) => const AboutScreen(),
              '/login': (context) => const LoginScreen(),
              '/register': (context) => const RegisterScreen(),
            },
          );
        },
      ),
    );
  }
}

