import 'package:cached_network_image/cached_network_image.dart';
import 'package:link_manager/ui/app_const.dart';
import 'package:link_manager/ui/router/app_routes.dart';
import 'package:flutter/material.dart';

class ProfileBtn extends StatelessWidget {
  final String userUrl;
  final bool disabel;
  final double radius;

  const ProfileBtn({
    super.key,
    required this.userUrl,
    this.disabel = false,
    this.radius = 17.5,
  });

  @override
  Widget build(BuildContext context) {
    final size = radius * 2;
    return SizedBox(
      width: size,
      child: IconButton(
        style: ButtonStyle(padding: getProperty(EdgeInsets.zero)),
        onPressed: () {
          final currentRoute = ModalRoute.of(context)?.settings.name;
          if (currentRoute == AppRoutes.profile || disabel) {
            return;
          }
          goRoute(context, AppRoutes.profile);
        },
        icon: ClipOval(
          child: CachedNetworkImage(
            imageUrl: userUrl,
            width: size,
            height: size,
            fit: BoxFit.cover,
            placeholder: (context, url) => loadWidget,
            errorWidget: (context, url, error) => const Icon(
              Icons.error,
            ),
          ),
        ),
      ),
    );
  }
}
