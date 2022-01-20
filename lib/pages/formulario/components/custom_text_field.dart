import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String descText;
  final int? line;
  final int? tamanho;
  final String? Function(String? text)? validator;
  final void Function(String? text)? onSaved;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final TextInputAction? textInputAction;
  final String? initialValue;

  const CustomTextField({
    Key? key,
    required this.label,
    required this.descText,
    this.line,
    this.tamanho,
    this.validator,
    this.initialValue,
    this.onSaved,
    this.keyboardType,
    this.controller,
    this.focusNode,
    this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: key,
      initialValue: initialValue,
      controller: (controller == null) ? null : controller,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      onSaved: onSaved,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
        hintText: descText,
      ),
      maxLength: (tamanho == null) ? null : tamanho,
      maxLines: (line == null) ? null : line,
      keyboardType: (keyboardType == null) ? null : keyboardType,
      focusNode: (focusNode == null) ? null : focusNode,
      textInputAction: (textInputAction == null) ? null : textInputAction,
    );
  }
}

class CategoriaDropDownInput<String> extends StatelessWidget {
  final String hintText;
  final List<String> options;
  final String? value;
  final String Function(String)? getLabel;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSaved;

  const CategoriaDropDownInput({
    Key? key,
    required this.hintText,
    required this.options,
    this.value,
    this.getLabel,
    this.onChanged,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      onSaved: onSaved,
      builder: (FormFieldState<String> state) {
        return InputDecorator(
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            labelText: 'Selecione a Categoria',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
          isEmpty: value == null || value == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isDense: true,
              onChanged: onChanged,
              items: options.map((value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(getLabel!(value).toString()),
                );
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}
