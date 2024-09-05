import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../theme/custom_colors.dart';

class CustomMultiSelectAutocomplete extends StatefulWidget {
  final List<Map<String, dynamic>> options;
  final String labelText;
  final String hintText;
  final void Function(List<int>) onChanged;
  final double contentPadding;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String valueKey;
  final bool isUpperCase;
  final bool enabled;
  final bool isAllSelected;

  const CustomMultiSelectAutocomplete({
    super.key,
    required this.options,
    required this.labelText,
    required this.hintText,
    required this.onChanged,
    this.enabled = true,
    this.valueKey = "name",
    this.isUpperCase = false,
    this.contentPadding = 20,
    required this.controller,
    required this.focusNode,
    this.isAllSelected = false,
  });

  @override
  _CustomMultiSelectAutocompleteState createState() =>
      _CustomMultiSelectAutocompleteState();
}

class _CustomMultiSelectAutocompleteState
    extends State<CustomMultiSelectAutocomplete> {
  List<int> selectedIds = [];

  @override
  Widget build(BuildContext context) {
    return RawAutocomplete<String>(
      focusNode: widget.focusNode,
      textEditingController: widget.controller,
      fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
        return TextFormField(
          enabled: widget.enabled,
          validator: (value) {
            if (!widget.enabled) return null;
            if ((value == null || value.isEmpty || value == "")) {
              return '${widget.labelText} boş bırakılamaz';
            }
            return null;
          },
          controller: controller,
          focusNode: focusNode,
          decoration: InputDecoration(
            suffixIcon: Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 15),
              child: Icon(Icons.arrow_drop_down,
                  color: widget.options.isNotEmpty
                      ? CustomColors.dark.getColor
                      : CustomColors.light.getColor),
            ),
            labelText: widget.labelText,
            hintText: widget.hintText,
            contentPadding: EdgeInsets.only(
              bottom: widget.contentPadding,
            ),
          ),
        );
      },
      optionsBuilder: (TextEditingValue textEditingValue) {
        List<String> optionsNames = widget.options.map((e) {
          return widget.isUpperCase
              ? e[widget.valueKey].toString().toUpperCase()
              : e[widget.valueKey].toString();
        }).toList();
        if (textEditingValue.text.isNotEmpty) {
          return optionsNames.where((String option) {
            return option.contains(widget.isUpperCase
                ? textEditingValue.text.toUpperCase()
                : textEditingValue.text);
          });
        }
        return optionsNames;
      },
      optionsViewOpenDirection: OptionsViewOpenDirection.down,
      onSelected: (value) {
        if (value.isNotEmpty) {
          for (var i = 0; i < widget.options.length; i++) {
            if (widget.options[i][widget.valueKey].toString().toUpperCase() ==
                value.toUpperCase()) {
              setState(() {
                int id = widget.options[i]["id"];
                if (selectedIds.contains(id)) {
                  selectedIds.remove(id);
                } else {
                  selectedIds.add(id);
                }
              });
            }
          }
          widget.onChanged(selectedIds);
        }
      },
      optionsViewBuilder: (context, onSelected, options) {
        return Align(
          alignment: Alignment.topLeft,
          child: Material(
            elevation: 4.0,
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                  maxHeight: 200,
                  maxWidth: 500), //RELEVANT CHANGE: added maxWidth
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (BuildContext context, int index) {
                  final option = options.elementAt(index);
                  return InkWell(
                    onTap: () {
                      onSelected(option);
                    },
                    child: Builder(builder: (BuildContext context) {
                      final bool highlight =
                          AutocompleteHighlightedOption.of(context) == index;
                      if (highlight) {
                        SchedulerBinding.instance
                            .addPostFrameCallback((Duration timeStamp) {
                          Scrollable.ensureVisible(context, alignment: 0.5);
                        });
                      }
                      final bool isSelected =
                          selectedIds.contains(widget.options[index]["id"]);
                      return Container(
                        color: highlight ? Theme.of(context).focusColor : null,
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Checkbox(
                              value: isSelected,
                              onChanged: (bool? value) {
                                onSelected(option);
                              },
                            ),
                            Expanded(child: Text(option)),
                          ],
                        ),
                      );
                    }),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}
