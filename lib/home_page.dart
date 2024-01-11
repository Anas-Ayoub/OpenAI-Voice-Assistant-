import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:openai/feature_box.dart';
import 'package:openai/openai_service.dart';
import 'package:openai/pallete.dart';
import 'package:openai/widget/drawer.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:logger/logger.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  String lang = "English";
  List<Color> botColors = const [
    Color.fromARGB(255, 54, 198, 255),
    Color.fromARGB(0, 54, 198, 255),
  ];

  String lottieAnimation = 'assets/lottie/BotHi.json';
  final speechToText = SpeechToText();
  final flutterTts = FlutterTts();
  String lastWords = '';
  final OpenAIService openAIService = OpenAIService();
  String? generatedContent;
  String? generatedImageUrl;
  int start = 200;
  int delay = 200;
  var logger = Logger(
    printer: PrettyPrinter(),
  );
  late AnimationController _controller;
  late Animation<double> _animation;
  bool rp = false;
  @override
  void initState() {
    super.initState();

    //Fade Animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _animation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves
            .easeInOutCirc, //Curves.easeInOutCirc, Curves.easeInOutQuint, Curves.fastOutSlowIn, Curves.easeInOut
      ),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });

    _controller.forward();

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

  Future<void> startListening() async {
    await speechToText.listen(
      onResult: onSpeechResult,
      listenFor: Duration(minutes: 1),
      pauseFor: Duration(seconds: 10),
    );
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

  Future<void> startSpeak(String content) async {
    await flutterTts.speak(content);
  }

  Future<void> stopSpeak() async {
    await flutterTts.stop();
  }

  @override
  void dispose() {
    super.dispose();
    speechToText.stop();
    flutterTts.stop();
  }

  void toggleLanguag() {
    setState(() {
      if (lang == "English")
        lang = "French";
      else
        lang = "English";
    });
  }

  void updateLanguage(String l) {
    setState(() {
      lang = l;
    });
  }

  void printvoics() async {
    List<dynamic> voices = await flutterTts.getVoices;
    logger.i(voices);
  }

  @override
  Widget build(BuildContext context) {
    logger.i('Content = $generatedContent');
    logger.i('IMAG : $generatedImageUrl');
    flutterTts.setPitch(1);
    return Scaffold(
      drawer: AiDrawer(updateLanguage: updateLanguage),
      appBar: AppBar(
        title: const Text(
          "AI Assistant",
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              //padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              width: 50,
              height: 20,
              decoration: BoxDecoration(
                  color: Colors.green, borderRadius: BorderRadius.circular(25)),
              child: InkWell(
                child: Center(
                  child: Text(
                    lang == "English" ? "en-Us" : "fr-FR",
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.black),
                  ),
                ),
                onTap: () => toggleLanguag(),
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              Theme.of(context).brightness == Brightness.dark
                  ? "assets/images/Darker.png"
                  : 'assets/images/Lighter.png',
            ),
            fit: BoxFit.cover,
            colorFilter: Theme.of(context).brightness == Brightness.dark
                ? ColorFilter.mode(
                    Colors.white.withOpacity(0.05), BlendMode.lighten)
                : null,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              AnimatedBuilder(
                animation: _animation,
                builder: ((context, child) {
                  return Container(
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: botColors,
                        center: Alignment.center,
                        radius: _animation.value,
                        stops: const [0.08, 0.48],
                      ),
                    ),
                    child: ZoomIn(
                      child: Center(
                        child: Lottie.asset(
                          lottieAnimation,
                          fit: BoxFit.cover,
                          repeat: lottieAnimation == 'assets/lottie/BotHi.json'
                              ? false
                              : true,
                          height: 220,
                          width: 220,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              // chat bubble
              FadeIn(
                duration: Duration(milliseconds: 2000),
                child: Visibility(
                  visible: generatedImageUrl == null,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      padding:
                          EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(width: 1, color: Colors.blue)),
                      width: double.infinity,
                      child: generatedContent == null
                          ? Text(
                              "How can i help you ?",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium,
                            )
                          : AnimatedTextKit(
                              totalRepeatCount: 1,
                              animatedTexts: [
                                TypewriterAnimatedText(
                                  cursor: "▌",
                                  generatedContent!,
                                  textStyle:
                                      Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                              repeatForever: false,
                              isRepeatingAnimation: true,
                            ),
                    ),
                  ),
                ),
              ),
              if (generatedImageUrl != null)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(generatedImageUrl!),
                  ),
                ),
              const SizedBox(
                height: 30,
              ),
              // Container(
              //   decoration: BoxDecoration(
              //       color: Colors.grey, //Theme.of(context).colorScheme.outline,
              //       boxShadow: [
              //         BoxShadow(
              //             color: Theme.of(context).colorScheme.outline,
              //             blurRadius: 6)
              //       ]),
              //   height: 1,
              //   width: MediaQuery.of(context).size.width - 100,
              // ),
              SlideInUp(
                duration: Duration(milliseconds: 500),
                child: Visibility(
                  visible:
                      generatedContent == null && generatedImageUrl == null,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    margin: const EdgeInsets.only(top: 11, bottom: 5),
                    child: Center(
                      child: Text(
                        'Features',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: generatedContent == null && generatedImageUrl == null,
                child: Column(
                  children: [
                    SlideInLeft(
                      duration: Duration(milliseconds: 500),
                      child: Card(
                        child: ListTile(
                          leading: Image.asset(
                            'assets/images/GPT.png',
                          ),
                          title: Text(
                            "ChatGPT",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          subtitle: Text(
                            "A smarter way to stay organized and informed with ChatGPT",
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                      ),
                    ),
                    SlideInLeft(
                      duration: Duration(milliseconds: 500),
                      delay: Duration(milliseconds: 100),
                      child: Card(
                        child: ListTile(
                          leading: Image.asset(
                            'assets/images/DALLE.png',
                          ),
                          title: Text(
                            "Dall-E",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          subtitle: Text(
                            "Get inspired and stay creative with your personal assistant powerd by Dall-E",
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Visibility(
            visible: generatedContent != null || generatedImageUrl != null,
            child: FloatingActionButton(
              backgroundColor: Color.fromARGB(255, 248, 146, 146),
              onPressed: () {
                setState(() {
                  generatedContent = null;
                  generatedImageUrl = null;
                  lottieAnimation = 'assets/lottie/BotHi.json';
                  stopSpeak();
                });
                print(generatedContent);
                print(generatedImageUrl);
              },
              child: Icon(
                Icons.square,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton.small(
                backgroundColor: Theme.of(context).colorScheme.outline,
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                onPressed: (() {
                  stopSpeak();
                }),
                child: Icon(Icons.volume_off),
              ),
              SizedBox(
                height: 10,
              ),
              FloatingActionButton(
                backgroundColor: const Color.fromARGB(255, 78, 143, 156),
                onPressed: () async {
                  if (await speechToText.hasPermission &&
                      speechToText.isNotListening) {
                    setState(() {
                      lottieAnimation = 'assets/lottie/BotWriting.json';
                    });
                    await startListening();
                  } else if (speechToText.isListening) {
                    setState(() {
                      lottieAnimation = 'assets/lottie/BotLoading.json';
                    });
                    Future.delayed(Duration(seconds: 2), () async {
                      final speech =
                          await openAIService.isArtPromptAPI(lastWords);
                      if (speech.contains('https')) {
                        generatedImageUrl = speech;
                        generatedContent = null;

                        setState(() {
                          lottieAnimation = 'assets/lottie/BotGreen.json';
                        });
                      } else {
                        generatedImageUrl = null;
                        logger.log(
                            Level.debug, "Assigning to Content this : $speech");
                        setState(() {
                          generatedContent = speech;
                          if (speech == 'Something Went Wrong :(') {
                            lottieAnimation = 'assets/lottie/BotRed.json';
                            botColors = const [
                              Color.fromARGB(255, 255, 54, 54),
                              Color.fromARGB(0, 255, 54, 54),
                            ];
                          } else {
                            lottieAnimation = 'assets/lottie/BotGreen.json';
                          }
                        });
                        await startSpeak(speech);
                      }
                      await stopListening();
                    });
                  } else {
                    initSpeechToText();
                  }
                },
                child: Icon(
                  speechToText.isListening ? Icons.mic_off : Icons.mic,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
