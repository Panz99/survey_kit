import 'package:flutter/material.dart';
import 'package:survey_kit/survey_kit.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SurveyKit(
          onResult: (SurveyResult result) {
            print(result.finishReason);
          },
          task: getSampleTask(),
          themeData: Theme.of(context).copyWith(
            colorScheme: ColorScheme.fromSwatch(
              primarySwatch: Colors.cyan,
            ).copyWith(
              onPrimary: Colors.white,
            ),
            primaryColor: Colors.cyan,
            backgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
              color: Colors.white,
              iconTheme: IconThemeData(
                color: Colors.cyan,
              ),
              textTheme: TextTheme(
                button: TextStyle(
                  color: Colors.cyan,
                ),
              ),
            ),
            iconTheme: const IconThemeData(
              color: Colors.cyan,
            ),
            outlinedButtonTheme: OutlinedButtonThemeData(
              style: ButtonStyle(
                minimumSize: MaterialStateProperty.all(
                  Size(150.0, 60.0),
                ),
                side: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> state) {
                    if (state.contains(MaterialState.disabled)) {
                      return BorderSide(
                        color: Colors.grey,
                      );
                    }
                    return BorderSide(
                      color: Colors.cyan,
                    );
                  },
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                textStyle: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> state) {
                    if (state.contains(MaterialState.disabled)) {
                      return Theme.of(context).textTheme.button?.copyWith(
                            color: Colors.grey,
                          );
                    }
                    return Theme.of(context).textTheme.button?.copyWith(
                          color: Colors.cyan,
                        );
                  },
                ),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: ButtonStyle(
                textStyle: MaterialStateProperty.all(
                  Theme.of(context).textTheme.button?.copyWith(
                        color: Colors.cyan,
                      ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Task getSampleTask() {
    var task = NavigableTask(
      id: TaskIdentifier(),
      steps: [
        InstructionStep(
          title: 'Welcome to the\nQuickBird Studios\nHealth Survey',
          text: 'Get ready for a bunch of super random questions!',
          buttonText: 'Let\'s go!',
        ),
        QuestionStep(
          title: 'How old are you?',
          answerFormat: IntegerAnswerFormat(
            defaultValue: 25,
            hint: 'Please enter your age',
          ),
        ),
        QuestionStep(
          title: 'Medication?',
          text: 'Are you using any medication',
          answerFormat: BooleanAnswerFormat(
            positiveAnswer: 'Yes',
            negativeAnswer: 'No',
            result: BooleanResult.POSITIVE,
          ),
        ),
        QuestionStep(
          title: 'Tell us about you',
          text:
              'Tell us about yourself and why you want to improve your health.',
          answerFormat: TextAnswerFormat(
            maxLines: 5,
          ),
        ),
        QuestionStep(
          title: 'Select your body type',
          answerFormat: ScaleAnswerFormat(
            step: 1,
            minimumValue: 1,
            maximumValue: 5,
            defaultValue: 3,
            minimumValueDescription: '1',
            maximumValueDescription: '5',
          ),
        ),
        QuestionStep(
          title: 'Select your body type',
          answerFormat: ScaleAnswerFormat(
            step: 1,
            minimumValue: 3,
            maximumValue: 15,
            defaultValue: 10,
            minimumValueDescription: '3',
            maximumValueDescription: '15',
          ),
        ),
        QuestionStep(
          title: 'Known allergies',
          text: 'Do you have any allergies that we should be aware of?',
          isOptional: true,
          answerFormat: SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Penicillin', value: 'Penicillin'),
              TextChoice(text: 'Latex', value: 'Latex'),
              TextChoice(text: 'Pet', value: 'Pet'),
              TextChoice(text: 'Pollen', value: 'Pollen'),
            ],
          ),
        ),
        QuestionStep(
          title: 'blablabla',
          text: 'asdadsas',
          isOptional: false,
          answerFormat: SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'sss', value: 'sadsad'),
              TextChoice(text: 'sss', value: 'asdsa'),
              TextChoice(text: 'aaaaa', value: 'assda'),
            ],
          ),
        ),
        QuestionStep(
          title: 'Done?',
          text: 'We are done, do you mind to tell us more about yourself?',
          isOptional: true,
          answerFormat: SingleChoiceAnswerFormat(
            textChoices: [
              TextChoice(text: 'Yes', value: 'Yes'),
              TextChoice(text: 'No', value: 'No'),
            ],
          ),
        ),
        QuestionStep(
          title: 'When did you wake up?',
          answerFormat: TimeAnswerFormat(
            defaultValue: TimeOfDay(
              hour: 12,
              minute: 0,
            ),
          ),
        ),
        QuestionStep(
          title: 'When was your last holiday?',
          answerFormat: DateAnswerFormat(
            minDate: DateTime.utc(1970),
            maxDate: DateTime.now(),
            defaultDate: DateTime.now(),
          ),
        ),
        CompletionStep(
          id: StepIdentifier(id: '321'),
          text: 'Thanks for taking the survey, we will contact you soon!',
          title: 'Done!',
          buttonText: 'Submit survey',
        ),
      ],
    );
    task.addNavigationRule(
      forTriggerStepIdentifier: task.steps[6].id,
      navigationRule: ConditionalNavigationRule(
        resultToStepIdentifierMapper: (input) {
          switch (input) {
            case "Yes":
              return task.steps[0].id;
            case "No":
              return task.steps[7].id;
            default:
              return null;
          }
        },
      ),
    );
    return task;
  }
}
