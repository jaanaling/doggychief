import 'package:doggie_chef/routes/route_value.dart';
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

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController controller = TextEditingController();
  bool isRecomended = false;
  bool isFavorite = false;
  String selectedCategory = '';
  List<String> categories = [
    "Puppy",
    "Adult",
    "Senior",
    "Grain-Free",
    "Weight Management",
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is! UserLoaded) {
          return const SizedBox();
        }
        final recipes = state.recipe;
        final recomendedRecipes = state.dog.recomendationRecipes;
        final favorites = state.dog.favoriteRecipes;

        final filtredRecipes = recipes.where((recipe) {
          final name = recipe.name.toLowerCase();
          final query = controller.text.toLowerCase();
          final category = recipe.category;
          final isNameMatch = name.contains(query);
          final isCategoryMatch =
              selectedCategory.isEmpty || category == selectedCategory;
          final isRecomendedMatch =
              !isRecomended || recomendedRecipes.contains(recipe.id);
          final isFavoriteMatch = !isFavorite || favorites.contains(recipe.id);
          return isNameMatch &&
              isCategoryMatch &&
              isRecomendedMatch &&
              isFavoriteMatch;
        }).toList();

        return Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  if (state.dog.image != null) AppIcon(asset: state.dog.image!),
                  AppButton(
                    isRound: true,
                    style: ButtonColors.yellow,
                    text: "",
                    child: AppIcon(asset: IconProvider.box.buildImageUrl()),
                    onPressed: () {
                      context.push(
                        "${RouteValue.home.path}/${RouteValue.storage.path}",
                      );
                    },
                  ),
                  AppButton(
                    isRound: true,
                    style: ButtonColors.yellow,
                    text: "",
                    child:
                        AppIcon(asset: IconProvider.database.buildImageUrl()),
                    onPressed: () {
                      context.push(
                        "${RouteValue.home.path}/${RouteValue.base.path}",
                      );
                    },
                  ),
                  AppButton(
                    isRound: true,
                    style: ButtonColors.yellow,
                    text: "",
                    child: AppIcon(asset: IconProvider.shop.buildImageUrl()),
                    onPressed: () {
                      context.push(
                        "${RouteValue.home.path}/${RouteValue.shop.path}",
                      );
                    },
                  ),
                ],
              ),
              Row(
                children: [
                  Stack(
                    children: [
                      AppIcon(
                        asset: IconProvider.search.buildImageUrl(),
                        height: getHeight(context, baseSize: 75),
                         width: getWidth(context, baseSize: 235),
                      ),
                      SizedBox(
                          width: getWidth(context, baseSize: 200),
                          height: getHeight(context, baseSize: 75),
                          child: AppTextField(controller: controller, flex: 0,)),
                    ],
                  ),
                  AppButton(
                    isRound: true,
                    style:
                        isRecomended ? ButtonColors.green : ButtonColors.yellow,
                    text: "",
                    child: AppIcon(
                        asset: IconProvider.recommended.buildImageUrl()),
                    onPressed: () {
                      setState(() {
                        isRecomended = !isRecomended;
                      });
                    },
                  ),
                  AnimatedButton(
                    child: AppIcon(
                        asset: isFavorite
                            ? IconProvider.favorites.buildImageUrl()
                            : IconProvider.unfavorite.buildImageUrl()),
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(
                height: getHeight(context, baseSize: 55),
                child: ListView.separated(
                  itemCount: categories.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  separatorBuilder: (context, index) => const Gap(16),
                  itemBuilder: (context, index) {
                    final category = categories[index];
                    return AppButton(
                      fontSize: 23,
                      style: selectedCategory == category
                          ? ButtonColors.yellow
                          : ButtonColors.purple,
                      onPressed: () {
                        setState(() {
                          selectedCategory =
                              selectedCategory == category ? '' : category;
                        });
                      },
                      text: category,
                    );
                  },
                ),
              ),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filtredRecipes.length,
                separatorBuilder: (context, index) => const Gap(16),
                itemBuilder: (context, index) {
                  final recipe = filtredRecipes[index];
                  final isFavoriteRes =
                      state.dog.favoriteRecipes.contains(recipe.id);
                  return AnimatedButton(
                    onPressed: () {
                      context.push(
                        "${RouteValue.home.path}/${RouteValue.recipe.path}",
                        extra: recipe.id,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image:
                              AssetImage(IconProvider.button.buildImageUrl()),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 13, vertical: 9),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppIcon(
                              asset: recipe.image,
                              width: 113,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWithBorder(recipe.name),
                                Text(
                                  "Calories: ${recipe.calories}",
                                  style: const TextStyle(
                                    color: Color(0xFF894406),
                                    fontSize: 17,
                                  ),
                                ),
                                Text(
                                  "Carbohydrates: ${recipe.carbohydrates}",
                                  style: const TextStyle(
                                    color: Color(0xFF894406),
                                    fontSize: 17,
                                  ),
                                ),
                                Text(
                                  "Fat: ${recipe.fat}",
                                  style: const TextStyle(
                                    color: Color(0xFF894406),
                                    fontSize: 17,
                                  ),
                                ),
                                Text(
                                  "Protein: ${recipe.protein}",
                                  style: const TextStyle(
                                    color: Color(0xFF894406),
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                            AnimatedButton(
                              onPressed: () {
                                setState(() {
                                  isFavorite = !isFavorite;

                                  context.read<UserBloc>().add(
                                        UserToggleFavoriteData(
                                          id: recipe.id,
                                        ),
                                      );
                                });
                              },
                              child: AppIcon(
                                asset: isFavoriteRes
                                    ? IconProvider.favorites.buildImageUrl()
                                    : IconProvider.unfavorite.buildImageUrl(),
                                width: 37,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
