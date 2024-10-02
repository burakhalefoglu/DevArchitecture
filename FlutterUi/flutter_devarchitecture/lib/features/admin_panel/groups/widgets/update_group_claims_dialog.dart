import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/bloc/base_state.dart';
import '../../../../core/bloc/bloc_helper.dart';
import '../../../../core/di/core_initializer.dart';
import '../../group_claims/bloc/group_claim_cubit.dart';
import '../../group_claims/widgets/group_claim_auto_complete.dart';

class UpdateGroupClaimsDialog extends StatefulWidget {
  final int groupId;

  const UpdateGroupClaimsDialog({Key? key, required this.groupId})
      : super(key: key);

  @override
  _UpdateGroupClaimDialogState createState() => _UpdateGroupClaimDialogState();
}

class _UpdateGroupClaimDialogState extends State<UpdateGroupClaimsDialog> {
  List<int> _selectedClaims = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GroupClaimCubit(),
      child: BlocConsumer<GroupClaimCubit, BaseState>(
        listener: (context, state) {
          if (state is BlocInitial) {
            BlocProvider.of<GroupClaimCubit>(context).getGroupClaimsByGroupId(
              widget.groupId,
            );
          }
          showScreenMessageByBlocStatus(state);
        },
        builder: (context, state) {
          var resultWidget = getResultWidgetByState(state);
          if (resultWidget != null) {
            return resultWidget;
          }
          return AlertDialog(
            title: const Text('Grup Yetkilerini Güncelle'),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: GroupClaimAutocomplete(
                groupId: widget.groupId,
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
                    BlocProvider.of<GroupClaimCubit>(context)
                        .saveGroupClaimsByGroupId(
                            widget.groupId, _selectedClaims);
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
