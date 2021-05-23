import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_book_app/bloc/searchBloc/search_bloc.dart';
import 'package:graduation_project_book_app/bloc/vdpBloc/vdb_bloc.dart';
import 'package:graduation_project_book_app/config/build_router.dart';
import 'package:graduation_project_book_app/logic/tech_mobile.dart';
import 'package:graduation_project_book_app/screens/signIn/signin.dart';
import 'package:graduation_project_book_app/services/search_services.dart';
import 'package:graduation_project_book_app/services/vdp_services.dart';

void main() {
  runApp(TechMobile(
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<VdpBloc>(create: (context) {
            return VdpBloc(Vdpservice());
          }),
          BlocProvider<SearchBloc>(create: (context) {
            return SearchBloc(SearchService());
          })
        ],
        child: LayoutBuilder(builder: (context, constraints) {
          return MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                  primarySwatch: Colors.blue,
                  appBarTheme: Theme.of(context)
                      .appBarTheme
                      .copyWith(brightness: Brightness.light)),
              //home: NavigationScreen());
              home: LoginScreen(),
              routes: buildRoutes());
        }));
  }
}
