import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'screens/HomeScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  // Declaring Auth Variables
  AuthLink authLink;
  HttpLink httpLink;
  // Declaring GraphQLClient for connection
  ValueNotifier<GraphQLClient> client;

  @override
  void initState() {
    super.initState();
    // Setting up network with GraphQL Server
    authLink = AuthLink(
        getToken: () async =>
            'Bearer <ADD YOUR JWT TOKEN HERE>');
    httpLink =
        HttpLink(uri: '<ADD URL ENDPOINT HERE>');
    Link link = authLink.concat(httpLink);
    client = ValueNotifier(GraphQLClient(link: link, cache: InMemoryCache()));
  }

  @override
  Widget build(BuildContext context) {
    // GraphQLProvider provides access to client instance down the widget tree
    return GraphQLProvider(
      client: client,
      child: CacheProvider(
        child: MaterialApp(
          title: 'Flutter & GraphQL Demo App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: MyHomePage(title: 'Flutter with GraphQL'),
        ),
      ),
    );
  }
}
