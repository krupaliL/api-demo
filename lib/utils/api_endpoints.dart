class ApiEndPoints {
  static final String baseUrl = 'https://reqres.in/api/';
  static _AuthEndPoints authEndpoints = _AuthEndPoints();
}

class _AuthEndPoints {
  final String registerEmail = 'register';
  final String users = 'users';
  final String loginEmail = 'login';
  final String getUsers = 'users?page=2';
}