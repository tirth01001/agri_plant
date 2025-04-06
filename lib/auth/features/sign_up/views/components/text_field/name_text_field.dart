part of sign_up;

class _NameTextField extends StatelessWidget {
  const _NameTextField({required this.controller, Key? key}) : super(key: key);

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: const InputDecoration(
        icon: Icon(Icons.person),
        hintText: "Name",
      ),
    );
  }
}
