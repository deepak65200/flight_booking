import 'package:flutter/material.dart';
import '../utils/asset_res.dart';
import '../utils/common_res.dart';

class SupportOptionModel {
  final IconData icon;
  final String title;
  final String subtitle;
  final String des;

  SupportOptionModel({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.des,
  });
}

final List<SupportOptionModel> supportOptions = [
  SupportOptionModel(
    icon: Icons.help_outline,
    title: 'Raise A Request',
    subtitle: '24x7 Online Support',
    des: '',
  ),
  SupportOptionModel(
    icon: Icons.receipt_long,
    title: 'Track My Tickets',
    subtitle: '24x7 Online Support',
    des: '',
  ),
  SupportOptionModel(
    icon: Icons.question_answer,
    title: 'FAQ’s',
    subtitle: '100+ Answers',
    des: '',
  ),
  SupportOptionModel(
    icon: Icons.call,
    title: 'Contact Us',
    subtitle: '+91 854654654',
    des: '',
  ),
];




