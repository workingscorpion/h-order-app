enum CardCompanyText {
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
  static Map<String, String> cardImageByCode = {
    "01": 'assets/cards/bc.png',
    "02": 'assets/cards/kb.png',
    "03": 'assets/cards/hana.png',
    "04": 'assets/cards/samsung.png',
    "06": 'assets/cards/shinhan.png',
    "07": 'assets/cards/hyundai.png',
    "08": 'assets/cards/lotte.png',
    "09": 'assets/cards/hanmi.png',
    "10": 'assets/cards/ssghanmi.png',
    "11": 'assets/cards/citi.png',
    "12": 'assets/cards/nh.png',
    "13": 'assets/cards/sh.png',
    "14": 'assets/cards/cu.png',
    "15": 'assets/cards/woori.png',
    "16": 'assets/cards/hana.png',
    "21": 'assets/cards/gwanju.png',
    "22": 'assets/cards/jeonbuk.png',
    "23": 'assets/cards/jeju.png',
    "24": 'assets/cards/saneun.png',
    "25": 'assets/cards/visa.png',
    "26": 'assets/cards/master.png',
    "27": 'assets/cards/diners.png',
    "28": 'assets/cards/amx.png',
    "29": 'assets/cards/jcb.png',
    "31": 'assets/cards/okcashbag.png',
    "32": 'assets/cards/post.png',
    "33": 'assets/cards/sbi.png',
    "34": 'assets/cards/china.png',
    "35": 'assets/cards/mg.png',
    "36": 'assets/cards/kdb.png',
    "37": 'assets/cards/kakaobank.png',
    "38": 'assets/cards/kbank.png',
    "39": 'assets/cards/payco.png',
    "40": 'assets/cards/kakaomoney.png',
    "41": 'assets/cards/ssgmoney.png',
    "42": 'assets/cards/naver.png',
    "99": 'assets/cards/etc.png',
  };

  static Map<String, String> cardNameByCode = {
    "01": 'BC카드',
    "02": 'KB국민',
    "03": '하나카드',
    "04": '삼성카드',
    "06": '신한카드',
    "07": '현대카드',
    "08": '롯데카드',
    "09": '한미카드',
    "10": '신세계한미카드',
    "11": '씨티카드',
    "12": 'NH농협카드',
    "13": '수협카드',
    "14": '신협카드',
    "15": '우리카드',
    "16": '하나카드',
    "21": '광주은행',
    "22": '전북은행',
    "23": '제주은행',
    "24": '산은',
    "25": '비자카드',
    "26": '마스터(마에스트로)카드',
    "27": '다이너스카드',
    "28": '아메리칸 익스프레스 카드',
    "29": 'JCB카드',
    "31": 'OK캐시백',
    "32": '우체국',
    "33": 'SBI저축은행',
    "34": '은련',
    "35": '새마을금고',
    "36": 'KDB캐피탈',
    "37": '카카오뱅크',
    "38": '케이뱅크',
    "39": '페이코',
    "40": '카카오페이',
    "41": '신세계페이',
    "42": '네이버페이',
    "99": '기타',
  };

  static Map<CardCompanyText, String> cardImages = {
    CardCompanyText.BC: 'assets/cards/bc.png',
    CardCompanyText.KB: 'assets/cards/kb.png',
    CardCompanyText.HANA: 'assets/cards/hana.png',
    CardCompanyText.SAMSUNG: 'assets/cards/samsung.png',
    CardCompanyText.SHINHAN: 'assets/cards/shinhan.png',
    CardCompanyText.HYUNDAI: 'assets/cards/hyundai.png',
    CardCompanyText.LOTTE: 'assets/cards/lotte.png',
    CardCompanyText.HANMI: 'assets/cards/hanmi.png',
    CardCompanyText.SSGHANMI: 'assets/cards/ssghanmi.png',
    CardCompanyText.CITI: 'assets/cards/citi.png',
    CardCompanyText.NH: 'assets/cards/nh.png',
    CardCompanyText.SH: 'assets/cards/sh.png',
    CardCompanyText.CU: 'assets/cards/cu.png',
    CardCompanyText.WOORI: 'assets/cards/woori.png',
    CardCompanyText.GWANJU: 'assets/cards/gwanju.png',
    CardCompanyText.JEONBUK: 'assets/cards/jeonbuk.png',
    CardCompanyText.JEJU: 'assets/cards/jeju.png',
    CardCompanyText.SANEUN: 'assets/cards/saneun.png',
    CardCompanyText.VISA: 'assets/cards/visa.png',
    CardCompanyText.MASTER: 'assets/cards/master.png',
    CardCompanyText.DINERS: 'assets/cards/diners.png',
    CardCompanyText.AMX: 'assets/cards/amx.png',
    CardCompanyText.JCB: 'assets/cards/jcb.png',
    CardCompanyText.OKCASHBAG: 'assets/cards/okcashbag.png',
    CardCompanyText.POST: 'assets/cards/post.png',
    CardCompanyText.SBI: 'assets/cards/sbi.png',
    CardCompanyText.CHINA: 'assets/cards/china.png',
    CardCompanyText.MG: 'assets/cards/mg.png',
    CardCompanyText.KDB: 'assets/cards/kdb.png',
    CardCompanyText.KAKAOBANK: 'assets/cards/kakaobank.png',
    CardCompanyText.KBANK: 'assets/cards/kbank.png',
    CardCompanyText.PAYCO: 'assets/cards/payco.png',
    CardCompanyText.KAKAOMONEY: 'assets/cards/kakaomoney.png',
    CardCompanyText.SSGMONEY: 'assets/cards/ssgmoney.png',
    CardCompanyText.NAVER: 'assets/cards/naver.png',
    CardCompanyText.ETC: 'assets/cards/etc.png',
  };

  static Map<CardCompanyText, List<String>> fourDigitMap = {
    CardCompanyText.BC: [
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
    CardCompanyText.KB: ['4673'],
    CardCompanyText.HANA: [
      '4655',
      '5441',
      '6244',
    ],
    CardCompanyText.HYUNDAI: ['3616'],
    CardCompanyText.WOORI: [
      '4061',
      '4062',
      '4063',
      '4064',
      '4065',
    ],
    CardCompanyText.KBANK: ['4656'],
    CardCompanyText.VISA: ['4450'],
    CardCompanyText.MASTER: ['5898'],
    CardCompanyText.ETC: [
      '4656',
      '9000',
    ]
  };

  static Map<CardCompanyText, List<String>> sixDigitMap = {
    CardCompanyText.BC: [
      '404825',
      '414025',
      '538159',
      '942150',
      '943150',
      '944603',
      '356820',
      '404678',
      '440025',
      '447320',
      '490220',
      '493455',
      '538720',
      '944520',
    ],
    CardCompanyText.KB: [
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
    CardCompanyText.HANA: [
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
      '455437',
      '457047',
      '459900',
      '459930',
      '459950',
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
    CardCompanyText.SAMSUNG: [
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
    CardCompanyText.SHINHAN: [
      '356900',
      '356901',
      '356902',
      '377981',
      '377982',
      '379983',
      '377988',
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
    CardCompanyText.HYUNDAI: [
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
    CardCompanyText.LOTTE: [
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
    CardCompanyText.CITI: [
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
    CardCompanyText.NH: [
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
    CardCompanyText.SH: [
      '421417',
      '421418',
      '422190',
      '432445',
      '465889',
      '940701',
      '940702',
    ],
    CardCompanyText.WOORI: [
      '421420',
      '515954',
      '535020',
      '537120',
      '537145',
      '538920',
      '548020',
      '552220',
      '657020',
      '942520',
    ],
    CardCompanyText.GWANJU: [
      '459952',
      '953003',
    ],
    CardCompanyText.JEJU: [
      '463916',
    ],
    CardCompanyText.KAKAOBANK: [
      '536510',
    ],
    CardCompanyText.KBANK: [
      '459912',
    ],
    CardCompanyText.ETC: [
      '443233',
      '949130',
    ],
  };
}
