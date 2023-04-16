import 'package:flutter/material.dart';
import 'package:my_app/provider/list_user_fetcher.dart';
import 'package:my_app/ui/create_user_page.dart';
import 'package:my_app/ui/list_user_page.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ListUserPage(),
    );
  }
}

class ListUser extends StatelessWidget {
  const ListUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List'),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('List User'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider<ListUserFetcher>(
                    create: (context) => ListUserFetcher(),
                    child: const ListUserPage(),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateUserPage(),
            ),
          );
        },
        child: const Icon(Icons.person_add_alt_1),
      ),
    );
  }
}
