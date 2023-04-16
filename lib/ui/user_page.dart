import 'package:flutter/material.dart';
import 'package:my_app/data/model/user.dart';
import 'package:my_app/data/repository/repository.dart';
import 'package:my_app/ui/edit_user_page.dart';

class UserPage extends StatefulWidget {
  final String id;

  // ignore: use_key_in_widget_constructors
  const UserPage({required this.id});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late Future<User> _futureUser;
  Future<bool>? _futureDeleteUser;

  @override
  void initState() {
    super.initState();
    _futureUser = Repository().getUser(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Page'),
      ),
      body: Center(
        child: FutureBuilder<User>(
          future: _futureUser,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              default:
                if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        foregroundImage:
                            NetworkImage("${snapshot.data!.avatar}"),
                        radius: 64,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        "${snapshot.data!.firstName} ${snapshot.data!.lastName}",
                        style: const TextStyle(fontSize: 24),
                      ),
                      Text(
                        "${snapshot.data!.email}",
                        style:
                            const TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: FutureBuilder<bool>(
                                future: _futureDeleteUser,
                                builder: (context, snapshot) {
                                  switch (snapshot.connectionState) {
                                    case ConnectionState.waiting:
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    default:
                                      return OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          fixedSize:
                                              const Size(double.infinity, 48),
                                          side: const BorderSide(
                                            width: 1,
                                            color: Colors.blue,
                                            style: BorderStyle.solid,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          textStyle:
                                              const TextStyle(fontSize: 16),
                                        ),
                                        onPressed: () {
                                          setState(() {
                                            _futureDeleteUser = Repository()
                                                .deleteUser(widget.id);
                                          });
                                        },
                                        child: const Text('Delete'),
                                      );
                                  }
                                },
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              flex: 1,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: const Size(double.infinity, 48),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          EditUserPage(id: widget.id)),
                                ),
                                child: const Text('Edit'),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }
            }
          },
        ),
      ),
    );
  }
}
