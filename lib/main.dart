import 'package:evolesoft_app/appTheme/appTheme.dart';
import 'package:evolesoft_app/helper/routeDirectory/route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const EvoleSoftTest());
}

class EvoleSoftTest extends StatefulWidget {
  // const EvoleSoftTest({super.key});
  const EvoleSoftTest({super.key});

  @override
  State<EvoleSoftTest> createState() => _EvoleSoftTestState();
}

class _EvoleSoftTestState extends State<EvoleSoftTest> {
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double? screenHeight = MediaQuery.of(context).size.height;
    double? screenWidth = MediaQuery.of(context).size.width;

    return ScreenUtilInit(
      designSize: Size(screenWidth, screenHeight),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppThemeClass.lightTheme,
        darkTheme: AppThemeClass.darkTheme,
        title: "EvoleSoft Test App",
        initialRoute: AppRoute.splash,
        onGenerateRoute: AppRoute.generateRoute,
      ),
    );
  }
}
