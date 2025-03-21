import 'dart:ui';

import 'package:doggie_chef/src/core/utils/animated_button.dart';
import 'package:doggie_chef/src/core/utils/app_icon.dart';
import 'package:doggie_chef/src/core/utils/icon_provider.dart';
import 'package:doggie_chef/src/feature/main/bloc/app_bloc.dart';
import 'package:doggie_chef/ui_kit/app_app_bar.dart';
import 'package:doggie_chef/ui_kit/app_button.dart';
import 'package:doggie_chef/ui_kit/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is! UserLoaded) {
          return const Placeholder();
        }
        final items = state.dog.shoppingList;
        return BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 22.0,
              sigmaY: 22.0,
            ),
            child: SingleChildScrollView(
                child: Column(
              children: [
                AppAppBar(),
                AppButton(
                    onPressed: () {}, style: ButtonColors.green, text: "add"),
                ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: items.length,
                    separatorBuilder: (_, __) => Gap(8),
                    itemBuilder: (context, index) {
                      final controller = TextEditingController(
                          text: items[index].ingredient.quantity.toString());

                      return Row(
                        children: [
                          Text(items[index].ingredient.name),
                          AppTextField(
                              controller: controller,
                              onChanged: (value) {
                                context
                                    .read<UserBloc>()
                                    .add(UserUpdateShoppingData(
                                      id: items[index].id,
                                      shopping:
                                          items[index].ingredient.copyWith(
                                                quantity: double.parse(value),
                                              ),
                                    ));
                              }),
                          AppButton(
                            style: ButtonColors.green,
                            isRound: true,
                            onPressed: () {
                              context.read<UserBloc>().add(UserSaveStorageData(
                                  ingredient: items[index].ingredient));
                            },
                            text: "",
                            child: AppIcon(
                                asset: IconProvider.shop.buildImageUrl()),
                          ),
                          AnimatedButton(
                            onPressed: () => context.read<UserBloc>().add(
                                UserDeleteShoppingData(id: items[index].id)),
                            child: AppIcon(
                                asset: IconProvider.cross.buildImageUrl()),
                          )
                        ],
                      );
                    })
              ],
            )));
      },
    );
  }
}
