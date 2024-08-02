import 'package:flutter/material.dart';
import 'UserDetailPageInAdmin.dart';

class UserListInAdminPage extends StatelessWidget {
  const UserListInAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                print('Test: move to the UserSearchPage');
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    _buildUserContainer('Username_1'),
                    const SizedBox(height: 20),
                    _buildUserContainer('Username_2'),
                    const SizedBox(height: 20),
                    _buildUserContainer('Username_3'),
                    const SizedBox(height: 20),
                    _buildUserContainer('Username_4'),
                    const SizedBox(height: 20),
                    _buildUserContainer('Username_5'),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(45.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UserDetailPageInAdmin()),
                  );
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
    );
  }

  Widget _buildUserContainer(String username) {
    return InkWell(
      onTap: () {
        print('Test: move to the UserDetailPageInAdmin');
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
                    print('Test: move to the UserDetailPageInAdmin');
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
