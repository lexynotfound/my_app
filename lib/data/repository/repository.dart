import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_app/data/model/user.dart';
import 'package:my_app/data/model/user_create.dart';

class Repository {
  Future<UserCreate> createUser(String name, job) async {
    final response = await http.post(
      Uri.parse('https://reqres.in/api/users/'),
      body: {"name": name, "job": job},
    );

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 201) {
      return UserCreate.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create User');
    }
  }

  Future<UserCreate> editUser(String id, name, job) async {
    final response = await http.patch(
      Uri.parse('https://reqres.in/api/users/$id'),
      body: {"name": name, "job": job},
    );

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 200) {
      return UserCreate.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to edit User');
    }
  }

  Future<bool> deleteUser(String id) async {
    final response = await http.delete(
      Uri.parse('https://reqres.in/api/users/$id'),
    );

    print(response.body);
    print(response.statusCode);

    if (response.statusCode == 204) {
      return true;
    } else {
      throw Exception('Failed to delete User');
    }
  }

  Future<User> getUser(String id) async {
    final response =
        await http.get(Uri.parse('https://reqres.in/api/users/$id'));

    print(response.body);

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body)["data"]);
    } else {
      throw Exception('Failed to load User');
    }
  }

  Future<List<User>> getListUser() async {
    // final response = await http.get(Uri.parse('https://reqres.in/api/users?page=1'));

    // print(response.body);

    // if (response.statusCode == 200) {
    //   List<User> listUser = [];
    //   for (int i = 0; i < jsonDecode(response.body)["data"].length; i++) {
    //     listUser.add(User.fromJson(jsonDecode(response.body)["data"][i]));
    //   }
    //   return listUser;
    // } else {
    //   throw Exception('Failed to load Users');
    // }

    final response = mock;
    await Future.delayed(const Duration(seconds: 1));

    // print(response);

    if (response["data"] != null) {
      List<User> listUser = [];
      for (int i = 0; i < response["data"].length; i++) {
        listUser.add(User.fromJson(response["data"][i]));
      }
      return listUser;
    } else {
      throw Exception('Failed to load Users');
    }
  }
}

Map<String, dynamic> mock = {
  "page": 2,
  "per_page": 6,
  "total": 12,
  "total_pages": 2,
  "data": [
    {
      "id": 7,
      "email": "michael.lawson@reqres.in",
      "first_name": "Michael",
      "last_name": "Lawson",
      "avatar": "https://reqres.in/img/faces/7-image.jpg"
    },
    {
      "id": 8,
      "email": "lindsay.ferguson@reqres.in",
      "first_name": "Lindsay",
      "last_name": "Ferguson",
      "avatar": "https://reqres.in/img/faces/8-image.jpg"
    },
    {
      "id": 9,
      "email": "tobias.funke@reqres.in",
      "first_name": "Tobias",
      "last_name": "Funke",
      "avatar": "https://reqres.in/img/faces/9-image.jpg"
    },
    {
      "id": 10,
      "email": "byron.fields@reqres.in",
      "first_name": "Byron",
      "last_name": "Fields",
      "avatar": "https://reqres.in/img/faces/10-image.jpg"
    },
    {
      "id": 11,
      "email": "george.edwards@reqres.in",
      "first_name": "George",
      "last_name": "Edwards",
      "avatar": "https://reqres.in/img/faces/11-image.jpg"
    },
    {
      "id": 12,
      "email": "rachel.howell@reqres.in",
      "first_name": "Rachel",
      "last_name": "Howell",
      "avatar": "https://reqres.in/img/faces/12-image.jpg"
    }
  ],
  "support": {
    "url": "https://reqres.in/#support-heading",
    "text":
        "To keep ReqRes free, contributions towards server costs are appreciated!"
  }
};
