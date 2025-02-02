import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:link_manager/generated/l10n.dart';
import 'package:link_manager/logic/api/firebase_api/firebase_api.dart';
import 'package:link_manager/logic/models/folder/folder.dart';
import 'package:link_manager/logic/models/user/app_user.dart';
import 'package:link_manager/ui/theme/app_colors.dart';
import 'package:link_manager/ui/widgets/lists/folder_widget_item.dart';

class ReorderedFolderList extends StatefulWidget {
  const ReorderedFolderList({
    super.key,
    required this.user,
  });

  final AppUser user;

  @override
  State<ReorderedFolderList> createState() => _ReorderedFolderListState();
}

class _ReorderedFolderListState extends State<ReorderedFolderList> {
  bool _haveReorder = false;
  List<Folder> _oldList = [];
  List<Folder> _currentList = [];

  @override
  void initState() {
    _oldList = [...widget.user.folders];
    _currentList = [...widget.user.folders];

    super.initState();
  }

  void _reorder(oldIndex, newIndex) async {
    if (_currentList.length < 2) {
      return;
    }

    if (oldIndex < newIndex) {
      newIndex--;
    }

    final old = _currentList.removeAt(oldIndex);
    _currentList.insert(newIndex, old);
  }

  Widget _reorderPermissionButton({
    required VoidCallback onPressed,
    required Color mainColor,
    required IconData icon,
  }) {
    return AnimatedOpacity(
      opacity: _haveReorder ? 1 : 0,
      duration: const Duration(milliseconds: 200),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon),
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(mainColor.withAlpha(85)),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                color: mainColor,
                width: 2,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _stopReorder() {
    if (!_haveReorder) {
      return;
    }

    setState(() {
      _currentList = [..._oldList];
      _haveReorder = false;
    });
  }

  void _confirmReorder() async {
    if (!_haveReorder) {
      return;
    }

    await FirebaseApi.updateUserById(
      user: widget.user.copyWith(folders: _currentList),
      id: FirebaseAuth.instance.currentUser?.uid,
    );
  }

  Widget _animateScale(context, scale, child) {
    return Transform.scale(
      scale: scale,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: AppColors.main,
              blurRadius: 12,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AutoSizeText(
              S.of(context).links,
              style: const TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 25,
              ),
            ),
            const Spacer(),
            _reorderPermissionButton(
              onPressed: _confirmReorder,
              mainColor: AppColors.correct,
              icon: Icons.check,
            ),
            _reorderPermissionButton(
              mainColor: AppColors.error,
              icon: Icons.close,
              onPressed: _stopReorder,
            ),
          ],
        ),
        Expanded(
          child: ReorderableListView.builder(
            padding: EdgeInsets.only(bottom: 66),
            itemCount: _currentList.length,
            onReorder: _reorder,
            onReorderStart: (_) {
              setState(() {
                _haveReorder = true;
              });
            },
            itemBuilder: (context, index) {
              final folder = _currentList[index];
              return FolderItemWidget(
                key: ValueKey(index),
                folder: folder,
                index: index,
                minHeight: 70,
              );
            },
            proxyDecorator: (child, _, __) {
              return TweenAnimationBuilder<double>(
                tween: Tween<double>(
                  begin: 1.0,
                  end: 0.9,
                ),
                duration: const Duration(
                  milliseconds: 300,
                ),
                curve: Curves.easeInOut,
                builder: _animateScale,
                child: child,
              );
            },
          ),
        ),
      ],
    );
  }
}
