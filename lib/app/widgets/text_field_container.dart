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
  final bool? email;
  final bool? newPwd;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;

  const TextFieldContainer({
    super.key,
    this.hintText,
    this.icon,
    this.onChanged,
    this.controller,
    this.focus,
    this.validatorText,
    this.inputFormatters,
    this.keyboardType,
    this.pwd,
    this.email,
    this.newPwd,
  });

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
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        obscureText: widget.pwd == true ? !visible : visible,
        validator: (value) {
          if (value!.isEmpty) {
            return widget.validatorText;
          }

          if (widget.email == true) {
            if (!value.contains('@')) {
              return 'O email deve conter "@"';
            }
          }

          if (widget.pwd == true) {
            if (value.length < 6) {
              return 'A senha deve ter no mínimo 6 dígitos';
            }
          }

          if (widget.newPwd == true && widget.pwd == true) {
            if (value != widget.controller!.text) {
              return 'A senha e a confirmação devem ser iguais';
            }
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
          // hintText: widget.hintText,
          labelText: widget.hintText,
          labelStyle: Theme.of(context).textTheme.bodySmall,
          hintStyle: Theme.of(context).textTheme.bodySmall,
          icon: Icon(widget.icon, color: Theme.of(context).colorScheme.primary),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
