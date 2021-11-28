import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gui/Resources/prop.dart';
import 'package:i18n_plus/i18nText.dart';

class ProgressIndicator extends StatefulWidget {
  final List<ProgressStep> steps; 
  final int currentStep;
  const ProgressIndicator(this.steps, this.currentStep,{Key? key}) : super(key: key);

  @override
  _ProgressIndicatorState createState() => _ProgressIndicatorState();
}

class _ProgressIndicatorState extends State<ProgressIndicator> {

  List<Widget> generateHelperWidgets(List<ProgressStep> steps,int? currentStep){
    List<Widget> widgets = [];
    for(int step = 0; step < steps.length; step++){
      if(step < currentStep!){
        widgets.add(Padding(
          padding: step == currentStep-1? const EdgeInsets.all(0):const EdgeInsets.fromLTRB(0, 8, 0, 0),
          child: Column(
                children: [
                  SizedBox(
                  child: Icon(steps[step].icon,color: Prop().customTheme.data.colorScheme.secondary,size: step == currentStep-1? 24:20),
                  ),
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: I18NText(
                            i18nKey: steps[step].title,
                            style: TextStyle(
                              fontSize: step == currentStep-1? 16:12,
                              fontWeight: FontWeight.bold,
                              color: Prop()
                                  .customTheme
                                  .data
                                  .colorScheme
                                  .secondary,
                            ),
                        ),
                      ),
                  )
                ]
              ),
        ),
        );
      }else{
       widgets.add(Padding(
            padding: const EdgeInsets.fromLTRB(0, 8, 0, 0),
            child: Column(
              children: [
                Icon(steps[step].icon,color: Colors.black,size: 20,),
                Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: I18NText(
                        i18nKey: steps[step].title,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                ),
              ]
            ),
        ));
      }
      widgets.add(
        Expanded(
          child: Container(
            height: 3.5,
            color: step < currentStep-1?Prop().customTheme.data.colorScheme.secondary:Colors.grey[300],
          ),
        )
      );
    }
    
    return widgets.getRange(0, widgets.length-1).toList();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
        child: SizedBox(
          child: Row(
            children: generateHelperWidgets(widget.steps, widget.currentStep),
          )
        ),
      )
    );
  }
}

class ProgressStep{
  String? title;
  IconData? icon;
  ProgressStep(this.title,this.icon);
}