import 'package:deeper_riverpod_education/src/features/postcard/domain/entities/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../domain/providers/user_data_provider.dart';

class Questionnaire extends ConsumerStatefulWidget {
  const Questionnaire({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _QuestionnaireState();
}

class _QuestionnaireState extends ConsumerState<Questionnaire> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  DateTime? birthDate;

  Future<void> _selectDate(BuildContext context) async {
    await showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (BuildContext builderContext) {
        return Container(
          height: 200.0,
          padding: const EdgeInsets.all(15),
          color: Colors.grey,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            initialDateTime:
                ref.watch(userDataProvider).user?.birthDate ?? DateTime.now(),
            onDateTimeChanged: (DateTime newDateTime) {
              setState(() {
                birthDate = newDateTime;
                String? customFormat;
                if (birthDate != null) {
                  customFormat = DateFormat('MMMM d, y').format(birthDate!);
                }
                birthDateController.text = customFormat ?? '';
              });
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userDataProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('What about you?')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Spacer(
            flex: 1,
          ),
          _Name(nameController: _nameController),
          Container(
            padding: const EdgeInsets.all(15),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Expanded(
                    child: Text(
                      'Choose your birthdate',
                    ),
                  ),
                  Expanded(
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      margin: const EdgeInsets.only(top: 5, bottom: 15),
                      child: TextFormField(
                        readOnly: true,
                        onTap: () {
                          _selectDate(context);
                        },
                        controller: birthDateController,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                              width: 1.0,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: const BorderSide(
                              color: Colors.red,
                              width: 1.0,
                            ),
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                              borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                              borderSide: BorderSide(color: Colors.white)),
                          contentPadding: const EdgeInsets.only(
                              top: 15, left: 15, right: 15, bottom: 15),
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 50),
            child: ElevatedButton(
              onPressed: () {
                if (_nameController.text == '' || birthDate == null) {
                  return;
                }
                final enteredName = _nameController.text;
                userData.saveUserData(
                    User(name: Name.dirty(enteredName), birthDate: birthDate!));
              },
              child: const Center(child: Text('Apply')),
            ),
          ),
          const Spacer(
            flex: 2,
          ),
        ],
      ),
    );
  }
}

class _Name extends StatelessWidget {
  const _Name({
    required TextEditingController nameController,
  }) : _nameController = nameController;

  final TextEditingController _nameController;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: TextField(
        controller: _nameController,
        decoration: InputDecoration(
          labelText: 'Enter your name',
          labelStyle: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
