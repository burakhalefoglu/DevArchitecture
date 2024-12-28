import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/constants/temp/screen_element_constants.dart';
import '../../../../core/bloc/base_state.dart';
import '../../../../core/bloc/bloc_consumer_extension.dart';
import '../../../../core/bloc/bloc_helper.dart';
import '../../../../core/constants/temp/messages.dart';
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
      child: ExtendedBlocConsumer<GroupClaimCubit, BaseState>(
        builder: (context, state) {
          if (state is BlocInitial) {
            BlocProvider.of<GroupClaimCubit>(context).getGroupClaimsByGroupId(
              widget.groupId,
            );
          }
          var resultWidget = getResultWidgetByState(context, state);
          if (resultWidget != null) {
            return resultWidget;
          }
          return AlertDialog(
            title: Text(ScreenElementConstants.updateGroupClaims),
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
                child: Text(ScreenElementConstants.cancel),
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
                        .getErrorMessage(Messages.atLeastOneSelection);
                  }
                },
                child: Text(ScreenElementConstants.saveButton),
              ),
            ],
          );
        },
      ),
    );
  }
}
