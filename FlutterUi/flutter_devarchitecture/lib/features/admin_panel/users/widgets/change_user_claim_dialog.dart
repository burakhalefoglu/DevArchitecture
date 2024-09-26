import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../user-claims/widgets/user_claim_auto_complete.dart';
import '../bloc/user_cubit.dart';

class ChangeUserClaimsDialog extends StatefulWidget {
  final int userId;
  final BuildContext c;

  const ChangeUserClaimsDialog(
      {Key? key, required this.c, required this.userId})
      : super(key: key);

  @override
  _ChangeUserClaimsDialogState createState() => _ChangeUserClaimsDialogState();
}

class _ChangeUserClaimsDialogState extends State<ChangeUserClaimsDialog> {
  List<int> _selectedClaims = []; // Seçilen yetkiler

  @override
  Widget build(BuildContext context) {
    final userCubit = BlocProvider.of<UserCubit>(widget.c);

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
              userCubit.saveUserClaims(widget.userId, _selectedClaims);
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
  }
}
