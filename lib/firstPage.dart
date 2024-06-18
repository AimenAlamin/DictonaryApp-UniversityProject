import 'package:flutter/material.dart';
import 'package:flutter_application_18/addpage.dart';
import 'package:flutter_application_18/login.dart';
import 'package:flutter_application_18/search.dart';
import 'package:flutter_application_18/selectPage.dart';
import 'package:flutter_application_18/setting_page.dart';
import 'package:flutter_application_18/sqldb.dart';

import 'package:flutter_application_18/streak_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final SqlDb sqlDb = SqlDb();

  @override
  void initState() {
    super.initState();
    initDb();
  }

  Future<void> initDb() async {
    await sqlDb.db;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          size: 35,
        ),
        title: const Text(
          "",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 13),
          child: ListView(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.asset(
                      'assets/images/ciuimg.png',
                      width: 70,
                      height: 70,
                    ),
                  ),
                  const Expanded(
                    child: ListTile(
                      title: Text(
                        'Aimen',
                      ),
                      subtitle: Text(
                        "Aimen0@gmail.com",
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              listTitlefunc(Icons.settings, "Setting"),
              listTitlefunc(Icons.info, "Info"),
              listTitlefunc(Icons.contact_page_outlined, "Contact us"),
              listTitlefunc(Icons.logout, "streak"),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          const Text.rich(
            TextSpan(
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w700,
              ),
              text: 'Welcome',
              children: [
                TextSpan(
                  text: ' Aimen ',
                ),
              ],
            ),
          ),
          Image.asset('assets/images/welcombird.png'),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: GridView.count(
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => const AddPage()),
                      );
                    },
                    child: Container(
                      height: 100,
                      width: 980,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 3),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            size: 48,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Add",
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ListWords(),
                      ));
                    },
                    child: Container(
                      height: 100,
                      width: 980,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 3),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.list_alt,
                            size: 48,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "List all",
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SearchPage(),
                      ));
                    },
                    child: Container(
                      height: 100,
                      width: 980,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 3),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search,
                            size: 48,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Search",
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const LoginPage(),
                      ));
                    },
                    child: Container(
                      height: 100,
                      width: 980,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(width: 3),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.logout,
                            size: 48,
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Logout",
                            style: TextStyle(
                              fontSize: 30.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget listTitlefunc(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: ListTile(
        title: Text(
          text,
          style: const TextStyle(
            fontSize: 25,
          ),
        ),
        leading: Icon(
          icon,
          size: 35,
        ),
        onTap: () {
          switch (text) {
            case 'Setting':
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const SettingPage()),
              );
              break;
            case 'streak':
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const StreakPage()),
              );

              break;
            default:
          }
        },
      ),
    );
  }
}
