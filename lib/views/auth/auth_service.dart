class AuthService {
  static String? _username;
  static String? _email;
  static String? _password;

  // Returns true if signup is successful (i.e. passwords match).
  static bool signup(String username, String email, String password, String confirmPassword) {
    if (password != confirmPassword) {
      return false;
    }
    _username = username;
    _email = email;
    _password = password;
    return true;
  }

  // Returns true if login is successful (i.e. credentials match a registered user).
  static bool login(String email, String password) {
    if (_email == null || _password == null) {
      return false;
    }
    return _email == email && _password == password;
  }
}
