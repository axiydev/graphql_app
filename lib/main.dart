import 'package:flutter/material.dart';
import 'package:graphql_app/page/other/other_page.dart';
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

HttpLink link = HttpLink('https://moving-shepherd-68.hasura.app/v1/graphql',
    defaultHeaders: {
      "content-type": "application/json",
      "x-hasura-admin-secret":
          "CrBB57Pl3c9u7g9FznaiU9N635aHEnT8fYy0RiyTkYbzX3Y3kvkyv4MCsd1YC5dg"
    });

ValueNotifier<GraphQLClient> client =
    ValueNotifier(GraphQLClient(link: link, cache: GraphQLCache()));

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
          client: client,
          child: const OtherPage(
            id: '1',
          )),
      // home: GraphQLProvider(
      //     client: GraphQlSrc.client, child: const ContinentsPage()),
    );
  }
}
