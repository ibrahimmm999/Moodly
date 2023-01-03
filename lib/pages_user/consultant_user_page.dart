import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:moodly/cubit/change_location_cubit.dart';
import 'package:moodly/models/consultant_model.dart';
import 'package:moodly/models/province.dart';
import 'package:moodly/shared/theme.dart';

class ConsultantUserPage extends StatelessWidget {
  const ConsultantUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    ChangeLocationCubit changeLocationCubit =
        context.read<ChangeLocationCubit>();
    changeLocationCubit.change('');

    PreferredSizeWidget header() {
      return AppBar(
        toolbarHeight: 70,
        backgroundColor: white,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: primaryColor,
          iconSize: 16,
        ),
        title: Text(
          'Consultant',
          style: primaryColorText.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
        elevation: 0,
        automaticallyImplyLeading: false,
      );
    }

    Widget location() {
      return Container(
        margin: const EdgeInsets.only(top: 12, bottom: 24),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(defaultRadius), color: white),
        child: DropdownButtonFormField(
          alignment: Alignment.centerLeft,
          style: darkText.copyWith(fontSize: 12),
          dropdownColor: white,
          borderRadius: BorderRadius.circular(defaultRadius),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(defaultRadius),
              hintText: "Select Your City...",
              border: const OutlineInputBorder(
                borderSide: BorderSide(width: 0, style: BorderStyle.none),
              ),
              hintStyle: greyText.copyWith(fontSize: 12),
              prefixIcon: Icon(
                Icons.location_on,
                color: primaryColor,
              )),
          items: Provinces()
              .listOfProvinces
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
              .toList(),
          onChanged: (val) {
            changeLocationCubit.change(val.toString());
          },
        ),
      );
    }

    Widget consultantTile(ConsultantModel consultant) {
      return Container(
        margin: const EdgeInsets.only(bottom: 24),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(defaultRadius),
          color: white,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(defaultRadius),
              child: Image.network(
                consultant.photoUrl,
                width: 102,
                height: 102,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    consultant.name,
                    style: darkText.copyWith(
                      fontSize: 16,
                      fontWeight: semibold,
                    ),
                  ),
                  Text(
                    consultant.openTime,
                    style: const TextStyle(
                      color: Color(0xFF6BCBB8),
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Icons.phone,
                        color: secondaryColor,
                        size: 20,
                      ),
                      Text(
                        consultant.phone,
                        style: darkText.copyWith(fontSize: 12),
                      )
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    consultant.address,
                    style: darkText.copyWith(
                      fontSize: 10,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          location(),
          StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance
                  .collection('consultants')
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  var consultants = snapshot.data!.docs.map((e) {
                    return ConsultantModel.fromJson(e.id, e.data());
                  }).toList();
                  consultants.sort(
                    (b, a) => a.name.compareTo(b.name),
                  );

                  return BlocBuilder<ChangeLocationCubit, String>(
                    bloc: changeLocationCubit,
                    builder: (context, state) {
                      var consultantsLoc = [];
                      if (state.isNotEmpty) {
                        consultantsLoc = consultants
                            .where(
                              (element) => element.province == state,
                            )
                            .toList();
                      } else {
                        consultantsLoc = consultants;
                      }
                      return Column(
                        children: consultantsLoc.map((e) {
                          return consultantTile(e);
                        }).toList(),
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
              })
        ],
      );
    }

    return Scaffold(
      backgroundColor: white2,
      appBar: header(),
      body: content(),
    );
  }
}
