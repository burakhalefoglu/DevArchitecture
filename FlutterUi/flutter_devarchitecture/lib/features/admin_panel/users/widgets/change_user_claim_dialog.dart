import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/bloc/base_state.dart';
import '../../../../core/bloc/bloc_helper.dart';
import '../../../../core/di/core_initializer.dart';
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
  List<int> _selectedClaims = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserClaimCubit(),
      child: BlocConsumer<UserClaimCubit, BaseState>(
        listener: (context, state) {
          showScreenMessageByBlocStatus(state);
        },
        builder: (context, state) {
          if (state is BlocInitial) {
            BlocProvider.of<UserClaimCubit>(context).getUserClaimsByUserId(
              widget.userId,
            );
          }
          var resultWidget = getResultWidgetByState(context, state);
          if (resultWidget != null) {
            return resultWidget;
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
                    CoreInitializer()
                        .coreContainer
                        .screenMessage
                        .getErrorMessage('Lütfen en az bir yetki seçiniz.');
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
