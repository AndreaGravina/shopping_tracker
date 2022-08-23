import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/presentation/widgets/default_text_field.dart';
import 'package:flutter_template/theme/colors.dart' as custom_colors;
import 'package:flutter_template/utils/utils.dart' as utils;

class DefaultDatePicker extends StatefulWidget {
  final String title;
  final FormFieldSetter<String> onSaved;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Function? onSubmitted;
  final Function? onDateSelected;
  final InputDecoration? decoration;
  final String? initialDate;
  final bool isRequired;
  final bool onlyDate;
  final bool isEnabled;
  final bool isReadOnly;
  final bool isReset;
  final bool isRange;

  const DefaultDatePicker({
    Key? key,
    required this.title,
    required this.onSaved,
    required this.controller,
    this.validator,
    this.textInputAction,
    this.focusNode,
    this.onSubmitted,
    this.onDateSelected,
    this.decoration,
    this.initialDate,
    this.isRequired = false,
    this.onlyDate = true,
    this.isEnabled = true,
    this.isReadOnly = true,
    this.isReset = false,
    this.isRange = false,
  }) : super(key: key);

  @override
  _DefaultDatePickerState createState() => _DefaultDatePickerState();
}

class _DefaultDatePickerState extends State<DefaultDatePicker> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  DateTime? _initialValueDate;
  TimeOfDay? _initialValueTime;
  DateTimeRange? _selectedDateRange;

  Future<void> _chooseDate(BuildContext ctx) async {
    final DateTime? picked = await showDatePicker(
      context: ctx,
      initialDate: _selectedDate != null
          ? _selectedDate!
          : _initialValueDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2099),
    );

    if (picked != null) {
      _selectedDate = picked;

      //only date picker
      if (widget.onlyDate) {
        widget.controller.text = utils.formatDate(
          _selectedDate!,
          pattern: 'dd/MM/yyyy',
        );
        if (widget.onDateSelected != null) {
          widget.onDateSelected!(widget.controller.text);
        }
        return;
      }
      //avoid asynchronous gap
      if (!mounted) {
        return;
      }
      _chooseTime(ctx);
    }
  }

  Future<void> _chooseTime(BuildContext ctx) async {
    final TimeOfDay? picked = await showTimePicker(
      context: ctx,
      initialTime: _selectedTime != null
          ? _selectedTime!
          : _initialValueTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      _selectedTime = picked;

      //final date
      final date = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );
      widget.controller.text = utils.formatDate(date);
      if (widget.onDateSelected != null) {
        widget.onDateSelected!(widget.controller.text);
      }
    }
  }

  Future<void> _chooseDateRange(BuildContext ctx) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: ctx,
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      initialDateRange: _selectedDateRange != null
          ? _selectedDateRange!
          : DateTimeRange(start: DateTime.now(), end: DateTime.now()),
      firstDate: DateTime(1900),
      lastDate: DateTime(2099),
      builder: _buildDateCalendar,
    );

    if (picked != null) {
      _selectedDateRange = picked;

      //set data range
      final buffer = StringBuffer();
      buffer.write(utils.formatDate(_selectedDateRange!.start, pattern: 'dd-MM-yyyy'));
      buffer.write(' / ');
      buffer.write(utils.formatDate(_selectedDateRange!.end, pattern: 'dd-MM-yyyy'));

      widget.controller.text = buffer.toString();
      if (widget.onDateSelected != null) {
        widget.onDateSelected!(widget.controller.text);
      }
    }
  }

  @override
  void initState() {
    try {
      if (widget.initialDate != null) {
        widget.controller.text = widget.initialDate!;

        //set data e orario
        if (widget.onlyDate) {
          _initialValueDate = DateFormat('dd/MM/yyyy').parse(widget.initialDate!);
        } else {
          final fullDate = DateFormat('dd/MM/yyyy HH:mm').parse(widget.initialDate!);
          _initialValueDate = DateTime(fullDate.year, fullDate.month, fullDate.day);
          _initialValueTime = TimeOfDay.fromDateTime(fullDate);
        }
      }
    } catch (e) {
      print("Errore data: $e");
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextField(
      onTap: widget.isRange ? _chooseDateRange : _chooseDate,
      title: widget.title,
      decoration: _inputDecoration(context),
      controller: widget.controller,
      textInputAction: widget.textInputAction,
      focusNode: widget.focusNode,
      isEnabled: widget.isEnabled,
      isReadOnly: widget.isReadOnly,
      isRequired: widget.isRequired,
      validator: widget.validator,
      onSaved: widget.onSaved,
      onSubmitted: widget.onSubmitted,
    );
  }

  Widget _buildDateCalendar(BuildContext context, Widget? child) {
    return Theme(
      data: Theme.of(context).copyWith(
        appBarTheme: Theme.of(context).appBarTheme.copyWith(
          /*backgroundColor: Theme.of(context).primaryColor,
          iconTheme: const IconThemeData(
            color: custom_colors.white,
          ),
          actionsIconTheme: const IconThemeData(
            color: custom_colors.white,
          ),*/
        ),
      ),
      child: child ?? const SizedBox.shrink(),
    );
  }

  InputDecoration _inputDecoration(BuildContext context) {
    return InputDecoration(
      suffixIcon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.date_range,
            size: 20.0,
          ),
          if (widget.isReset)
            GestureDetector(
              onTap: () {
                //clear value
                widget.controller.clear();
                if (widget.onDateSelected != null) {
                  widget.onDateSelected!('');
                }
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: Icon(
                  Icons.clear,
                  size: 20.0,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
