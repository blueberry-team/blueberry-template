class AppStrings {
  static const String appTitle = '블루베리 플러터 템플릿';

  //MatchFilterWidget.dart
  static const String filterTitle = '어떤 친구를 만날까요?';
  static const String filterSubmitButtonText = '만나기';
  static const String petGenderMale = '수컷';
  static const String petGenderFemale = '암컷';
  static const String locationSeoul = 'Seoul';
  static const String locationLA = 'LA';
  static const String locationHawaii = 'Hawaii';
  static const String locationJapan = 'Japan';

  //MatchProvider.dart
  static const String dbUpdateSuccess = "DB 업데이트 성공";
  static const String dbUpdateFail = "DB 업데이트 실패 : 이미 등록된 petId 입니다.";
  static const String dbUpdateError = 'DB 업데이트 중 오류 발생: ';
  static const String dbLoadError = '펫 데이터를 로드하는 중 오류 발생: ';
  static const String noFilteredResult = '필터링된 결과가 없습니다';
  static const String matchFound = '서로 좋아요한 상태입니다.';
  static const String noMatch = '서로 좋아요한 상태가 아닙니다. 친구로 추가하지 않습니다.';
  static const String addedFriendSuccess = '친구 추가 확인 : ';
  static const String addedFriendError = '친구 추가 중 오류 발생: ';
  //MatchProvider.dart snackbar
  static const String matchSuccessMessageLike = '좋아요 목록에 추가 했어요. 친구가 되었어요.';
  static const String matchSuccessMessageSuperLike =
      '즐겨찾기 목록에 추가 했어요. 친구가 되었어요.';
  static const String matchFailMessageLike =
      '좋아요 목록에 추가 했어요. 상대도 좋아요를 누르면 친구가 됩니다.';
  static const String matchFailMessageSuperLike =
      '즐겨찾기 목록에 추가 했어요. 상대도 좋아요를 누르면 친구가 됩니다.';
  static const String ignoreSuccessMessage = '이제 다시 매칭 되지 않아요.';
  static const String dbUpdateFailMessage = '이미 추가된 펫이에요.';

  // MatchProfileListWidget.dart
  static const String noPetsMessage = '추천해 줄 펫이 없어요. 조건을 다시 한번 확인해 주세요.';

  //ProfileScreen.dart
  static const String petGender = '성별';
  static const String petBreed = '종';
  static const String petLocation = '지역';
  static const String petBio = '소개';
  static const String ignoreThisPet = '해당 펫을 추천 안함';

  //UserReportBottomSheetWidget.dart
  static const String reportReasonSpamAccount = '광고용 계정';
  static const String reportReasonFakeAccount = '가짜로 의심되는 계정';
  static const String reportReasonInappropriateNamePhoto = '이름&사진이 부적절';
  static const String reportConfirmationMessage = '%s님을 신고하시겠습니까?';
  static const String reportSuccessMessage = '신고가 접수되었습니다.';
  static const String reportErrorMessage = '신고 접수 중 오류가 발생했습니다.';

  //FriendBottomSheet.dart
  static const String chatButton = '채팅';
  static const String profileButton = '프로필';
  static const String reportButton = '신고하기';
  static const String deleteButton = '삭제하기';
  static const String blockButton = '차단하기';

  //FriendsListProvider.dart
  static const String userNotFoundErrorMessage = '유저 데이터를 찾을 수 없습니다.';
  static const String friendDeleteSuccessMessage = '친구가 삭제되었습니다.';

  //NickNameTextWidget.dart
  static const String nickNameTextWidgetdefaultNickName = '닉네임';
  static const String nickNameTextWidgetError = '오류';
  static const String emailTextWidgetError = '이메일 정보를 가져오지 못했습니다.';
  static const String dateTextWidgetError = '날짜 정보를 가져오지 못했습니다.';

  //MyPageScreen.dart
  static const String myPageTitle = '내 페이지';
  static const String loginButtonText = '로그인';
  static const String logoutButtonText = '로그아웃';
  static const String welcomeBackText = '다시 오신 것을 환영합니다!';
  static const String signUpButtonText = '회원가입';
  static const String errorTitle = '오류';
  static const String okButtonText = '확인';
  static const String loggedInMessage = '로그인 되었습니다.';
  static const String passwordForgot = '비밀번호를 잊어버렸나요?';

  //Take Photo
  static const String takeProfilePhoto = 'Take a profile photo';
  static const String setBackCamera = '후면 카메라를 불러오는 중 입니다. 잠시만 기다려 주세요';
  static const String setFrontCamera = '전면 카메라를 불러오는 중 입니다. 잠시만 기다려 주세요';
  static const String takePhotoDirectly = '직접 촬영 하기';
  static const String chooseFromGallery = '앨범에서 선택하기';

  //Save Photo
  static const String savePhoto = '이미지 저장 하기';
  static const String previewProfilePhoto = '프로필 사진 미리보기';

  //ChatPage.dart
  static const String lessonChatScreenTitle = '채팅';
  static const String chatRoomScreenTitle = '채팅방 목록';

  //ShoppingPageSample.dart
  static const String shoppingPageTitle = '쇼핑 페이지';
  static const String shoppingPageTitle1 = '이 제품들을 찾고 있나요?';
  static const String shoppingPageSubTitle1 = '항상 최고의 블루베리를 찾아드립니다.';
  static const String shoppingPageTitle2 = '신상품';
  static const String shoppingPageSubTitle2 = '최신 제품을 확인하세요.';

  //SignUpDialog.dart
  static const String signUpPageTitle = '회원가입';
  static const String emailInputLabel = '이메일';
  static const String passwordInputLabel = '비밀번호';
  static const String cancelButtonText = '취소';
  static const String signUpSuccessMessage = '회원가입 성공!';
  static const String signUpFailedMessage = '회원가입 실패. 다시 시도해 주세요.';
  static const String verifyCode = '인증번호';
  static const String checkVerifyCode = '인증하기';
  static const String checkDuplicateEmail = '중복확인';
  static const String requiredYourEmail = '이메일 인증을 위해 사용 중인 이메일을 입력해주세요.';
  static const String usingEmailLogin = '이메일 로그인을 사용 중 입니다.';
  static const String usingGithubLogin = 'github 로그인을 사용 중 입니다.';
  static const String usingGoogleLogin = 'google 로그인을 사용 중 입니다.';
  static const String usingAppleLogin = 'apple 로그인을 사용 중 입니다.';

  //MBTIScreen.dart
  static const String titleMBTI = 'MBTI';
  static const String titleMBTITest = 'MBTI Test';
  static const String yourMBTI = '의 MBTI는';
  static const String petMBTI = '반려동물의 MBTI는';
  static const String pleaseCheckMBTI = 'MBTI를 검사해주세요';
  static const String pleaseLogin = '로그인하시면 MBTI를 등록할 수 있어요';
  static const String reCheckMBTI = '재검사하기';
  static const String checkMBTI = '검사하기';
  static const String setMBTI = '등록하기';
  static const String setCompleteMBTI = '새로운 MBTI를 등록했어요';
  static const String setErrorMBTI = '등록에 실패했어요 다시 시도해주세요';
  static const String shareMBTI = '공유하기';
  static const String stronglyAgree = '매우 그렇다';
  static const String agree = '그렇다';
  static const String neutral = '보통이다';
  static const String disagree = '아니다';
  static const String stronglyDisagree = '전혀 아니다';

  //AdminScreen.dart
  static const String adminPageTitle = '관리자 페이지';
  static const String tmpUserButtonText = '임시 사용자 생성';
  static const String tmpItemButtonText = '임시 항목 생성';
  static const String uploadBannerButtonLabel = '배너 업로드';
  static const String makeItemButtonLabel = '상품 등록 버튼';
  static const String makeUserButtonLabel = '사용자 등록 버튼';
  static const String uploadItemButtonLabel = '항목 업로드';
  static const String uploadUserButtonLabel = '사용자 업로드';
  static const String uploadEventButtonLabel = '이벤트 업로드';
  static const String makeChatButtonLabel = '임시 채팅 만들기';

  //RankViewWidget.dart
  static const String rankViewTitle = '오늘의 순위';

  //CacheService.dart
  static const String commonCacheKey = 'commonCacheKey';
  static const String userCacheKey = 'userCacheData';

  //Error Handling
  static const String errorMessage_emptyPassword = '비밀번호를 입력하세요.';
  static const String errorMessage_invalidPassword =
      '비밀번호는 최소 8자 이상이어야 하며, 하나 이상의 문자와 숫자가 포함되어야 합니다.';
  static const String errorMessage_emptyEmail = '이메일 주소를 입력하세요.';
  static const String errorMessage_invalidEmail = '유효한 이메일 주소를 입력하세요.';
  static const String errorMessage_checkEmail = '이메일 주소를 확인해주세요.';
  static const String errorMessage_emailAlreadyInUse =
      '이미 다른 계정에서 사용 중인 이메일 주소입니다.';
  static const String errorMessage_weakPassword = '비밀번호가 너무 약합니다.';
  static const String errorMessage_userNotFound =
      '이 식별자에 해당하는 사용자 기록이 없습니다. 사용자가 삭제되었을 수 있습니다.';
  static const String errorMessage_wrongPassword =
      '비밀번호가 잘못 되었습니다. 다시 시도 해 주세요.';
  static const String errorMessage_regexpPassword =
      '비밀번호는 최소 8자 이상이어야 하며, 두개 이상의 문자와 숫자가 포함되어야 합니다.';
  static const String errorMessage_checkPassword = '비밀번호를 확인 해주세요.';
  static const String errorMessage_duplicatedPassword = '비밀번호가 일치하지 않습니다.';
  static const String errorMessage_emptyName = '이름을 입력해주세요.';
  static const String errorMessage_worngName = '한글 4자 이상의 이름을 입력해주세요.';
  static const String errorMessage_emptyNickName = '닉네임을 입력해주세요.';
  static const String errorMessage_wrongNickName =
      '특수 문자를 제외 한 4자 이상의 닉네임을 입력해주세요.';
  static const String errorMessage_forbiddenNickName = '금지된 닉네임입니다. 다시 입력해주세요.';
  static const String errorMessage_emptyVerifyCode = '인증번호를 입력 해 주세요';
  static const String errorMessage_wrongVerifyCode =
      '인증번호를 확인 해 주세요, 5자리의 숫자로 구성되어 있습니다';

  // Company Info
  static const String companyInfoTitle = '회사 정보';
  static const String companyInfoName = '커뮤니티 앱';
  static const String companyInfoAddress = '미국 애니타운 메인 스트리트 1234';
  static const String companyInfoPhone = '123-456-7890';
  static const String companyInfoPrivacy = '개인정보 보호정책';
  static const String companyInfoCenter = '고객 센터';
  static const String companyInfoTerms = '서비스 이용약관';
  static const String companyInfoAbout = '회사 소개';

  // Phone Verification
  static const String inputPhoneNumber = '전화번호를 입력해주세요';
  static const String inputVerificationCode = '인증번호를 입력해주세요';
  static const String errorMessage_timeOut = '입력시간을 초과하였습니다';
  static const String errorMessage_commonError = '처리 중 오류가 발생했습니다.';
  static const String errorMessage_emptyPhoneNumber = '전화번호를 입력해주세요.';
  static const String errorMessage_invalidPhoneNumber = '전화번호를 확인해주세요.';
  static const String errorMessage_emptyVerificationCode = '인증번호를 입력해주세요.';
  static const String errorMessage_invalidVerificationCode = '인증번호를 확인해주세요.';

  //Email Verification
  static const String send_emailVerification = '이메일 인증 메일을 보냈습니다. 확인해주세요.';
  static const String check_emailVerification = '이메일 인증을 확인해주세요.';
  static const String click_emailVerification = '인증을 완료 하셨다면 버튼을 눌러주세요';

  //Success Handling
  static const String successMessage_emailValidation = '사용 가능한 이메일입니다';

  //InAppPurchase
  static const String successMessage_purchase = '결제가 완료 되었습니다.';
  static const String successMessage_membership = '멤버십 가입이 완료 되었습니다.';
  static const String errorMessage_purchase = '결제에 실패 했습니다. 다시 시도 해 주세요.';
  static const String isUserMembership = '프리미엄 멤버쉽을 사용 중 입니다';
  static const String notUserMembership = '프리미엄 멤버쉽을 사용 중이 아닙니다';
  static const String getMembership = '프리미엄 회원 가입하기';

  //Appbar Logo
  static const String appbar_Text_Logo = 'Petting';
  static final List<String> date = ["Su", "Mo", "Tu", "We", "Th", "Fr", "Sa"];

  // Location Service
  static const String errorMessage_sendFailed = '문자 발송 실패';
  static const String button_openConfigMenu = '설정 열기';
  static const String button_sendMessage = '112 문자보내기';
  static const String errorMessage_unknownError = '알 수 없는 오류가 발생했습니다.';

  //Permission Error
  static const String errorMessage_permissionGallery = '앨범 접근 권한을 허용 해주세요';
  static const String errorMessage_locationPermissionForeverDenied =
      '위치 권한이 거부되었습니다. 설정에서 권한을 허용해주세요.';
  static const String errorMessage_locationPermissionDisabled =
      '위치 서비스가 비활성화되어 있습니다. 설정에서 위치 서비스를 활성화해주세요.';
  static const String errorMessage_locationPermissionDenied = '위치 권한이 필요합니다.';
}
