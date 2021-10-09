import 'package:equatable/equatable.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

class Advertisement extends Equatable {
  final int id;
  final String title;
  final int price;
  final DateTime datePosted;
  final String description;
  final Image photo;

  Advertisement({
    required this.id,
    required this.photo,
    required this.price,
    required this.datePosted,
    required this.description,
    required this.title,
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}
