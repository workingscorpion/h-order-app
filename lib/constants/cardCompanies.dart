enum CardCompanyCode {
  BC,
  KB,
  HANA,
  SAMSUNG,
  SHINHAN,
  HYUNDAI,
  LOTTE,
  HANMI,
  SSGHANMI,
  CITI,
  NH,
  SH,
  CU,
  WOORI,
  GWANJU,
  JEONBUK,
  JEJU,
  SANEUN,
  VISA,
  MASTER,
  DINERS,
  AMX,
  JCB,
  OKCASHBAG,
  POST,
  SBI,
  CHINA,
  MG,
  KDB,
  KAKAOBANK,
  KBANK,
  PAYCO,
  KAKAOMONEY,
  SSGMONEY,
  NAVER,
  ETC,
}

class CardCompanies {
  static Map<CardCompanyCode, String> cardImages = {
    CardCompanyCode.BC: 'assets/cards/bc.png',
    CardCompanyCode.KB: 'assets/cards/kb.png',
    CardCompanyCode.HANA: 'assets/cards/hana.png',
    CardCompanyCode.SAMSUNG: 'assets/cards/samsung.png',
    CardCompanyCode.SHINHAN: 'assets/cards/shinhan.png',
    CardCompanyCode.HYUNDAI: 'assets/cards/hyundai.png',
    CardCompanyCode.LOTTE: 'assets/cards/lotte.png',
    CardCompanyCode.HANMI: 'assets/cards/hanmi.png',
    CardCompanyCode.SSGHANMI: 'assets/cards/ssghanmi.png',
    CardCompanyCode.CITI: 'assets/cards/citi.png',
    CardCompanyCode.NH: 'assets/cards/nh.png',
    CardCompanyCode.SH: 'assets/cards/sh.png',
    CardCompanyCode.CU: 'assets/cards/cu.png',
    CardCompanyCode.WOORI: 'assets/cards/woori.png',
    CardCompanyCode.GWANJU: 'assets/cards/gwanju.png',
    CardCompanyCode.JEONBUK: 'assets/cards/jeonbuk.png',
    CardCompanyCode.JEJU: 'assets/cards/jeju.png',
    CardCompanyCode.SANEUN: 'assets/cards/saneun.png',
    CardCompanyCode.VISA: 'assets/cards/visa.png',
    CardCompanyCode.MASTER: 'assets/cards/master.png',
    CardCompanyCode.DINERS: 'assets/cards/diners.png',
    CardCompanyCode.AMX: 'assets/cards/amx.png',
    CardCompanyCode.JCB: 'assets/cards/jcb.png',
    CardCompanyCode.OKCASHBAG: 'assets/cards/okcashbag.png',
    CardCompanyCode.POST: 'assets/cards/post.png',
    CardCompanyCode.SBI: 'assets/cards/sbi.png',
    CardCompanyCode.CHINA: 'assets/cards/china.png',
    CardCompanyCode.MG: 'assets/cards/mg.png',
    CardCompanyCode.KDB: 'assets/cards/kdb.png',
    CardCompanyCode.KAKAOBANK: 'assets/cards/kakaobank.png',
    CardCompanyCode.KBANK: 'assets/cards/kbank.png',
    CardCompanyCode.PAYCO: 'assets/cards/payco.png',
    CardCompanyCode.KAKAOMONEY: 'assets/cards/kakaomoney.png',
    CardCompanyCode.SSGMONEY: 'assets/cards/ssgmoney.png',
    CardCompanyCode.NAVER: 'assets/cards/naver.png',
    CardCompanyCode.ETC: 'assets/cards/etc.png',
  };

  static Map<CardCompanyCode, List<String>> fourDigitMap = {
    CardCompanyCode.BC: [
      "4162",
      "9440",
      "3560",
      "3563",
      "3565",
      "4481",
      "4553",
      "4906",
      "5388",
      "6048",
      "6360",
      "6210",
      "6253",
      "6541",
      "6556",
      "9410",
      "9420",
      "9430",
      "9460",
      "9461"
    ],
    CardCompanyCode.KB: ['4673'],
    CardCompanyCode.HANA: [
      '4655',
      '5441',
      '6244',
    ],
    CardCompanyCode.HYUNDAI: ['3616'],
    CardCompanyCode.WOORI: [
      '4061',
      '4062',
      '4063',
      '4064',
      '4065',
    ],
    CardCompanyCode.KBANK: ['4656'],
    CardCompanyCode.VISA: ['4450'],
    CardCompanyCode.MASTER: ['5898'],
    CardCompanyCode.ETC: [
      '4656',
      '9000',
    ]
  };

