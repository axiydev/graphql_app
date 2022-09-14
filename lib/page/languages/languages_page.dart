import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_app/service/graphql_src/graph_ql_src.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class LanguagesPage extends StatelessWidget {
  final String? countryCode;
  const LanguagesPage({super.key, required this.countryCode});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Languages'),
      ),
      body: Query(
        options: QueryOptions<String?>(
            document: gql(GraphQlQuerySrc.languagesDocument!),
            variables: {"code": countryCode}),
        builder: (result, {fetchMore, refetch}) {
          if (result.hasException ||
              result.isLoading ||
              result.data!['country']['languages']!.isEmpty) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (kDebugMode) {
            print(result.data!['country']['languages']);
          }

          return ListView.builder(
              shrinkWrap: true,
              itemCount: result.data!['country']['languages'].length ?? 5,
              itemBuilder: (context, index) => Card(
                    child: ListTile(
                      onTap: () {},
                      title: Text(result.data!['country']['languages'][index]
                              ['name'] ??
                          'Unknown'),
                      subtitle: Text(result.data!['country']['languages'][index]
                              ['code'] ??
                          'Unknown'),
                    ),
                  ));
        },
      ),
    );
  }
}
