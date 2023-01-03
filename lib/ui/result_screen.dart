import 'package:bmi_calculater/bloc/bmi_cubit.dart';
import 'package:bmi_calculater/contans/color_file.dart';
import 'package:bmi_calculater/model/calucalator_model.dart';
import 'package:bmi_calculater/model/model_database.dart';
import 'package:bmi_calculater/widget/card_widget.dart';
import 'package:bmi_calculater/widget/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultScreen extends StatefulWidget {
  ResultScreen({Key? key, required this.dataBaseModel, this.calculatorModel})
      : super(key: key);
  DataBaseModel dataBaseModel;
  CalculatorModel? calculatorModel;

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BMI Calculater',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).backgroundColor,
      ),
      backgroundColor: backGroundColor,
      body: BlocConsumer<BmiCubit, BmiState>(
        listener: (context, state) => state is CreateState,
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 30),
            child: widget.calculatorModel == null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'Hi Mr. ${widget.dataBaseModel.name}',
                        fontSize: 30,
                      ),
                      Expanded(
                        flex: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: MyCardWidget(
                              child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextWidget(
                                    text:'Your AGE : ${widget.dataBaseModel.age} years old.',
                                    fontSize: 20),

                                TextWidget(
                                    text:
                                        widget.dataBaseModel.type.toUpperCase(),
                                    fontSize: 20),
                                TextWidget(
                                  text: widget.dataBaseModel.result
                                      .floor()
                                      .toString(),
                                  fontSize: 50,
                                ),
                                TextWidget(
                                    text:
                                        '${widget.dataBaseModel.type} BMI range:',
                                    color: inActiveColor),
                                TextWidget(
                                    text: widget.dataBaseModel.category,
                                    fontSize: 20),
                                TextWidget(
                                    text:
                                        'You have a ${widget.dataBaseModel.type} body weight. ',
                                    fontSize: 30),
                              ],
                            ),
                          )),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: TextWidget(text: 'RE-CALCULATOR'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              minimumSize: Size(double.infinity, 0)),
                        ),
                      )
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: 'Your Result',
                        fontSize: 30,
                      ),
                      Expanded(
                        flex: 8,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: MyCardWidget(
                              child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextWidget(
                                    text:
                                        widget.dataBaseModel.type.toUpperCase(),
                                    color: widget.calculatorModel!.color,
                                    fontSize: 20),
                                TextWidget(
                                  text: widget.calculatorModel!.result
                                      .floor()
                                      .toString(),
                                  fontSize: 50,
                                ),
                                TextWidget(
                                    text:
                                        '${widget.dataBaseModel.type} BMI range:',
                                    color: inActiveColor),
                                TextWidget(
                                    text: widget.calculatorModel!.status!,
                                    fontSize: 20),
                                TextWidget(
                                    text:
                                        'You have a ${widget.dataBaseModel.type} body weight. ',
                                    fontSize: 30),
                                ElevatedButton(
                                  onPressed: () async {
                                    BmiCubit.get(context)
                                        .create(widget.dataBaseModel);
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: backGroundCardColor,
                                      minimumSize: Size(double.infinity, 60)),
                                  child: TextWidget(text: 'Save result'),
                                )
                              ],
                            ),
                          )),
                        ),
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: TextWidget(text: 'RE-CALCULATOR'),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: primaryColor,
                              minimumSize: Size(double.infinity, 0)),
                        ),
                      )
                    ],
                  ),
          );
        },
      ),
    );
  }
}
