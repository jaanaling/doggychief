import 'dart:ui';

import 'package:doggie_chef/src/core/utils/icon_provider.dart';
import 'package:doggie_chef/src/core/utils/text_with_border.dart';
import 'package:doggie_chef/src/feature/main/bloc/app_bloc.dart';
import 'package:doggie_chef/ui_kit/app_app_bar.dart';
import 'package:doggie_chef/ui_kit/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RecomendationScreen extends StatefulWidget {
  const RecomendationScreen({super.key});

  @override
  State<RecomendationScreen> createState() => _RecomendationScreenState();
}

class _RecomendationScreenState extends State<RecomendationScreen> {
  int currentId = 0;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is! UserLoaded) {
          return const Placeholder();
        }
        final dog = state.dog;
        final recomendations = dog.getDailyRecommendations();
        final tips = state.tips;

        return BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 8.0,
              sigmaY: 8.0,
            ),
            child: SingleChildScrollView(
                child: Column(
              children: [
                AppAppBar(),
                Text(
                    "Daily Calories: ${recomendations.dailyCalories.toStringAsFixed(2)}"),
                Text(
                    "Daily Fat: ${recomendations.dailyFat.toStringAsFixed(2)}"),
                Text(
                    "Daily Protein: ${recomendations.dailyProtein.toStringAsFixed(2)}"),
                Text(
                    "Daily Carbohydrates: ${recomendations.dailyCarbohydrates.toStringAsFixed(2)}"),
                Text("Meals Per Day: ${recomendations.mealsPerDay}"),
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage(IconProvider.button.buildImageUrl()))),
                  child: Column(
                    children: [
                      Expanded(
                          child: TextWithBorder(tips[currentId].description)),
                      Row(
                        children: [
                          AppButton(
                            onPressed: () => setState(() {
                              if (currentId > 0) {
                                currentId--;
                              }
                            }),
                            style: ButtonColors.red,
                            text: "Back",
                          ),
                          AppButton(
                            onPressed: () => setState(() {
                              if (currentId < tips.length - 1) {
                                currentId++;
                              }
                            }),
                            style: ButtonColors.green,
                            text: "Next",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )));
      },
    );
  }
}
