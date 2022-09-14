import 'package:flutter/material.dart';
import 'package:graphql_app/page/continents/continents_page.dart';
import 'package:graphql_app/service/graphql_src/graph_ql_src.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
/*
Created by Axmadjon Isaqov on 15:10:07 14.09.2022
© 2022 @axi_dev 
*/

/*
Mavzu:::GraphQl Flutter
*/
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GraphQLProvider(
          client: GraphQlSrc.client, child: const ContinentsPage()),
    );
  }
}
