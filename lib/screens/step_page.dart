import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/account_bloc.dart';
import '../model/account.dart';

class StepPage extends StatefulWidget {
  const StepPage({super.key});

  @override
  State<StepPage> createState() => _StepPageState();
}

class _StepPageState extends State<StepPage> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  bool _isComplete = false;
  int _isActiveIndex = 0;
  int _currentStep = 0;
  List<Step> stepList() => [
        Step(
          state: _isActiveIndex > 0 ? StepState.complete : StepState.indexed,
          isActive: _isActiveIndex >= 0,
          title: const Text("Account"),
          content: Column(
            children: <Widget>[
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Full Name"),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), labelText: "Address"),
              ),
            ],
          ),
        ),
        Step(
          state: _isActiveIndex > 1 ? StepState.complete : StepState.indexed,
          isActive: _isActiveIndex >= 1,
          title: const Text("Check Account"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Name: ${_fullNameController.text}",
                style: const TextStyle(fontSize: 18),
              ),
              Text("Address: ${_addressController.text}",
                  style: const TextStyle(fontSize: 18)),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "ยืนยันข้อมูล",
                style: TextStyle(fontSize: 18),
              )
            ],
          ),
        )
      ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "FormPage",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[500],
      ),
      body: _isComplete ? formSuccess() : myStepper(),
    );
  }

  myStepper() {
    return Stepper(
      controlsBuilder: (BuildContext context, ControlsDetails controlsDetails) {
        return Padding(
          padding: const EdgeInsets.only(
            top: 20,
          ),
          child: Row(
            children: <Widget>[
              if (_currentStep == 0 && _currentStep < stepList().length - 1)
                FilledButton(
                  onPressed: controlsDetails.onStepContinue,
                  child: const Text("Next"),
                ),
              if (_currentStep >= stepList().length - 1)
                FilledButton(
                  onPressed: () {
                    // random id
                    final String id = DateTime.now().millisecondsSinceEpoch.toString();
                    final Account createAccount = Account(
                        id: id,
                        fullName: _fullNameController.text,
                        address: _addressController.text);
                    context.read<AccountBloc>().add(AddAccount(account: createAccount));
                    setState(() {
                      _isComplete = true;
                    });
                  },
                  child: const Text("Confirm"),
                ),
              const SizedBox(
                width: 20,
              ),
              if (_currentStep > 0)
                FilledButton(
                  onPressed: controlsDetails.onStepCancel,
                  child: const Text("Back"),
                ),
            ],
          ),
        );
      },
      type: StepperType.horizontal,
      steps: stepList(),
      currentStep: _currentStep,
      onStepContinue: _handleStepContinue,
      onStepCancel: _handleStepCancel,
    );
  }

  void _handleStepContinue() {
    if (_currentStep >= stepList().length - 1) {
      return;
    }
    setState(() {
      _currentStep += 1;
      _isActiveIndex += 1;
    });
  }

  void _handleStepCancel() {
    if (_currentStep <= 0) {
      return;
    }
    setState(() {
      _currentStep -= 1;
      _isActiveIndex -= 1;
    });
  }

  formSuccess() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Column(
              children: [
                Icon(
                  Icons.check_circle,
                  size: 200,
                  color: Colors.green,
                ),
                Text(
                  "Success!",
                  style: TextStyle(fontSize: 30),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
