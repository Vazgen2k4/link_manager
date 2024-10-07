import 'package:link_manager/app_logger.dart';
import 'package:link_manager/generated/l10n.dart';
import 'package:link_manager/logic/bloc/auth/auth_bloc.dart';
import 'package:link_manager/ui/widgets/app_validator/app_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateFolderAlert extends StatefulWidget {
  final void Function(String name)? onSucsess;

  const CreateFolderAlert({
    super.key,
    this.onSucsess,
  });

  @override
  State<CreateFolderAlert> createState() => _CreateFolderAlertState();
}

class _CreateFolderAlertState extends State<CreateFolderAlert> {
  final nameController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  void onConfirm() {
    final allIsValide = formKey.currentState?.validate() ?? false;
    if (!allIsValide) {
      AppLogger.logInfo("Валидация в CreateFolderAlertState не прошла");
      return;
    }

    final state = context.read<AuthBloc>().state as AuthLoaded;
    final user = state.curentUser;

    if (user == null) {
      return;
    }

    final name = nameController.value.text.trim();

    if (widget.onSucsess != null) {
      widget.onSucsess!(name);
    }

    Navigator.of(context).pop(true);
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(S.of(context).add_folder),
      content: SizedBox(
        width: 250,
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: S.of(context).field_lable_name,
                ),
                validator: AppValidator(context, settings: {
                  AppValidatorType.required,
                }).validate,
              ),
            ],
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: Text(S.of(context).cancel),
        ),
        TextButton(
          onPressed: onConfirm,
          child: Text(S.of(context).confirm),
        ),
      ],
    );
  }
}
