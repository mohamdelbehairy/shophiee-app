import 'package:app/constants.dart';
import 'package:app/pages/login_page.dart';
import 'package:app/pages/register_page.dart';
import 'package:app/widgets/custom_bottom.dart';
import 'package:flutter/material.dart';

class FirstPageBody extends StatelessWidget {
  const FirstPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/images/home4.jpg'), fit: BoxFit.fill),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Discover your Nearby Friends',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 40),
            ),
            const SizedBox(height: 8),
            Text(
              'Find your all friends in one place by\nsigning the apps quick & easily.',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            CustomBottom(
                 width: double.infinity,
              borderRadius: BorderRadius.circular(32),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return LoginPage();
                  }));
                },
                colorText: Colors.white,
                colorBottom: kPrimaryColor,
                text: 'Have account?Login'),
            const SizedBox(height: 8),
            CustomBottom(
              width: double.infinity,
              borderRadius: BorderRadius.circular(32),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return RegisterPage();
                  }));
                },
                colorText: Colors.black,
                colorBottom: Colors.white,
                text: 'Join us, its free'),
            SizedBox(height: MediaQuery.of(context).size.height * .12),
          ],
        ),
      ),
    );
  }
}
