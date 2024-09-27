import 'package:flutter/material.dart';
import 'package:hundalstore/Home_page.dart';

class UnableToLoad extends StatefulWidget {
  const UnableToLoad({
    super.key,
  });

  @override
  State<UnableToLoad> createState() => _NoInternetState();
}

class _NoInternetState extends State<UnableToLoad> {
  bool ontap = false;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Container(
        color: Colors.white,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
              height: size.height * 0.15,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                'assets/hundal_logo.png',
              )))),
          // Container(
          //   height: size.height * 0.45,
          //   alignment: Alignment.center,
          //   padding: EdgeInsets.only(
          //       left: size.width * 0.1, right: size.width * 0.1),
          //   child: Lottie.asset('assets/lottie/no_internet_lottie.json',
          //       repeat: true, animate: true),
          // ),
          SizedBox(height: size.height * 0.04),
          const Text(
            'Unable to load the page',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 24, color: Colors.black, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: size.height * 0.01),
          const Text(
            'Try to reload the page',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 16,
                color: Color(0xff707070),
                fontWeight: FontWeight.w400),
          ),
          SizedBox(height: size.height * 0.02),
          ontap
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  style: const ButtonStyle(
                      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero)),
                      backgroundColor:
                          WidgetStatePropertyAll(Color(0xffffd333))),
                  onPressed: (() async {
                    setState(() {
                      ontap = true;
                    });
                    // // bool isBack = await widget.controller.canGoBack();
                    Future.delayed(const Duration(seconds: 1), () async {
                      //   print(isBack);
                      //   if (isBack == true) {
                      //     await widget.controller.goBack();
                      //   } else {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()));
                      // }
                      setState(() {
                        ontap = false;
                      });
                    });
                  }),
                  child: const Text(
                    'Reload',
                    style: TextStyle(color: Colors.black),
                  ))
        ]),
      ),
    );
  }
}
