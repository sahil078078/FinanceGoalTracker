import '../exported.dart';

class MyTextFormField extends StatelessWidget {
  final String? label;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final int? maxLength;
  final int? maxLines;
  final TextInputType? keyboardType;
  final String? hintText;
  final bool absorbing, readOnly;
  final void Function()? onTap;
  final ValueChanged<String>? onSubmit;
  final TextInputAction? textInputAction;

  const MyTextFormField({
    Key? key,
    this.label,
    this.inputFormatters,
    this.controller,
    this.validator,
    this.maxLength,
    this.maxLines = 1,
    this.keyboardType,
    this.hintText,
    this.absorbing = false,
    this.readOnly = false,
    this.onTap,
    this.onSubmit,
    this.textInputAction,
  }) : super(key: key);

  OutlineInputBorder border({Color color = grey300, double width = 1.0}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(
        color: color,
        width: width,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 7),
            child: Text(
              "$label",
              style: MyTextStyle.semiBold.copyWith(
                fontSize: 15,
              ),
            ),
          ),
        InkWell(
          onTap: absorbing ? onTap : null,
          child: AbsorbPointer(
            absorbing: absorbing,
            child: TextFormField(
              controller: controller,
              cursorColor: appPrimary,
              validator: validator,
              maxLength: maxLength,
              maxLines: maxLines,
              keyboardType: keyboardType,
              style: MyTextStyle.regular.copyWith(
                fontSize: 18,
                color: appPrimary,
              ),
              inputFormatters: inputFormatters,
              textInputAction: textInputAction ?? TextInputAction.next,
              readOnly: readOnly,
              onFieldSubmitted: onSubmit,
              decoration: InputDecoration(
                counterText: "",
                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                hintText: hintText,
                hintMaxLines: 1,
                hintStyle: MyTextStyle.regular.copyWith(color: grey700, fontSize: 15),
                border: border(width: 0.75, color: grey400),
                focusedBorder: border(color: appPrimary, width: 1),
                disabledBorder: border(width: 0.5, color: grey400),
                enabledBorder: border(width: 0.75, color: grey600),
                errorBorder: border(width: 0.45, color: red),
                focusedErrorBorder: border(width: 0.75, color: red),
                errorMaxLines: 1,
                errorStyle: MyTextStyle.light.copyWith(fontSize: 12, color: redMsg),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
