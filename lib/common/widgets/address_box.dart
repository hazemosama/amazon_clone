import 'package:amazon_clone/features/address/screens/address_screen.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressBox extends StatelessWidget {
  const AddressBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      height: 49,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xffb5e8ef),
            Color(0xffcaf1e2),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.bottomCenter,
        ),
      ),
      padding: const EdgeInsets.only(left: 10.0),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, AddressScreen.routeName);
        },
        child: Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              size: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                'Deliver to ${user.name} - ${user.address}',
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.4
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 5.0, top: 2.0, right: 2),
              child: Icon(
                Icons.keyboard_arrow_down,
                size: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
