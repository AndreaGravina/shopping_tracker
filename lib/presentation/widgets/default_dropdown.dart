import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/data/models/choice_item.dart';
import 'package:flutter_template/theme/colors.dart' as custom_colors;

class DefaultDropdown extends StatefulWidget {
  final List<ChoiceItem> choiceItems;
  final String title;
  final FormFieldSetter<dynamic> onSaved;
  final int? initialValue;
  final List<int>? initialValues;
  final FormFieldValidator<dynamic>? validator;
  final Function? onChanged;
  final GlobalKey<FormFieldState>? fieldKey;
  final bool isRequired;
  final bool showHint;
  final bool isMultiple;

  const DefaultDropdown({
    Key? key,
    required this.choiceItems,
    required this.onSaved,
    this.title = '',
    this.initialValue,
    this.initialValues,
    this.validator,
    this.onChanged,
    this.fieldKey,
    this.showHint = true,
    this.isRequired = false,
    this.isMultiple = false,
  }) : super(key: key);

  @override
  _DefaultDropdownState createState() => _DefaultDropdownState();
}

class _DefaultDropdownState extends State<DefaultDropdown> {
  final List<ChoiceItem> _selectedItems = [];
  String _selectedText = '';

  void _toggleChoice(ChoiceItem value) {
    if (_selectedItems.contains(value)) {
      _selectedItems.remove(value);
    } else {
      _selectedItems.add(value);
    }
    _buildSelectedString();
  }

  void _buildSelectedString() {
    final buffer = StringBuffer();
    for (var i = 0; i < _selectedItems.length; i++) {
      if (i > 0) {
        buffer.write(', ');
      }
      buffer.write(_selectedItems[i].choiceItemTitle);
    }
    _selectedText = buffer.toString();
    //aggiorno grafica tendina
    setState(() {});
  }

  List<Widget> _getSelectedItemsBuilder(BuildContext context) {
    return widget.choiceItems.map<Widget>((item) {
      if (_selectedText.isNotEmpty) {
        return FittedBox(
          alignment: Alignment.centerLeft,
          child: Text(_selectedText),
        );
      }
      return Text(
        tr('select_multiple_placeholder'),
        style: TextStyle(
          color: Theme.of(context).hintColor,
        ),
      );
    }).toList();
  }

  ChoiceItem? get _initialValue {
    if (widget.initialValue != null) {
      //singola
      for (final item in widget.choiceItems) {
        if (item.choiceItemId == widget.initialValue) {
          return item;
        }
      }
    } else if (widget.initialValues != null &&
        widget.initialValues!.isNotEmpty &&
        widget.isMultiple) {
      //multipla
      for (final item in widget.choiceItems) {
        if (item.choiceItemId == widget.initialValues!.last) {
          return item;
        }
      }
    }
    return null;
  }

  @override
  void initState() {
    if (widget.initialValues != null && widget.isMultiple) {
      //aggiungo opzioni selezionate
      _selectedItems.clear();
      for (final item in widget.choiceItems) {
        if (widget.initialValues!.contains(item.choiceItemId)) {
          _selectedItems.add(item);
        }
      }
      _buildSelectedString();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (widget.title.isNotEmpty) ...[
          Text(
            widget.isRequired ? '${widget.title} *' : widget.title,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
              fontWeight: FontWeight.w500,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(
            height: 4.0,
          ),
        ],
        DropdownButtonFormField(
          key: widget.fieldKey,
          isExpanded: true,
          hint: Text(
            widget.showHint
                ? widget.isMultiple
                    ? tr('select_multiple_placeholder')
                    : tr('select_placeholder')
                : '',
          ),
          items: widget.choiceItems.map((ChoiceItem item) {
            return DropdownMenuItem(
              value: item,
              child: Text(
                item.choiceItemTitle ?? '',
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.subtitle1?.copyWith(
                    color: (widget.isMultiple && _selectedItems.contains(item))
                        ? custom_colors.black
                        : custom_colors.red),
              ),
            );
          }).toList(),
          onChanged: (ChoiceItem? value) {
            if (widget.onChanged != null) {
              widget.onChanged!(value);
            }
            if (widget.isMultiple) {
              _toggleChoice(value!);
            }
          },
          selectedItemBuilder: widget.isMultiple ? _getSelectedItemsBuilder : null,
          value: _initialValue,
          onSaved: (ChoiceItem? value) {
            if (widget.isMultiple) {
              widget.onSaved(_selectedItems);
            } else {
              widget.onSaved(value);
            }
          },
          validator: (ChoiceItem? value) {
            if (widget.validator != null) {
              if (widget.isMultiple) {
                return widget.validator!(_selectedItems);
              } else {
                return widget.validator!(value);
              }
            }
            return null;
          },
        ),
      ],
    );
  }
}
