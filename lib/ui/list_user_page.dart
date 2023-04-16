import 'package:flutter/material.dart';
import 'package:my_app/data/model/state_fetcher.dart';
import 'package:my_app/data/model/user.dart';
import 'package:my_app/provider/list_user_fetcher.dart';
import 'package:my_app/ui/user_page.dart';
import 'package:provider/provider.dart';

class ListUserPage extends StatefulWidget {
  const ListUserPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ListUserPageState createState() => _ListUserPageState();
}

class _ListUserPageState extends State<ListUserPage> {
  @override
  void initState() {
    Provider.of<ListUserFetcher>(context, listen: false).fetchListUser();
    // listUserFetcher.fetchListUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List User'),
      ),
      body: Consumer<ListUserFetcher>(
        builder: (context, value, _) {
          switch (value.stateFetcher) {
            case StateFetcher.loading:
              return const Center(child: CircularProgressIndicator());
            case StateFetcher.loaded:
              return ListView.builder(
                itemCount: value.user?.length,
                itemBuilder: (context, index) => itemUser(value.user![index]),
              );
            case StateFetcher.error:
              return Center(child: Text('${value.error}'));
            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  ListTile itemUser(User user) {
    return ListTile(
      leading: CircleAvatar(
        foregroundImage: NetworkImage('${user.avatar}'),
      ),
      title: Text('${user.firstName} ${user.lastName}'),
      subtitle: Text('${user.email}'),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserPage(id: '${user.id}')),
        );
      },
    );
  }
}
