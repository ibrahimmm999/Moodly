import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:moodly/cubit/question_form_cubit.dart';
import 'package:moodly/cubit/tracking_cubit.dart';
import 'package:moodly/widgets/custom_button.dart';
import '../shared/theme.dart';

class TrackingQuestionPage extends StatelessWidget {
  const TrackingQuestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    QuestionFormCubit questionFormCubit = context.read<QuestionFormCubit>();
    TrackingCubit trackingCubit = context.read<TrackingCubit>();

    PreferredSizeWidget header() {
      return AppBar(
        toolbarHeight: 70,
        backgroundColor: white,
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10, bottom: 3),
            child: BlocConsumer<TrackingCubit, TrackingState>(
              bloc: trackingCubit,
              listener: (context, state) {
                if (state is TrackingSuccess) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Data saved successfully!'),
                    ),
                  );
                } else if (state is TrackingFailed) {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                      backgroundColor: primaryColor,
                    ),
                  );
                }
              },
              builder: (context, state) {
                if (state is TrackingLoading) {
                  return Container(
                    margin: const EdgeInsets.only(right: 12),
                    child: LoadingAnimationWidget.twistingDots(
                      leftDotColor: secondaryColor,
                      rightDotColor: primaryColor,
                      size: 24,
                    ),
                  );
                }
                return IconButton(
                  onPressed: () {
                    trackingCubit.saveQuestions(questionFormCubit.state);
                  },
                  icon: const Icon(
                    Icons.check_rounded,
                  ),
                  iconSize: 24,
                  color: secondaryColor,
                );
              },
            ),
          )
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: primaryColor,
          iconSize: 16,
        ),
        title: Text(
          'Tracking Question',
          style: primaryColorText.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      );
    }

    Widget inputQuestion(TextEditingController controller) {
      return TextFormField(
          controller: controller,
          cursorColor: primaryColor,
          decoration: InputDecoration(
              hintStyle: greyText,
              focusColor: primaryColor,
              border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.all(Radius.circular(defaultRadius)),
                  borderSide: BorderSide(color: dark)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(defaultRadius),
                  borderSide: BorderSide(color: primaryColor))));
    }

    Widget buttonAdd() {
      return Container(
        margin: EdgeInsets.only(top: defaultMargin),
        child: CustomButton(
            radiusButton: 12,
            buttonColor: primaryColor,
            buttonText: 'Add Question',
            widthButton: double.infinity,
            onPressed: () {
              questionFormCubit.addQuestion();
            },
            heightButton: 55),
      );
    }

    Widget content() {
      return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('tracking')
              .doc('questions')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              var question = (snapshot.data!.data()
                  as Map<String, dynamic>)['listQuestion'] as List;
              List<TextEditingController> listController = [];
              for (var element in question) {
                listController.add(TextEditingController(text: element));
              }
              if (listController.isEmpty) {
                questionFormCubit.init([TextEditingController()]);
              } else {
                questionFormCubit.init(listController);
              }
              return BlocBuilder<QuestionFormCubit, List>(
                bloc: questionFormCubit,
                builder: (context, state) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(20),
                    itemCount: state.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "No.${index + 1}",
                              style: darkText.copyWith(
                                  fontWeight: medium, fontSize: 12),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              children: [
                                Expanded(child: inputQuestion(state[index])),
                                const SizedBox(width: 4),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Material(
                                    child: InkWell(
                                      child: const Icon(Icons.remove_circle),
                                      onTap: () {
                                        if (state.length > 1) {
                                          questionFormCubit
                                              .removeQuestion(index);
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            index + 1 == state.length
                                ? buttonAdd()
                                : const SizedBox()
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            }
            return Center(
              child: LoadingAnimationWidget.twistingDots(
                leftDotColor: secondaryColor,
                rightDotColor: primaryColor,
                size: 60,
              ),
            );
          });
    }

    return Scaffold(
      backgroundColor: white2,
      appBar: header(),
      body: content(),
    );
  }
}
