import 'package:flutter/material.dart';
import 'package:my_app/data/model/user_create.dart';
import 'package:my_app/data/repository/repository.dart';

class EditUserPage extends StatefulWidget {
  final String id;
  // ignore: use_key_in_widget_constructors
  const EditUserPage({required this.id});
  @override
  State<EditUserPage> createState() => _EditUserPageState();
}

class _EditUserPageState extends State<EditUserPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  Future<UserCreate>? _futureEditUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit User'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                isDense: true,
                hintText: 'Name',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _jobController,
              decoration: const InputDecoration(
                isDense: true,
                hintText: 'Job',
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            FutureBuilder<UserCreate>(
              future: _futureEditUser,
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return const CircularProgressIndicator();
                  default:
                    return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(MediaQuery.of(context).size.width, 54),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        textStyle: const TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        if (_nameController.text.isEmpty) {
                          return;
                        }
                        if (_jobController.text.isEmpty) {
                          return;
                        }
                        setState(() {
                          _futureEditUser = Repository().editUser(
                            widget.id,
                            _nameController.text,
                            _jobController.text,
                          );
                        });
                      },
                      child: const Text('Edit User'),
                    );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
