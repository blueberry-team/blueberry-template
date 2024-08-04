import 'package:blueberry_flutter_template/screens/adminScreen/UserDetailPageInAdmin.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class UserListInAdminPage extends StatelessWidget {
  static const String name = 'UserListInAdminPage';

  const UserListInAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> usernames = [
      'Username_1',
      'Username_2',
      'Username_3',
      'Username_4',
      'Username_5',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            const Text(
              'Users',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            IconButton(
              icon: const Icon(
                Icons.search,
                size: 40,
              ),
              onPressed: () {
                //TODO: UserSearchScreen 구현 필요
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  itemCount: usernames.length,
                  itemBuilder: (context, index) {
                    return _buildUserContainer(context, usernames[index]);
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 20),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(45.0),
                child: InkWell(
                  onTap: () {
                    context.pushNamed(UserDetailPageInAdmin.name);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue,
                    ),
                    width: 350,
                    height: 50,
                    child: const Center(
                      child: Text(
                        'Add User',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserContainer(BuildContext context, String username) {
    return InkWell(
      onTap: () {
        context.pushNamed(UserDetailPageInAdmin.name);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.black,
        ),
        width: 350,
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                username,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.white),
                  onPressed: () {
                    context.pushNamed(UserDetailPageInAdmin.name);
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.white),
                  onPressed: () {
                    print('Test: Delete the User');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
