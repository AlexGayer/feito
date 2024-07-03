// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

class FABWidget extends StatefulWidget {
  final Function() onPressed;
  Observable<bool> isOpened;
  FABWidget({super.key, required this.onPressed, required this.isOpened});

  @override
  State<FABWidget> createState() => _FABWidgetState();
}

class _FABWidgetState extends State<FABWidget>
    with SingleTickerProviderStateMixin {
  final duration = const Duration(milliseconds: 300);

  Widget toggle() {
    return AnimatedSlide(
      curve: Curves.ease,
      offset: !widget.isOpened.value ? Offset.zero : const Offset(0, 1),
      duration: duration,
      child: AnimatedOpacity(
        duration: duration,
        opacity: !widget.isOpened.value ? 1 : 0,
        child: FloatingActionButton(
          materialTapTargetSize: MaterialTapTargetSize.padded,
          onPressed: widget.onPressed,
          child: const Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return toggle();
  }
}
