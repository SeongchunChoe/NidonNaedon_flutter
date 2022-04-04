import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nidonnaedon/common/custom_textEditing_controller.dart';
import 'package:nidonnaedon/screens/input_point.dart';
import 'package:nidonnaedon/vm/entry_info.dart';
import 'package:nidonnaedon/vm/hole_info.dart';
import 'package:nidonnaedon/vm/start_info.dart';

void main() => runApp(const StartGame());

class StartGame extends StatefulWidget {
  const StartGame({Key? key}) : super(key: key);

  @override
  _StartGameState createState() => _StartGameState();
}

class _StartGameState extends State<StartGame> {
  final FocusNode nameFocusNode = FocusNode();
  EntryInfo entryInfo = EntryInfo();
  StartInfo startInfo = StartInfo();
  late List<HoleInfo> firstHoleInfoList;
  late List<HoleInfo> secondHoleInfoList;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    firstHoleInfoList = makeHeaderInfo(true);
    secondHoleInfoList = makeHeaderInfo(false);
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          Container(height: statusBarHeight),
          const Padding(
            padding: EdgeInsets.only(top: 25, bottom: 32),
            child: Text(
              "게임을 시작합니다~!!",
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            SizedBox(
              width: 120,
              height: 30,
              child: TextField(
                  maxLength: 6,
                  maxLines: 1,
                  focusNode: nameFocusNode,
                  controller: CustomTextEditingController(entryInfo.name.value),
                  onChanged: (newValue) => entryInfo.name.value = newValue,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                      labelText: '이름',
                      isDense: true,
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(),
                      counterText: "")),
            ),
            const SizedBox(
              width: 10,
            ),
            SizedBox(
              width: 70,
              height: 30,
              child: TextField(
                  maxLength: 3,
                  maxLines: 1,
                  controller:
                      CustomTextEditingController(entryInfo.handy.value),
                  onChanged: (newValue) => entryInfo.handy.value = newValue,
                  textAlign: TextAlign.center,
                  keyboardType:
                      const TextInputType.numberWithOptions(signed: true),
                  textInputAction: TextInputAction.done,
                  onSubmitted: (value) {
                    if (entryInfo.isEnable())
                      addMember(entryInfo, nameFocusNode);
                  },
                  decoration: const InputDecoration(
                      labelText: '핸디',
                      isDense: true,
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(),
                      counterText: "")),
            ),
            const SizedBox(
              width: 30,
            ),
            Obx(
              () => SizedBox(
                width: 60,
                height: 30,
                child: ElevatedButton(
                  onPressed: entryInfo.isEnable()
                      ? () => addMember(entryInfo, nameFocusNode)
                      : null,
                  child: const Text('추가'),
                ),
              ),
            ),
          ]),
          Expanded(
            child: CupertinoScrollbar(
              isAlwaysShown: true,
              child: ListView.separated(
                itemCount: startInfo.entryList.value.length,
                itemBuilder: (BuildContext context, int index) =>
                    entryItem(index),
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: 120,
                height: 30,
                child: TextField(
                    maxLines: 1,
                    controller:
                        CustomTextEditingController(startInfo.danwi.value),
                    onChanged: (newValue) => startInfo.danwi.value = newValue,
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    decoration: const InputDecoration(
                        labelText: '타당',
                        isDense: true,
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(),
                        counterText: "")),
              ),
              const Spacer(),
              Obx(
                () => Checkbox(
                    value: startInfo.isDoubleStart.value,
                    onChanged: (value) {
                      startInfo.isDoubleStart.value = value!;
                    }),
              ),
              const Text("배판으로 시작"),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Obx(
                () => SizedBox(
                  width: 80,
                  height: 30,
                  child: TextField(
                      maxLines: 1,
                      controller:
                          CustomTextEditingController(startInfo.buddy.value),
                      onChanged: (newValue) => startInfo.buddy.value = newValue,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          labelText: '버디',
                          isDense: true,
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                          counterText: "")),
                ),
              ),
              const Spacer(),
              Obx(
                () => SizedBox(
                  width: 80,
                  height: 30,
                  child: TextField(
                      maxLines: 1,
                      controller:
                          CustomTextEditingController(startInfo.eagle.value),
                      onChanged: (newValue) => startInfo.eagle.value = newValue,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          labelText: '이글',
                          isDense: true,
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                          counterText: "")),
                ),
              ),
              const Spacer(),
              Obx(
                () => SizedBox(
                  width: 80,
                  height: 30,
                  child: TextField(
                      maxLines: 1,
                      controller: CustomTextEditingController(
                          startInfo.albatross.value),
                      onChanged: (newValue) =>
                          startInfo.albatross.value = newValue,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          labelText: '알바트로스',
                          labelStyle: TextStyle(fontSize: 12),
                          isDense: true,
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                          counterText: "")),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: <Widget>[
              Obx(
                () => SizedBox(
                  width: 80,
                  height: 30,
                  child: TextField(
                      maxLines: 1,
                      controller: CustomTextEditingController(
                          startInfo.holeInOne.value),
                      onChanged: (newValue) =>
                          startInfo.holeInOne.value = newValue,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          labelText: '홀인원',
                          isDense: true,
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                          counterText: "")),
                ),
              ),
              const Spacer(),
              Obx(
                () => SizedBox(
                  width: 80,
                  height: 30,
                  child: TextField(
                      maxLines: 1,
                      controller:
                          CustomTextEditingController(startInfo.near.value),
                      onChanged: (newValue) => startInfo.near.value = newValue,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          labelText: '니어',
                          isDense: true,
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                          counterText: "")),
                ),
              ),
              const Spacer(),
              Obx(
                () => SizedBox(
                  width: 80,
                  height: 30,
                  child: TextField(
                      maxLines: 1,
                      controller:
                          CustomTextEditingController(startInfo.double.value),
                      onChanged: (newValue) =>
                          startInfo.double.value = newValue,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                          labelText: '배판',
                          isDense: true,
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                          counterText: "")),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Row(children: [
            Expanded(
              child: Obx(
                () => ElevatedButton(
                  onPressed:
                      startInfo.entryList.length > 1 ? () => startGame() : null,
                  child: const Text("게임 시작"),
                ),
              ),
            )
          ]),
        ],
      ),
    ));
  }

  startGame() {
    Get.to(const InputPoint(), arguments: {'startInfo': startInfo, 'firstHoleInfoList': firstHoleInfoList, 'secondHoleInfoList': secondHoleInfoList});
  }

  addMember(EntryInfo entryInfo, FocusNode fn) {
    setState(() {
      startInfo.entryList.value.add(entryInfo);
      this.entryInfo = EntryInfo();
      FocusScope.of(context).requestFocus(fn);
    });
  }

  deleteMember(int idx) {
    setState(() {
      startInfo.entryList.value.removeAt(idx);
    });
  }

  Widget entryItem(int idx) {
    EntryInfo item = startInfo.entryList[idx];
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
            width: 120,
            alignment: Alignment.centerLeft,
            child: Text(item.name.value)),
        Container(
            margin: const EdgeInsets.only(left: 30), child: const Text("핸디")),
        Container(
            width: 40,
            margin: const EdgeInsets.only(left: 10),
            alignment: Alignment.centerRight,
            child: Text(item.handy.value)),
        Container(
            margin: const EdgeInsets.only(left: 15),
            child: IconButton(
              icon: const Icon(Icons.close),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              iconSize: 30,
              splashRadius: 30,
              onPressed: () {
                deleteMember(idx);
              },
            ))
      ],
    );
  }

  makeHeaderInfo(bool isFirst){
    var holeList = <HoleInfo>[];
    for(var i=1; i<10; i++){
      holeList.add(HoleInfo()..hole = (isFirst ? i : i+9).toString().obs);
    }
    return holeList;
  }

  TextEditingController _textEditingController(String value) {
    var c = TextEditingController(text: value);
    c.selection =
        TextSelection.fromPosition(TextPosition(offset: c.text.length));
    return c;
  }
