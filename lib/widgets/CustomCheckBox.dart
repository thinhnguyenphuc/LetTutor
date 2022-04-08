import 'package:flutter/material.dart';

class TextCheckbox extends StatefulWidget {
  final bool defaultCheckboxValue;
  final MaterialStateProperty<Color>? fillColor;
  final String text;
  final TextStyle textStyle;

  const TextCheckbox({
    Key? key,
    this.defaultCheckboxValue = false,
    this.fillColor,
    this.text = "",
    this.textStyle = const TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TextCheckboxState();
  }
}

class _TextCheckboxState extends State<TextCheckbox> {
  late bool _isChecked;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.defaultCheckboxValue;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
        color: Colors.transparent,
        child: Row(children: <Widget>[
          Checkbox(
            checkColor: Colors.blue,
            fillColor:
                widget.fillColor ?? MaterialStateProperty.resolveWith(getColor),
            value: _isChecked,
            onChanged: (bool? value) {
              setState(() {
                _isChecked = value!;
              });
            },
          ),
          Text(
            widget.text,
            textAlign: TextAlign.center,
            style: widget.textStyle,
          )
        ]));
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.white;
    }
    return Colors.white;
  }
}
