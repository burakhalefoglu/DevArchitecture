import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/core/constants/temp/screen_element_constants.dart';

import '../../../../core/bloc/base_state.dart';
import '../../../../core/bloc/bloc_consumer_extension.dart';
import '../../../../core/bloc/bloc_helper.dart';
import '../../../../core/constants/temp/messages.dart';
import '../../../../core/di/core_initializer.dart';
import '../../user_groups/bloc/user_group_cubit.dart';
import '../../user_groups/widgets/user_group_auto_complete.dart';

class ChangeUserGroupsDialog extends StatefulWidget {
  final int userId;

  const ChangeUserGroupsDialog({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  _ChangeUserGroupsDialogState createState() => _ChangeUserGroupsDialogState();
}

class _ChangeUserGroupsDialogState extends State<ChangeUserGroupsDialog> {
  List<int> _selectedGroups = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserGroupCubit(),
      child: ExtendedBlocConsumer<UserGroupCubit, BaseState>(
        builder: (context, state) {
          var resultWidget = getResultWidgetByState(context, state);
          if (resultWidget != null) {
            return resultWidget;
          }
          return AlertDialog(
            title: Text(ScreenElementConstants.updateUserGroups),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              child: UserGroupAutocomplete(
                userId: widget.userId,
                onChanged: (selectedGroups) {
                  setState(() {
                    _selectedGroups = selectedGroups;
                  });
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(ScreenElementConstants.cancelButton),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_selectedGroups.isNotEmpty) {
                    BlocProvider.of<UserGroupCubit>(context)
                        .saveUserGroupPermissions(
                            widget.userId, _selectedGroups);
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
