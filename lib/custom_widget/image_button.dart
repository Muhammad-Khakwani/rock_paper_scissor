import 'package:flutter/material.dart';

class ImageButton extends StatefulWidget {
  const ImageButton(
      {super.key,
      required this.image,
      this.title,
      this.onTap,
      this.isPressed = false,
      this.height,
      this.width});

  final ImageProvider<Object> image;
  final String? title;
  final double? height;
  final double? width;
  final void Function()? onTap;
  final bool isPressed;

  @override
  State<ImageButton> createState() => _ImageButtonState();
}

class _ImageButtonState extends State<ImageButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: widget.onTap,
          child: Container(
            height: widget.height,
            width: widget.width,
            decoration: BoxDecoration(
                border: (widget.isPressed)
                    ? Border.all(color: Colors.greenAccent)
                    : null,
                image: DecorationImage(image: widget.image),
                boxShadow: [
                  BoxShadow(
                      color: Colors.blueGrey.shade100,
                      blurRadius: 5,
                      blurStyle: BlurStyle.outer)
                ]),
          ),
        ),
        widget.title != null
            ? const SizedBox(
                height: 2,
              )
            : const SizedBox(),
        Text(
          widget.title ?? "",
          style: TextStyle(color: widget.isPressed ? Colors.greenAccent : null),
        )
      ],
    );
  }
}
