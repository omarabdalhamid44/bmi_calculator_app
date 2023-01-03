import 'package:bmi_calculater/bloc/bmi_cubit.dart';
import 'package:bmi_calculater/contans/color_file.dart';
import 'package:bmi_calculater/storage/db_bmi.dart';
import 'package:bmi_calculater/ui/calculate_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseBMI().initDB();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BmiCubit(),
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
            backgroundColor: backGroundColor
        ),
        home: CalculaterScreen(),
      ),
    );
  }
}
