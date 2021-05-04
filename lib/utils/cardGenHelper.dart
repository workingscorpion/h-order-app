import 'package:h_order/constants/cardCompanies.dart';

class CardGenHelper {
  static CardCompanyText cardCompanyByCardNumber(String cardNumber) {
    final cardLength = cardNumber.replaceAll(" ", "").length;
    CardCompanyText result = CardCompanyText.ETC;
    if (cardLength >= 4 && cardLength < 6) {
      result =
          getCardCompanies(str: cardNumber.substring(0, 4), isFourDigit: true);
    } else if (cardLength >= 6) {
      result =
          getCardCompanies(str: cardNumber.substring(0, 6), isFourDigit: false);
    }

    return result;
  }

  static getCardCompanies({String str, bool isFourDigit}) {
    CardCompanyText result = CardCompanyText.ETC;
    (isFourDigit ? CardCompanies.fourDigitMap : CardCompanies.sixDigitMap)
        .forEach((key, value) {
      if (value.contains(str)) {
        result = key;
      }
    });
    return result;
  }

  static getCardImage({CardCompanyText text}) {
    return CardCompanies.cardImages[text];
  }
}
