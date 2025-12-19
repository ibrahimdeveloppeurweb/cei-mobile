import 'package:cei_mobile/screens/candidature/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:cei_mobile/store/CandidatureStore.dart';

class FiliationStep extends StatelessWidget {
  final CandidatureStore store;

  const FiliationStep({Key? key, required this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Observer(
        builder: (_) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommonWidgets.buildStepTitle('Filiation du candidat'),
            CommonWidgets.buildLegalReference('Article 53 - Informations sur les parents requises'),
            24.height,
            _buildFiliationSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildFiliationSection() {
    return Column(
      children: [
        // Père
        CommonWidgets.buildSectionCard(
          title: 'Informations sur le père',
          icon: Icons.person,
          children: [
            CommonWidgets.buildTextField(
              label: 'Nom et prénoms du père *',
              hint: 'Nom complet du père',
              initialValue: store.filiationPere,
              onChanged: (value) => store.filiationPere = value,
            ),
            12.height,
            Row(
              children: [
                Expanded(
                  child: CommonWidgets.buildDateField(
                    label: 'Date de naissance du père',
                    selectedDate: store.dateNaissancePere,
                    onChanged: (date) => store.dateNaissancePere = date,
                  ),
                ),
                16.width,
                Expanded(
                  child: CommonWidgets.buildTextField(
                    label: 'Lieu de naissance du père',
                    hint: 'Lieu de naissance',
                    initialValue: store.lieuNaissancePere,
                    onChanged: (value) => store.lieuNaissancePere = value,
                  ),
                ),
              ],
            ),
            12.height,
            CommonWidgets.buildTextField(
              label: 'Nationalité du père',
              hint: 'Nationalité',
              initialValue: store.nationalitePere,
              onChanged: (value) => store.nationalitePere = value,
            ),
          ],
        ),
        16.height,
        // Mère
        CommonWidgets.buildSectionCard(
          title: 'Informations sur la mère',
          icon: Icons.person,
          children: [
            CommonWidgets.buildTextField(
              label: 'Nom et prénoms de la mère *',
              hint: 'Nom complet de la mère',
              initialValue: store.filiationMere,
              onChanged: (value) => store.filiationMere = value,
            ),
            12.height,
            Row(
              children: [
                Expanded(
                  child: CommonWidgets.buildDateField(
                    label: 'Date de naissance de la mère',
                    selectedDate: store.dateNaissanceMere,
                    onChanged: (date) => store.dateNaissanceMere = date,
                  ),
                ),
                16.width,
                Expanded(
                  child: CommonWidgets.buildTextField(
                    label: 'Lieu de naissance de la mère',
                    hint: 'Lieu de naissance',
                    initialValue: store.lieuNaissanceMere,
                    onChanged: (value) => store.lieuNaissanceMere = value,
                  ),
                ),
              ],
            ),
            12.height,
            CommonWidgets.buildTextField(
              label: 'Nationalité de la mère',
              hint: 'Nationalité',
              initialValue: store.nationaliteMere,
              onChanged: (value) => store.nationaliteMere = value,
            ),
          ],
        ),
      ],
    );
  }
}