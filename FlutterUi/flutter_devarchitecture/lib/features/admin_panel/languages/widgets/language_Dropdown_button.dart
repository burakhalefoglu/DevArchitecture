import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/language_cubit.dart';
import '../models/language.dart';
import '../../../../core/bloc/base_state.dart';
import '../../../../core/widgets/inputs/dropdown_button.dart'; // Custom dropdown button

class LanguageDropdownButton extends StatefulWidget {
  final void Function(Language selectedLanguage) onChanged;
  final Key? key; // Key parametresi

  const LanguageDropdownButton({
    this.key,
    required this.onChanged,
  }) : super(key: key);

  @override
  _LanguageDropdownButtonState createState() => _LanguageDropdownButtonState();
}

class _LanguageDropdownButtonState extends State<LanguageDropdownButton> {
  Language? _selectedLanguage;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LanguageCubit()..getAll(),
      child: BlocConsumer<LanguageCubit, BaseState>(
        listener: (context, state) {
          if (state is BlocFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is BlocInitial || state is BlocLoading) {
            return const CircularProgressIndicator();
          } else if (state is BlocSuccess<List<Language>>) {
            List<Language> languages = state.result!;

            return CustomDropdownButton(
              key: widget.key, // Key parametresinin kullanımı
              icon: Icons.language,
              getFirstValue: (value) {
                _selectedLanguage = languages.firstWhere(
                    (lang) => lang.code == value,
                    orElse: () => languages.first);
              },
              options: languages.map((lang) => lang.code).toList(),
              onChanged: (String? selectedCode) {
                if (selectedCode != null) {
                  _selectedLanguage =
                      languages.firstWhere((lang) => lang.code == selectedCode);
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
