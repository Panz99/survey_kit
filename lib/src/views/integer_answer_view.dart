import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:survey_kit/src/answer_format/integer_answer_format.dart';
import 'package:survey_kit/src/controller/survey_controller.dart';
import 'package:survey_kit/src/views/decoration/input_decoration.dart';
import 'package:survey_kit/src/result/question/integer_question_result.dart';
import 'package:survey_kit/src/steps/predefined_steps/question_step.dart';
import 'package:survey_kit/src/views/widget/step_view.dart';

class IntegerAnswerView extends StatefulWidget {
  final QuestionStep questionStep;
  final IntegerQuestionResult? result;

  const IntegerAnswerView({
    required this.questionStep,
    required this.result,
  });

  @override
  _IntegerAnswerViewState createState() => _IntegerAnswerViewState();
}

class _IntegerAnswerViewState extends State<IntegerAnswerView> {
  late final IntegerAnswerFormat _integerAnswerFormat;
  late final TextEditingController _controller;
  late final DateTime _startDate;

  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _integerAnswerFormat =
        widget.questionStep.answerFormat as IntegerAnswerFormat;
    _controller = TextEditingController();
    _controller.text = widget.result?.result?.toString() ?? '';
    _checkValidation(_controller.text);
    _startDate = DateTime.now();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _checkValidation(String text) {
    setState(() {
      _isValid = widget.questionStep.isOptional ||
          (text.isNotEmpty && int.tryParse(text) != null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return StepView(
      step: widget.questionStep,
      controller: SurveyController(
        context: context,
        resultFunction: () => IntegerQuestionResult(
          id: widget.questionStep.id,
          startDate: _startDate,
          endDate: DateTime.now(),
          valueIdentifier: _controller.text,
          result: int.tryParse(_controller.text) ??
              _integerAnswerFormat.defaultValue ??
              null,
        ),
      ),
      isValid: _isValid,
      title: Text(
        widget.questionStep.title,
        style: Theme.of(context).textTheme.headline5,
        textAlign: TextAlign.center,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: TextField(
            controller: _controller,
            onChanged: (String value) {
              _checkValidation(value);
            },
            keyboardType: TextInputType.number,
            textAlign: TextAlign.center,
            decoration: textFieldInputDecoration(
              hint: _integerAnswerFormat.hint,
            ),
          ),
        ),
      ),
    );
  }
}
