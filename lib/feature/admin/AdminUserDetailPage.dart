import 'package:flutter/material.dart';

class AdminUserDetailPage extends StatelessWidget {
  static const String name = 'UserDetailPageInAdmin';

  const AdminUserDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final userDetails = [
      'Name',
      'Nickname',
      'Phone',
      'Email',
      'Description',
      'Profile Photo'
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Users',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
          textAlign: TextAlign.center,
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 20),
                itemCount: userDetails.length,
                itemBuilder: (context, index) {
                  return _buildUserInformationContainer(userDetails[index]);
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 20),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(45.0),
              child: InkWell(
                onTap: () {
                  print(
                      'Test: move to the UserListInAdminPage & Add the User in UserListInAdminPage');
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
                      'Create',
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

  Widget _buildUserInformationContainer(String username) {
    return InkWell(
      onTap: () {
        print('Test: Enter the User Information');
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey,
        ),
        width: 350,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                username,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
