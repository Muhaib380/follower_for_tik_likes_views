class Validators {
  Validators._();

  static String? name(String? v) {
    if (v == null || v.trim().isEmpty) return 'Name is required';
    if (v.trim().length < 3) return 'Name is too short';
    return null;
  }

  /// Email ya username dono chalte hain (Login screen ke hisaab se).
  static String? emailOrUsername(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email or username is required';
    return null;
  }

  static String? email(String? v) {
    if (v == null || v.trim().isEmpty) return 'Email is required';
    final ok = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$').hasMatch(v.trim());
    return ok ? null : 'Enter a valid email';
  }

  static String? password(String? v) {
    if (v == null || v.isEmpty) return 'Password is required';
    if (v.length < 6) return 'Minimum 6 characters';
    return null;
  }
}