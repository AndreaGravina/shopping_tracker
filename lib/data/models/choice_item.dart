class ChoiceItem {
  int? _choiceItemId;
  String? _choiceItemTitle;

  int? get choiceItemId => _choiceItemId;

  String? get choiceItemTitle => _choiceItemTitle;

  ChoiceItem({
    int? id,
    String? title,
  }) {
    _choiceItemId = id;
    _choiceItemTitle = title;
  }
}
