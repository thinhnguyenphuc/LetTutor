final Map<String, String> skillList = {
  'all': 'All',
  'business-english': 'English for Business',
  'english-for-kids': 'English for kids',
  'conversational-english': 'Conversation',
  'starters': 'STARTERS',
  'movers': 'MOVERS',
  'flyers': 'FLYERS',
  'ket': 'KET',
  'pet': 'PET',
  'ielts': 'IELTS',
  'toefl': 'TOEFL',
  'toeic': 'TOEIC'
};

List<String> getAllSkillList() {
  List<String> res = [];
  for (String item in skillList.values) {
    res.add(item);
  }
  return res;
}

List<String> getAllSkillListKey() {
  List<String> res = [];
  for (String item in skillList.keys) {
    res.add(item);
  }
  return res;
}

String getSkillByKey(String key) {
  String? res = skillList[key];
  return res ?? "null";
}

