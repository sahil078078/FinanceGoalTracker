

import '../exported.dart';

class CustomRichText extends StatelessWidget {
  final String text1;
  final String? text2, text3, text4, text5;
  final TextStyle? style1, style2, style3, style4, style5;
  final GestureTapCallback? onTap1, onTap2, onTap3, onTap4, onTap5;
  final TextAlign textAlign;
  final int? maxLines;
  const CustomRichText({
    super.key,
    required this.text1,
    this.text2,
    this.text3,
    this.text4,
    this.text5,
    this.style1,
    this.style2,
    this.style3,
    this.style4,
    this.style5,
    this.onTap1,
    this.onTap2,
    this.onTap3,
    this.onTap4,
    this.onTap5,
    this.textAlign = TextAlign.start,
    this.maxLines,
  });

  TextStyle get _style => MyTextStyle.regular.copyWith(
        fontSize: 13.5,
        color: black,
        height: 1.01,
      );

  @override
  Widget build(BuildContext context) {
    return RichText(
      maxLines: maxLines,
      textAlign: textAlign,
      text: TextSpan(
        style: _style,
        children: <InlineSpan>[
          TextSpan(text: text1, style: style1 ?? _style, recognizer: TapGestureRecognizer()..onTap = onTap1),
          TextSpan(text: text2, style: style2 ?? _style, recognizer: TapGestureRecognizer()..onTap = onTap2),
          TextSpan(text: text3, style: style3 ?? _style, recognizer: TapGestureRecognizer()..onTap = onTap3),
          TextSpan(text: text4, style: style4 ?? _style, recognizer: TapGestureRecognizer()..onTap = onTap4),
          TextSpan(text: text5, style: style5 ?? _style, recognizer: TapGestureRecognizer()..onTap = onTap5),
        ],
      ),
    );
  }
}
