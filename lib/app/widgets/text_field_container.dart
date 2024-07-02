import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class TextFieldContainer extends StatefulWidget {
  final String? hintText;
  final IconData? icon;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final FocusNode? focus;
  final String? validatorText;
  final bool? pwd;

  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  const TextFieldContainer(
      {super.key,
      this.hintText,
      this.icon,
      this.onChanged,
      this.controller,
      this.focus,
      this.validatorText,
      this.inputFormatters,
      this.keyboardType,
      this.pwd});

  @override
  State<TextFieldContainer> createState() => _TextFieldContainerState();
}

class _TextFieldContainerState extends State<TextFieldContainer> {
  bool visible = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        obscureText: widget.pwd == true ? !visible : visible,
        validator: (value) {
          if (value!.isEmpty) {
            return widget.validatorText;
          }

          return null;
        },
        keyboardType: widget.keyboardType,
        inputFormatters: widget.inputFormatters,
        controller: widget.controller,
        onChanged: widget.onChanged,
        focusNode: widget.focus,
        cursorColor: Theme.of(context).colorScheme.primary,
        decoration: InputDecoration(
          suffixIcon: widget.pwd == true
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      visible = !visible;
                    });
                  },
                  icon: Icon(
                    !visible ? MdiIcons.eyeOff : MdiIcons.eye,
                    color: Theme.of(context).colorScheme.primary,
                  ))
              : null,
          hintText: widget.hintText,
          labelText: widget.hintText,
          labelStyle: Theme.of(context).textTheme.labelSmall,
          hintStyle: Theme.of(context).textTheme.labelSmall,
          icon: Icon(widget.icon, color: Theme.of(context).colorScheme.primary),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
