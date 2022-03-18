import 'dart:async';

import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int seconds = 0, minutes = 0, hours = 0;
  String digitSeconds = "00", digitMinutes = "00", digitHours = "00";
  Timer? _timer;
  bool isStart = false;
  List laps = [];

  void stop() {
    _timer!.cancel();
    setState(() {
      isStart = false;
    });
  }

  void reset() {
    _timer!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;
      digitSeconds = "00";
      digitMinutes = "00";
      digitHours = "00";
      isStart = false;
      laps = [];
    });
  }

  void addLaps() {
    String lap = ("$digitHours:$digitMinutes:$digitSeconds");
    setState(() {
      laps.add(lap);
    });
  }

  void start() {
    isStart = true;
    if (isStart) {
      _timer = Timer.periodic(Duration(seconds: 1), (timer) {
        int localSeconds = seconds + 1;
        int localMinutes = minutes;
        int localHours = hours;
        if (localSeconds > 59) {
          if (localMinutes > 59) {
            localHours++;
            localMinutes = 0;
          } else {
            localMinutes++;
            localSeconds = 0;
          }
        }
        setState(() {
          seconds = localSeconds;
          minutes = localMinutes;
          hours = localHours;
          digitSeconds =
              (localSeconds < 10) ? "0$localSeconds" : "$localSeconds";
          digitMinutes =
              (localMinutes < 10) ? "0$localMinutes" : "$localMinutes";
          digitHours = (localHours < 10) ? "0$localHours" : "$localHours";
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF1C2757),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: Text(
                  'StopWatch APP',
                  style: TextStyle(
                    fontSize: 28.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20.0),
              Center(
                child: Text(
                  '$digitHours:$digitMinutes:$digitSeconds',
                  style: const TextStyle(
                    fontSize: 48.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                height: 400.0,
                decoration: const BoxDecoration(
                  color: Color(0xFF323F68),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: ListView.builder(
                  itemCount: laps.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Lap ${index + 1}',
                            style: const TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            laps[index],
                            style: const TextStyle(
                              fontSize: 20.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: RawMaterialButton(
                      onPressed: () => {
                        (isStart) ? stop() : start(),
                      },
                      shape: const StadiumBorder(
                        side: BorderSide(color: Colors.blue),
                      ),
                      child: Text(
                        (isStart) ? 'Stop' : 'Start',
                        style: const TextStyle(
                          fontSize: 20.0,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  IconButton(
                    color: Colors.white,
                    onPressed: () => {
                      addLaps(),
                    },
                    icon: const Icon(Icons.flag),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: RawMaterialButton(
                      fillColor: Colors.blue,
                      onPressed: () => {
                        reset(),
                      },
                      shape: const StadiumBorder(),
                      child: const Text(
                        'Restart',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )));
  }
}
