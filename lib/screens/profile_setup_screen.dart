import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/language_provider.dart';
import '../providers/auth_provider.dart';
import '../models/user_profile.dart';
import 'main_navigation.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({Key? key}) : super(key: key);

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _weightController = TextEditingController();
  final _heightController = TextEditingController();
  String _selectedSport = 'Lari';

  @override
  Widget build(BuildContext context) {
    final lang = Provider.of<LanguageProvider>(context);
    final authProvider = Provider.of<AuthUserProvider>(context);
    List<String> sports = [lang.txtRun, lang.txtRide, lang.txtWalk];

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  lang.txtSetupTitle,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: _weightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: lang.txtWeight,
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (val) => val!.isEmpty ? 'Field Required' : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _heightController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: lang.txtHeight,
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (val) => val!.isEmpty ? 'Field Required' : null,
                ),
                const SizedBox(height: 20),
                DropdownButtonFormField<String>(
                  value: _selectedSport == 'Lari'
                      ? lang.txtRun
                      : (_selectedSport == 'Sepeda'
                            ? lang.txtRide
                            : lang.txtWalk),
                  decoration: InputDecoration(
                    labelText: lang.txtPrimarySport,
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  items: sports.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      if (newValue == lang.txtRun) _selectedSport = 'Lari';
                      if (newValue == lang.txtRide) _selectedSport = 'Sepeda';
                      if (newValue == lang.txtWalk)
                        _selectedSport = 'Jalan Kaki';
                    });
                  },
                ),
                const SizedBox(height: 40),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      UserProfile newProfile = UserProfile(
                        uid: authProvider.user!.uid,
                        name: authProvider.user!.displayName ?? 'Athlete',
                        email: authProvider.user!.email ?? '',
                        weight: double.parse(_weightController.text),
                        height: double.parse(_heightController.text),
                        primarySport: _selectedSport,
                      );

                      bool success = await authProvider.createUserProfile(
                        newProfile,
                      );
                      if (success) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const MainNavigation(),
                          ),
                        );
                      }
                    }
                  },
                  child: Text(
                    lang.txtSave,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
