
import 'package:agriplant/data/global_controller.dart';
import 'package:agriplant/widgets/current_weather_widget.dart';
import 'package:agriplant/widgets/daily_data_widget.dart';
import 'package:agriplant/widgets/header_widget.dart';
import 'package:agriplant/widgets/hourly_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  //call location
  final GlobalController globalController = Get.put(GlobalController(), permanent: true);
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Obx(() => globalController.checkLoading().isTrue
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: FutureBuilder(
                  future: Future.delayed(const Duration(milliseconds: 100),()=>true),
                  builder: (context, snapshot) {

                    if(!snapshot.hasData){

                      return Center(child: CircularProgressIndicator(),);
                    }

                    return ListView(
                      scrollDirection: Axis.vertical,
                      children: [
                        const SizedBox(
                          height: 00.0,
                        ),
                        const HeaderWidget(),
                        CurrentWeatherWidget(
                          weatherDataCurrent:
                              // globalController.getWeatherData().,
                              globalController.getWeatherData().getCurrentWeather(),
                        ),
                        const Center(
                          heightFactor: 2,
                          child: Text(
                            'Today',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ),
                        HourlyDataWidget(
                            weatherDataHourly: globalController
                                .getWeatherData()
                                .getHourlyWeather()),
                        DailyDataForecast(
                            weatherDataDaily:
                                globalController.getWeatherData().getDailyWeather())
                      ],
                    );
                  }
                ),
              )),
      ),
    );
  }
}
