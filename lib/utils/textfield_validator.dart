enum TextFieldType { name, email, password }

class TextfieldValidator {
  static String? Function(String?)? validator(TextFieldType type) {
    switch (type) {
      case TextFieldType.name:
        return name;
      case TextFieldType.email:
        return email;
      case TextFieldType.password:
        return password;
    }
  }

  static String? name(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }
}
