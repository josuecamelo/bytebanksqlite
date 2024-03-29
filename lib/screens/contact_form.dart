import 'package:bytebankbd/database/app_database.dart';
import 'package:bytebankbd/database/dao/contact_dao.dart';
import 'package:bytebankbd/models/contact.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _accountNumberController = TextEditingController();
  final ContactDao _dao = ContactDao();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Novo Contato')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Nome Completo',
              ),
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextField(
                controller: _accountNumberController,
                decoration: InputDecoration(
                  labelText: 'Número da Conta',
                ),
                style: TextStyle(
                  fontSize: 24.0,
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,//preencher totalmente
                child: RaisedButton(
                    child: Text('Criar'),
                    onPressed: () {
                      final String name = _nameController.text;
                      final int accountNumber = int.tryParse(_accountNumberController.text);
                      final Contact newContact = Contact(0, name, accountNumber);
                      _dao.save(newContact).then((id) {
                        Navigator.pop(context);
                      });
                    }
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
