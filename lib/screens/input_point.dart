import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nidonnaedon/common/custom_textEditing_controller.dart';
import 'package:nidonnaedon/vm/entry_info.dart';
import 'package:nidonnaedon/vm/hole_info.dart';
import 'package:nidonnaedon/vm/start_info.dart';

void main() => runApp(const InputPoint());

class InputPoint extends StatelessWidget {
  const InputPoint({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(height: statusBarHeight),
            const Padding(
              padding: EdgeInsets.only(top: 25, bottom: 32),
              child: Text(
                "점수 입력",
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            Table(
              border: TableBorder.all(),
              columnWidths: const {0: FlexColumnWidth(3.0)},
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: _makeInputArea(true),
            ),
            Container(height: 30),
            Table(
              border: TableBorder.all(),
              columnWidths: const {0: FlexColumnWidth(3.0)},
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: _makeInputArea(false),
            ),
          ]),
        ),
      ),
    );
  }

  _makeInputArea(bool isFirst) {
    var table = <TableRow>[];
    List<HoleInfo> list =
        Get.arguments[isFirst ? 'firstHoleInfoList' : 'secondHoleInfoList'];
    table.add(_holes(list));
    table.add(_pars(list));
    table.addAll(_players(Get.arguments['startInfo'], isFirst));
    return table;
  }

  _holeWithPlayer(String name, List<Point> point) {
    var player = <Widget>[];
    player.add(
      TableCell(
          child: SizedBox(
              height: 30,
              child: Center(
                  child: Text(name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14))))),
    );
    for (int i = 0; i < 9; i++) {
      player.add(
        SizedBox(
          height: 30,
          child: TextField(
              maxLength: 1,
              maxLines: 1,
              controller: CustomTextEditingController(point[i].point.value),
              onChanged: (newValue) => point[i].point.value = newValue,
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                  isDense: true, border: InputBorder.none, counterText: "")),
        ),
      );
    }

    return TableRow(
        children: player);
  }

  _players(StartInfo startInfo, bool isFirst) {
    var table = <TableRow>[];
    for (var entryInfo in startInfo.entryList) {
      table.add(_holeWithPlayer(entryInfo.name.value,
          isFirst ? entryInfo.pointsFirst : entryInfo.pointsSecond));
    }

    return table;
  }

  _holes(List<HoleInfo> list) {
    var holes = <Widget>[];
    holes.add(
      const TableCell(
          child: SizedBox(
              height: 30,
              child: Center(
                  child: Text("HOLE",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14))))),
    );
    for (var hole in list) {
      holes.add(
        TableCell(
          child: Center(
              child: Text(hole.hole.value,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 14))),
        ),
      );
    }

    return TableRow(
        decoration: const BoxDecoration(color: Color(0xffa8ebfb)),
        children: holes);
  }

  _pars(List<HoleInfo> list) {
    var pars = <Widget>[];
    pars.add(
      const TableCell(
          child: SizedBox(
              height: 30,
              child: Center(
                  child: Text("PAR",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14))))),
    );
    for (var hole in list) {
      pars.add(
        Container(
          height: 30,
          alignment: Alignment.center,
          child: TextField(
              maxLength: 1,
              maxLines: 1,
              controller: CustomTextEditingController(hole.par.value),
              onChanged: (newValue) => hole.par.value = newValue,
              style: const TextStyle(fontSize: 14),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  isDense: true, border: InputBorder.none, counterText: "")),
        ),
      );
    }

    return TableRow(
        decoration: const BoxDecoration(color: Color(0xFFECECEC)),
        children: pars);
  }
}
