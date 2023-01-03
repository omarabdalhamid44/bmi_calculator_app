import 'package:bmi_calculater/bloc/bmi_cubit.dart';
import 'package:bmi_calculater/contans/color_file.dart';
import 'package:bmi_calculater/model/calucalator_model.dart';
import 'package:bmi_calculater/model/model_database.dart';
import 'package:bmi_calculater/ui/result_screen.dart';
import 'package:bmi_calculater/widget/card_widget.dart';
import 'package:bmi_calculater/widget/text_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class CalculaterScreen extends StatefulWidget {
  const CalculaterScreen({Key? key}) : super(key: key);

  @override
  State<CalculaterScreen> createState() => _CalculaterScreenState();
}

class _CalculaterScreenState extends State<CalculaterScreen> {
  late TextEditingController textEditingController;
  late ScrollController scrollController;
  late FocusNode focusNode;

  @override
  void initState() {
    // TODO: implement initState
    textEditingController = TextEditingController();
    scrollController = ScrollController();
    focusNode = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BmiCubit, BmiState>(
      listener: (context, state) {
        state is ListState;
        state is AgeState;
        state is HeightState;
        state is WeightState;
        state is GenderState;
      },
      buildWhen: (previous, current) =>
          current is ListState ||
          current is AgeState ||
          current is HeightState ||
          current is WeightState ||
          current is GenderState,
      builder: (context, state) {
        var cubit = BlocProvider.of<BmiCubit>(context);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          backgroundColor: Theme.of(context).backgroundColor,
          drawer: Drawer(
              backgroundColor: primaryColor,
              child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Column(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Align(
                          alignment: Alignment.topCenter,
                          child: TextWidget(
                              text:
                                  'No. Of User Calculator is ${cubit.listRead.length}'),
                        ),
                        cubit.listRead.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                  itemCount: cubit.listRead.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ResultScreen(
                                                      dataBaseModel: cubit
                                                          .listRead[index]),
                                            ));
                                      },
                                      title: TextWidget(
                                          text: cubit.listRead[index].name),
                                      subtitle: TextWidget(
                                          text: cubit.listRead[index].type),
                                      trailing: IconButton(
                                          onPressed: () {
                                            BlocProvider.of<BmiCubit>(context)
                                                .delete(index);
                                          },
                                          icon: Icon(Icons.delete)),
                                    );
                                  },
                                ),
                              )
                            : Expanded(
                                child: Center(
                                    child: TextWidget(
                                        text: 'Start first calculator .. ')),
                              )
                      ]))),
          appBar: AppBar(
            title: Text(
              'BMI Calculater',
              style: TextStyle(color: Colors.white),
            ),
            centerTitle: true,
            // elevation: 0,
            backgroundColor: Theme.of(context).backgroundColor,
          ),
          body: LayoutBuilder(
            builder: (p0, p1) {
              return ListView(
                padding: EdgeInsets.only(top: p1.maxHeight * 0.011),
                controller: scrollController,
                physics: BouncingScrollPhysics(),
                children: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: p1.maxHeight * 0.01),
                    height: p1.maxHeight * 0.10,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                          color: Colors.white54,
                          blurRadius: 60,
                          offset: Offset(0, -40))
                    ]),
                    child: TextField(
                      controller: textEditingController,
                      cursorColor: primaryColor,
                      focusNode: focusNode,
                      dragStartBehavior: DragStartBehavior.down,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          hintText: 'Enter Your name .. ',
                          hintStyle: TextStyle(color: inActiveColor),
                          filled: true,
                          fillColor: backGroundColor,
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none)),
                    ),
                  ),
                  SizedBox(
                    height: p1.maxHeight * 0.20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: InkWell(
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              cubit.changeGender(gender.male.toString());
                            },
                            child: MyCardWidget(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.male,
                                    size: 60,
                                    color: cubit.genderSelected ==
                                            gender.male.toString()
                                        ? activeColor
                                        : inActiveColor,
                                  ),
                                  TextWidget(
                                    text: 'Male',
                                    fontSize: 25,
                                    color: cubit.genderSelected ==
                                            gender.male.toString()
                                        ? activeColor
                                        : inActiveColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: InkWell(
                            splashColor: Colors.transparent,
                            hoverColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            onTap: () {
                              setState(() {
                                cubit.changeGender(gender.female.toString());
                              });
                            },
                            child: MyCardWidget(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.female,
                                    size: 60,
                                    color: cubit.genderSelected ==
                                            gender.female.toString()
                                        ? activeColor
                                        : inActiveColor,
                                  ),
                                  TextWidget(
                                    text: 'FE-MALE',
                                    fontSize: 25,
                                    color: cubit.genderSelected ==
                                            gender.female.toString()
                                        ? activeColor
                                        : inActiveColor,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: p1.maxHeight * 0.01,
                  ),
                  MyCardWidget(
                      height: p1.maxHeight * 0.25,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextWidget(
                            text: 'HEIGHT',
                            fontSize: 15,
                            color: inActiveColor,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              TextWidget(text: '${cubit.height}', fontSize: 40),
                              TextWidget(text: ' cm', color: inActiveColor),
                            ],
                          ),
                          SliderTheme(
                            data: SliderThemeData(
                                activeTrackColor: activeColor,
                                inactiveTrackColor: inActiveColor,
                                overlayColor: primaryColor.withOpacity(0.12),
                                thumbColor: primaryColor),
                            child: Slider(
                                max: 200,
                                min: 120,
                                value: cubit.height.toDouble(),
                                onChanged: (value) {
                                  cubit.changeHeight(value.round());
                                }),
                          )
                        ],
                      )),
                  SizedBox(
                    height: p1.maxHeight * 0.01,
                  ),
                  SizedBox(
                    height: p1.maxHeight * 0.30,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: MyCardWidget(
                            height: 250,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextWidget(
                                    text: 'WEIGHT',
                                    fontSize: 15,
                                    color: inActiveColor),
                                TextWidget(
                                  text: '${cubit.weight}',
                                  fontSize: 55,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        cubit.changeWeight('-');
                                      },
                                      child: Icon(
                                        Icons.minimize,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(),
                                          minimumSize: Size(50, 50),
                                          elevation: 0,
                                          backgroundColor: backGroundCardColor
                                              .withOpacity(0.5)),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        cubit.changeWeight('+');
                                      },
                                      child: Icon(Icons.add),
                                      style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(),
                                          minimumSize: Size(50, 50),
                                          elevation: 0,
                                          backgroundColor: backGroundCardColor
                                              .withOpacity(0.5)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: MyCardWidget(
                            height: 250,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                TextWidget(
                                  text: 'AGE',
                                  fontSize: 20,
                                  color: inActiveColor,
                                ),
                                TextWidget(
                                  text: '${cubit.age}',
                                  fontSize: 50,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        cubit.changeAge('-');
                                      },
                                      child: Icon(
                                        Icons.minimize,
                                      ),
                                      style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(),
                                          minimumSize: Size(50, 50),
                                          elevation: 0,
                                          backgroundColor: backGroundCardColor
                                              .withOpacity(0.5)),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        cubit.changeAge('+');
                                      },
                                      child: Icon(Icons.add),
                                      style: ElevatedButton.styleFrom(
                                          shape: CircleBorder(),
                                          minimumSize: Size(50, 50),
                                          elevation: 0,
                                          backgroundColor: backGroundCardColor
                                              .withOpacity(0.5)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: p1.maxHeight * 0.025,
                  ),
                  SizedBox(
                    height: p1.maxHeight * 0.084,
                    child: ElevatedButton(
                      onPressed: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ResultScreen(
                                  dataBaseModel: dataBaseModel,
                                  calculatorModel: calculatorModel),
                            ));
                      },
                      child: TextWidget(text: 'CALCULATOR'),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          minimumSize: Size(double.infinity, 0)),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  CalculatorModel get calculatorModel {
    CalculatorModel caluclator = CalculatorModel(
        BmiCubit.get(context).height.toDouble(),
        BmiCubit.get(context).weight.toDouble());
    caluclator.calculator();
    caluclator.changeValues();
    return caluclator;
  }

  DataBaseModel get dataBaseModel {
    calculatorModel;
    DataBaseModel dataBaseModel = DataBaseModel();
    dataBaseModel.name = textEditingController.text;
    dataBaseModel.type = calculatorModel.type!;
    dataBaseModel.result = calculatorModel.result;
    dataBaseModel.weight = BmiCubit.get(context).height;
    dataBaseModel.height = BmiCubit.get(context).weight;
    dataBaseModel.gender = BmiCubit.get(context).genderSelected;
    dataBaseModel.age = BmiCubit.get(context).age;
    dataBaseModel.category = calculatorModel.status!;
    return dataBaseModel;
  }
}

enum gender { male, female }
