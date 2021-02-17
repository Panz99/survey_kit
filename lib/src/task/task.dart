import 'package:flutter/widgets.dart';
import 'package:surveykit/src/steps/step.dart';
import 'package:surveykit/src/task/identifier/task_identifier.dart';

abstract class Task {
  TaskIdentifier id;
  final List<Step> steps;

  Task({
    TaskIdentifier id,
    @required this.steps,
  }) {
    if (id == null) {
      id = TaskIdentifier();
      return;
    }
    this.id = id;
  }
}