  static Map<CardCompanyCode, List<String>> sixDigitMap = {
    CardCompanyCode.BC: [
      '404825',
      '414025',
      '538159',
      '942150',
      '943150',
      '944603',
    ],
    CardCompanyCode.KB: [
      '356407',
      '356415',
      '356416',
      '356417',
      '356910',
      '356911',
      '356912',
      '375144',
      '376364',
      '376364',
      '433290',
      '457972',
      '457973',
      '502123',
      '522971',
      '527289',
      '523612',
      '540926',
      '540947',
      '554346',
      '554959',
      '557042',
      '558526',
      '502123',
      '623374',
      '625804',
      '943645',
      '943646',
      '944541',
      '944542',
      '944547',
      '949094',
    ],
    CardCompanyCode.HANA: [
      '356543',
      '356545',
      '371001',
      '371002',
      '371003',
      '374722',
      '374723',
      '374724',
      '377969',
      '379192',
      '379193',
      '402367',
      '408966',
      '411900',
      '411904',
      '411905',
      '418236',
      '440025',
      '455437',
      '457047',
      '459900',
      '459930',
      '459950',
      '493455',
      '516574',
      '518185',
      '523830',
      '524242',
      '524335',
      '524353',
      '531838',
      '532092',
      '546252',
      '553177',
      '502928',
      '636189',
      '626261',
      '941181',
    ],
    CardCompanyCode.SAMSUNG: [
      '375987',
      '377989',
      '379183',
      '400912',
      '451245',
      '458532',
      '464942',
      '470587',
      '470588',
      '512360',
      '518831',
      '531070',
      '540447',
      '552070',
      '625817',
      '941009',
      '941029',
      '941034',
      '941085',
      '941088',
      '941090',
      '942090',
    ],
    CardCompanyCode.SHINHAN: [
      '356900',
      '356901',
      '356902',
      '377981',
      '377982',
      '379983',
      '377988',
      '404678',
      '405753',
      '422155',
      '430972',
      '434975',
      '436420',
      '438676',
      '449914',
      '451842',
      '451845',
      '460561',
      '461954',
      '465887',
      '510737',
      '511187',
      '515594',
      '517134',
      '542158',
      '542879',
      '552576',
      '559410',
      '606045',
      '624348',
      '941061',
      '941083',
      '941098',
      '941161',
      '942061',
    ],
    CardCompanyCode.HYUNDAI: [
      '402857',
      '418123',
      '433028',
      '451281',
      '524333',
      '543333',
      '552290',
      '552377',
      '559924',
      '949013',
      '949019',
      '949028',
      '949088',
      '949097',
    ],
    CardCompanyCode.LOTTE: [
      '356914',
      '356915',
      '356916',
      '376272',
      '376277',
      '377973',
      '421468',
      '464959',
      '467008',
      '488972',
      '512462',
      '513792',
      '625104',
      '625904',
      '940915',
      '940951',
    ],
    CardCompanyCode.CITI: [
      '406357',
      '410109',
      '422727',
      '440446',
      '462890',
      '474360',
      '514876',
      '524144',
      '588644',
      '940010',
    ],
    CardCompanyCode.NH: [
      '356316',
      '356317',
      '356418',
      '356516',
      '485479',
      '524040',
      '524041',
      '543000',
      '543017',
      '542416',
      '546112',
      '941116',
      '944116',
      '946316',
    ],
    CardCompanyCode.SH: [
      '421417',
      '421418',
      '422190',
      '432445',
      '465889',
      '940701',
      '940702',
    ],
    CardCompanyCode.WOORI: [
      '356820',
      '421420',
      '447320',
      '490220',
      '515954',
      '535020',
      '537120',
      '537145',
      '538720',
      '538920',
      '548020',
      '552220',
      '657020',
      '942520',
      '944520',
    ],
    CardCompanyCode.GWANJU: [
      '459952',
      '953003',
    ],
    CardCompanyCode.JEJU: [
      '463916',
    ],
    CardCompanyCode.KAKAOBANK: [
      '536510',
    ],
    CardCompanyCode.KBANK: [
      '459912',
    ],
    CardCompanyCode.ETC: [
      '443233',
      '949130',
    ],
  };
}
