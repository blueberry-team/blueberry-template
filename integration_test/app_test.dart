import 'package:blueberry_flutter_template/firebase_options.dart';
import 'package:blueberry_flutter_template/model/DogProfileModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'base_test.dart';

class ModelTestCase extends BaseTestCase {}

void main() async {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final firestore = FirebaseFirestore.instance;

  group('Firestore에서 데이터를 가져와 fromJson 메서드 실행', () {
    final testCase = ModelTestCase();

    late String collectionName;

    test('[pet 컬렉션이 있을 때], [첫 번째 문서를 가져와 fromJson 메서드로 매핑하면], [오류 없이 매핑된다]',
        () async {
      DogProfileModel? fetchedData;

      testCase.given(() {
        collectionName = 'pet';
      });

      testCase.when(() async {
        final querySnapshot =
            await firestore.collection(collectionName).limit(1).get();

        if (querySnapshot.docs.isNotEmpty) {
          final data = querySnapshot.docs.first.data();
          fetchedData = DogProfileModel.fromJson(data);
        } else {
          throw Exception('$collectionName 컬렉션 안에 다큐먼트가 존재하지 않습니다');
        }
      });

      testCase.then(() {
        expect(fetchedData, isNotNull, reason: 'fetchedData는 null이 아니어야 합니다.');
      });
    });
  });
}
