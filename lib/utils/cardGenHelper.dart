import 'package:h_order/constants/cardCompanies.dart';

class CardGenHelper {
  static CardCompanyCode cardCompanyByCardNumber(String cardNumber) {
    final cardLength = cardNumber.replaceAll(" ", "").length;
    CardCompanyCode result = CardCompanyCode.ETC;
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
    CardCompanyCode result = CardCompanyCode.ETC;
    (isFourDigit ? CardCompanies.fourDigitMap : CardCompanies.sixDigitMap)
        .forEach((key, value) {
      if (value.contains(str)) {
        result = key;
      }
    });
    return result;
  }

  static getCardImage({CardCompanyCode code}) {
    return CardCompanies.cardImages[code];
  }
}
