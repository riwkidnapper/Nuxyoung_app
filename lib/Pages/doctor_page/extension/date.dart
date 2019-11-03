import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show TextInputFormatter;
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart' show DateFormat;

import 'date_picker.dart';

/// A [FormField<DateTime>] that integrates a text input with time-chooser UIs.
///
/// It borrows many of it's parameters from [TextFormField].
///
/// When a [controller] is specified, [initialValue] must be null (the
/// default).
class DateTimeField extends FormField<DateTime> {
  DateTimeField({
    @required this.format,
    @required this.onShowPicker,

    // From super
    Key key,
    FormFieldSetter<DateTime> onSaved,
    FormFieldValidator<DateTime> validator,
    DateTime initialValue,
    bool autovalidate = false,
    bool enabled = true,

    // Features
    this.resetIcon = const Icon(Icons.close),
    this.onChanged,

    // From TextFormField
    // Key key,
    this.controller,
    // String initialValue,
    this.focusNode,
    InputDecoration decoration = const InputDecoration(),
    TextInputType keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    TextInputAction textInputAction,
    TextStyle style,
    StrutStyle strutStyle,
    TextDirection textDirection,
    TextAlign textAlign = TextAlign.start,
    bool autofocus = false,
    this.readOnly = false,
    bool showCursor,
    bool obscureText = false,
    bool autocorrect = true,
    // bool autovalidate = false,
    bool maxLengthEnforced = true,
    int maxLines = 1,
    int minLines,
    bool expands = false,
    int maxLength,
    VoidCallback onEditingComplete,
    ValueChanged<DateTime> onFieldSubmitted,
    // FormFieldSetter<String> onSaved,
    // FormFieldValidator<String> validator,
    List<TextInputFormatter> inputFormatters,
    // bool enabled = true,
    double cursorWidth = 2.0,
    Radius cursorRadius,
    Color cursorColor,
    Brightness keyboardAppearance,
    EdgeInsets scrollPadding = const EdgeInsets.all(20.0),
    bool enableInteractiveSelection = true,
    InputCounterWidgetBuilder buildCounter,
  }) : super(
            key: key,
            autovalidate: autovalidate,
            initialValue: initialValue,
            enabled: enabled ?? true,
            validator: validator,
            onSaved: onSaved,
            builder: (field) {
              final _DateTimeFieldState state = field;
              final InputDecoration effectiveDecoration = (decoration ??
                      const InputDecoration())
                  .applyDefaults(Theme.of(field.context).inputDecorationTheme);
              return TextField(
                controller: state._effectiveController,
                focusNode: state._effectiveFocusNode,
                decoration: effectiveDecoration.copyWith(
                  errorText: field.errorText,
                  suffixIcon: state.shouldShowClearIcon(effectiveDecoration)
                      ? IconButton(
                          icon: resetIcon,
                          onPressed: state.clear,
                        )
                      : null,
                ),
                keyboardType: keyboardType,
                textInputAction: textInputAction,
                style: style,
                strutStyle: strutStyle,
                textAlign: textAlign,
                textDirection: textDirection,
                textCapitalization: textCapitalization,
                autofocus: autofocus,
                readOnly: readOnly,
                showCursor: showCursor,
                obscureText: obscureText,
                autocorrect: autocorrect,
                maxLengthEnforced: maxLengthEnforced,
                maxLines: maxLines,
                minLines: minLines,
                expands: expands,
                maxLength: maxLength,
                onChanged: (string) =>
                    field.didChange(tryParse(string, format)),
                onEditingComplete: onEditingComplete,
                onSubmitted: (string) => onFieldSubmitted == null
                    ? null
                    : onFieldSubmitted(tryParse(string, format)),
                inputFormatters: inputFormatters,
                enabled: enabled,
                cursorWidth: cursorWidth,
                cursorRadius: cursorRadius,
                cursorColor: cursorColor,
                scrollPadding: scrollPadding,
                keyboardAppearance: keyboardAppearance,
                enableInteractiveSelection: enableInteractiveSelection,
                buildCounter: buildCounter,
              );
            });

  /// For representing the date as a string e.g.
  /// `DateFormat("EEEE, MMMM d, yyyy 'at' h:mma")`
  /// (Sunday, June 3, 2018 at 9:24pm)
  final DateFormat format;

  /// Called when the date chooser dialog should be shown.
  final Future<DateTime> Function(BuildContext context, DateTime currentValue)
      onShowPicker;

