import 'package:flutter/material.dart';
import 'package:my_app/data/repository/repository.dart';
import 'package:my_app/data/model/user_create.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({Key? key}) : super(key: key);

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _jobController = TextEditingController();
  Future<UserCreate>? _futureCreateUser;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create User'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Name',
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _jobController,
              decoration: InputDecoration(
                isDense: true,
                hintText: 'Job',
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            FutureBuilder<UserCreate>(
              future: _futureCreateUser,
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
                          _futureCreateUser = Repository().createUser(
                            _nameController.text,
                            _jobController.text,
                          );
                        });
                      },
                      child: const Text('Create User'),
                    );
                }
              },
            ),
            const SizedBox(height: 100),
            FutureBuilder<UserCreate>(
              future: _futureCreateUser,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      Text('name : ${snapshot.data!.name}'),
                      Text('job : ${snapshot.data!.job}'),
                    ],
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
