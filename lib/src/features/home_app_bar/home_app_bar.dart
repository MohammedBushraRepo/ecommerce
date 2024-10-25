import 'package:ecommerce/src/constants/breakpoints.dart';
import 'package:ecommerce/src/features/account/account_screen.dart';
import 'package:ecommerce/src/features/orders_list/orders_list_screen.dart';
import 'package:ecommerce/src/features/sign_in/email_password_sign_in_screen.dart';
import 'package:ecommerce/src/features/sign_in/email_password_sign_in_state.dart';
import 'package:ecommerce/src/localization/string_hardcoded.dart';
import 'package:ecommerce/src/models/app_user.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/src/common_widgets/action_text_button.dart';
import 'package:ecommerce/src/features/home_app_bar/more_menu_button.dart';
import 'package:ecommerce/src/features/home_app_bar/shopping_cart_icon.dart';
/// Custom [AppBar] widget that is reused by the [ProductsListScreen] and
/// [ProductScreen]. 
/// It shows the following actions, depending on the application state:
/// - [ShoppingCartIcon]
/// - Orders button
/// - Account or Sign-in button
class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: get user from auth repository
    const user = AppUser(uid: '123', email: 'test@test.com');
    final screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth < Breakpoint.tablet) {
      return AppBar(
        title: Text('My Shop'.hardcoded),
        actions: const [
          ShoppingCartIcon(),
          MoreMenuButton(user: user),
        ],
      );
    } else {
      return AppBar(
        title: Text('My Shop'.hardcoded),
        actions: [
          const ShoppingCartIcon(),
          if (user != null) ...[
            ActionTextButton(
              key: MoreMenuButton.ordersKey,
              text: 'Orders'.hardcoded,
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_) => const OrdersListScreen(),
                ),
              ),
            ),
            ActionTextButton(
              key: MoreMenuButton.accountKey,
              text: 'Account'.hardcoded,
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_) => const AccountScreen(),
                ),
              ),
            ),
          ] else
            ActionTextButton(
              key: MoreMenuButton.signInKey,
              text: 'Sign In'.hardcoded,
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (_) => const EmailPasswordSignInScreen(
                    formType: EmailPasswordSignInFormType.signIn,
                  ),
                ),
              ),
            ),
        ],
      );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}