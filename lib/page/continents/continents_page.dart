import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_app/models/continents_model.dart';
import 'package:graphql_app/page/countries/countries_page.dart';
import 'package:graphql_app/service/graphql_src/graph_ql_src.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ContinentsPage extends StatefulWidget {
  const ContinentsPage({super.key});

  @override
  State<ContinentsPage> createState() => _ContinentsPageState();
}

class _ContinentsPageState extends State<ContinentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('continents'),
      ),
      body: Query(
        options: QueryOptions<String?>(
            document: gql(GraphQlQuerySrc.continentsDocument!)),
        builder: (result, {fetchMore, refetch}) {
          if (result.hasException ||
              result.isLoading ||
              result.data!['continents']!.isEmpty) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (kDebugMode) {
            print(result.data!['continents']);
          }

          final ContinentsModel continentsModel =
              ContinentsModel.fromJson(result.data!);
          return ListView.builder(
              shrinkWrap: true,
              itemCount: continentsModel.continents!.length,
              itemBuilder: (context, index) => Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).push(CupertinoPageRoute(
                            builder: (context) => GraphQLProvider(
                                  client: GraphQlSrc.client,
                                  child: CountriesPage(
                                      continentCode: continentsModel
                                          .continents![index]!.code!),
                                )));
                      },
                      title: Text(continentsModel.continents![index]!.name ??
                          'Unknown'),
                      subtitle: Text(continentsModel.continents![index]!.code ??
                          'Unknown'),
                    ),
                  ));
        },
      ),
    );
  }
}
