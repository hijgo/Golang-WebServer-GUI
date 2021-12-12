import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gui/Resources/layout.dart';
import 'package:gui/Resources/prop.dart';


class CustomTextField extends StatefulWidget {
  final TextEditingController? textEdit;
  final TextInputType? type;
  final double? percentage;
  final double? min;
  final bool isChecked;
  final bool? isLimted;
  final double? height;
  final double? minus;
  final bool? stretch;
  final IconData? icon;
  final int? limit;
  final VoidCallback? onTouch;
  final bool tall;
  final bool? changeable;
  final bool? maxCharacters;
  final String? lable;
  const CustomTextField(
      {Key? key, this.textEdit,
      this.percentage,
      this.min,
      this.icon,
      this.lable,
      required this.isChecked,
      required this.tall,
      this.type,
      this.changeable,
      this.stretch,
      this.limit,
      this.onTouch,
      this.height, this.maxCharacters, this.isLimted, this.minus}) : super(key: key);
  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  Color? color;
  TextInputType? type;
  double? height;
  double? min;
  bool? changleable;
  bool? strectch;
  int? limit;
  IconData? icon;
  bool? isSLimted;

  @override
  void initState() {
    widget.tall ? type = TextInputType.multiline : type = TextInputType.text;
    widget.tall ? height = widget.height : height = 60;
    widget.min != null ? min = widget.min : min = null;
    widget.stretch != null ? strectch = widget.stretch : strectch = false;
    widget.changeable != null? changleable = widget.changeable: changleable = true;
    widget.limit != null ? limit = widget.limit : limit = null;
    widget.icon != null ? icon = widget.icon : icon = Icons.comment;
    widget.isLimted !=null? isSLimted = widget.isLimted: isSLimted = false;
    super.initState();
  }


  double? getOvervallWidth(){
    if(!strectch!){
      return(Layout(context: context).customTileWidth(widget.percentage,min) - (widget.minus != null?widget.minus!:0)) ;
    }else{
      return null;
    }
  }

  EdgeInsets getPadding(){
    if(!strectch!){
      return const EdgeInsets.all(0);
    }else{
      return const EdgeInsets.fromLTRB(0, 0, 5, 10);
    }
  }

  @override
  Widget build(BuildContext context) {
    widget.isChecked ? color = Colors.grey[300] : color = Colors.red[300];
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 8, 5),
      child: RawMaterialButton(
    onPressed: widget.onTouch,
    child: Container(
      color: color,
      height: height,
      width: getOvervallWidth(),
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 20, 0),
          child: Icon(
            icon,
            color: Colors.black,
          ),
        ),
        Expanded(
          child: SizedBox(
            height: height,
            child: Padding(
              padding: getPadding(),
              child: TextField(
              maxLength: isSLimted!?null:limit,
                onChanged: (text) {},
                inputFormatters: isSLimted!?[LengthLimitingTextInputFormatter(limit)]:null,
                maxLines: null,
                enabled: changleable,
                keyboardType: type,
                controller: widget.textEdit,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                  labelText: widget.lable,
                  labelStyle: TextStyle(color: Prop().customTheme.data.colorScheme.primary,fontSize: 15)
                ),
              ),
            ),
          ),
        ),
      ]),
    ),
      ),
    );
  }
}
