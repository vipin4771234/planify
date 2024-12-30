import 'package:flutter/material.dart';
import 'package:planify/app_resources/app_resources.dart';
import 'package:planify/screens/auth_screens/auth_export.dart';
import 'package:planify/screens/get_started_screens/get_started_provider.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({Key? key}) : super(key: key);

  @override
  GetStartedScreenState createState() => GetStartedScreenState();
}

class GetStartedScreenState extends State<GetStartedScreen>
    with SingleTickerProviderStateMixin {
  late GetStartedProvider getStartedProvider;

  @override
  void initState() {
    super.initState();
    getStartedProvider = GetStartedProvider();
    getStartedProvider =
        Provider.of<GetStartedProvider>(context, listen: false);
    getStartedProvider.init(context: context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    initializeResources(context: context);
    Provider.of<GetStartedProvider>(context, listen: true);
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          height: sizes!.height,
          width: sizes!.width,
          decoration: const BoxDecoration(
            // color: Colors.red,
            image: DecorationImage(
              image: AssetImage('assets/png/get_start_pic.png'),
              fit: BoxFit.fill,
              colorFilter: ColorFilter.mode(
                AppColors.overlayColor,
                BlendMode.srcOver,
              ),
            ),
          ),
          child: Column(
            children: [
              const Spacer(),
              Text(
                "Your next dream trip is just around the corner. 😍",
                style: TextStyle(
                  fontSize: sizes!.fontRatio * 54,
                  color: AppColors.mainWhite,
                  fontWeight: FontWeight.w800,
                ),
              ),
              CommonPadding.sizeBoxWithHeight(height: 34),
              Visibility(
                visible: !getStartedProvider.isChecking,
                child: const SizedBox(
                  child: CircularProgressIndicator(
                    color: AppColors.mainWhite100,
                  ),
                ),
              ),
              Visibility(
                visible: getStartedProvider.isChecking,
                child: buttonContainer(
                  title: "Yaaas let's go!",
                  onPress: () async {
                    /// -> Login Screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ),
                    );
                  },
                ),
              ),
              CommonPadding.sizeBoxWithHeight(height: 30),
            ],
          ).get16HorizontalPadding(),
        ),
      ),
    );
  }

  Widget buttonContainer({
    required String title,
    required Function onPress,
  }) {
    return GestureDetector(
      onTap: () => onPress.call(),
      child: Container(
        height: sizes!.heightRatio * 56,
        width: sizes!.widthRatio * 350,
        decoration: BoxDecoration(
          color: AppColors.mainWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: AppColors.mainBlack,
            width: 2,
          ),
          boxShadow: const [
            BoxShadow(
              color: AppColors.mainBlue400,
              spreadRadius: 0,
              blurRadius: 0,
              offset: Offset(-4, 4), // changes position of shadow
            ),
          ],
        ),
        child: Center(
            child: GradientText(
          title,
          style: TextStyle(
            fontSize: sizes!.fontRatio * 18,
            fontWeight: FontWeight.w800,
            //fontFamily: "Basement-Bold",
          ),
          colors: const [
            AppColors.getStartGradientOne,
            AppColors.getStartGradientTwo,
            AppColors.getStartGradientThree,
          ],
        )),
      ),
    );
  }
}
