class Validators {
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email est obligatoire !';
    }

    // Expression régulière simple pour un email
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Entrer un email valide';
    }
    return null; // ok
  }

  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mot de Passe est obligatoire !';
    }

    if (value.length < 6) {
      return 'Le Mot Passe doit contenir au moins 6 caractères';
    }

    return null; // ok
  }
}
