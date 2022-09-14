import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class DetailPage extends StatefulWidget {
  final String? countryCodeOther;
  const DetailPage({super.key, required this.countryCodeOther});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Mutation(
        options: MutationOptions(
            document: gql(
              r'''
mutation FlutterMutation($code:String!,$name:String!){
  update_continents(where: { code:{_eq: $code}},_set:{name:$name}) {
    returning {
      name
      code
    }
  }
}
''',
            ),
            update: (cache, result) => true,
            // or do something with the result.data on completion
            onCompleted: (dynamic resultData) {
              print(resultData);
            },
            variables: {
              "code": widget.countryCodeOther,
              "name": controller.text
            }),
        builder: (runMutation, result) {
          if (result!.hasException || result.isLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (kDebugMode) {
            print(result.data);
          }
          return Column(
            children: [
              Text(result.data.toString()),
              CupertinoTextField(
                controller: controller,
                placeholder: 'Name',
              ),
              CupertinoButton(
                  child: const Text('update'),
                  onPressed: () {
                    runMutation({
                      "name": controller.text,
                      "code": widget.countryCodeOther
                    });
                    Navigator.of(context).pop();
                  })
            ],
          );
        },
      ),
    );
  }
}
