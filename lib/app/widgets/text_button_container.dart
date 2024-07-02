import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextButtonContainer extends StatefulWidget {
  final String hintText;
  final IconData? icon;
  final ValueChanged<String>? onChanged;
  final TextEditingController? timeCtrl;
  final FocusNode? focus;
  final String? validatorText;
  final Function() onPressed;

  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  const TextButtonContainer({
    super.key,
    required this.hintText,
    this.icon,
    this.onChanged,
    this.timeCtrl,
    this.focus,
    this.validatorText,
    this.inputFormatters,
    this.keyboardType,
    required this.onPressed,
  });

  @override
  State<TextButtonContainer> createState() => _TextButtonContainerState();
}

class _TextButtonContainerState extends State<TextButtonContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.45,
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () => widget.onPressed(),
        child: IgnorePointer(
          child: TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return widget.validatorText;
              }

              return null;
            },
            readOnly: true,
            controller: widget.timeCtrl,
            decoration: InputDecoration(
              // hintText: widget.hintText,
              labelText: widget.hintText,
              labelStyle: Theme.of(context).textTheme.bodySmall,
              // hintStyle: Theme.of(context).textTheme.bodySmall,
              border: InputBorder.none,
              prefixIcon: Icon(widget.icon,
                  color: Theme.of(context).colorScheme.primary),
            ),
          ),
        ),
      ),
    );
  }
}