  /// The [InputDecoration.suffixIcon] to show when the field has text. Tapping
  /// the icon will clear the text field. Set this to `null` to disable that
  /// behavior. Also, setting the suffix icon yourself will override this option.
  final Icon resetIcon;

  final TextEditingController controller;
  final FocusNode focusNode;
  final bool readOnly;
  final void Function(DateTime value) onChanged;

  @override
  _DateTimeFieldState createState() => _DateTimeFieldState();

  /// Returns an empty string if [DateFormat.format()] throws or [date] is null.
  static String tryFormat(DateTime date, DateFormat format) {
    if (date != null) {
      try {
        return format.format(date);
      } catch (e) {
        // print('Error formatting date: $e');
      }
    }
    return '';
  }

  /// Returns null if [format.parse()] throws.
  static DateTime tryParse(String string, DateFormat format) {
    if (string?.isNotEmpty ?? false) {
      try {
        return format.parse(string);
      } catch (e) {
        // print('Error parsing date: $e');
      }
    }
    return null;
  }

  /// Sets the hour and minute of a [DateTime] from a [TimeOfDay].
  static DateTime combine(DateTime date, TimeOfDay time) => DateTime(
      date.year, date.month, date.day, time?.hour ?? 0, time?.minute ?? 0);

  static DateTime convert(TimeOfDay time) =>
      DateTime(1, 1, 1, time?.hour ?? 0, time?.minute ?? 0);
}

class _DateTimeFieldState extends FormFieldState<DateTime> {
  TextEditingController _controller;
  FocusNode _focusNode;
  bool isShowingDialog = false;
  bool hadFocus = false;

  @override
  DateTimeField get widget => super.widget;

  TextEditingController get _effectiveController =>
      widget.controller ?? _controller;
  FocusNode get _effectiveFocusNode => widget.focusNode ?? _focusNode;

  bool get hasFocus => _effectiveFocusNode.hasFocus;
  bool get hasText => _effectiveController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController(text: format(widget.initialValue));
      _controller.addListener(_handleControllerChanged);
    }
    if (widget.focusNode == null) {
      _focusNode = FocusNode();
      _focusNode.addListener(_handleFocusChanged);
    }
    widget.controller?.addListener(_handleControllerChanged);
    widget.focusNode?.addListener(_handleFocusChanged);
  }

  @override
  void didUpdateWidget(DateTimeField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      widget.controller?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null && widget.controller == null) {
        _controller =
            TextEditingController.fromValue(oldWidget.controller.value);
        _controller.addListener(_handleControllerChanged);
      }
      if (widget.controller != null) {
        setValue(parse(widget.controller.text));
        // Release the controller since it wont be used
        if (oldWidget.controller == null) {
          _controller?.dispose();
          _controller = null;
        }
      }
    }
    if (widget.focusNode != oldWidget.focusNode) {
      oldWidget.focusNode?.removeListener(_handleFocusChanged);
      widget.focusNode?.addListener(_handleFocusChanged);

      if (oldWidget.focusNode != null && widget.focusNode == null) {
        _focusNode = FocusNode();
        _focusNode.addListener(_handleFocusChanged);
      }
      if (widget.focusNode != null && oldWidget.focusNode == null) {
        // Release the focus node since it wont be used
        _focusNode?.dispose();
        _focusNode = null;
      }
    }
  }

  @override
  void didChange(DateTime value) {
    if (widget.onChanged != null) widget.onChanged(value);
    super.didChange(value);
  }

  @override
  void dispose() {
    _controller?.dispose();
    _focusNode?.dispose();
    widget.controller?.removeListener(_handleControllerChanged);
    widget.focusNode?.removeListener(_handleFocusChanged);
    super.dispose();
  }

  @override
  void reset() {
    super.reset();
    _effectiveController.text = format(widget.initialValue);
    didChange(widget.initialValue);
  }

  void _handleControllerChanged() {
    // Suppress changes that originated from within this class.
    //
    // In the case where a controller has been passed in to this widget, we
    // register this change listener. In these cases, we'll also receive change
    // notifications for changes originating from within this class -- for
    // example, the reset() method. In such cases, the FormField value will
    // already have been set.
    if (_effectiveController.text != format(value))
      didChange(parse(_effectiveController.text));
  }

  String format(DateTime date) => DateTimeField.tryFormat(date, widget.format);
  DateTime parse(String text) => DateTimeField.tryParse(text, widget.format);

  Future<void> requestUpdate() async {
    if (!isShowingDialog) {
      isShowingDialog = true;
      final newValue = await widget.onShowPicker(context, value);
      isShowingDialog = false;
      if (newValue != null) {
        _effectiveController.text =
            format(DateTime(newValue.year + 543, newValue.month, newValue.day));
      }
    }
  }

  void _handleFocusChanged() {
    if (hasFocus && !hadFocus && (!hasText || widget.readOnly)) {
      hadFocus = hasFocus;
      _hideKeyboard();
      requestUpdate();
    } else {
      hadFocus = hasFocus;
    }
  }

  void _hideKeyboard() {
    Future.microtask(() => FocusScope.of(context).requestFocus(FocusNode()));
  }

  void clear() async {
    _hideKeyboard();
    // Fix for ripple effect throwing exception
    // and the field staying gray.
    // https://github.com/flutter/flutter/issues/36324
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _effectiveController.clear());
    });
  }

  bool shouldShowClearIcon([InputDecoration decoration]) =>
      widget.resetIcon != null &&
      (hasText || hasFocus) &&
      decoration?.suffixIcon == null;
}

