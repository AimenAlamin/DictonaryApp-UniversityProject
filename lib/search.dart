import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_application_18/sqldb.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final SqlDb sqlDb = SqlDb();
  final TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> words = [];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  dynamic fetchData(String query) async {
    List<Map<String, dynamic>> response;
    if (query.isEmpty) {
      response = [];
    } else {
      String sql = "SELECT * FROM words WHERE english LIKE '%$query%'";
      response = await sqlDb.readData(sql);
    }
    setState(() {
      words = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 1, 15, 31),
        toolbarHeight: 40.0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 1, 15, 31),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: searchController,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.white),
                ),
                hintText: 'Search',
                hintStyle: const TextStyle(fontSize: 30, color: Colors.white),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding: const EdgeInsets.only(left: 15.0, top: 5.0),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 50,
                  ),
                  onPressed: () {
                    fetchData(searchController.text);
                  },
                ),
                filled: true,
                fillColor: const Color.fromARGB(255, 21, 31, 39),
              ),
              maxLength: 50,
            ),
          ),
          Expanded(child: buildListView()),
        ],
      ),
    );
  }

  Widget buildListView() {
    if (words.isEmpty) {
      return const Center(
        child: Text(
          'No results found',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: words.length,
        itemBuilder: (context, index) {
          final word = words[index];
          Uint8List? imageBytes = word['image'];

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: imageBytes != null
                  ? ClipRect(
                      child: Image.memory(
                        imageBytes,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    )
                  : null,
              title: Text(
                word['english'],
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              subtitle: Text(
                word['turkey'],
                style: const TextStyle(fontSize: 20, color: Colors.white),
              ),
              trailing: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('Delete Word'),
                        content: const Text(
                            'Are you sure you want to remove the word from the dictionary?'),
                        actions: [
                          TextButton(
                            onPressed: () async {
                              int deletedRows = await sqlDb.deleteData(
                                'DELETE FROM words WHERE english = ?',
                                [word['english']],
                              );
                              if (deletedRows > 0) {
                                fetchData(searchController.text);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Word deleted successfully'),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Failed to delete word'),
                                  ),
                                );
                              }
                              Navigator.of(context).pop();
                            },
                            child: const Text('Yes'),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('No'),
                          ),
                        ],
                      );
                    },
                  );
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              ),
            ),
          );
        },
      );
    }
  }
}
