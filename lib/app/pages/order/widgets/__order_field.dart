part of '../order_page.dart';

class _OrderField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final FormFieldValidator<String> validator;
  final List<TextInputFormatter>? inputFormatters;
  final String hintText;

  const _OrderField({
    required this.title,
    required this.controller,
    required this.validator,
    required this.hintText,
    this.inputFormatters,
  });

  static const _defaultBorder = UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.grey),
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 35,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                title,
                style: context.textStyles.textRegular.copyWith(
                  overflow: TextOverflow.ellipsis,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              focusedBorder: _defaultBorder,
              enabledBorder: _defaultBorder,
              border: _defaultBorder,
            ),
            validator: validator,
            inputFormatters: inputFormatters,
          ),
        ],
      ),
    );
  }
}
