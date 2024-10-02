import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_devarchitecture/features/admin_panel/lookups/models/lookup.dart';

import '../../../../core/bloc/bloc_helper.dart';
import '../bloc/language_cubit.dart';
import '../../../../core/bloc/base_state.dart';
import '../../../../core/widgets/inputs/dropdown_button.dart';

class LanguageCodeDropdownButton extends StatefulWidget {
  final void Function(LookUp selectedLanguage) onChanged;
  final void Function(LookUp selectedLanguage) getInitialValue;
  final bool isShort;
  final Key? key;

  const LanguageCodeDropdownButton({
    this.key,
    required this.onChanged,
    required this.getInitialValue,
    this.isShort = false,
  }) : super(key: key);

  @override
  _LanguageCodeDropdownButtonState createState() =>
      _LanguageCodeDropdownButtonState();
}

class _LanguageCodeDropdownButtonState
    extends State<LanguageCodeDropdownButton> {
  LookUp? _selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageCubit(),
      child: BlocConsumer<LanguageCubit, BaseState>(
        listener: (context, state) {
          if (state is BlocInitial) {
            BlocProvider.of<LanguageCubit>(context).getLanguageCodes();
          }
          showScreenMessageByBlocStatus(state);
        },
        builder: (context, state) {
          var resultWidget = getResultWidgetByState(state);
          if (resultWidget != null) {
            return resultWidget;
          }
          if (state is BlocSuccess<List<LookUp>>) {
            List<LookUp> languages = state.result!;

            // Dropdown'da gösterilecek seçenekler
            List<String> options = widget.isShort
                ? languages.map((lang) => lang.id.toString()).toList()
                : languages.map((lang) => lang.label).toList();

            return CustomDropdownButton(
              key: widget.key,
              icon: Icons.language,
              getFirstValue: (value) {
                _selectedLanguage = widget.isShort
                    ? languages.firstWhere(
                        (lang) => lang.id.toString() == value,
                        orElse: () => languages.first)
                    : languages.firstWhere((lang) => lang.label == value,
                        orElse: () => languages.first);
                widget.getInitialValue(_selectedLanguage!);
              },
              options: options,
              onChanged: (String? selectedValue) {
                if (selectedValue != null) {
                  _selectedLanguage = widget.isShort
                      ? languages.firstWhere(
                          (lang) => lang.id.toString() == selectedValue)
                      : languages
                          .firstWhere((lang) => lang.label == selectedValue);
                  widget.onChanged(_selectedLanguage!);
                }
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
