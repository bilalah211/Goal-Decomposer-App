class ValidatorHelper {
  static String? validateTitle(String? value) {
    if (value == null || value.trim().isEmpty) return 'Title is required';
    return null;
  }

  static String? validateDescription(String? value) {
    if (value == null || value.trim().isEmpty) return 'Description is required';
    return null;
  }

  static String? validateDeadline(String? value) {
    if (value == null || value.trim().isEmpty) return 'Deadline is required';
    return null;
  }
}
