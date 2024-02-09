import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String btnText;
  final VoidCallback ontap;
  final Color btnTextColor;
  final bool loading;

  final Color btnColor;
  final double btnRadius;
  final double btnHeight;
  final double btnMargin;
  final double btnWidth;
  const CustomButton({
    super.key,
    required this.btnText,
    required this.ontap,
    this.btnRadius = 8,
    this.btnTextColor = Colors.white,
    this.btnColor = Colors.black,
    this.btnWidth = double.infinity,
    this.btnHeight = 60,
    this.btnMargin = 10,
    this.loading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: btnWidth,
      height: btnHeight,
      margin: EdgeInsets.symmetric(horizontal: btnMargin),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Theme.of(context).brightness == Brightness.dark
                ? Colors.white
                : btnColor,
          ),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(btnRadius),
            ),
          ),
        ),
        onPressed: loading ? null : ontap,
        child: loading
            ? SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black
                      : Colors.white,
                ),
              )
            : Text(
                btnText,
                style: TextStyle(
                  color: Theme.of(context).brightness == Brightness.dark
                      ? Colors.black
                      : btnTextColor,
                  fontFamily: "DMSans Medium",
                ),
              ),
      ),
    );
  }
}
