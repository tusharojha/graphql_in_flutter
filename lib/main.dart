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
  AuthLink authLink;
  HttpLink httpLink;
  ValueNotifier<GraphQLClient> client;

  @override
  void initState() {
    super.initState();
    authLink = AuthLink(
        getToken: () async =>
            'Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Ik0wTTNOVVV3UmpVNU0wSkZRalpDUkRsQ05URTNOVFk1T0RnME5EaEJNVGRDTUVORU1EQkNOZyJ9.eyJodHRwczovL2hhc3VyYS5pby9qd3QvY2xhaW1zIjp7IngtaGFzdXJhLWRlZmF1bHQtcm9sZSI6InVzZXIiLCJ4LWhhc3VyYS1hbGxvd2VkLXJvbGVzIjpbInVzZXIiXSwieC1oYXN1cmEtdXNlci1pZCI6Imdvb2dsZS1vYXV0aDJ8MTAzMDY4MTUzODY0MjU2ODcwOTM0In0sImdpdmVuX25hbWUiOiJUdXNoYXIiLCJmYW1pbHlfbmFtZSI6Ik9qaGEiLCJuaWNrbmFtZSI6InR1c2hhcm9qaGEyMDAxIiwibmFtZSI6IlR1c2hhciBPamhhIiwicGljdHVyZSI6Imh0dHBzOi8vbGgzLmdvb2dsZXVzZXJjb250ZW50LmNvbS9hLS9BT2gxNEdoYmtsTEtqaFVtWHMtcE0xb3c5Rk11dkVvUElONUYtLXlmQW1kdmZ3IiwibG9jYWxlIjoiZW4iLCJ1cGRhdGVkX2F0IjoiMjAyMC0wNi0yOVQwODoxODo0My4zNDNaIiwiaXNzIjoiaHR0cHM6Ly9nZW5lc2lzcG9ydGFsLmF1dGgwLmNvbS8iLCJzdWIiOiJnb29nbGUtb2F1dGgyfDEwMzA2ODE1Mzg2NDI1Njg3MDkzNCIsImF1ZCI6IkFLbDA2dzVESk95a2lnV2ZJVmdSS3RONDVnNzQyMzFDIiwiaWF0IjoxNTkzNDE4NzIzLCJleHAiOjExMTkzNDE4NzIxLCJhdF9oYXNoIjoiaFRiS2QxZ2hjbTlyb2RZSU1Oa0pDdyIsIm5vbmNlIjoiQ1JmQk8wSUZuU1lMcnlscTBMSUtOOWNpU1BmQU5ONUMifQ.qUdzc1dOchsrrPOHy6aFz1XRqvNdksi1lvb4Nc79fdZVoQqRzNhwzUCAU0vMq-YsNEiVoxWE99cF9Mgo_KypkY6a5g1ub2idik4uMv7QZVNYUj734FgDt3hFV2c3dFj-yZKqvxoDEiIt-WhjBAZt0SiwZHDuVpwaQ-E152P5OXouNUfLWY7qmwYNtDhyjXWfiVYMR78W7xD05oTe8G_vYfJg7db-_dRWIuUncSJ2e1rX3WZ-xmcIyKdEwPKPQkm1kkkN41jQd4ObKs-l7aJ_jCrFycaL_v3SlGBLXf5ICbBzQ6-1exn2KtsH2aeZOEGRQnrLgHH8uM5SDJel7uiYeQ');
    httpLink =
        HttpLink(uri: 'https://definite-rabbit-51.hasura.app/v1/graphql');
    Link link = authLink.concat(httpLink);
    client = ValueNotifier(GraphQLClient(link: link, cache: InMemoryCache()));
  }

  @override
  Widget build(BuildContext context) {
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