//
//
// Widget _authButton(Size size) {
//   return Positioned(
//       left: size.width * 0.15,
//       right: size.width * 0.15,
//       bottom: 0,
//       child: SizedBox(
//         height: 50,
//         child: RaisedButton(
//             child: Text("Login", style: TextStyle(fontSize: 20, color: Colors.white),),
//             color: Colors.blue,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
//             onPressed: () {
//               if(formKey.currentState?.validate() == true){
//                 print(emailController.text.toString());
//               }
//             }),
//       ));
// }
//
// Widget _inputForm(Size size) {
//   return Padding(
//     padding: EdgeInsets.all(size.width * 0.05),
//     child: Card(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       elevation: 6,
//       child: Padding(
//         padding:
//             const EdgeInsets.only(left: 12.0, right: 12, top: 12, bottom: 32),
//         child: Form(
//             key: formKey,
//             child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   TextFormField(
//                       controller: emailController,
//                       decoration: const InputDecoration(
//                           icon: Icon(Icons.account_circle),
//                           labelText: "Email"),
//                       validator: (value) {
//                         if (value?.isEmpty == true) {
//                           return "Please input correct Email.";
//                         }
//                         return null;
//                       }),
//                   TextFormField(
//                     obscureText: true,
//                       controller: passwordController,
//                       decoration: const InputDecoration(
//                           icon: Icon(Icons.vpn_key), labelText: "Password"),
//                       validator: (value) {
//                         if (value?.isEmpty == true) {
//                           return "Please input correct Password.";
//                         }
//                         return null;
//                       }),
//                   Container(height: 8),
//                   const Text("Forgot Password")
//                 ])),
//       ),
//     ),
//   );
// }
}