enum InputTypedate { date, time, both }

class DateTimePicker extends StatefulWidget {
  final String attribute;
  final List<FormFieldValidator> validators;
  final DateTime initialValue;
  final bool readOnly;
  final InputDecoration decoration;
  final ValueTransformer valueTransformer;

  /// The date/time picker dialogs to show.
  final InputTypedate inputType;

  /// Allow manual editing of the date/time. Defaults to true. If false, the
  /// picker(s) will be shown every time the field gains focus.
  // final bool editable;

  /// For representing the date as a string e.g.
  /// `DateFormat("EEEE, MMMM d, yyyy 'at' h:mma")`
  /// (Sunday, June 3, 2018 at 9:24pm)
  final DateFormat format;

  /// The date the calendar opens to when displayed. Defaults to the current date.
  ///
  /// To preset the widget's value, use [initialValue] instead.
  @Deprecated(
      "This field will be removed in version 4.0.0. Selected date or Current date will be used on DatePicker calendar instead")
  final DateTime initialDate;

  /// The earliest choosable date. Defaults to 1900.
  final DateTime firstDate;

  /// The latest choosable date. Defaults to 2100.
  final DateTime lastDate;

  /// The initial time prefilled in the picker dialog when it is shown. Defaults
  /// to noon. Explicitly set this to `null` to use the current time.
  @Deprecated(
      "This field will be removed in the next major version. Selected time or noon will be used on TimePicker instead")
  final TimeOfDay initialTime;

  /// If defined, the TextField [decoration]'s [suffixIcon] will be
  /// overridden to reset the input using the icon defined here.
  /// Set this to `null` to stop that behavior. Defaults to [Icons.close].
  final Icon resetIcon;

  /// For validating the [DateTime]. The value passed will be `null` if
  /// [format] fails to parse the text.
  final FormFieldValidator<DateTime> validator;

  /// Called when an enclosing form is saved. The value passed will be `null`
  /// if [format] fails to parse the text.
  final FormFieldSetter<DateTime> onSaved;

  /// Corresponds to the [showDatePicker()] parameter. Defaults to
  /// [DatePickerMode.day].
  final DatePickerMode initialDatePickerMode;

  /// Corresponds to the [showDatePicker()] parameter.
  ///
  /// See [GlobalMaterialLocalizations](https://docs.flutter.io/flutter/flutter_localizations/GlobalMaterialLocalizations-class.html)
  /// for acceptable values.
  final Locale locale;

  /// Corresponds to the [showDatePicker()] parameter.
  final bool Function(DateTime) selectableDayPredicate;

  /// Corresponds to the [showDatePicker()] parameter.
  final ui.TextDirection textDirection;

  /// Called when an enclosing form is submitted. The value passed will be
  /// `null` if [format] fails to parse the text.
  final ValueChanged<DateTime> onFieldSubmitted;
  final TextEditingController controller;
  final FocusNode focusNode;
  final TextInputType keyboardType;
  final TextStyle style;
  final TextAlign textAlign;

  /// Preset the widget's value.
  final bool autofocus;
  final bool autovalidate;
  final bool obscureText;
  final bool autocorrect;
  final bool maxLengthEnforced;
  final int maxLines;
  final int maxLength;
  final List<TextInputFormatter> inputFormatters;
  final bool enabled;
  final TransitionBuilder builder;

