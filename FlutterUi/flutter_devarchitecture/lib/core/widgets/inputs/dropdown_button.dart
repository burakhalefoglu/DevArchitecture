import 'package:flutter/material.dart';
import '/core/theme/extensions.dart';

import '../../theme/custom_colors.dart';

class CustomDropdownButton extends StatefulWidget {
  final List<String> options;
  final void Function(String?) onChanged;
  final void Function(String?) getFirstValue;
  final IconData icon;

  const CustomDropdownButton({
    super.key,
    required this.options,
    required this.onChanged,
    required this.getFirstValue,
    required this.icon,
  });

  @override
  State<CustomDropdownButton> createState() => _VtDropdownButtonState();
}

class _VtDropdownButtonState extends State<CustomDropdownButton> {
  late String _firstValue;

  @override
  void initState() {
    super.initState();
    _firstValue = widget.options.first;
  }

  @override
  Widget build(BuildContext context) {
    widget.getFirstValue(widget.options.first);
    return Padding(
      padding: context.lowVerticalPadding,
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          prefixIcon: Icon(
            widget.icon,
            color: CustomColors.dark.getColor.withAlpha(150),
          ),
        ),
        style: TextStyle(
          color: CustomColors.dark.getColor,
          fontSize: 18.0,
          fontWeight: FontWeight.w300,
        ),
        isExpanded: true,
        items: [
          ...List.generate(
            widget.options.length,
            (index) => DropdownMenuItem(
              alignment: Alignment.topLeft,
              value: widget.options[index],
              child: Text(widget.options[index]),
            ),
          ),
        ],
        value: _firstValue,
        onChanged: (value) {
          widget.onChanged(value);
          setState(() {
            _firstValue = value.toString();
          });
        },
      ),
    );
  }
}
