import 'package:link_manager/logic/models/folder/folder.dart';
import 'package:link_manager/ui/widgets/lists/links_list_widget.dart';
import 'package:flutter/material.dart';

class FolderItemWidget extends StatefulWidget {
  const FolderItemWidget({
    super.key,
    required this.folder,
    required this.index,
    this.minHeight = 70,
    this.maxHeight = 120,
    this.padding = 0,
  });

  final Folder folder;
  final int index;
  final double padding;
  final double minHeight;
  final double maxHeight;

  @override
  State<FolderItemWidget> createState() => _FolderItemWidgetState();
}

class _FolderItemWidgetState extends State<FolderItemWidget> {
  bool isOpen = false;

  @override
  Widget build(BuildContext context) {
    final height = isOpen ? widget.maxHeight : widget.minHeight;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.padding),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isOpen = !isOpen;
          });
        },
        child: AnimatedContainer(
          clipBehavior: Clip.antiAlias,
          padding: const EdgeInsets.all(8),
          height: height,
          duration: const Duration(
            milliseconds: 100,
          ),
          decoration: BoxDecoration(
            color: const Color.fromARGB(37, 104, 58, 183),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: const Color.fromARGB(255, 104, 58, 183),
              width: 3,
            ),
          ),
          child: Stack(
            children: [
              LInksListWidget(
                folder: widget.folder,
                index: widget.index,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
