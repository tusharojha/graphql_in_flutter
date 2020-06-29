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
  // GraphQL query to be fetched
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
        // Running the Query in this widget
        child: Query(
          options: QueryOptions(
            documentNode: gql(getCategories),
          ),
          builder: (QueryResult result,
              {VoidCallback refetch, FetchMore fetchMore}) {
            if (result.hasException) {
              // error connecting to server
              print(result.exception.toString());
              return Text("Error Connecting to server!");
            }

            if (result.loading) {
              // getting data from the server
              return CircularProgressIndicator();
            }
            // Casting the Categories into CategoryList Object present in Category.dart
            CategoryList cl =
                CategoryList.fromResponse(result.data['Category']);
            // Displaying the ListView on successful response
            return ListView.builder(
                itemCount: cl.categories.length,
                itemBuilder: (context, index) {
                  // Category Object contains the name & url of category
                  final category = cl.categories[index];

                  // Showing custom item ui for a particular category
                  return CategoryItem(category: category);
                });
          },
        ),
      ),
    );
  }
}
