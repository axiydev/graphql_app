import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_app/main.dart';
import 'package:graphql_app/page/other/detail/detail_page.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class OtherPage extends StatefulWidget {
  final String? id;
  const OtherPage({super.key, this.id});

  @override
  State<OtherPage> createState() => _OtherPageState();
}

class _OtherPageState extends State<OtherPage> {
  @override
  void didUpdateWidget(OtherPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Other page'),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: Query(
          options: QueryOptions(
            document: gql(r'''
      query MyQuery{
        continents{
          name
          code
        }
      }
      '''),
          ),
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
            return ListView.builder(
                itemCount: result.data!['continents'].length ?? 5,
                itemBuilder: (context, index) => Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.of(context).push(CupertinoPageRoute(
                              builder: (context) => GraphQLProvider(
                                    client: client,
                                    child: DetailPage(
                                        countryCodeOther:
                                            result.data!['continents'][index]
                                                ['code']),
                                  )));
                        },
                        title: Text(result.data!['continents'][index]['name'] ??
                            'Unknown'),
                        subtitle: Text(result.data!['continents'][index]
                                ['code'] ??
                            'Unknown'),
                      ),
                    ));
          },
        ),
      ),
    );
  }
}
