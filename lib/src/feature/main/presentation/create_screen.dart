import 'dart:ui';

import 'package:doggie_chef/src/feature/main/bloc/app_bloc.dart';
import 'package:doggie_chef/src/feature/main/model/dog.dart';
import 'package:doggie_chef/ui_kit/app_app_bar.dart';
import 'package:doggie_chef/ui_kit/app_button.dart';
import 'package:doggie_chef/ui_kit/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final List<String> selectedAlergens = [];
  final ageTextField = TextEditingController();
  final weightTextField = TextEditingController();

  String? image;
  final name = TextEditingController();

  int activity = 1;
  String? selectedBreed;
  String? error;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is! UserLoaded) {
          return const Placeholder();
        }

        final dog = state.dog;
        if (dog.age == 0 || dog.weight == 0) {
          name.text = dog.name;
          ageTextField.text = dog.age.toString();
          weightTextField.text = dog.weight.toString();
          selectedBreed = dog.breed;
          activity = dog.activity;
          selectedAlergens.addAll(dog.alergens);
          image = dog.image;
        }

        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 22.0,
            sigmaY: 22.0,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppAppBar(title: "Profile"),
                Row(
                  children: [
                    CountTextField(
                        controller: ageTextField,
                        title: "age",
                        setState: () => setState(() {})),
                    CountTextField(
                        controller: weightTextField,
                        title: "weight",
                        setState: () => setState(() {})),
                  ],
                ),
                AppTextField(
                  controller: name,
                  title: "name",
                ),
                AppButton(
                  style: ButtonColors.yellow,
                  text: selectedBreed ?? "breed",
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Wrap(
                          children: List.generate(
                            dogBreeds.length,
                            (index) => AppButton(
                              style: ButtonColors.purple,
                              onPressed: () {
                                setState(() {
                                  selectedBreed = dogBreeds[index];
                                });
                                context.pop();
                              },
                              text: dogBreeds[index],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                Row(
                  children: List.generate(
                    5,
                    (index) => AppButton(
                      style: activity == index + 1
                          ? ButtonColors.yellow
                          : ButtonColors.purple,
                      onPressed: () {
                        setState(() {
                          activity = index + 1;
                        });
                      },
                      text: (index + 1).toString(),
                    ),
                  ),
                ),
                if (error != null) Text(error!),
                Wrap(
                  children: List.generate(
                    commonDogAllergens.length,
                    (int index) => AppButton(
                      style:
                          selectedAlergens.contains(commonDogAllergens[index])
                              ? ButtonColors.yellow
                              : ButtonColors.purple,
                      onPressed: () {
                        setState(() {
                          if (selectedAlergens
                              .contains(commonDogAllergens[index])) {
                            selectedAlergens.remove(commonDogAllergens[index]);
                          } else {
                            selectedAlergens.add(commonDogAllergens[index]);
                          }
                        });
                      },
                      text: commonDogAllergens[index],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                AppButton(
                  onPressed: () {
                    if (name.text.isEmpty ||
                        selectedBreed == null ||
                        weightTextField.text.isEmpty ||
                        ageTextField.text.isEmpty) {
                      setState(() {
                        error = "Fill in all fields";
                      });
                    } else {
                      setState(() {
                        error = null;
                      });
                    }
                    if (error == null) {
                      context.read<UserBloc>().add(
                            UserUpdateData(
                              name: name.text,
                              breed: selectedBreed,
                              age: int.parse(ageTextField.text),
                              weight: double.parse(weightTextField.text),
                              gender: dog.gender,
                              activity: activity,
                              alergens: selectedAlergens,
                              image: image,
                            ),
                          );
                      context.pop();
                    }
                  },
                  style: ButtonColors.green,
                  text: "save",
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
