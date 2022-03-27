import '../models/tutorModel.dart';
import '../resources/DemoTutorList.dart';

final List<Tutor> tutorList = [
  tutor0,
  tutor1,
  tutor2,
  tutor3,
  tutor4,
  tutor5
];

List<Tutor> getTutorList(String skill){
  if(skill == "All"){
    return tutorList;
  } else {
    List<Tutor> list = <Tutor>[];
    for(Tutor tutor in tutorList){
      if(tutor.skill.contains(skill)){
        list.add(tutor);
      }
    }
    return list;
  }
}