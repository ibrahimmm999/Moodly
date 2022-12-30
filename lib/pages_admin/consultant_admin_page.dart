import 'package:flutter/material.dart';
import 'package:moodly/shared/theme.dart';

class ConsultantAdminPage extends StatelessWidget {
  const ConsultantAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
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

    Widget consultantAdminTile() {
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
            ),
            Column(
              children: [
                Material(
                  color: white,
                  borderRadius: BorderRadius.circular(defaultRadius),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(defaultRadius),
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: Center(
                        child: Icon(
                          Icons.edit,
                          color: secondaryColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                Material(
                  color: white,
                  borderRadius: BorderRadius.circular(defaultRadius),
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(defaultRadius),
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      child: Center(
                        child: Icon(
                          Icons.delete,
                          color: primaryColor,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      );
    }

    Widget content() {
      return ListView(
        padding: EdgeInsets.symmetric(horizontal: defaultMargin),
        children: [
          const SizedBox(height: 24),
          Column(
            children: [
              consultantAdminTile(),
              consultantAdminTile(),
              consultantAdminTile(),
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
