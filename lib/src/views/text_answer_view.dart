import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:survey_kit/src/answer_format/text_answer_format.dart';
import 'package:survey_kit/src/controller/survey_controller.dart';
import 'package:survey_kit/src/views/decoration/input_decoration.dart';
import 'package:survey_kit/src/result/question/text_question_result.dart';
import 'package:survey_kit/src/steps/predefined_steps/question_step.dart';
import 'package:survey_kit/src/views/widget/step_view.dart';

class TextAnswerView extends StatefulWidget {
  final QuestionStep questionStep;
  final TextQuestionResult? result;

  const TextAnswerView({
    required this.questionStep,
    required this.result,
  });

  @override
  _TextAnswerViewState createState() => _TextAnswerViewState();
}

class _TextAnswerViewState extends State<TextAnswerView> {
  late final TextAnswerFormat _textAnswerFormat;
  late final DateTime _startDate;

  late final TextEditingController _controller;
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _controller.text = widget.result?.result ?? '';
    _checkValidation(_controller.text);
    _textAnswerFormat = widget.questionStep.answerFormat as TextAnswerFormat;
    _startDate = DateTime.now();
  }

  void _checkValidation(String text) {
    setState(() {
      _isValid = text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StepView(
      step: widget.questionStep,
      controller: SurveyController(
        context: context,
        resultFunction: () => TextQuestionResult(
          id: widget.questionStep.id,
          startDate: _startDate,
          endDate: DateTime.now(),
          valueIdentifier: _controller.text,
          result: _controller.text,
        ),
      ),
      title: Text(
        widget.questionStep.title,
        style: Theme.of(context).textTheme.headline5,
        textAlign: TextAlign.center,
      ),
      isValid: _isValid,
      child: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(bottom: 32.0, left: 14.0, right: 14.0),
            child: Text(
              widget.questionStep.text,
              style: TextStyle(
                fontSize: 18.0,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            height: 100.0,
            child: TextField(
              controller: _controller,
              textAlign: TextAlign.center,
              onChanged: (String text) {
                _checkValidation(text);
              },
              decoration: textFieldInputDecoration(
                hint: _textAnswerFormat.hint,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
