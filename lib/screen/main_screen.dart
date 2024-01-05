import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:voice_assistance/api/openai_service.dart';
import 'package:voice_assistance/screen/future_box.dart';
import 'package:voice_assistance/widgets/pallete.dart';
import 'package:voice_assistance/widgets/widgets.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final speechToText = SpeechToText();
  final flutterTts = FlutterTts();
  String lastWords = "";
  final OpenAIService openAIService = OpenAIService();
  String? generatedContent;
  String? generatedImageUrl;
  int start = 200;
  int delay = 200;

  @override
  void initState() {
    super.initState();
    initSpeechToText();
    initTextToSpeech();
  }

  Future<void> initTextToSpeech() async {
    await flutterTts.setSharedInstance(true);
    setState(() {});
  }

  Future<void> initSpeechToText() async {
    await speechToText.initialize();
    setState(() {});
  }

  // Each time to start a speech recognition session
  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
    });
  }

  Future<void> systemSpeak(String content) async {
    await flutterTts.speak(content);
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: BounceInUp(child: const Text("Echo", style: kTextStyleBold16)),
        leading: const Icon(Icons.menu),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ZoomIn(
              child: Stack(
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
            ),
            FadeInRight(
              child: Visibility(
                visible: generatedImageUrl == null,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  margin: const EdgeInsets.symmetric(horizontal: 40)
                      .copyWith(top: 30),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Pallete.borderColor,
                    ),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                        generatedContent == null
                            ? "Good morning. what task can i do for you ?"
                            : generatedContent!,
                        style: generatedContent == null
                            ? kTextstyleCeraPro23
                            : kTextstyleCeraPro18),
                  ),
                ),
              ),
            ),
            if (generatedImageUrl != null)
              Padding(
                padding: const EdgeInsets.all(10),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(generatedImageUrl!)),
              ),
            FadeInLeft(
              child: Visibility(
                visible: generatedContent == null && generatedImageUrl == null,
                child: Container(
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
              ),
            ),

            // future list
            Visibility(
              visible: generatedContent == null && generatedImageUrl == null,
              child: Column(
                children: [
                  SlideInLeft(
                    delay: Duration(milliseconds: start),
                    child: const FutureBox(
                      color: Pallete.firstSuggestionBoxColor,
                      hearder: "ChatTea",
                      description:
                          "Good way to think and spend time of learning & learning easy",
                    ),
                  ),
                  SlideInRight(
                    delay: Duration(milliseconds: start + delay),
                    child: const FutureBox(
                      color: Pallete.secondSuggestionBoxColor,
                      hearder: "Dall-E",
                      description:
                          "Good way to think and spend time of learning & learning easy",
                    ),
                  ),
                  SlideInLeft(
                    delay: Duration(milliseconds: start + 2 * delay),
                    child: const FutureBox(
                      color: Pallete.thirdSuggestionBoxColor,
                      hearder: "Smart Voice Assistance",
                      description:
                          "Good way to think and spend time of learning & learning easy",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ZoomIn(
        child: FloatingActionButton(
          onPressed: () async {
            if (await speechToText.hasPermission && speechToText.isNotListening) {
              await startListening();
            } else if (speechToText.isListening) {
              final speech = await openAIService.isArtPromptAPI(lastWords);
              if (speech.contains('https')) {
                generatedImageUrl = speech;
                generatedContent = null;
                setState(() {});
              } else {
                generatedImageUrl = null;
                generatedContent = speech;
                setState(() {});
                await systemSpeak(speech);
              }
        
              await stopListening();
            } else {
              initSpeechToText();
            }
          },
          backgroundColor: Pallete.firstSuggestionBoxColor,
          child: Icon(speechToText.isListening ? Icons.stop : Icons.mic),
        ),
      ),
    );
  }
}
