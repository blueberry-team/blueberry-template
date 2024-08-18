import 'package:blueberry_flutter_template/firebase_options.dart';
import 'package:blueberry_flutter_template/model/DogProfileModel.dart';
import 'package:blueberry_flutter_template/model/PostModel.dart';
import 'package:blueberry_flutter_template/model/UserModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late FirebaseFirestore firestore;

  setUpAll(() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    firestore = FirebaseFirestore.instance;
  });

  group('Firestore에서 데이터를 가져와 fromJson 메서드 실행', () {
    late String collectionName;

    test('pet 컬렉션이 있을 때, 첫 번째 문서를 가져와 fromJson 메서드로 매핑하면, 오류 없이 매핑된다',
        () async {
      DogProfileModel? fetchedData;

      // Given: 컬렉션 이름 설정
      collectionName = 'pet';

      // When: 첫 번째 문서 가져오기 및 fromJson 매핑
      final querySnapshot =
          await firestore.collection(collectionName).limit(1).get();

      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs.first.data();
        fetchedData = DogProfileModel.fromJson(data);
      } else {
        throw Exception('$collectionName 컬렉션 안에 다큐먼트가 존재하지 않습니다');
      }

      // Then: 매핑된 데이터 검증
      expect(fetchedData, isNotNull, reason: 'fetchedData는 null이 아니어야 합니다.');
    });

    test('user 컬렉션이 있을 때, 첫 번째 문서를 가져와 fromJson 메서드로 매핑하면, 오류 없이 매핑된다',
        () async {
      UserModel? fetchedData;

      // Given: 컬렉션 이름 설정
      collectionName = 'users';

      // When: 첫 번째 문서 가져오기 및 fromJson 매핑
      final querySnapshot =
          await firestore.collection(collectionName).limit(1).get();

      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs.first.data();
        fetchedData = UserModel.fromJson(data);
      } else {
        throw Exception('$collectionName 컬렉션 안에 다큐먼트가 존재하지 않습니다');
      }

      // Then: 매핑된 데이터 검증
      expect(fetchedData, isNotNull, reason: 'fetchedData는 null이 아니어야 합니다.');
    });

    test('posts 컬렉션이 있을 때, 첫 번째 문서를 가져와 fromJson 메서드로 매핑하면, 오류 없이 매핑된다',
        () async {
      PostModel? fetchedPost;

      // Given: 컬렉션 이름 설정
      collectionName = 'posts';

      // When: 첫 번째 문서 가져오기 및 fromJson 매핑
      final querySnapshot =
          await firestore.collection(collectionName).limit(1).get();

      if (querySnapshot.docs.isNotEmpty) {
        final data = querySnapshot.docs.first.data();
        fetchedPost = PostModel.fromJson(data);
      } else {
        throw Exception('$collectionName 컬렉션 안에 다큐먼트가 존재하지 않습니다');
      }

      // Then: 매핑된 데이터 검증
      expect(fetchedPost, isNotNull, reason: 'fetchedPost는 null이 아니어야 합니다.');
    });
  });
}
