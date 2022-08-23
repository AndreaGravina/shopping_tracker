import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_template/theme/style.dart';
import 'package:flutter_template/utils/responsive_util.dart';
import 'package:flutter_template/utils/router.dart';
import 'package:flutter_template/utils/shared_prefs.dart';
import 'package:flutter_template/utils/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SharedPrefs.init();

  setupServiceLocator();

  runApp(EasyLocalization(
    supportedLocales: const [
      Locale('it', 'IT'),
      //Locale('en', 'US'),
    ],
    path: 'assets/translations',
    fallbackLocale: const Locale('it', 'IT'),
    useOnlyLangCode: true,
    child: ResponsiveAppUtil(builder: (
      BuildContext context,
      Orientation orientation,
      DeviceType deviceType,
    ) {
      return const MyApp();
    }),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //lock screen in portrait
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      theme: appTheme(),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: CustomRouter.generateRoute,
      initialRoute: '/',
    );
  }
}
