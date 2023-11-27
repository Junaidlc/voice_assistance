import 'package:flutter/material.dart';
import 'package:voice_assistance/screen/future_box.dart';
import 'package:voice_assistance/widgets/pallete.dart';
import 'package:voice_assistance/widgets/widgets.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Echo", style: kTextStyleBold16),
        leading: const Icon(Icons.menu),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    margin: const EdgeInsets.only(top: 4),
                    decoration: const BoxDecoration(
                      color: Pallete.assistantCircleColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Container(
                  height: 125,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/images/va_image.png"),
                    ),
                  ),
                )
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              margin:
                  const EdgeInsets.symmetric(horizontal: 40).copyWith(top: 30),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Pallete.borderColor,
                  ),
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text("Good morning. what task can i do for you ?",
                    style: kTextstyleCeraPro23),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 10, left: 22),
              child: const Text(
                "Here are a faw features",
                style: TextStyle(
                  fontFamily: 'Cere Pro,',
                  color: Pallete.mainFontColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // future list
            const Column(
              children: [
                FutureBox(
                  color: Pallete.firstSuggestionBoxColor,
                  hearder: "ChatTea",
                  description:
                      "Good way to think and spend time of learning & learning easy",
                ),
                FutureBox(
                  color: Pallete.secondSuggestionBoxColor,
                  hearder: "Dall-E",
                  description:
                      "Good way to think and spend time of learning & learning easy",
                ),
                FutureBox(
                  color: Pallete.thirdSuggestionBoxColor,
                  hearder: "Smart Voice Assistance",
                  description:
                      "Good way to think and spend time of learning & learning easy",
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Pallete.firstSuggestionBoxColor,
        child: const Icon(Icons.mic),
      ),
    );
  }
}
