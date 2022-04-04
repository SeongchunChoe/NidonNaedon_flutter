import 'package:get/get.dart';

class EntryInfo {
  var pointsFirst = <Point>[].obs;
  var pointsSecond = <Point>[].obs;
  var name = "".obs;
  var handy = "".obs;

  EntryInfo(){
    for(var i = 0; i < 9; i++){
      pointsFirst.add(Point());
      pointsSecond.add(Point());
    }
  }

  isEnable() => (name.value.isNotEmpty && handy.value.isNotEmpty);

  get allPoints {
    var pointsAll = <Point>[];
    pointsAll.addAll(pointsFirst);
    pointsAll.addAll(pointsSecond);

    return pointsAll;
  }
}

class Point {
  var point = "".obs;
}