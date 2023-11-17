class FormValidator {
  static String? emailValidator(String? value, {bool isRequired = false}) {
    if (isRequired && (value?.isEmpty ?? true)) return "Vous devez remplir ce champ";

    final regex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    if ((value ?? "").isNotEmpty && !regex.hasMatch(value!)) {
      return 'Veuillez entrer une adresse e-mail valide.';
    }

    return null;
  }

  static String? requiredValidator(String? value) {
    if (value?.isEmpty ?? true) return "Vous devez remplir ce champ";
    return null;
  }
}