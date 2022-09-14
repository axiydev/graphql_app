import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphQlSrc {
  static HttpLink httpLink = HttpLink('https://countries.trevorblades.com');
  static ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(link: httpLink, cache: GraphQLCache()));
}

class GraphQlQuerySrc {
  static String? get continentsDocument => r'''
query GetContinents{
  continents{
    name
    code
  }
}
''';

  static String? get countriesDocument => r'''
query FlutterQuery($code:ID!){
 continent(code:$code){
  name
  code
  countries{
    name
    code
  }
}
}
''';
  static String? get languagesDocument => r'''
query FlutterQuery($code:ID!){
  country(code:$code){
    name
    code
    languages{
      native
      name
      code
      rtl
    }
}
}
''';
}
