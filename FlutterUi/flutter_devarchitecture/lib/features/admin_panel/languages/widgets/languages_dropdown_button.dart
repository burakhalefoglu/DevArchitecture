import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_devarchitecture/features/admin_panel/lookups/models/lookup.dart';

import '../../../../core/di/core_initializer.dart';
import '../bloc/language_cubit.dart';
import '../../../../core/bloc/base_state.dart';
import '../../../../core/widgets/inputs/dropdown_button.dart';

class LanguageDropdownButton extends StatefulWidget {
  final void Function(LookUp selectedLanguage) onChanged;
  final void Function(LookUp selectedLanguage) getInitialValue;
  final Key? key;

  const LanguageDropdownButton({
    this.key,
    required this.onChanged,
    required this.getInitialValue,
  }) : super(key: key);

  @override
  _LanguageDropdownButtonState createState() => _LanguageDropdownButtonState();
}

class _LanguageDropdownButtonState extends State<LanguageDropdownButton> {
  LookUp? _selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageCubit(),
      child: BlocConsumer<LanguageCubit, BaseState>(
        listener: (context, state) {
          if (state is BlocFailed) {
            CoreInitializer()
                .coreContainer
                .screenMessage
                .getErrorMessage(state.message);
          }
        },
        builder: (context, state) {
          if (state is BlocInitial || state is BlocLoading) {
            BlocProvider.of<LanguageCubit>(context).getLanguageLookups();
            return const CircularProgressIndicator();
          } else if (state is BlocSuccess<List<LookUp>>) {
            List<LookUp> languages = state.result!;

            // Dropdown'da gösterilecek seçenekler
            List<String> options = languages.map((lang) => lang.label).toList();

            return CustomDropdownButton(
              key: widget.key,
              icon: Icons.language,
              getFirstValue: (value) {
                _selectedLanguage = languages.firstWhere(
                    (lang) => lang.label == value,
                    orElse: () => languages.first);
                widget.getInitialValue(_selectedLanguage!);
              },
              options: options,
              onChanged: (String? selectedValue) {
                if (selectedValue != null) {
                  _selectedLanguage = languages
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
