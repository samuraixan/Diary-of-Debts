class Contact{
  final String name;
  final String phoneNumber;
  final String? imagePath;
  bool? favorites;
  Contact({required this.name, required this.phoneNumber, this.imagePath, this.favorites});
}