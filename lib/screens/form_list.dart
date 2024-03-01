import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/account_bloc.dart';
import '../model/account.dart';
import 'step_page.dart';

class FormList extends StatefulWidget {
  const FormList({super.key});

  @override
  State<FormList> createState() => _FormListState();
}

class _FormListState extends State<FormList> {
  List<Account> accounts = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Form Page',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[500],
      ),
      body: BlocBuilder<AccountBloc, AccountState>(builder: (context, state) {
        if (state is AccountLoaded) {
          accounts += state.accounts;
        }
        return Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 10),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 20,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[500],
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const StepPage()),
                        );
                      },
                      child: const Text(
                        'FormStep',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Text(
                'รายการที่บันทึก',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(
                height: 10,
              ),
              if (state is AccountLoading)
                const Text('')
              else if (state is AccountLoaded)
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: accounts.length,
                    itemBuilder: (BuildContext context, int index) {
                      var account = accounts[index];
                      return Card(
                        child: ListTile(
                          title: Text("Full Name: ${account.fullName}"),
                          subtitle: Text("Address: ${account.address}"),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }
}
