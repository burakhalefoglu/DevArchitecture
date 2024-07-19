import 'package:flutter/material.dart';

import '/core/widgets/inputs/text_input.dart';
import '../../dependency_resolvers/get_it/core_initializer.dart';

class FilterTableWidget extends StatefulWidget {
  final List<Map<String, dynamic>> datas;
  final List<Map<String, dynamic>> headers;
  final Color color;
  final List<Widget Function(BuildContext, void Function())>
      customManipulationButton;
  final List<void Function(int)> customManipulationCallback;
  final Widget? infoHover;
  final Widget? addButton;

  const FilterTableWidget({
    super.key,
    required this.datas,
    required this.headers,
    required this.color,
    required this.customManipulationButton,
    required this.customManipulationCallback,
    required this.infoHover,
    required this.addButton,
  });

  @override
  State<FilterTableWidget> createState() => _FilterTableWidgetState();
}

class _FilterTableWidgetState extends State<FilterTableWidget> {
  List<Map<String, dynamic>> filteredData = [];
  List<String> filterKeys = [];
  final TextEditingController controller = TextEditingController();

  @override
  void initState() {
    for (var i = 0; i < widget.datas.length; i++) {
      var key = "";
      for (var element
          in widget.datas[i].values.map((e) => e.toString()).toList()) {
        key = key + element.toString();
      }
      filterKeys.add(key);
      key = "";
    }
    filteredData = widget.datas;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Expanded(
          child: Row(
        children: [
          const Spacer(
            flex: 10,
          ),
          Expanded(
            flex: 2,
            child: CustomTextInput(
              labelText: "Search",
              hintText: "",
              min: 3,
              max: 15,
              controller: controller,
              enabled: true,
              onChanged: (value) {
                if (mounted) {
                  setState(() {
                    if (value == "" || value.isEmpty) {
                      filteredData = widget.datas;
                      return;
                    }
                    filteredData = [];
                    for (var i = 0; i < widget.datas.length; i++) {
                      if (filterKeys[i]
                          .toLowerCase()
                          .contains(value.toLowerCase())) {
                        filteredData.add(widget.datas[i]);
                      }
                    }
                  });
                }
              },
            ),
          ),
          const Spacer(),
        ],
      )),
      Expanded(
          flex: 5,
          child: CoreInitializer()
              .coreContainer
              .dataTable
              .getTableWithCustomManipulationButtons(
                  context,
                  widget.headers,
                  filteredData,
                  widget.color,
                  widget.customManipulationButton,
                  widget.customManipulationCallback,
                  infoHover: widget.infoHover,
                  addButton: widget.addButton)),
      const Spacer(),
    ]);
  }
}
