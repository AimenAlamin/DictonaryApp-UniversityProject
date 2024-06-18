import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_application_18/sqldb.dart';

class ListWords extends StatefulWidget {
  const ListWords({super.key});

  @override
  _ListWordsState createState() => _ListWordsState();
}

class _ListWordsState extends State<ListWords> {
  final SqlDb sqlDb = SqlDb(); // Create an instance of SqlDb
  List<Map<String, dynamic>> words = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    List<Map<String, dynamic>> response =
        await sqlDb.readData('SELECT * FROM words');
    setState(() {
      words = response;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "History",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: buildListView(),
    );
  }

  Widget buildListView() {
    return ListView.builder(
      itemCount: words.length,
      itemBuilder: (context, index) {
        final word = words[index];
        // Extracting image bytes
        Uint8List? imageBytes = word['image'];

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListTile(
            leading: imageBytes != null
                ? ClipRect(
                    child: Image.memory(
                      imageBytes,
                      width: 50, // adjust as needed
                      height: 50, // adjust as needed
                      fit: BoxFit.cover,
                    ),
                  )
                : null,
            title: Text(
              word['english'],
              style: const TextStyle(fontSize: 20),
            ),
            subtitle: Text(
              word['turkey'],
              style: const TextStyle(fontSize: 20),
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
                            // Perform delete operation here
                            int deletedRows = await sqlDb.deleteData(
                                'DELETE FROM words WHERE english = ?',
                                [word['english']]);
                            if (deletedRows > 0) {
                              // If deletion successful, refresh data
                              fetchData();
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
