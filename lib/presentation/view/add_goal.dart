import 'package:flutter/material.dart';
import 'package:goal_decomposer/core/theme/app_colors.dart';
import 'package:goal_decomposer/core/utils/app_textStyle.dart';
import 'package:goal_decomposer/core/utils/constants.dart';
import 'package:goal_decomposer/core/utils/media_query_helper.dart';
import 'package:goal_decomposer/core/utils/validator_helper.dart';
import 'package:goal_decomposer/data/models/goal_model.dart';
import 'package:goal_decomposer/presentation/viewModel/goal_provider.dart';
import 'package:goal_decomposer/presentation/widgets/custom_appBar.dart';
import 'package:provider/provider.dart';

import '../widgets/custom_rounded_button.dart';
import '../widgets/custom_textfield.dart';

class AddGoal extends StatefulWidget {
  const AddGoal({super.key});

  @override
  State<AddGoal> createState() => _AddGoalState();
}

class _AddGoalState extends State<AddGoal> {
  TextEditingController titleC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();
  TextEditingController deadlineC = TextEditingController();

  //---[Variables]---
  int selectedPriorityIndex = 0;
  final List<String> _priorityIndex = ['Low', 'Medium', 'High'];
  //---[Form Key]---
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<GoalProvider>(context, listen: false);
    return Scaffold(
      appBar: MyAppBar(title: AppConstants.addGoal, showBackButton: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //---[Upper Section--Fields]---
            _buildFieldsSection(vm, context),

            Divider(),
            SizedBox(height: 5),

            //---[Lower Section--Button]---
            _buildButtonSection(vm),
          ],
        ),
      ),
    );
  }

  //---[Button Section]---
  Widget _buildButtonSection(GoalProvider vm) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),

      child: Consumer<GoalProvider>(
        builder: (context, vmP, child) => CustomRoundedContainer(
          height: MediaQueryHelper.height(context) / 16,
          width: MediaQueryHelper.width(context),
          buttonTitle: vmP.isLoading ? '' : 'Create Goal',
          fontSize: 22,
          color: AppColors.primaryBlueColor,
          onTap: vmP.isLoading
              ? null
              : () async {
                  if (_formKey.currentState!.validate()) {
                    final newGoal = GoalCardModel(
                      id: DateTime.now().toIso8601String(),
                      title: titleC.text.trim(),
                      description: descriptionC.text.trim(),
                      deadline: vm.selectedDate!,
                      priority: _priorityIndex[selectedPriorityIndex],
                    );
                    if (newGoal == null) return;
                    vmP.addAndGenerateGoalSteps(newGoal);

                    titleC.clear();
                    descriptionC.clear();
                    deadlineC.clear();
                    print(newGoal);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Successfully Added Goal')),
                    );
                    Navigator.pop(context);
                  }
                },
          child: vmP.isLoading ? CircularProgressIndicator() : null,
        ),
      ),
    );
  }

  //---[TextFields Section]---
  Widget _buildFieldsSection(GoalProvider vm, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),

      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextField(
              controller: titleC,
              title: 'Goal Title',
              validator: ValidatorHelper.validateTitle,
            ),
            SizedBox(height: 25),
            CustomTextField(
              controller: descriptionC,
              maxLines: 4,
              title: 'Description',
              validator: ValidatorHelper.validateDescription,
            ),
            SizedBox(height: 25),
            CustomTextField(
              controller: deadlineC,
              readOnly: true,
              title: 'Deadline',

              suffixIcon: InkWell(
                onTap: () async {
                  await vm.pickDate(context);
                  if (vm.selectedDate != null) {
                    deadlineC.text = vm.formattedDate;
                  }
                },
                child: Icon(
                  Icons.calendar_month,
                  size: 30,
                  color: Colors.grey.shade600,
                ),
              ),
              onTap: () async {
                await vm.pickDate(context);
                if (vm.selectedDate != null) {
                  deadlineC.text = vm.formattedDate;
                }
              },
              validator: ValidatorHelper.validateDeadline,
            ),

            SizedBox(height: 25),
            Text(
              'Priority',
              style: AppTextStyles.labelMedium.copyWith(
                color: Colors.grey.shade500,
              ),
            ),
            SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(
                _priorityIndex.length,
                (index) => ChoiceChip(
                  checkmarkColor: AppColors.whiteColor,
                  label: Center(
                    child: Text(
                      _priorityIndex[index],
                      style: TextStyle(
                        color: selectedPriorityIndex == index
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  ),
                  selected: selectedPriorityIndex == index,
                  selectedColor: selectedPriorityIndex == 0
                      ? Colors.grey
                      : selectedPriorityIndex == 1
                      ? Colors.green
                      : Colors.red,
                  onSelected: (value) => setState(() {
                    selectedPriorityIndex = index;
                  }),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
