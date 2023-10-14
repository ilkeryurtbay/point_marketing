String? nonEmptyValidator(String? value) {
  if (value == null || value.isEmpty) {
    return 'Bu alan boş bırakılamaz';
  }
  return null; // Geçerli bir değerse null döner.
}
