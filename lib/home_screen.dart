import 'package:flutter/material.dart';
import 'package:water_tracker_app/water_tracker.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textEditingController =
      TextEditingController(text: '0');

  List<WaterTrack> waterTrackerList = [];

  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F8),
      appBar: appBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          headingContent(context),
          const SizedBox(height: 24),
          mainBody(),
        ],
      ),
    );
  }

  Expanded mainBody() {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) =>
            Divider(thickness: 2, color: Theme.of(context).primaryColor),
        itemCount: waterTrackerList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue[100],
              foregroundColor: Colors.black,
              child: Text('${index + 1}'),
            ),
            title: Text(
              '${waterTrackerList[index].noOfGlass} glass of water',
            ),
            titleTextStyle: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(DateFormat('jm').format(dateTime)),
                Text(DateFormat('yMd').format(dateTime)),
              ],
            ),
            trailing: CircleAvatar(
              backgroundColor: Colors.red[100],
              child: IconButton(
                onPressed: () {
                  setState(() {
                    waterTrackerList.removeAt(index);
                  });
                },
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
            ),
          );
        },
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      title: const Text("Water Tracker"),
      titleTextStyle: const TextStyle(
        fontSize: 24,
        letterSpacing: 3,
        fontWeight: FontWeight.w400,
      ),
      foregroundColor: Colors.white,
      centerTitle: true,
    );
  }

  Container headingContent(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(30),
          bottomLeft: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 5,
            color: Color(0xFFBDBDBD),
            offset: Offset(10, 0),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          noOfGlassesDisplay(),
          const SizedBox(height: 24),
          noOfGlassesAdder(context),
        ],
      ),
    );
  }

  Row noOfGlassesAdder(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 100,
          height: 70,
          child: TextField(
            controller: _textEditingController,
            textAlign: TextAlign.center,
            cursorColor: Colors.blue,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 1,
                  ),
                  borderRadius: BorderRadius.circular(12)),
            ),
          ),
        ),
        const SizedBox(width: 20),
        GestureDetector(
          onTap: noOfGlassAdd,
          child: CircleAvatar(
            backgroundColor: Colors.blue[100],
            foregroundColor: Colors.black,
            radius: 25,
            child: const Icon(Icons.add,size: 28),
          ),
        ),
      ],
    );
  }

  void noOfGlassAdd() {
    setState(() {
      if (_textEditingController.text.isEmpty ||
          int.parse(_textEditingController.text) == 0) {
        return;
      }
      int noOfGlass = int.parse(_textEditingController.text);
      WaterTrack waterTrack = WaterTrack(
        noOfGlass: noOfGlass,
        dateTime: dateTime,
      );
      waterTrackerList.add(waterTrack);
    });
  }

  Column noOfGlassesDisplay() {
    return Column(
      children: [
        Text(
          totalGlassOfWater().toString(),
          style: const TextStyle(fontSize: 28),
        ),
        const Text(
          "Glasses of water",
          style: TextStyle(fontSize: 20),
        ),
      ],
    );
  }

  int totalGlassOfWater() {
    int counter = 0;
    for (WaterTrack i in waterTrackerList) {
      counter += i.noOfGlass;
    }
    return counter;
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
