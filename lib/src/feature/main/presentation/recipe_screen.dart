import 'dart:ui';

import 'package:doggie_chef/src/core/utils/animated_button.dart';
import 'package:doggie_chef/src/core/utils/app_icon.dart';
import 'package:doggie_chef/src/core/utils/icon_provider.dart';
import 'package:doggie_chef/src/core/utils/size_utils.dart';
import 'package:doggie_chef/src/core/utils/text_with_border.dart';
import 'package:doggie_chef/src/feature/main/bloc/app_bloc.dart';
import 'package:doggie_chef/ui_kit/app_button.dart';
import 'package:doggie_chef/ui_kit/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

class RecipeScreen extends StatefulWidget {
  final int id;

  const RecipeScreen({super.key, required this.id});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  final GlobalKey shareButtonKey = GlobalKey();
  final GlobalKey shareButtonKey2 = GlobalKey();
  int currentStep = 0;

  void _goToNextStep(UserLoaded state) {
    final recipe =
        state.recipe.firstWhere((element) => element.id == widget.id);
    final item = recipe;

    if (currentStep < recipe.steps.length - 1) {
      setState(() {
        currentStep++;
      });
    } else {
      showAdaptiveDialog(
        context: context,
        builder: (_) => StatefulBuilder(
          builder: (context, setState) => Dialog(
            backgroundColor: Colors.transparent,
            insetPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 24,
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Container(
                width: 314,
                height: 154,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(IconProvider.dialog.buildImageUrl()),
                        fit: BoxFit.fill)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        AnimatedButton(
                          onPressed: () {
                            context
                                .read<UserBloc>()
                                .add(UserToggleFavoriteData(id: item.id));
                          },
                          child: AppIcon(
                              asset: state.dog.favoriteRecipes.contains(item.id)
                                  ? IconProvider.favorites.buildImageUrl()
                                  : IconProvider.unfavorite.buildImageUrl()),
                        ),
                        AnimatedButton(
                          onPressed: () {
                            _shareRecipe(shareButtonKey, item.name);
                          },
                          child: AppIcon(
                              asset: IconProvider.share.buildImageUrl()),
                        )
                      ],
                    ),
                    const TextWithBorder(
                      'Woof-Woof! It`s so tasty!',
                      fontSize: 23,
                      textAlign: TextAlign.center,
                    ),
                    AppIcon(asset: IconProvider.masq.buildImageUrl()),
                    AppButton(
                      onPressed: () => context
                        ..pop()
                        ..pop(),
                      style: ButtonColors.yellow,
                      text: "back",
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }

  void _shareRecipe(GlobalKey shareButtonKey, String text) {
    Share.share(
      '🐶 Whipping up a tasty treat for my pup! Homemade, healthy, and full of love! ❤️🍖 Give it a try in "Doggie Chef"! 👇: ${text}',
      subject: 'Give it a try! 👇',
      sharePositionOrigin: shareButtonRect(shareButtonKey),
    );
  }

  Rect? shareButtonRect(GlobalKey shareButtonKey) {
    RenderBox? renderBox =
        shareButtonKey.currentContext!.findRenderObject() as RenderBox?;
    if (renderBox == null) return null;

    Size size = renderBox.size;
    Offset position = renderBox.localToGlobal(Offset.zero);

    return Rect.fromCenter(
      center: position + Offset(size.width / 2, size.height / 2),
      width: size.width,
      height: size.height,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (context, state) {
      if (state is! UserLoaded) {
        return const Placeholder();
      }

      final item =
          state.recipe.where((element) => element.id == widget.id).first;

      return BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 22.0,
          sigmaY: 22.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: getWidth(context, percent: 1),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 17, vertical: 17),
                  child: Row(
                    children: [
                      AnimatedButton(
                          onPressed: () => context.pop(),
                          child: AppIcon(
                              asset: IconProvider.back.buildImageUrl())),
                      Spacer(),
                      Expanded(flex: 5, child: TextWithBorder(item.name)),
                      Row(
                        children: [
                          AnimatedButton(
                            onPressed: () {
                              context
                                  .read<UserBloc>()
                                  .add(UserToggleFavoriteData(id: item.id));
                            },
                            child: AppIcon(
                                asset: state.dog.favoriteRecipes
                                        .contains(item.id)
                                    ? IconProvider.favorites.buildImageUrl()
                                    : IconProvider.unfavorite.buildImageUrl()),
                          ),
                          AnimatedButton(
                            onPressed: () {
                              _shareRecipe(shareButtonKey, item.name);
                            },
                            child: AppIcon(
                                asset: IconProvider.share.buildImageUrl()),
                          )
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.28),
                          borderRadius: BorderRadius.circular(13),
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                TextWithBorder("Calories: "),
                                AppTextField(
                                  controller: TextEditingController(
                                    text: item.calories.toString(),
                                  ),
                                  isEdit: false,
                                )
                              ],
                            ),
                            Row(
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
                    ],
                  ),
                ),
              ),
              TextWithBorder(item.description),
              ListView.separated(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: item.ingredients.length,
                separatorBuilder: (_, __) => Gap(8),
                itemBuilder: (context, index) => Column(
                  children: [
                    TextWithBorder(item.ingredients[index].name),
                    AppTextField(
                      controller: TextEditingController(
                        text: item.ingredients[index].quantity.toString(),
                      ),
                      isEdit: false,
                    ),
                    AppButton(
                      style: ButtonColors.green,
                      isRound: true,
                      onPressed: () {
                        context.read<UserBloc>().add(UserSaveShoppingData(
                            ingredient: item.ingredients[index]));
                      },
                      text: "",
                      child: AppIcon(asset: IconProvider.shop.buildImageUrl()),
                    ),
                  ],
                ),
              ),
              TextWithBorder("Steps:"),
              Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                            AssetImage(IconProvider.button.buildImageUrl()))),
                child: Column(
                  children: [
                    TextWithBorder(
                        "Step ${currentStep + 1} of ${item.steps.length}"),
                    Expanded(
                        child: TextWithBorder(
                            item.steps[currentStep].description)),
                    AppButton(
                      onPressed: () => _goToNextStep(state),
                      style: ButtonColors.green,
                      text: "Next",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
