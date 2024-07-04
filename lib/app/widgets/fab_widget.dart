import 'package:flutter/material.dart';

class FABWidget extends StatelessWidget {
  final Function() onPressed;
  final bool isOpened;

  FABWidget({Key? key, required this.onPressed, required this.isOpened})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSlide(
      curve: Curves.ease,
      offset: !isOpened ? Offset.zero : const Offset(0, 1),
      duration: const Duration(milliseconds: 300),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: !isOpened ? 1 : 0,
        child: FloatingActionButton(
          materialTapTargetSize: MaterialTapTargetSize.padded,
          onPressed: onPressed,
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
