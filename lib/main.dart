import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/all_api_service.dart';
import 'pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (_) => AllApiService.create(),
      dispose: (_, AllApiService service) => service.client.dispose(),
      child: MaterialApp(
        theme: ThemeData(
          accentColor: Color(0xFFF51C4E),
          primaryColor: Color(0xFF141519),
          scaffoldBackgroundColor: Color(0xFF000000),
          textTheme: TextTheme(
            body1: TextStyle(color: Colors.white),
          ),
        ),
        color: Colors.red,
        debugShowCheckedModeBanner: false,
        title: 'COVID-19',
        home: HomePage(),
      ),
    );
  }
}
