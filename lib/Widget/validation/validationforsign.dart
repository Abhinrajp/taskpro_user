String? validateforpassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter your Password';
  }
  return null;
}

String? validateformail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Enter your Email';
  } else if (!emailregexp.hasMatch(value)) {
    return 'Please enter a valid email address';
  }
  return null;
}

final RegExp emailregexp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    caseSensitive: false, multiLine: false);
