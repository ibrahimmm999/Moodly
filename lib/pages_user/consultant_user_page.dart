import 'package:flutter/material.dart';
import 'package:moodly/shared/theme.dart';

class ConsultantUserPage extends StatelessWidget {
  const ConsultantUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> loc = [
      "Yogyakarta",
      "Jakarta",
      "Bandung",
      "Raja Ampat",
      "Bali",
      "Medan"
    ];
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
          alignment: Alignment.center,
          style: darkText.copyWith(fontSize: 12),
          dropdownColor: white,
          borderRadius: BorderRadius.circular(defaultRadius),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.all(defaultRadius),
              border: const OutlineInputBorder(
                borderSide: BorderSide(width: 0, style: BorderStyle.none),
              ),
              hintText: "Select Your City...",
              hintStyle: greyText.copyWith(fontSize: 12),
              prefixIcon: Icon(
                Icons.location_on,
                color: primaryColor,
              )),
          items: loc
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
              .toList(),
          onChanged: (val) {
            print(val);
          },
        ),
      );
    }

    Widget consultantTile() {
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
              child: Image.asset(
                'assets/example/profile_pict_example.png',
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
                    'Mr. Budi, S.Psi.',
                    style: darkText.copyWith(
                      fontSize: 16,
                      fontWeight: semibold,
                    ),
                  ),
                  const Text(
                    'Open 24 Jam',
                    style: TextStyle(
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
                        '0812345678',
                        style: darkText.copyWith(fontSize: 12),
                      )
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Jl. Diponegoro No.47A, Mlati, Sleman',
                    style: darkText.copyWith(
                      fontSize: 10,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          location(),
          Column(
            children: [
              consultantTile(),
              consultantTile(),
              consultantTile(),
            ],
          )
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
