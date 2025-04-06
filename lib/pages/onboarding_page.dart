import 'package:agriplant/models/user_account.dart';
import 'package:agriplant/pages/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

//This is global User Id when Splesh Screen Show Then auto fill
//This Object auto initilize when spleach screen show it init from Firebase
UserAccount globalUserAccount = UserAccount(
  "",  
  {
    Profile.name: "Rahul",
    Profile.address: "123 Abc parck , abc state ,",
    Profile.dp: "https://static.vecteezy.com/system/resources/previews/004/985/994/original/cartoon-farmer-with-farmland-background-free-vector.jpg",
    Profile.mobile: "1234567890"
  }, 
  [], 
  [],[]
);
//

class OnboardingPage extends StatelessWidget {
  
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              const Spacer(),
              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 380),
                child: Image.asset('assets/onboarding.png'),
              ),
              const Spacer(),
              Text('Welcome to Agriplant',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
              const Padding(
                padding: EdgeInsets.only(top: 30, bottom: 30),
                child: Text(
                  "Get your agriculture products from the comfort of your home. You're just a few clicks away from your favorite products.",
                  textAlign: TextAlign.center,
                ),
              ),
              /**/
              FilledButton.tonalIcon(
                onPressed: () {

                  //Login With Google
                  //Navigate To Home ( Test )
                  Navigator.of(context).pushReplacement(CupertinoPageRoute(builder: (context) => const HomePage()));


                },
                icon: const Icon(IconlyLight.login),
                label: const Text("Continue with Google"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
