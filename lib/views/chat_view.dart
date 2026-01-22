import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff9f9f9),
      body: Padding(
        padding: const EdgeInsets.only(left: 14.0, right: 14),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              // const Center(
              //   child: Text(
              //     'Do you have any doubt!',
              //     style: TextStyle(color: Color(0xff7A8194)),
              //   ),
              // ),
              // const SizedBox(
              //   height: 30,
              // ),
              // const Center(
              //   child: Text(
              //     '1 FEB 12:00',
              //     style: TextStyle(color: Colors.white70),
              //   ),
              // ),
              // const SizedBox(
              //   height: 8,
              // ),

              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 70.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xff7A8194)),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'which product\'s stock should be \n increase',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xff373E4E)),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'According to the data you have provided,\n you should increase the stock of shoes \n whose price range is from 800 rupees \n to 1000 rupees.',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 70.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xff7A8194)),
                  child: const Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Then how many products we have \n in stock',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color(0xff373E4E)),
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    'As per current data we have 200 shirts \nin price range of 800rs to 100rs',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              // Container(
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(20),
              //       color: const Color(0xff373E4E)),
              //   child: const Padding(
              //     padding: EdgeInsets.all(10.0),
              //     child: Text(
              //       'Next Month',
              //       style: TextStyle(
              //         color: Colors.white,
              //       ),
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // const Center(
              //   child: Text(
              //     '08:12',
              //     style: TextStyle(color: Colors.white70),
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 70.0),
              //   child: Container(
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(20),
              //         color: const Color(0xff7A8194)),
              //     child: const Padding(
              //       padding: EdgeInsets.all(10.0),
              //       child: Text(
              //         'I commented on Figma, I want to add\n sjdiw weosjwy',
              //         style: TextStyle(
              //           color: Colors.white,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 10,
              // ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 300.0),
              //   child: Container(
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(20),
              //         color: const Color(0xff7A8194)),
              //     child: const Padding(
              //       padding: EdgeInsets.all(10.0),
              //       child: Text(
              //         '?',
              //         style: TextStyle(
              //           color: Colors.white,
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Container(
                  height: 45,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(
                          style: BorderStyle.solid,
                          width: 0.1,
                          color: Colors.grey[500]!),
                      borderRadius: BorderRadius.circular(30),
                      color: const Color(0xfff2f2f2)),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 50,
                      ),
                      const Text(
                        'Message',
                        style: TextStyle(color: Color(0xff4D4D4D)),
                      ),
                      const Spacer(),
                      const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.send,
                          color: Color(0xff4D4D4D),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    );
  }
}
