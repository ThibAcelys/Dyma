import 'package:flutter/material.dart';
import 'package:project/model/activity_model.dart';
import 'package:project/provider/city_provider.dart';
import 'package:project/views/activity_form/widgets/activity_form_image_picker.dart';
import 'package:provider/provider.dart';

import 'activity_form_autocomplete.dart';

class ActivityForm extends StatefulWidget {
  final String cityName;
  ActivityForm({required this.cityName});

  @override
  State<ActivityForm> createState() => _ActivityFormState();
}

class _ActivityFormState extends State<ActivityForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  FocusNode? _priceFocusNode;
  FocusNode? _urlFocusNode;
  FocusNode? _addressFocusNode;
  final TextEditingController _urlController = TextEditingController();
  bool _isLoading = false;
  String? _nameInputAsync;
  FormState get form {
    return _formKey.currentState!;
  }

  Activity? newActivity;

  @override
  void initState() {
    newActivity = Activity(
        city: widget.cityName,
        name: '',
        price: 0,
        location: LocationActivity(address: "", longitude: 00, latitude: 00),
        image: '',
        status: ActivityStatus.ongoing);
    _priceFocusNode = FocusNode();
    _urlFocusNode = FocusNode();
    _addressFocusNode = FocusNode();
    _addressFocusNode!.addListener(() async {
      if (_addressFocusNode!.hasFocus) {
        var location = await showInputAutoComplete(context);
      } else {
        print('no focus');
      }
    });
    super.initState();
  }

  void upDateUrlField(String url) {
    setState(() {
      _urlController.text = url;
    });
  }

  Future<void> submitForm() async {
    try {
      CityProvider cityProvider = Provider.of<CityProvider>(
        context,
        listen: false,
      );
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      _nameInputAsync = await cityProvider.verifyIfActivityNameIsUnique(
          widget.cityName, newActivity!.name);
      if (form.validate()) {
        await cityProvider.addActivityToCity(newActivity!);
        Navigator.pop(context);
      } else {
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('error ici');
    }
  }

  void dispose() {
    _priceFocusNode!.dispose();
    _urlFocusNode!.dispose();
    _addressFocusNode!.dispose();
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              autofocus: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Remplissez le nom";
                } else if (_nameInputAsync != null) {
                  return _nameInputAsync;
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: 'Nom',
              ),
              onSaved: (value) => newActivity!.name = value!,
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_priceFocusNode),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              focusNode: _priceFocusNode,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Remplissez le prix";
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              decoration: const InputDecoration(
                hintText: 'Prix',
              ),
              onSaved: (value) => newActivity!.price = double.parse(value!),
              onFieldSubmitted: (_) =>
                  FocusScope.of(context).requestFocus(_urlFocusNode),
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              focusNode: _addressFocusNode,
              decoration: const InputDecoration(
                hintText: 'Adresse',
              ),
              onSaved: (value) => newActivity!.location?.address = value!,
            ),
            const SizedBox(
              height: 30,
            ),
            TextFormField(
              focusNode: _urlFocusNode,
              controller: _urlController,
              keyboardType: TextInputType.url,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Remplissez l'url";
                }
                return null;
              },
              decoration: const InputDecoration(
                hintText: 'Url image',
              ),
              onSaved: (value) => newActivity!.image = value!,
            ),
            const SizedBox(
              height: 30,
            ),
            ActivityFormImagePicker(updateUrl: upDateUrlField),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Annuler')),
                ElevatedButton(
                    onPressed: _isLoading ? null : submitForm,
                    child: const Text('Sauvegarder'))
              ],
            )
          ],
        ),
      ),
    );
  }
}
