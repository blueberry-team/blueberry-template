import 'dart:math';

class RandomUserNickNameGenerator {
  static final List<String> adjectives = [
    '행복한',
    '즐거운',
    '신비로운',
    '용감한',
    '영리한',
    '재미있는',
    '친절한',
    '멋진',
    '귀여운',
    '활발한',
    '섹시한',
    '짖궂은',
    '똑똑한',
    '강인한',
    '성실한',
    '건강함',
  ];

  static final List<String> nouns = [
    '고양이',
    '강아지',
    '토끼',
    '여우',
    '사자',
    '호랑이',
    '팬더',
    '코알라',
    '돌고래',
    '펭귄',
    '도마뱀',
    '앵무새',
    '악어',
    '햄스터',
    '늑대',
    '원숭이',
    '오리',
    '닭',
    '캥거루',
  ];

  static String generate() {
    final random = Random();
    final adjective = adjectives[random.nextInt(adjectives.length)];
    final noun = nouns[random.nextInt(nouns.length)];
    final number = random.nextInt(100);

    return '$adjective$noun$number';
  }
}
