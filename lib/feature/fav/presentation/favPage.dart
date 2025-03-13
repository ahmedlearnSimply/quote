// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:quote/core/functions/naviagation.dart';
import 'package:quote/core/services/storage/local_storage.dart';
import 'package:quote/core/utils/appcolors.dart';
import 'package:quote/core/utils/textstyle.dart';
import 'package:quote/feature/home/model/quote.dart';

class Favpage extends StatefulWidget {
  const Favpage({super.key});

  @override
  State<Favpage> createState() => _FavpageState();
}

class _FavpageState extends State<Favpage> {
  @override
  List<Quote> favQuotes = [];

  @override
  void initState() {
    super.initState();
    favQuotes = AppLocalStorage.loadFavQuotes();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              push(context, Favpage());
            },
          )
        ],
        backgroundColor: AppColors.secondary,
        title: Text(
          "مرحبا بك ${AppLocalStorage.getCachedData(
            key: AppLocalStorage.name,
          )}",
          style: getTitleStyle(
            color: AppColors.primary,
            fontSize: 28,
          ),
        ),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: favQuotes.length,
          itemBuilder: (context, index) {
            Quote quote = favQuotes[index];
            return Container(
              width: 100,
              decoration: BoxDecoration(color: Colors.black),
              child: Text(
                quote.text,
              ),
            );
          },
        ),
      ),
    );
  }
}
