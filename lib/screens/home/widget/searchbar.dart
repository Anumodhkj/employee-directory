import 'package:flutter/material.dart';
import 'package:webandcraf/constants/strings.dart';

class SearchBar extends StatelessWidget {
  final void Function(String)? onChanged;
  final void Function()? onTap;
  const SearchBar({Key? key, this.onTap, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
        margin: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 1,
              color: Colors.grey,
            )),
        height: 45,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                child: TextFormField(
              onChanged: onChanged,
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                border: InputBorder.none,
                hintText: Strings.hint,
              ),
            )),
            Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: const Center(
                child: Icon(
                  Icons.search_rounded,
                  color: Colors.grey,
                  size: 30,
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
