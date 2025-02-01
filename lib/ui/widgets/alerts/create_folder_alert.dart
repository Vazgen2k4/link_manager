import 'package:link_manager/app_logger.dart';
import 'package:link_manager/generated/l10n.dart';
import 'package:link_manager/logic/bloc/auth/auth_bloc.dart';
import 'package:link_manager/logic/models/link/app_link.dart';
import 'package:link_manager/ui/widgets/alerts/alert_radio_buttons.dart';
import 'package:link_manager/ui/widgets/app_validator/app_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



// TODO: удалить этот файл и просто модифицировать файл 
// './alert_widget.dart'
class CreateFolderAlert extends StatefulWidget {
  final void Function(String name, String link)? onFolderCreated;

  const CreateFolderAlert({
    super.key,
    this.onFolderCreated,
  });

  @override
  
  State<CreateFolderAlert> createState() => _CreateFolderAlertState();
}

class _CreateFolderAlertState extends State<CreateFolderAlert> {
  final nameController = TextEditingController();
  final linkController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AppLinkType linkType = AppLinkType.none;

  void onConfirm() {
    final isFormValid = formKey.currentState?.validate() ?? false;
    if (!isFormValid) {
      AppLogger.logInfo("Валидация в CreateFolderAlertState не прошла");
      return;
    }

    final state = context.read<AuthBloc>().state as AuthLoaded;
    final user = state.currentUser;

    if (user == null) {
      return;
    }

    final name = nameController.value.text.trim();
    final link = linkController.value.text.trim();

    if (widget.onFolderCreated != null) {
      widget.onFolderCreated!(name, link);
    }

    Navigator.of(context).pop(true);
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    linkController.dispose();
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
              AlertRadioButtons(
                withNone: true,
                linkType: linkType,
                onChanged: (value) {
                  if (linkType == value.first) {
                    return;
                  }
                  setState(() {
                    linkType = value.first;
                  });
                },
              ),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: S.of(context).field_label_name,
                ),
                validator: AppValidator(context, settings: {
                  AppValidatorType.required,
                }).validate,
              ),
              if (linkType != AppLinkType.none) ...[
                TextFormField(
                  controller: linkController,
                  decoration: InputDecoration(
                    labelText: S.of(context).field_label_link,
                  ),
                  validator: AppValidator(context, settings: {
                    AppValidatorType.required,
                    if (linkType == AppLinkType.link) AppValidatorType.link,
                    if (linkType == AppLinkType.email) AppValidatorType.mail,
                    if (linkType == AppLinkType.phone) AppValidatorType.phone,
                  }).validate,
                ),
              ],
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
