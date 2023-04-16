class UserCreate {
  UserCreate({
    this.id,
    this.name,
    this.job,
  });

  String? id;
  String? name;
  String? job;

  factory UserCreate.fromJson(Map<String, dynamic> json) => UserCreate(
        id: json["id"],
        name: json["name"],
        job: json["job"],
      );
}
