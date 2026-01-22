import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class CustomSearchBar extends StatelessWidget {
  final double height;
  final double width;
  final String hintText;

  const CustomSearchBar({
    required this.height,
    required this.width,
    super.key,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: TextField(
        // controller: controller,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).dividerColor,
              width: 0.1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).dividerColor,
              width: 0.1,
            ),
          ),
          filled: true,
          fillColor: Theme.of(context).colorScheme.surface,
          hintText: hintText,
          hintStyle: GoogleFonts.inter(
            color: Theme.of(context).iconTheme.color,
            fontWeight: FontWeight.w400,
            fontSize: 12,
            // fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
