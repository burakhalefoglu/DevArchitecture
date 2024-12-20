import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

import 'i_address_input.dart';

class GoogleAutoComplete implements IAddressInput {
  @override
  Widget getAddressInput() {
    var controller = TextEditingController();

    return GooglePlaceAutoCompleteTextField(
      textEditingController: controller,
      googleAPIKey: '', //TODO: Add Api Key
      inputDecoration: InputDecoration(),
      debounceTime: 800,
      countries: ["tr_TR"],
      isLatLngRequired: true,
      getPlaceDetailWithLatLng: (Prediction prediction) {
        print("placeDetails" + prediction.lng.toString());
      },
      itemClick: (Prediction prediction) {
        controller.text = prediction.description!;
        controller.selection = TextSelection.fromPosition(
            TextPosition(offset: prediction.description!.length));
      },
      itemBuilder: (context, index, Prediction prediction) {
        return Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const Icon(Icons.location_on),
              const SizedBox(
                width: 7,
              ),
              Expanded(child: Text(prediction.description ?? ""))
            ],
          ),
        );
      },
      seperatedBuilder: const Divider(),
      isCrossBtnShown: true,
      containerHorizontalPadding: 10,
    );
  }
}
