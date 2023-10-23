import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiClient.dart';
import '../models/login_pages_model/otp_login_response_model.dart';
import '../models/login_pages_model/register_responce_model.dart';
import '../my_home_page.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final apiClient = ApiClient();
  RegisterResponce registerResponce = RegisterResponce();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    registerResponce =
        ModalRoute.of(context)?.settings.arguments as RegisterResponce;
  }

  String otpCode = '';

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    // RegisterResponce r = ModalRoute.of(context)?.settings.arguments as RegisterResponce;
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 132),
          const Text(
            'Enter OTP',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 16),
          const Text('We have just sent you 4 digit code via your',
              style: TextStyle(fontSize: 14, color: Colors.black54)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('email',
                  style: TextStyle(fontSize: 14, color: Colors.black54)),
              const SizedBox(width: 5),
              Text('${registerResponce.data?.user?.email}',
                  style: const TextStyle(fontSize: 14, color: Colors.black))
            ],
          ),
          const SizedBox(height: 31),
          OtpTextField(
            numberOfFields: 4,
            borderColor: Colors.black,
            showFieldAsBox: true,

            obscureText: true,
            //запускается при вводе кода в
            onCodeChanged: (String code) {
              //обрабатывайте валидацию или проверки здесь
            },
            //запускается, когда заполнено каждое текстовое поле
            onSubmit: (String verificationCode) async {
              otpCode = verificationCode;
              // showDialog(
              //     context: context,
              //     builder: (context){
              //       return AlertDialog(
              //         title: Text("Verification Code"),
              //         content: Text('Code entered is $verificationCode'),
              //       );
              //     }
              // );
            }, // end onSubmit
          ),
          const SizedBox(height: 48),
          SizedBox(
            width: 327,
            height: 48,
            child: ElevatedButton(
              onPressed: () async {
                setState(() {
                  isLoading = true;
                });
                try {
                  var response = await apiClient.otpLogin('${registerResponce.data!.user!.id}', otpCode);
                  if (response.statusCode == 200) {
                    OTPLoginResponse otpRes = OTPLoginResponse.fromJson(response.data);
                    if (otpRes.data != null) {
                      SharedPreferences preferences = await SharedPreferences.getInstance();
                      // Сохраняем данные в SharedPreferences
                      preferences.setInt('id', otpRes.data?.user?.id ?? 0);
                      preferences.setString('email', otpRes.data?.user?.email ?? '');
                      preferences.setString('token', otpRes.data?.token ?? '');
                      preferences.setString('name', otpRes.data?.user?.name ?? '');
                      preferences.setString('phoneNumber', otpRes.data?.user?.phoneNumber ?? '');

                      setState(() {
                        isLoading = false;
                      });
                      showMyDialog(context);
                    }
                  } else if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Incorrect code')));
                    setState(() {
                      isLoading = false;
                    });
                  }
                } catch (e) {
                  // // Если поймано исключение Ioexception, используйте панель быстрого доступа, чтобы отобразить сообщение об ошибке.
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Incorrect code')));
                  setState(() {
                    isLoading = false;
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                backgroundColor: const Color(0xFF4F3D56),
              ),
              child: isLoading
                  ? const Center(child: CircularProgressIndicator(backgroundColor: Colors.white))
                  : const Text('Continue', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Didn’t receive code? ',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black38),
              ),
              InkWell(
                onTap: () {
                  apiClient
                      .otpGenerate('${registerResponce.data?.user?.email}');
                },
                child: const Text(
                  'Resend Code',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  void showMyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            height: 324,
            width: 327,
            child: Column(
              children: [
                const SizedBox(height: 32),
                const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: SizedBox(
                    height: 120,
                    width: 279,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text('I agree to the ',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black45)),
                            Text('Terms of Service ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                            Text('and',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black45)),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Conditions of Use ',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500)),
                            Text('Including consent ',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black45)),
                          ],
                        ),
                        Text(
                            'to electronic communications and I affirm that the information provided',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black45)),
                        Text('is my own.',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black45)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                    height: 46,
                    width: 180,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const MyHomePage()));
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF4F3D56)),
                        child: const Text(
                          'Agree and continue',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        )),
                  ),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    'Disgree',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