  /// Called when the time chooser dialog should be shown. In the future the
  /// preferred way of using this widget will be to utilize the [datePicker] and
  /// [timePicker] callback functions instead of adding their parameter list to
  /// this widget.
  final Future<TimeOfDay> Function(BuildContext context) timePicker;

  /// Called when the date chooser dialog should be shown. In the future the
  /// preferred way of using this widget will be to utilize the [datePicker] and
  /// [timePicker] callback functions instead of adding their parameter list to
  /// this widget.
  final Future<DateTime> Function(BuildContext context) datePicker;

  /// Called whenever the state's value changes, e.g. after picker value(s)
  /// have been selected or when the field loses focus. To listen for all text
  /// changes, use the [controller] and [focusNode].
  final ValueChanged<DateTime> onChanged;

  final bool showCursor;

  final int minLines;

  final bool expands;

  final TextInputAction textInputAction;

  final VoidCallback onEditingComplete;

  final InputCounterWidgetBuilder buildCounter;

  // final VoidCallback onEditingComplete,
  final Radius cursorRadius;
  final Color cursorColor;
  final Brightness keyboardAppearance;
  final EdgeInsets scrollPadding;
  final bool enableInteractiveSelection;

  final double cursorWidth;
  final TextCapitalization textCapitalization;

  DateTimePicker({
    @required this.attribute,
    this.validators = const [],
    this.readOnly = false,
    this.inputType = InputTypedate.both,
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.cursorWidth = 2.0,
    this.enableInteractiveSelection = true,
    this.decoration = const InputDecoration(),
    this.resetIcon = const Icon(Icons.close),
    this.initialTime = const TimeOfDay(hour: 12, minute: 0),
    this.keyboardType = TextInputType.text,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.obscureText = false,
    this.autocorrect = true,
    this.maxLines = 1,
    this.maxLengthEnforced = true,
    this.expands = false,
    this.autovalidate = false,
    // this.editable = true,
    this.initialValue,
    this.format,
    this.firstDate,
    this.lastDate,
    this.onChanged,
    this.initialDate,
    this.validator,
    this.onSaved,
    this.onFieldSubmitted,
    this.initialDatePickerMode,
    this.locale,
    this.selectableDayPredicate,
    this.textDirection,
    this.controller,
    this.focusNode,
    this.style,
    this.enabled,
    this.maxLength,
    this.inputFormatters,
    this.valueTransformer,
    this.builder,
    this.timePicker,
    this.datePicker,
    this.showCursor,
    this.minLines,
    this.textInputAction,
    this.onEditingComplete,
    this.buildCounter,
    this.cursorRadius,
    this.cursorColor,
    this.keyboardAppearance,
    this.textCapitalization = TextCapitalization.none,
    this.strutStyle,
  });

  final StrutStyle strutStyle;

  @override
  _DateTimePickerState createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  bool _readOnly = false;
  final GlobalKey<FormFieldState> _fieldKey = GlobalKey<FormFieldState>();
  FormBuilderState _formState;
  DateTime _initialValue;
  FocusNode _focusNode;
  TextEditingController _textFieldController;
  DateTime stateCurrentValue;

  final _dateTimeFormats = {
    InputTypedate.both: DateFormat("EEEE, MMMM d, yyyy 'at' h:mma"),
    InputTypedate.date: DateFormat('dd-MM-yyyy'),
    InputTypedate.time: DateFormat("HH:mm"),
  };

  @override
  void initState() {
    super.initState();
    _formState = FormBuilder.of(context);
    _formState?.registerFieldKey(widget.attribute, _fieldKey);
    _initialValue = widget.initialValue ??
        (_formState.initialValue.containsKey(widget.attribute)
            ? _formState.initialValue[widget.attribute]
            : null);
    stateCurrentValue = _initialValue;
    _readOnly = (_formState?.readOnly == true) ? true : widget.readOnly;
    _focusNode = widget.focusNode ?? FocusNode();
    _textFieldController = widget.controller ?? TextEditingController();

    _textFieldController.text = _initialValue == null
        ? ''
        : widget.format == null
            ? DateFormat("EEEE, MMMM d, yyyy 'at' h:mma").format(_initialValue)
            : widget.format.format(_initialValue);
    _focusNode.addListener(_handleFocus);
  }

  // Hack to avoid manual editing of date - as is in DateTimeField library
  _handleFocus() async {
    setState(() {
      stateCurrentValue = _fieldKey.currentState.value;
    });
    if (_focusNode.hasFocus) {
      _textFieldController.clear();
    }
  }

