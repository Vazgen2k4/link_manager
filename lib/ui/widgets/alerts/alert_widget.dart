import 'package:link_manager/generated/l10n.dart';
import 'package:link_manager/logic/bloc/auth/auth_bloc.dart';
import 'package:link_manager/logic/models/link/app_link.dart';
import 'package:link_manager/ui/widgets/alerts/alert_radio_buttons.dart';
import 'package:link_manager/ui/widgets/app_validator/app_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlertWidget extends StatefulWidget {
  final void Function(
    String name,
    String value,
    AppLinkType type,
  )? onSucsess;

  const AlertWidget({
    super.key,
    this.onSucsess,
  });

  @override
  State<AlertWidget> createState() => _AlertWidgetState();
}

class _AlertWidgetState extends State<AlertWidget> {
  final nameController = TextEditingController();
  final linkController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  AppLinkType linkType = AppLinkType.link;

  void onConfirm() {
    final allIsValide = formKey.currentState?.validate() ?? false;
    if (!allIsValide) {
      return;
    }

    final state = context.read<AuthBloc>().state as AuthLoaded;
    final user = state.currentUser;

    if (user == null) {
      return;
    }

    final link = linkController.value.text.trim();
    final name = nameController.value.text.trim();

    if (widget.onSucsess != null) {
      widget.onSucsess!(name, link, linkType);
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
