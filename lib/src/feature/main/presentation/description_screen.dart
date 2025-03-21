import 'dart:ui' as ui;

import 'package:doggie_chef/src/core/utils/text_with_border.dart';
import 'package:doggie_chef/src/feature/main/bloc/app_bloc.dart';
import 'package:doggie_chef/ui_kit/app_app_bar.dart';
import 'package:doggie_chef/ui_kit/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DescriptionScreen extends StatelessWidget {
  final int id;
  const DescriptionScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is! UserLoaded) {
          return const Placeholder();
        }
        final item = state.food[id];

        return BackdropFilter(
          filter: ui.ImageFilter.blur(
            sigmaX: 22.0,
            sigmaY: 22.0,
          ),
          child: SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  AppAppBar(title: item.name),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.28),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                       
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextWithBorder("Calories: "),
                              SizedBox(
                                width: 100,
                                child: AppTextField(
                                  backgrund: true,
                                  controller: TextEditingController(
                                    text: item.calories.toString(),
                                  ),
                                  isEdit: false,
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextWithBorder("Fat: "),
                            AppTextField(
                              controller: TextEditingController(
                                text: item.fat.toString(),
                              ),
                              isEdit: false,
                            )
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextWithBorder("Protein: "),
                            AppTextField(
                              controller: TextEditingController(
                                text: item.protein.toString(),
                              ),
                              isEdit: false,
                            )
                          ],
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextWithBorder("Carbohydrates: "),
                            AppTextField(
                              controller: TextEditingController(
                                text: item.carbohydrates.toString(),
                              ),
                              isEdit: false,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  TextWithBorder(item.description)
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
