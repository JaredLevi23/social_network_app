import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key, required this.label, this.onPressed, this.background, this.outlineColor, this.fontColor,
  });

  final String label;
  final Function()? onPressed;
  final Color? background;
  final Color? outlineColor;
  final Color? fontColor;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 60,
      color: background ?? Colors.indigo,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular( 15 ),
        side: BorderSide(
          color: outlineColor ?? Colors.transparent,
          width: 3
        )
      ),
      textColor: fontColor ?? Colors.white,
      onPressed: onPressed,
      child: Text( label , style: const TextStyle( fontSize: 17 ),),
    );
  }
}