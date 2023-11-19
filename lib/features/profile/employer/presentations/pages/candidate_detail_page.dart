import 'package:flutter/material.dart';
import 'package:qatjobs/core/widget/custom_appbar_widget.dart';
import 'package:qatjobs/features/users/data/models/users_model.codegen.dart';

class CandidateDetailPage extends StatefulWidget {
  const CandidateDetailPage({
    super.key,
    required this.userModel,
  });

  final UserModel userModel;

  @override
  State<CandidateDetailPage> createState() => _CandidateDetailPageState();
}

class _CandidateDetailPageState extends State<CandidateDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Candidate Detail',
        showLeading: true,
      ),
    );
  }
}