  @override
  void dispose() {
    _formState?.unregisterFieldKey(widget.attribute);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        primaryColor: Color(0xFF607D8B), //color of the main banner
        accentColor:
            Color(0xFF607D8B), //color of circle indicating the selected date
        buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme
                .accent //color of the text in the button "OK/CANCEL"
            ),
      ),
      child: DateTimeField(
        key: _fieldKey,
        initialValue: _initialValue,
        format: widget.format != null
            ? widget.format
            : _dateTimeFormats[widget.inputType],
        onSaved: (val) {
          if (widget.valueTransformer != null) {
            var transformed = widget.valueTransformer(val);
            _formState?.setAttributeValue(widget.attribute, transformed);
          } else {
            _formState?.setAttributeValue(widget.attribute, val);
          }
        },
        validator: (val) {
          for (int i = 0; i < widget.validators.length; i++) {
            if (widget.validators[i](val) != null)
              return widget.validators[i](val);
          }
          return null;
        },
        onShowPicker: _onShowPicker,
        onChanged: widget.onChanged,
        autovalidate: widget.autovalidate,
        resetIcon: widget.resetIcon,
        textDirection: widget.textDirection,
        textAlign: widget.textAlign,
        maxLength: widget.maxLength,
        autofocus: widget.autofocus,
        decoration: widget.decoration,
        enabled: widget.enabled,
        autocorrect: widget.autocorrect,
        readOnly: _readOnly,
        controller: _textFieldController,
        focusNode: _focusNode,
        inputFormatters: widget.inputFormatters,
        keyboardType: widget.keyboardType,
        maxLengthEnforced: widget.maxLengthEnforced,
        maxLines: widget.maxLines,
        obscureText: widget.obscureText,
        showCursor: widget.showCursor,
        minLines: widget.minLines,
        expands: widget.expands,
        style: widget.style,
        onEditingComplete: widget.onEditingComplete,
        buildCounter: widget.buildCounter,
        cursorColor: widget.cursorColor,
        cursorRadius: widget.cursorRadius,
        cursorWidth: widget.cursorWidth,
        enableInteractiveSelection: widget.enableInteractiveSelection,
        keyboardAppearance: widget.keyboardAppearance,
        onFieldSubmitted: widget.onFieldSubmitted,
        scrollPadding: widget.scrollPadding,
        strutStyle: widget.strutStyle,
        textCapitalization: widget.textCapitalization,
        textInputAction: widget.textInputAction,
      ),
    );
  }

  Future<DateTime> _onShowPicker(
      BuildContext context, DateTime currentValue) async {
    currentValue = stateCurrentValue;
    switch (widget.inputType) {
      case InputTypedate.date:
        return await _showDatePicker(context, currentValue) ?? currentValue;
      case InputTypedate.time:
        return DateTimeField.convert(
            await _showTimePicker(context, currentValue) ??
                TimeOfDay.fromDateTime(currentValue));
      case InputTypedate.both:
        final date = await _showDatePicker(context, currentValue);
        if (date != null) {
          final time = await _showTimePicker(context, currentValue);
          return DateTimeField.combine(date, time);
        }
        return _fieldKey.currentState.value ?? currentValue;
      default:
        throw "Unexcepted input type ${widget.inputType}";
    }
  }

  Future<DateTime> _showDatePicker(
      BuildContext context, DateTime currentValue) {
    if (widget.datePicker != null) {
      return widget.datePicker(context);
    } else {
      return showCustomDatePicker(
          context: context,
          locale: Locale("th", "TH"),
          selectableDayPredicate: widget.selectableDayPredicate,
          initialDatePickerMode:
              widget.initialDatePickerMode ?? DatePickerMode.day,
          // ignore: deprecated_member_use_from_same_package
          initialDate: currentValue != null ? DateTime(currentValue.year - 543, currentValue.month, currentValue.day) : (widget.initialDate ?? DateTime.now()),
          firstDate: widget.firstDate ?? DateTime(1900),
          lastDate: widget.lastDate ?? DateTime(2700));
    }
  }

  Future<TimeOfDay> _showTimePicker(
      BuildContext context, DateTime currentValue) {
    if (widget.timePicker != null) {
      return widget.timePicker(context);
    } else {
      return showTimePicker(
          context: context,
          // ignore: deprecated_member_use_from_same_package
          initialTime: widget.initialTime ??
              TimeOfDay.fromDateTime(currentValue ?? DateTime.now()));
    }
  }
}
