// ignore_for_file: non_constant_identifier_names, camel_case_types

import '../../controllers/login_controller.dart';
import '../../controllers/signUp-controller.dart';
import '../../utils/export_file.dart';

class OTP_view extends StatefulWidget {
  const OTP_view({super.key});

  @override
  State<OTP_view> createState() => _OTPviewState();
}

class _OTPviewState extends State<OTP_view> {
  final SignUpController controller = !Get.isRegistered<SignUpController>()
      ? Get.put(SignUpController())
      : Get.find<SignUpController>();
  final LoginController loginController = !Get.isRegistered<LoginController>()
      ? Get.put(LoginController())
      : Get.find<LoginController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Signup_image(),
            OTP_data(),
            SizedBox(height: 10.h),
            OTP_Field(),
            SizedBox(height: 20.h),
            Resend_OTP(),
            SizedBox(height: 60.h),
            OTP_button(),
          ],
        ),
      ),
    );
  }

  Widget OTP_data() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(left: 15.w, top: 20),
          child: Text(
            "Mobile Verification",
            style: GoogleFonts.inter(
                fontSize: kTwentyFourFont,
                color: darkGrey,
                fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(height: 30.h),
        Container(
          margin: const EdgeInsets.only(left: 20),
          child: Column(
            children: [
              Row(
                children: [
                  const Text("OTP Sent to"),
                  Text(
                    "Phone",
                    style: GoogleFonts.inter(
                        fontSize: kTwelveFont,
                        color: darkGrey,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Row(
                children: [
                  const Text("of "),
                  Text(
                    loginController.mobileController.text,
                    style: GoogleFonts.inter(
                        fontSize: kTwelveFont,
                        color: darkGrey,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget OTP_Field() {
    return Container(
      alignment: Alignment.topLeft,
      margin: const EdgeInsets.only(top: 12, left: 20, right: 20),
      child: Form(
        //key: formKey,
        child: PinCodeTextField(
          controller: controller.otpController,
          backgroundColor: Colors.white,
          appContext: context,
          pastedTextStyle:
              const TextStyle(color: Colors.blue, fontWeight: kFW700),
          length: 6,
          animationType: AnimationType.fade,
          validator: (v) {
            if (v!.length < 4) {
              return "I'm from validator";
            } else {
              return null;
            }
          },
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.underline,
            fieldHeight: 40.h,
            fieldWidth: 40.w,
          ),
          animationDuration: const Duration(milliseconds: 300),
          enableActiveFill: true,
          keyboardType: TextInputType.number,
          // boxShadows: const [
          //   BoxShadow(
          //     offset: Offset(0, 1),
          //     blurRadius: 10,
          //   )
          // ],
          onCompleted: (v) {
            debugPrint("Completed");
          },
          onChanged: (value) {
            debugPrint(value);
            setState(() {});
          },
          beforeTextPaste: (text) {
            debugPrint("Allowing to paste $text");
            return true;
          },
        ),
      ),
    );
  }

  Widget Resend_OTP() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Text(
                "00:30",
                style: GoogleFonts.inter(
                    fontSize: kTwelveFont,
                    color: darkGrey,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(width: 3),
              const Text("Sec time remaining"),
            ],
          ),
          Obx(
            () => controller.isLoading == false
                ? TextButton(
                    onPressed: () async {
                      bool isResent = await controller.resendOtp(context);
                      if (isResent) {
                        controller.otpController.clear();
                      }
                    },
                    child: Text(
                      "Resend OTP",
                      style: GoogleFonts.inter(
                          fontSize: kTwelveFont,
                          color: darkGrey,
                          fontWeight: FontWeight.w600),
                    ))
                : CircularProgressIndicator(),
          )
        ],
      ),
    );
  }

  Widget OTP_button() {
    return Container(
      // alignment: Alignment.center,
      margin: const EdgeInsets.only(top: 5),
      height: 40.h,
      padding: const EdgeInsets.only(left: 100, right: 100),
      width: double.infinity,
      //decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)),
      child: TextButton(
        onPressed: () async {
          bool isVerified =
              await controller.checkOtp(context, controller.otpController.text);
          if (isVerified) {
            Get.toNamed(kDashboardPage);
          }
        },
        style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll<Color>(purple),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                    side: const BorderSide(color: purple)))),
        child: Text(
          "Verify",
          style: GoogleFonts.inter(
              fontSize: kFourteenFont,
              color: white,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
