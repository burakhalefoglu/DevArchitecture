import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/base_state.dart';
import '../../user-claims/bloc/user_claim_cubit.dart';
import '../../user-claims/widgets/user_claim_auto_complete.dart';

class ChangeUserClaimsDialog extends StatefulWidget {
  final int userId;

  const ChangeUserClaimsDialog({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  _ChangeUserClaimsDialogState createState() => _ChangeUserClaimsDialogState();
}

class _ChangeUserClaimsDialogState extends State<ChangeUserClaimsDialog> {
  List<int> _selectedClaims = []; // Seçilen yetkiler

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          UserClaimCubit()..getUserClaimsByUserId(widget.userId),
      child: BlocConsumer<UserClaimCubit, BaseState>(
        listener: (context, state) {
          if (state is BlocFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is BlocLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return AlertDialog(
            title: const Text('Kullanıcı Yetkilerini Güncelle'),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: UserClaimAutocomplete(
                userId: widget.userId,
                onChanged: (selectedClaims) {
                  setState(() {
                    _selectedClaims = selectedClaims;
                  });
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('İptal'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_selectedClaims.isNotEmpty) {
                    BlocProvider.of<UserClaimCubit>(context)
                        .saveUserClaimsByUserId(widget.userId, _selectedClaims);
                    Navigator.of(context).pop();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Lütfen en az bir yetki seçiniz.'),
                      ),
                    );
                  }
                },
                child: const Text('Kaydet'),
              ),
            ],
          );
        },
      ),
    );
  }
}
