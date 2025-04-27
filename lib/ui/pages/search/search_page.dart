// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:link_manager/logic/api/firebase_api/firebase_api.dart';
import 'package:link_manager/logic/models/folder/folder.dart';
import 'package:link_manager/logic/models/user/app_user.dart';
import 'package:link_manager/ui/widgets/custom_appbar/custom_appbar.dart';
import 'package:link_manager/ui/widgets/lists/folder_widget_item.dart';

class SearchFolderPage extends StatefulWidget {
  const SearchFolderPage({super.key});

  @override
  State createState() => _SearchFolderPageState();
}

class _SearchFolderPageState extends State<SearchFolderPage> {
  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser?.uid;

    return StreamBuilder(
      stream: FirebaseApi.users.doc(userId).snapshots(),
      builder: (context, snapshot) {
        final user = snapshot.data?.data();

        if (user == null) {
          return const Center(child: LinearProgressIndicator());
        }

        final appUser = AppUser.fromJson(user);
        if (appUser.folders.isEmpty) {
          return Center(
            child: Text('No folders found'),
          );
        }

        return Scaffold(
          appBar: CustomAppBar(
            title: 'Search Folders',
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchList(
              folders: appUser.folders,
            ),
          ),
        );
      },
    );
  }
}

class SearchList extends StatefulWidget {
  const SearchList({
    super.key,
    required this.folders,
  });
  final List<Folder> folders;

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  TextEditingController searchController = TextEditingController();

  // Делаем копию исходных данных, чтобы сохранить фильтрацию
  late List<Folder> filteredFolders;

  @override
  void initState() {
    super.initState();
    filteredFolders = widget.folders; // Изначально показываем все папки
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void onSearch(String query) {
    setState(() {
      // Фильтруем папки по имени (проверка на null)
      filteredFolders = widget.folders
          .where((folder) => folder.name != null && folder.name!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search folders...',
              border: OutlineInputBorder(),
              suffixIcon: Icon(Icons.search),
            ),
            onChanged: onSearch, // Ввод текста для поиска
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: filteredFolders.length,
            itemBuilder: (context, index) {
              final folder = filteredFolders[index];
              return FolderItemWidget(
                folder: folder,
                index: index,
                minHeight: 70,
              );
            },
          ),
        ),
      ],
    );
  }
}
