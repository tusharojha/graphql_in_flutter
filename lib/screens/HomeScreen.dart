import 'package:flutter/material.dart';
import 'package:flutter_catalog/models/Category.dart';
import 'package:flutter_catalog/widgets/CategoryItem.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String getCategories = """
  query {
    Category{
      Category_name
      Category_url
    }
  }
""";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Query(
          options: QueryOptions(
            documentNode: gql(getCategories),
          ),
          builder: (QueryResult result,
              {VoidCallback refetch, FetchMore fetchMore}) {
            if (result.hasException) {
              print(result.exception.toString());
              return Text("Error Connecting to server!");
            }

            if (result.loading) {
              return CircularProgressIndicator();
            }
            CategoryList cl =
                CategoryList.fromResponse(result.data['Category']);
            return ListView.builder(
                itemCount: cl.categories.length,
                itemBuilder: (context, index) {
                  final category = cl.categories[index];

                  return CategoryItem(category: category);
                });
          },
        ),
      ),
    );
  }
}
