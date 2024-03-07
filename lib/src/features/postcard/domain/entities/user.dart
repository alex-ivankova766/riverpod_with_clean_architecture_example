import 'package:formz/formz.dart';

class User {
  User({
    required this.name,
    required this.birthDate,
  });
  Name name;
  DateTime birthDate;
}

enum NameValidationError { invalid }

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');
  const Name.dirty([super.value = '']) : super.dirty();

  static final RegExp _usernameRegExp =
      RegExp(r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+$');

  @override
  NameValidationError? validator(String? value) {
    return _usernameRegExp.hasMatch(value ?? '')
        ? null
        : NameValidationError.invalid;
  }
}
