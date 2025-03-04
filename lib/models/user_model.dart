class UserModel {
  final int id;
  final String email;
  final String firstName;
  final String lastName;
  final String avatar;

  UserModel({
    required this.id,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.avatar,
  });

  static UserModel empty() =>
      UserModel(id: 0, email: '', firstName: '', lastName: '', avatar: '');

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      email: json['email'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      avatar: json['avatar'],
    );
  }

/*Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'avatar': avatar,
    };
  }*/
}

class UserUpdate {
  final String name;
  final String job;

  UserUpdate({
    required this.name,
    required this.job,
  });

  static UserUpdate empty() => UserUpdate(name: '', job: '');

  factory UserUpdate.fromJson(Map<String, dynamic> json) {
    return UserUpdate(
      name: json['name'],
      job: json['job'],
    );
  }
}

/*
class UserResponse {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final List<UserModel> users;

  UserResponse({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.users,
  });

  static UserResponse empty() => UserResponse(page: 0, perPage: 0, total: 0, totalPages: 0, users: [],);

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      page: json['page'],
      perPage: json['per_page'],
      total: json['total'],
      totalPages: json['total_pages'],
      users: List<UserModel>.from(json['data'].map((userList) => UserModel.fromJson(userList))),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'per_page': perPage,
      'total': total,
      'total_pages': totalPages,
      'data': users.map((x) => x.toJson()).toList(),
    };
  }
}
*/
