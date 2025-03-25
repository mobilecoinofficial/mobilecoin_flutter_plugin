extension NullableStringExtension on String? {
  bool get isPresent => (this?.trim() ?? '') != '';

  String? get presence => isPresent ? this : null;
}
