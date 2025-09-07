import 'package:education/routes/route_navigation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'core/services/secure_storage/secure_storage.dart';
import 'core/utils/permission_handler/connection_validator.dart';
import 'core/utils/print_log.dart';


String accessToken = "";
StreamController<int> msgController = StreamController<int>.broadcast();
RxBool internetConnection = true.obs;

Future<void> main() async{

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitUp]);

  await AppSecureStorage.getInstance().then((value) => {
    accessToken = value?.getString(AppSecureStorage.kAuthToken) ?? "",
    PrintLog.printLog("Auth Token is: $accessToken"),
    PrintLog.printLog("Fcm Token is: ${value?.getString(AppSecureStorage.kFcmToken) ?? ""}")
  });

  runApp(const MyApp());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>  with WidgetsBindingObserver{

  final networkService = ConnectionValidator();


  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    listenToInternetConnection();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  /// Listening Internet Connection Status
  listenToInternetConnection(){
    networkService.internetConnectionStream().listen((isConnected) {
      PrintLog.printLog(isConnected ? "Internet Connection Active" : "No Internet Connection");
      if(!isConnected){
        internetConnection.value = false;
      }else{
        internetConnection.value = true;
      }
    });
  }

  @override
  void didChangeAppLifecycleState(final AppLifecycleState state) async{

    switch (state) {
      case AppLifecycleState.resumed:
        PrintLog.printLog("Main App Lifecycle State::::::::: Resumed");
        break;
      case AppLifecycleState.inactive:
        PrintLog.printLog("Main App Lifecycle State::::::::: InActive");
        break;
      case AppLifecycleState.paused:
        PrintLog.printLog("Main App Lifecycle State::::::::: Paused");
        break;
      case AppLifecycleState.detached:
        PrintLog.printLog("Main App Lifecycle State::::::::: Detached");
        break;
      case AppLifecycleState.hidden:
        PrintLog.printLog("Main App Lifecycle State::::::::: Hidden");
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          if (FocusManager.instance.primaryFocus?.hasFocus ?? false) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: GetMaterialApp(
          initialRoute: RouteNavigation.splashScreenRoute,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: RouteNavigation.generateRoute,
          title: "Education App",
          darkTheme: ThemeData(
            useMaterial3: true,
            brightness: Brightness.dark,
          ),
          theme: ThemeData.light(useMaterial3: true),
          themeMode: ThemeMode.light,
          builder: (context, child) {
            return ResponsiveBreakpoints.builder(
              child: MediaQuery(data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1)), child: child!),
              breakpoints: [
                const Breakpoint(start: 0, end: 450, name: MOBILE),
                const Breakpoint(start: 451, end: 800, name: TABLET),
                const Breakpoint(start: 801, end: 1920, name: DESKTOP),
                const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
              ],

            );
          },
        )
    );
  }
}