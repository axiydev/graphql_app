import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_app/page/languages/languages_page.dart';
import 'package:graphql_app/service/graphql_src/graph_ql_src.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class CountriesPage extends StatelessWidget {
  final String? continentCode;
  const CountriesPage({super.key, required this.continentCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('countries'),
      ),
      body: Query(
        options: QueryOptions<String?>(
            document: gql(GraphQlQuerySrc.countriesDocument!),
            variables: {"code": continentCode}),
        builder: (result, {fetchMore, refetch}) {
          if (result.hasException ||
              result.isLoading ||
              result.data!['continent']['countries']!.isEmpty) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (kDebugMode) {
            print(result.data!['continent']['countries']);
          }

          return ListView.builder(
              shrinkWrap: true,
              itemCount: result.data!['continent']['countries'].length ?? 5,
              itemBuilder: (context, index) => Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => GraphQLProvider(
                                  client: GraphQlSrc.client,
                                  child: LanguagesPage(
                                      countryCode: result.data!['continent']
                                          ['countries'][index]['code']),
                                )));
                      },
                      title: Text(result.data!['continent']['countries'][index]
                              ['name'] ??
                          'Unknown'),
                      subtitle: Text(result.data!['continent']['countries']
                              [index]['code'] ??
                          'Unknown'),
                    ),
                  ));
        },
      ),
    );
  }
}
