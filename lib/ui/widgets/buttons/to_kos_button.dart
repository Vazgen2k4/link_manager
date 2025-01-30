import 'package:auto_size_text/auto_size_text.dart';
import 'package:link_manager/generated/l10n.dart';
import 'package:link_manager/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ToKosButton extends StatelessWidget {
  const ToKosButton({
    super.key,
  });

  Future<void> goKos() async {
    final url = Uri.parse('https://kos.cvut.cz/schedule');
    await launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.calendar_month_outlined),
      tileColor: AppColors.buttons,
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          width: 3,
          color: AppColors.main,
        ),
      ),
      title: AutoSizeText.rich(
        TextSpan(
          text: S.of(context).link_to_kos,
          children: const [
            TextSpan(
              text: "\tKOS",
              style: TextStyle(
                color: Colors.blueGrey,
                fontWeight: FontWeight.w700,
              ),
            )
          ],
        ),
        style: const TextStyle(fontSize: 20),
      ),
      onTap: goKos,
    );
  }
}
