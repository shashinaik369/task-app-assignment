import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tasks_app_asignment/constants.dart';
import 'package:tasks_app_asignment/screens/authentication/login_screen.dart';
import 'package:tasks_app_asignment/task_database.dart';
import 'blocs/task/task_bloc.dart';
import 'models/task_model.dart';
import 'screens/homescreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    
  );
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());

  final hiveDatabase = HiveDatabase();
  await hiveDatabase.openBox();
  runApp(MyApp(
    hiveDatabase: hiveDatabase,
  ));
}

class MyApp extends StatelessWidget {
  final HiveDatabase _hiveDatabase;

  const MyApp({
    Key? key,
    required HiveDatabase hiveDatabase,
  })  : _hiveDatabase = hiveDatabase,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _hiveDatabase,
      child: BlocProvider(
        create: (context) => TaskBloc(
          hiveDatabase: _hiveDatabase,
        )..add(
            LoadTasks(),
          ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: const MaterialColor(
              0xFF000A1F,
              <int, Color>{
                50: Color(0xFF000A1F),
                100: Color(0xFF000A1F),
                200: Color(0xFF000A1F),
                300: Color(0xFF000A1F),
                400: Color(0xFF000A1F),
                500: Color(0xFF000A1F),
                600: Color(0xFF000A1F),
                700: Color(0xFF000A1F),
                800: Color(0xFF000A1F),
                900: Color(0xFF000A1F),
              },
            ),
          ),
          home:(firebaseAuth.currentUser != null) ? HomeScreen() : LoginScreen(),
        ),
      ),
    );
  }
}
