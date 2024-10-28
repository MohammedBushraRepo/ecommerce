import 'package:ecommerce/src/constants/breakpoints.dart';
import 'package:ecommerce/src/features/products/presentation/home_app_bar/more_menu_button.dart';
import 'package:ecommerce/src/features/products/presentation/home_app_bar/shopping_cart_icon.dart';
import 'package:ecommerce/src/localization/string_hardcoded.dart';
import 'package:ecommerce/src/features/authentication/domain/app_user.dart';
import 'package:ecommerce/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce/src/common_widgets/action_text_button.dart';
import 'package:go_router/go_router.dart';

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
                onPressed: () => context
                    .pushNamed(AppRoute.orders.name) // context.go('/orders')
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     fullscreenDialog: true,
                //     builder: (_) => const OrdersListScreen(),
                //   ),
                // ),
                ),
            ActionTextButton(
                key: MoreMenuButton.accountKey,
                text: 'Account'.hardcoded,
                onPressed: () => context
                    .pushNamed(AppRoute.account.name) //context.go('/account'),
                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     fullscreenDialog: true,
                //     builder: (_) => const AccountScreen(),
                //   ),
                // ),
                ),
          ] else
            ActionTextButton(
              key: MoreMenuButton.signInKey,
              text: 'Sign In'.hardcoded,
              onPressed: () => context
                  .pushNamed(AppRoute.signIn.name), //context.go('/signIn')
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     fullscreenDialog: true,
              //     builder: (_) => const EmailPasswordSignInScreen(
              //       formType: EmailPasswordSignInFormType.signIn,
              //     ),
              //   ),
              // ),
            ),
        ],
      );
    }
  }

  @override
  Size get preferredSize => const Size.fromHeight(60.0);
}