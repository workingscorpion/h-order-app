import 'dart:convert';

import 'package:h_order/models/categoryModel.dart';
import 'package:h_order/models/historyDetailModel.dart';
import 'package:h_order/models/historyModel.dart';
import 'package:h_order/models/homeModel.dart';
import 'package:h_order/models/keyValueModel.dart';
import 'package:h_order/models/noticeModel.dart';
import 'package:h_order/models/productModel.dart';
import 'package:h_order/models/productOptionModel.dart';
import 'package:h_order/models/serviceModel.dart';

abstract class SampleData {
  static final String homeJson = '''{
  "room": "202호",
  "name": "김커먼",
  "address": "서울특별시 구로구 경인로 67길 67 신도림081 (우: 08208)",
  "phone": "02-1234-5678",
  "cellPhone": "010-1234-5678",
  "emergencyPhone": "-",
  "contractStartDate": "2020-01-01",
  "contractEndDate": "2021-12-31",
  "roomDetail": "남동 202호 (42.9 m2  / C-1타입)",
  "contractType": "렌트비   ㅣ   월 1,040,000원",
  "items": [
    "현관 출입카드 1매​",
    "시스템 에어컨 리모컨 1개​",
    "우편함 열쇠 2개",
    "H-Order 패드 1개"
  ],
  "bannerImages": [
    "assets/sample/commontown/banner/1.png",
    "assets/sample/commontown/banner/2.png",
    "assets/sample/commontown/banner/3.png"
  ],
  "serviceImages": [
    "assets/sample/commontown/service/se1.png",
    "assets/sample/commontown/service/se2.png",
    "assets/sample/commontown/service/se3.png",
    "assets/sample/commontown/service/se4.png"
  ]
}''';

  static final String noticeJson = '''[
  {
    "index": 7,
    "isRead": true,
    "title": "5월 커뮤니티 프로그램을 소개합니다.",
    "writer": "커먼매니저",
    "content": "<div _ngcontent-jmp-c18=\\"\\" class=\\"content_blog flex_col col1\\"><div class=\\"blog_content_paragraph body2\\">커먼타운은 비슷한 취향을 가진 멤버들이 만나서 즐거운 활동을 하며 관계를 쌓아갈 수 있도록 매월 다양한 <a href=\\"https://www.commontown.co/ko/community-detail\\">커뮤니티 프로그램</a>을 진행하고 있는데요. 코로나19로부터 멤버들의 건강을 지키기 위해 중단되었던 커뮤니티 프로그램을 5월 24일부터 다시 재개합니다. 코로나19로 면역력이 부쩍 약해진 멤버들을 위해, 면역력 증강과 체력 회복에 도움이 되는 다양한 프로그램을 준비했어요.</div><div class=\\"blog_content_paragraph body2\\">* 아직 코로나19 확산세가 줄어들지 않은 만큼, 커먼타운은 모든 커먼타운 멤버의 안전을 최우선으로 고려하여 프로그램 진행의 모든 과정에서 주의를 기울일 예정입니다.</div><div class=\\"blog_content_paragraph body2\\">* 코로나19로 인해 프로그램 진행이 어렵다고 판단될 시, 프로그램은 취소될 수 있습니다.</div><div class=\\"blog_content_heading1 title7\\">5월의 커뮤니티 프로그램</div><div class=\\"blog_content_image img_blog\\"><img src=\\"https://images.prismic.io/commontown-sales/23b28990-71dd-4991-8a4b-ef84cfa52b22_6326affe-8475-4cdd-ad1f-d0048b17c9fd.png?auto=compress,format&amp;w=720\\"></div><ul><li class=\\"blog_content_list_item body2\\">5월 24일 : 면역력 증강을 위한 한강 러닝<br>사회적 거리두기로 신체 활동이 줄어든 요즘. 한강 러닝을 함께하며, 약해진 면역력을 높여보세요.</li></ul><div class=\\"blog_content_image img_blog\\"><img src=\\"https://images.prismic.io/commontown-sales/77a88e73-caa6-43cf-8d38-80499eb5a951_20200504_210746.jpg?auto=compress,format&amp;w=720\\"></div><ul><li class=\\"blog_content_list_item body2\\">5월 25일 : 공간으로 이해하는 서울의 역사 (남산 편)<br>오늘날 낭만적인 공간으로만 인식되는 남산. 원창님과 한양도성 남산 구간을 함께 걸으며, 그 속에 숨어있는 역사와 이야기를 들어보는 시간을 가집니다.<br>일제 강점기 시기, 일본이 남산 중턱을 파괴하고 세운 ‘조선신궁’은 일제 식민 지배 상징 역할을 하기도 했으며, 그 외에도 남산 곳곳에는 여러 역사적 반전이 서려 있습니다. 일제 강점기 시기 남산이 겪었던 슬프고 아픈 이야기를 들으며, 또 다른 시각에서 바라보는 남산의 풍경은 어떠한 모습일 지 함께 경험해봐요.</li></ul><div class=\\"blog_content_image img_blog\\"><img src=\\"https://images.prismic.io/commontown-sales/80b70844-925a-489e-9b7b-a5273288cb0c_%E1%84%80%E1%85%AA%E1%86%AB%E1%84%8B%E1%85%A1%E1%86%A8%E1%84%89%E1%85%A1%E1%86%AB1.JPG?auto=compress,format&amp;w=720\\"></div><ul><li class=\\"blog_content_list_item body2\\">5월 26일 : 서울의 명산 관악산 야경 트레킹<br>원창님과 함께하는 야경 트레킹. 서울 남부를 대표하는 산, 관악산을 함께 오르며 목동부터 강남, 잠실에 이르는 서울 강남 지역의 야경을 한 눈에 담아보세요.<br></li></ul><div class=\\"blog_content_image img_blog\\"><img src=\\"https://images.prismic.io/commontown-sales/3574a317-39a6-4f82-b7a8-256b6d7f326f_ba29b103-c46d-4721-8d0d-a6ec87388df4.png?auto=compress,format&amp;w=720\\"></div><ul><li class=\\"blog_content_list_item body2\\">5월 27일 : 마음 근육을 키워가는 빈야사 요가<br>진선님과 함께하는 빈야사 요가. 견고하고 단단한 움직임으로 나의 몸을 바라봅니다. 역동적인 동작을 통해 몸이 가벼워지고 즐거워지는 경험을 하면, 복잡한 생각과 감정은 나에게서 점점 멀어질거에요.</li></ul><div class=\\"blog_content_paragraph body2\\">즐거운 만남이 가득한 커뮤니티 리빙, 커먼타운의 하우스가 궁금하시다면 <a href=\\"https://www.commontown.co/ko/house-list/seoul/all\\">이곳</a>을 클릭해 커먼타운에 대해 더 자세히 알아보세요.</div></div>",
    "createdTime": "2021-04-19"
  },
  {
    "index": 6,
    "isRead": true,
    "title": "커먼타운의 코로나 19 대응정책",
    "writer": "커먼매니저",
    "content": "<div _ngcontent-jmp-c18=\\"\\" class=\\"content_blog flex_col col1\\"><div class=\\"blog_content_heading1 title7\\">커먼타운은 모든 커먼타운 멤버의 안전을 최우선으로 고려해, 코로나19 대응정책을 마련하여 하우스를 운영하고 있습니다.</div><div class=\\"blog_content_paragraph body2\\">신규 멤버의 하우스 투어와 입주는 아래와 같이 진행하고 있습니다.</div><ul><li class=\\"blog_content_list_item body2\\">신규 입주자의 하우스 투어를 최소로 진행하기 위해, VR 투어를 권장하고 있습니다.</li><li class=\\"blog_content_list_item body2\\">하우스 투어 전, 해당 하우스 멤버에게 하우스 투어가 있음을 공지합니다. (다인실 투어의 경우 기존 멤버들이 외부인의 방 출입에 대해 불편을 느낄시, 커먼타운은 이를 존중하여 VR투어로 대체할 것입니다.)</li><li class=\\"blog_content_list_item body2\\">하우스 투어 진행시 신규 입주자와 직원 모두 사전에 체온을 측정하고, 마스크 착용을 의무화합니다.</li><li class=\\"blog_content_list_item body2\\">신규 입주자는 입주 확정 전, 해외 방문 이력 및 집단 발병과 관련되어 있는 지 여부 등을 &lt;코로나19 관련 서약서&gt; 제출을 통해 확인합니다.</li></ul><div class=\\"blog_content_paragraph body2\\">하우스 방문을 통한 관리를 위해, 모든 매니저는 예방규칙을 준수하고 있습니다.</div><ul><li class=\\"blog_content_list_item body2\\">하우스 관리를 위해 방문하는 모든 커먼타운 매니저는 사전에 체온 측정을 진행하고, 마스크 착용을 의무화합니다.</li><li class=\\"blog_content_list_item body2\\">코로나19 의심 증상(발열 여부 - 체온 37.5℃ 이상, 호흡기 증상 - 기침, 인후통 등)이 나타나면 하우스 방문은 취소되며, 즉시 코로나19 검사를 시행합니다.</li><li class=\\"blog_content_list_item body2\\">매니저의 건강 문제로 서비스 제공일정이 변경될 경우, 문자로 사전 공지합니다. (서비스 당일 오전 내 발송)</li></ul><div class=\\"blog_content_paragraph body2\\">코로나19 예방을 위해 하우스 청소 진행시 아래와 같은 조치를 추가로 시행합니다.</div><ul><li class=\\"blog_content_list_item body2\\">매주 진행하는 공용공간 청소 서비스는 계속 진행됩니다.</li><li class=\\"blog_content_list_item body2\\">청소 서비스 진행시 기본적인 방역 작업을 함께 진행합니다.</li><li class=\\"blog_content_list_item body2\\">접촉이 많은 부분(각종 손잡이, 세탁기, 건조기, 정수기 등 가전제품 버튼 등)을 소독합니다.</li><li class=\\"blog_content_list_item body2\\">하우스 내부에 살균 소독제와 손 세정제를 상시 비치하여, 멤버들이 수시로 사용할 수 있도록 했습니다.</li></ul><div class=\\"blog_content_paragraph body2\\">친구 혹은 지인을 하우스에 초대하는 것에 대해, 커먼타운은 일시적으로 규제 조치를 시행합니다.</div><div class=\\"blog_content_paragraph body2\\">[트리하우스]</div><ul><li class=\\"blog_content_list_item body2\\">모든 커먼타운 멤버의 안전을 위해, 지인의 하우스 출입을 최소화해주세요.</li><li class=\\"blog_content_list_item body2\\">부득이하게 외부인이 방문해야할 경우, 메인 출입구에서 방문 대장을 작성해야 출입이 가능합니다. (이름, 연락처, 체온, 방문 목적, 해외 방문 이력 등을 기록합니다.)</li><li class=\\"blog_content_list_item body2\\">외부인과 함께 사용하는 경우가 많은 6층 테라스의 바비큐 장비 대여 서비스는 잠정 중단합니다.</li></ul><div class=\\"blog_content_paragraph body2\\">[그 외 하우스]</div><ul><li class=\\"blog_content_list_item body2\\">커먼타운은 커먼타운 멤버의 안전을 최우선으로 고려하여 트리하우스 외 모든 하우스의 지인 초대 및 방문을 제한합니다.</li></ul><div class=\\"blog_content_paragraph body2\\">커뮤니티 프로그램의 안전한 진행을 위해 아래와 같은 정책을 마련했습니다.</div><ul><li class=\\"blog_content_list_item body2\\">커먼타운 매니저는 프로그램 진행의 모든 단계에서 프로그램을 안전하게 진행하기 위해 노력하겠습니다.</li><li class=\\"blog_content_list_item body2\\">커뮤니티 프로그램에 참석하는 모든 멤버는 사전 체온 측정을 진행해야 합니다.</li><li class=\\"blog_content_list_item body2\\">코로나19 의심 증상이 있는 경우, 프로그램 참석을 제한합니다.</li><li class=\\"blog_content_list_item body2\\">프로그램 진행 시 참석하는 모든 사람의&nbsp; 마스크 착용을 의무화합니다.</li><li class=\\"blog_content_list_item body2\\">코로나19 확산 추이에 따라 해당 일정에 맞춰 프로그램을 진행하는 것이 어렵다고 판단될 시, 프로그램이 사전에 취소될 수 있습니다. (프로그램 취소 공지는 당일 오전까지 멤버에게 문자로 발송합니다.)</li><li class=\\"blog_content_list_item body2\\">프로그램을 조금 더 안전한 방식으로 운영하기 위해, 밀폐된 공간에서 진행하는 프로그램은 지양하고 있으며, 실외에서 진행할 수 있는 프로그램 위주로 진행하고 있습니다.</li></ul></div>",
    "createdTime": "2021-04-17"
  },
  {
    "index": 5,
    "isRead": true,
    "title": "함께 사용해서 더 좋은, 커먼타운 '키친'",
    "writer": "커먼매니저",
    "content": "<div _ngcontent-jmp-c18=\\"\\" class=\\"content_blog flex_col col1\\"><div class=\\"blog_content_paragraph body2\\">커먼타운에 사는 멤버들은 식사 시간이 외롭지 않습니다. 이유가 무엇이냐고 물으신다면, 확실하게 대답할 수 있습니다. 말 그대로입니다.</div><div class=\\"blog_content_heading1 title7\\">‘함께 밥 먹을 수 있으니까요.‘</div><div class=\\"blog_content_paragraph body2\\">사실, 함께 밥 먹는다는 것은 많은 의미를 내포하고 있습니다.</div><div class=\\"blog_content_paragraph body2\\">여러 명이 테이블에 둘러앉아도 불편함이 없어야 하고, 음식을 준비할 때도 동선에 제약이 없어야 합니다. 그리고 음식을 보관할 공간도 충분해야 합니다. 먹을 식기도 부족함이 없어야 하고요. 물론, 기꺼이 소중한 저녁 시간을 함께 보내고 싶을 만큼, 좋은 사람들이 있어야 하죠.</div><div class=\\"blog_content_paragraph body2\\">하지만 이 모든 조건을 완벽하게 충족하는 것은 생각보다 어렵습니다. 함께 식사하기 위해서 따로 만남을 갖는 ‘소셜 다이닝’의 개념이 주목받는 것도 같은 맥락입니다. 음식을 나누며, 여러 이야기 나눌 수 있는 환경과 조건을, 1인 가구가 늘어나는 현실에서 모두 챙기는 것이 힘들기 때문입니다.</div><div class=\\"blog_content_paragraph body2\\">커먼타운이 공용 공간, 특히, 키친을 제대로 마련하는 데 큰 노력을 기울인 것도 이 때문입니다. 적어도 커먼타운의 멤버라면, 함께 밥을 먹으며, 도란도란 대화할 수 있는 그 시간을 누구나 누릴 수 있도록 배려하고 싶었습니다.</div><div class=\\"blog_content_paragraph body2\\">﻿</div><div class=\\"blog_content_paragraph body2\\">﻿</div><div class=\\"blog_content_heading1 title7\\">다용도로 활용 가능한 넓은 테이블!</div><div class=\\"blog_content_image img_blog\\"><img src=\\"https://images.prismic.io/commontown-sales/e5ea05bb-32ac-4ff7-b4b6-92200bf7e9d6_2.+%E1%84%8B%E1%85%B5%E1%84%90%E1%85%A2%E1%84%8B%E1%85%AF%E1%86%AB+512.jpg?auto=compress,format&amp;w=720\\"></div><div class=\\"blog_content_paragraph body2\\">멤버가 함께 식사할 수 있는 넓은 테이블이 있습니다. 이곳은 식사는 물론, 커피나 맥주를 마시는 공간이 될 수 있고, 개인 작업을 할 수 있는 워크스테이션이 될 수도 있습니다. 그만큼 다용도로 활용하기 좋습니다. 게다가 커먼타운의 다이닝 공간은 인테리어가 특별합니다. 조명, 식탁보 등 멋진 소품이 이곳에서 보내는 시간을 더 빛나게 합니다.</div><div class=\\"blog_content_paragraph body2\\">혼자 밥 먹고 싶을 때도 있을 텐데, 넓은 테이블이 괜히 불편할 것 같다고요? 걱정하지 마세요. 혼밥족을 위한 바 테이블이 마련된 하우스도 있습니다.</div><div class=\\"blog_content_paragraph body2\\">﻿</div><div class=\\"blog_content_paragraph body2\\">﻿</div><div class=\\"blog_content_heading1 title7\\">주방 집기, 모두 세팅 완료!</div><div class=\\"blog_content_image img_blog\\"><img src=\\"https://images.prismic.io/commontown-sales/6beeb82e-9f6f-41f9-8346-97d681b2a4ec_3.+%E1%84%8B%E1%85%B5%E1%86%B8%E1%84%80%E1%85%AE%E1%84%8C%E1%85%A5%E1%86%BC+023+%E1%84%8F%E1%85%B5%E1%84%8E%E1%85%B5%E1%86%AB.jpg?auto=compress,format&amp;w=720\\"></div><div class=\\"blog_content_paragraph body2\\">주방에서 사용하는 집기들은 생각보다 가짓수가 많습니다. 젓가락, 숟가락부터 크고 작은 접시, 간단하게 요리할 수 있는 냄비와 프라이팬까지. 그래서 커먼타운이 프라이팬, 밥솥, 냄비, 도마, 집게 등 공용 집기들은 물론이고 접시, 숟가락, 젓가락 등 개인 집기들까지 전부 다 마련했습니다.</div><div class=\\"blog_content_paragraph body2\\">멤버들과 예쁜 그릇에 사이 좋게 식사를 할 수 있겠죠? 넉넉하게 준비되어 있어, 언제든 부담 없이 쓸 수 있습니다.</div><div class=\\"blog_content_paragraph body2\\">﻿</div><div class=\\"blog_content_paragraph body2\\">﻿</div><div class=\\"blog_content_paragraph body2\\">넓은 다이닝 공간, 고급 집기들, 음식물 냉동고 등은 한 차원 높은 생활을 누리는 데 큰 도움이 될 거예요.</div><div class=\\"blog_content_heading1 title7\\">오로지 커먼타운에서 함께 살기 때문에 누릴 수 있는 것이죠.</div><div class=\\"blog_content_paragraph body2\\">어떤가요? 이곳에서 살고 싶지 않은가요?</div><div class=\\"blog_content_paragraph body2\\">함께 사용해서 더 좋은 집, 커먼타운에서 살아보세요.﻿</div></div>",
    "createdTime": "2021-04-09"
  },
  {
    "index": 4,
    "isRead": true,
    "title": "커먼타운데 살며 편하게 전입신고 하기!",
    "writer": "커먼매니저",
    "content": "<div _ngcontent-jmp-c18=\\"\\" class=\\"content_blog flex_col col1\\"><div class=\\"blog_content_paragraph body2\\">전입신고란 하나의 세대에 속하는 자의 전원 또는 일부가 거주지를 이동할 때, 신고 의무자가 새로운 거주지로 이사한 날로부터 14일 이내에 전입 사실을 새 거주지 관할 기관에 신고하는 민원 업무를 말하는데요.</div><div class=\\"blog_content_paragraph body2\\">이사 후 14일 이내에 전입신고를 하지 않는다고 바로 과태료가 부과되지 않지만, 장기간 전입신고를 하지 않을 경우, 거주지 불명으로 직권 거주 불명 등록이 되어 과태료가 부과될 수 있으니 이사 후 까먹기 전에 전입신고 하는 것이 좋습니다. 이 뿐만 아니라 전입신고를 하지 않을 경우 사는 집이 경매 등으로 이전 되었을 때 &lt;주택임대차보호법&gt;에 의거한 보호를 받을 수 없어 보증금을 돌려받지 못하는 상황에 처하게 됩니다.</div><div class=\\"blog_content_paragraph body2\\">그렇다면 코리빙 하우스에 거주하는 분들도 전입신고가 가능할까요? 개인이 운영하는 경우는 불가능하지만, 커먼타운처럼 법인이 운영하는 코리빙 하우스는 전입신고가 가능합니다.</div><div class=\\"blog_content_paragraph body2\\">커먼타운을 포함해 코리빙 하우스에 거주하는 분들을 위해 컴퓨터만으로 쉽고 편리하게 전입신고하는 방법을 소개해드릴게요.</div><ul><li class=\\"blog_content_list_item body2\\">STEP 1. 정부24 접속하기</li></ul><div class=\\"blog_content_paragraph body2\\">정부 서비스 통합 포털 사이트 정부24 https://www.gov.kr 에 접속합니다.</div><div class=\\"blog_content_image img_blog\\"><img src=\\"https://images.prismic.io/commontown-sales/e095b403-fb0f-4a2c-808c-9a53d4ca479e_%E1%84%8C%E1%85%A5%E1%86%AB%E1%84%8B%E1%85%B5%E1%86%B8%E1%84%89%E1%85%B5%E1%86%AB%E1%84%80%E1%85%A9_%E1%84%8B%E1%85%B5%E1%84%86%E1%85%B5%E1%84%8C%E1%85%B5_1.jpg?auto=compress,format&amp;w=720\\"></div><ul><li class=\\"blog_content_list_item body2\\">STEP 2. 로그인</li></ul><div class=\\"blog_content_paragraph body2\\">오른쪽 상단에 로그인 버튼을 클릭해 설치프로그램 설치 후 공인인증서로 로그인합니다. 전입신고 신청 중에도 공인인증서 등록이 필요하니 미리 설치해두는 것이 좋습니다.</div><div class=\\"blog_content_image img_blog\\"><img src=\\"https://images.prismic.io/commontown-sales/b1eab94b-a164-4554-8a13-24b982b04349_%E1%84%8C%E1%85%A5%E1%86%AB%E1%84%8B%E1%85%B5%E1%86%B8%E1%84%89%E1%85%B5%E1%86%AB%E1%84%80%E1%85%A9_%E1%84%8B%E1%85%B5%E1%84%86%E1%85%B5%E1%84%8C%E1%85%B5_2.jpg?auto=compress,format&amp;w=720\\"></div><ul><li class=\\"blog_content_list_item body2\\">STEP 3. 전입신고 Click</li></ul><div class=\\"blog_content_paragraph body2\\">회원가입이 끝났으면 왼쪽 하단에 위치한 ‘전입신고’ ▶ ‘신청하기’를 클릭 합니다.</div><div class=\\"blog_content_image img_blog\\"><img src=\\"https://images.prismic.io/commontown-sales/02fbcb5a-8164-4a2a-adfc-a2b0df1b70b1_%E1%84%8C%E1%85%A5%E1%86%AB%E1%84%8B%E1%85%B5%E1%86%B8%E1%84%89%E1%85%B5%E1%86%AB%E1%84%80%E1%85%A9_%E1%84%8B%E1%85%B5%E1%84%86%E1%85%B5%E1%84%8C%E1%85%B5_3.jpg?auto=compress,format&amp;w=720\\"></div><ul><li class=\\"blog_content_list_item body2\\">STEP 4. 주의사항 확인 후 ‘신청’ Click</li></ul><div class=\\"blog_content_paragraph body2\\">주의사항을 빠르게 훑어본 후 모든 박스에 체크한 후 신청 탭을 클릭합니다. 온라인 전입신고는 한 달(30일) 1회 신청 가능합니다.</div><div class=\\"blog_content_image img_blog\\"><img src=\\"https://images.prismic.io/commontown-sales/2c73f0e7-f210-4482-96a4-2d7c82c81dcc_%E1%84%8C%E1%85%A5%E1%86%AB%E1%84%8B%E1%85%B5%E1%86%B8%E1%84%89%E1%85%B5%E1%86%AB%E1%84%80%E1%85%A9_%E1%84%8B%E1%85%B5%E1%84%86%E1%85%B5%E1%84%8C%E1%85%B5_4.jpg?auto=compress,format&amp;w=720\\"></div><ul><li class=\\"blog_content_list_item body2\\">STEP 5. 이미지와 동일하게 Check</li></ul><div class=\\"blog_content_paragraph body2\\">이미지와 동일하게 체크합니다. 코리빙 하우스는 모든 입주민이 세대주로 전입되므로 이사할 곳 세대주와의 관계는 본인이 됩니다.</div><div class=\\"blog_content_image img_blog\\"><img src=\\"https://images.prismic.io/commontown-sales/d062aa7f-23e6-43a7-b612-6c5488866708_%E1%84%8C%E1%85%A5%E1%86%AB%E1%84%8B%E1%85%B5%E1%86%B8%E1%84%89%E1%85%B5%E1%86%AB%E1%84%80%E1%85%A9_%E1%84%8B%E1%85%B5%E1%84%86%E1%85%B5%E1%84%8C%E1%85%B5_5.jpg?auto=compress,format&amp;w=720\\"></div><ul><li class=\\"blog_content_list_item body2\\">STEP 6. 개인 정보 입력</li></ul><div class=\\"blog_content_paragraph body2\\">전출지는 공인인증서를 통해 자동으로 조회되며, 전입지 주소에 입주하는 코리빙 하우스 주소를 입력합니다. 대부분 코리빙 하우스는 공동주택에 해당하기 때문에 ‘예’를 선택하면 됩니다.</div><div class=\\"blog_content_image img_blog\\"><img src=\\"https://images.prismic.io/commontown-sales/aac064a9-e983-49b5-a676-5c3770b97836_%E1%84%8C%E1%85%A5%E1%86%AB%E1%84%8B%E1%85%B5%E1%86%B8%E1%84%89%E1%85%B5%E1%86%AB%E1%84%80%E1%85%A9_%E1%84%8B%E1%85%B5%E1%84%86%E1%85%B5%E1%84%8C%E1%85%B5_6.jpg?auto=compress,format&amp;w=720\\"></div><ul><li class=\\"blog_content_list_item body2\\">STEP 7. 신청 완료하기</li></ul><div class=\\"blog_content_paragraph body2\\">3개월 이내에 주거 이전 우편물 전송 서비스는 무료 신청 가능합니다. 초등학교 배정정보 작성은 건너뛰고, ‘민원 신청하기’ 버튼을 클릭하면 전입신고 신청이 완료됩니다. 전입 신청 후 일주일 이내로 등본에 반영된다고 합니다.</div><div class=\\"blog_content_image img_blog\\"><img src=\\"https://images.prismic.io/commontown-sales/7a76ba7a-e53f-4e44-a07f-982c8ae8e2f2_%E1%84%8C%E1%85%A5%E1%86%AB%E1%84%8B%E1%85%B5%E1%86%B8%E1%84%89%E1%85%B5%E1%86%AB%E1%84%80%E1%85%A9_%E1%84%8B%E1%85%B5%E1%84%86%E1%85%B5%E1%84%8C%E1%85%B5_7.jpg?auto=compress,format&amp;w=720\\"></div><div class=\\"blog_content_paragraph body2\\">커먼타운은 입주한 멤버들에게 임대인의 권리를 행사할 수 있도록 전입신고를 적극 권장하고 있어요.</div><div class=\\"blog_content_paragraph body2\\">임차인의 권리를 보호해주는 커먼타운의 새로운 멤버가 되고 싶다면 커먼타운 홈페이지에서 하우스에 가격과 상세 정보를 확인 후 상담 신청하세요.</div></div>",
    "createdTime": "2021-04-01"
  },
  {
    "index": 3,
    "isRead": true,
    "title": "커먼타운 멤버를 위한 제휴 혜택을 소개합니다",
    "writer": "커먼매니저",
    "content": "<div _ngcontent-jmp-c18=\\"\\" class=\\"content_blog flex_col col1\\"><div class=\\"blog_content_paragraph body2\\">커먼타운은 모든 커먼타운 멤버가 서로 연결되어 더욱 행복한 삶을 살 수 있도록, 다양한 방식으로 지원하고 있습니다.</div><div class=\\"blog_content_paragraph body2\\">이번에는, 그 중 하나인 제휴 혜택, 커먼플러스를 소개하려고 해요.</div><div class=\\"blog_content_paragraph body2\\">커먼플러스는 커먼타운 멤버들이 더욱더 편안하고 건강한 삶을 살 수 있도록 엄선한 다양한 브랜드와의 제휴혜택을 의미합니다.</div><div class=\\"blog_content_paragraph body2\\">생활이 더욱 윤택해지는 생활 서비스부터, 일상을 조금 더 특별하게 만들어줄 라이프스타일 브랜드까지, 커먼타운이 소개하는 브랜드를 다양한 할인 혜택을 통해 경험해보세요.</div><div class=\\"blog_content_paragraph body2\\"><a href=\\"https://www.commontown.co/ko/community\\">커먼타운 커뮤니티 더 알아보기</a></div><div class=\\"blog_content_paragraph body2\\">제휴혜택은 시기에 따라 달라질 수 있습니다. 주기적으로 제휴 혜택을 확인하고, 다양한 브랜드를 경험하며 일상에 특별함을 더해보세요.&nbsp;</div><div class=\\"blog_content_image img_blog\\"><img src=\\"https://images.prismic.io/commontown-sales/abdc08b3-3207-4069-b192-b62e350893b7_%E1%84%8B%E1%85%A9%E1%84%83%E1%85%B3%E1%84%85%E1%85%B5%E1%84%89%E1%85%A5%E1%86%AB+%E1%84%8B%E1%85%B5%E1%84%86%E1%85%B5%E1%84%8C%E1%85%B5750x480.jpg?auto=compress,format&amp;w=720\\"></div><div class=\\"blog_content_paragraph body2\\">▶︎ [오드리선] 순수한 원료를 사용해 건강한 아름다움을 추구하는 호주 여성 케어 브랜드 :: 100% 유기농 순면커버 생리대 40% 할인</div><div class=\\"blog_content_paragraph body2\\"><a href=\\"https://www.instagram.com/audreysun.kr/\\">&nbsp;브랜드 인스타그램 가기</a></div><div class=\\"blog_content_image img_blog\\"><img src=\\"https://images.prismic.io/commontown-sales/60575550-6d57-4391-921d-b525db35d7bb_%E1%84%8A%E1%85%A5%E1%86%AB%E1%84%8B%E1%85%AD%E1%84%80%E1%85%A1+%E1%84%8B%E1%85%B5%E1%84%86%E1%85%B5%E1%84%8C%E1%85%B5_750x480+%284%29.JPG?auto=compress,format&amp;w=720\\"></div><div class=\\"blog_content_paragraph body2\\">▶︎ [썬요가] 삶을 건강하고 즐겁게 만들어주는 다양한 경험을 전해주는 요가 클래스 :: 평일 수업 1회 무료 수강 및 멤버십 수업 10%할인, 요가용품 할인</div><div class=\\"blog_content_paragraph body2\\"><a href=\\"https://www.instagram.com/sunyogastudio/\\">&nbsp;브랜드 인스타그램 가기</a></div><div class=\\"blog_content_image img_blog\\"><img src=\\"https://images.prismic.io/commontown-sales/66f28276-5a83-4587-b826-e9366a2a6ef8_%E1%84%83%E1%85%A2%E1%84%91%E1%85%AD+%E1%84%8B%E1%85%B5%E1%84%86%E1%85%B5%E1%84%8C%E1%85%B5.jpg?auto=compress,format&amp;w=720\\"></div><div class=\\"blog_content_paragraph body2\\">▶︎ [스티쳐] 만드는 재미와 즐거움을 주는 DIY 가죽 공예 브랜드 :: 카드지갑 DIY키트 (9,900원 상당) 무료 제공 및 공식몰 상시 20%할인</div><div class=\\"blog_content_paragraph body2\\"><a href=\\"https://www.instagram.com/stitcher_official/\\">&nbsp;브랜드 인스타그램 가기</a></div><div class=\\"blog_content_image img_blog\\"><img src=\\"https://images.prismic.io/commontown-sales/45f47035-5d9f-4410-80dd-88d5d74ba2b8_DSC_7204.jpg?auto=compress,format&amp;w=720\\"></div><div class=\\"blog_content_paragraph body2\\">▶︎ [서스테인어블 해빗] 지속 가능한 습관을 위한 라이프스타일 플랫폼 :: 카페 상시 20% 할인 및 브랜드 상품 상시 할인, 공간 대관 할인</div><div class=\\"blog_content_paragraph body2\\"><a href=\\"https://www.instagram.com/sustainable_habits_/\\">&nbsp;브랜드 인스타그램 가기</a></div><div class=\\"blog_content_image img_blog\\"><img src=\\"https://images.prismic.io/commontown-sales/2bda703a-7f34-48d2-a095-e59377afc5dd_200313_%E1%84%86%E1%85%A1%E1%84%90%E1%85%A1%E1%84%8C%E1%85%AE-%E1%84%85%E1%85%B5%E1%84%87%E1%85%A6%E1%84%90%E1%85%A9-%E1%84%8C%E1%85%A1%E1%84%85%E1%85%AD%E1%84%8C%E1%85%A5%E1%86%AB%E1%84%83%E1%85%A1%E1%86%AF-%E1%84%80%E1%85%A5%E1%86%AB+%285%29.png?auto=compress,format&amp;w=720\\"></div><div class=\\"blog_content_paragraph body2\\">▶︎ [마타주] 계절옷부터 가구까지, 물건 보관 서비스 :: 보관함 1개월 무료 및 보관함 당 상시 2000원 할인</div><div class=\\"blog_content_paragraph body2\\"><a href=\\"https://www.instagram.com/matazoo_/\\">&nbsp;브랜드 인스타그램 가기</a></div><div class=\\"blog_content_image img_blog\\"><img src=\\"https://images.prismic.io/commontown-sales/5cde0e18-e47a-4dd0-83c8-7ffea47737df_IMG_7675.JPG?auto=compress,format&amp;rect=0,194,1080,691&amp;w=750&amp;h=480&amp;w=720\\"></div><div class=\\"blog_content_paragraph body2\\">▶︎ [런드리라운지] 프리미엄 셀프세탁 서비스 공간 :: 멤버십 포인트 제공 (50,000P)</div><div class=\\"blog_content_image img_blog\\"><img src=\\"https://images.prismic.io/commontown-sales/00ab35a2-5439-4d90-ad25-aed517340b92_%E1%84%92%E1%85%A9%E1%84%90%E1%85%A6%E1%86%AF+%E1%84%8F%E1%85%A1%E1%84%91%E1%85%AE%E1%84%8E%E1%85%B5%E1%84%82%E1%85%A9_%E1%84%89%E1%85%B3%E1%84%90%E1%85%B2%E1%84%83%E1%85%B5%E1%84%8B%E1%85%A9+1608_%E1%84%8E%E1%85%B5%E1%86%B7%E1%84%89%E1%85%B5%E1%86%AF+3.jpg?auto=compress,format&amp;w=720\\"></div><div class=\\"blog_content_paragraph body2\\">▶︎ [호텔카푸치노] 어반 라이프스타일 호텔 :: 멤버 전용 할인 혜택 제공&nbsp;</div><div class=\\"blog_content_paragraph body2\\"><a href=\\"https://www.instagram.com/hotelcappuccinoseoul/\\">&nbsp;브랜드 인스타그램 가기</a></div></div>",
    "createdTime": "2021-03-21"
  },
  {
    "index": 2,
    "isRead": true,
    "title": "서울시 주거지원 사업을 통해 렌트비 50%를 지원받으세요",
    "writer": "커먼매니저",
    "content": "<div _ngcontent-jmp-c18=\\"\\" class=\\"content_blog flex_col col1\\"><div class=\\"blog_content_heading1 title7\\">서울시가 주관하는 '창업가 주거지원' 사업을 통해, 신성장 산업 분야에서 일하는 창업가들에게 커먼타운이 주거공간을 제공합니다.</div><div class=\\"blog_content_paragraph body2\\">커먼타운은 밀레니얼 세대 1인가구들의 더 나은 삶을 위해, 주거와 관련한 다양한 솔루션을 제시해온 <a href=\\"https://www.commontown.co/ko/community\\">공유주거</a> 브랜드입니다. 창업가 주거지원 사업을 통해, 서울시와 협력하여 창업가들이 함께 살고, 함께 일하며 시너지를 낼 수 있도록 지원할 예정이에요.</div><div class=\\"blog_content_paragraph body2\\">서울시에 기반을 둔 창업가라면, 아래 설명과 안내문 링크를 통해 서울시 창업가 주거지원 사업에 대한 자세한 내용을 확인하고, 주거비 지원을 신청하세요.</div><div class=\\"blog_content_paragraph body2\\">0. 서울시 창업가주거지원 사업 안내문 확인하기 &gt; <a href=\\"https://news.seoul.go.kr/economy/archives/508290\\">링크 클릭!</a></div><div class=\\"blog_content_paragraph body2\\">1. 자격요건 및 지원대상</div><ul><li class=\\"blog_content_list_item body2\\">신성장 산업에 종사하는 서울 시민인 창업가이면서, 업력 7년 미만 서울 소재 창업기업</li><li class=\\"blog_content_list_item body2\\">3년 이내 초기 창업기업의 대표 및 직원이 팀 단위로 셰어하우스에 입주하는 경우 직원도 입주 가능 (대표 포함 최대 4인) - 팀 단위 지원시 우선 선발</li><li class=\\"blog_content_list_item body2\\"><a href=\\"http://news.seoul.go.kr/snap/doc.html?fn=5f0c0e1f06ca09.19497954.docx&amp;rs=/wp-content/blogs.dir/24/files/2020/07/\\">지원 업종 확인하기</a></li></ul><div class=\\"blog_content_paragraph body2\\">2. 지원혜택</div><ul><li class=\\"blog_content_list_item body2\\">지원 내용 : 보증금&nbsp; 50%이상 지원, 임대료 50% 지원, 공용관리비 100% 지원 (창업가는 보증금 및 임대료 50%와 세대관리비만 부담)</li><li class=\\"blog_content_list_item body2\\">지원 기간 : 20년 9월 1일부터 21년 8월 31일까지 (최대 1년)</li></ul><div class=\\"blog_content_paragraph body2\\">3. 신청기간</div><ul><li class=\\"blog_content_list_item body2\\">지원 기간 내 수시 지원</li><li class=\\"blog_content_list_item body2\\">입주 시점에 상관없이 최대 21년 8월 31일까지만 임대료를 지원하므로, 더 많은 혜택을 받고 싶은 창업가라면 지금 바로 지원하세요!</li></ul><div class=\\"blog_content_paragraph body2\\">4. 신청절차</div><ul><li class=\\"blog_content_list_item body2\\">자격요건에 맞는 창업가가 추천기관의 추천을 받아 신청서류를 서울시에 제출</li><li class=\\"blog_content_list_item body2\\">서류제출은 추천기관 또는 창업가가 직접 제출</li><li class=\\"blog_content_list_item body2\\">서울시가 신청자를 대상으로 창업가선정위원회 주최하여 지원 대상 선정 (약 월1회, 최초 8/18 예정)<br>- 투자유치 실적, (2순위) 매출실적, (3순위) 성공가능성 평가 기준으로 지원대상자&nbsp; 선정<br>- 설립 3년 이내의 초기 스타트업 : 매출액 평가 안 함<br>- 초기 스타트업은 초기 스타트업끼리 평가 진행하며, 그 외 스타트업은&nbsp; 그 외 스타트업끼리 평가 진행</li><li class=\\"blog_content_list_item body2\\">선정 완료 시 커먼타운과 계약 후 입주</li></ul><div class=\\"blog_content_paragraph body2\\">[추천기관 리스트]</div><ul><li class=\\"blog_content_list_item body2\\"><a href=\\"https://news.seoul.go.kr/economy/files/2020/07/5f28eefbcb8028.09754938.pdf\\">주거지원 사업 안내문</a> (붙임2 참고)</li><li class=\\"blog_content_list_item body2\\"><a href=\\"http://seoulstartuphub.com/policy/policy.do\\">서울창업허브 파트너스</a></li></ul><div class=\\"blog_content_paragraph body2\\">5. 지원 하우스</div><div class=\\"blog_content_image img_blog\\"><img src=\\"https://images.prismic.io/commontown-sales/56df6ec5-67a9-4615-bca6-3f9407a39360_%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA+2020-07-30+%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE+6.29.01.png?auto=compress,format&amp;w=720\\"></div><div class=\\"blog_content_image img_blog\\"><img src=\\"https://images.prismic.io/commontown-sales/464f0735-8f26-47f8-b237-4cbfb148ca1e_%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA+2020-07-30+%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE+6.29.59.png?auto=compress,format&amp;w=720\\"></div><div class=\\"blog_content_image img_blog\\"><img src=\\"https://images.prismic.io/commontown-sales/2b94be99-f737-4bde-b7dd-c16a6794b74b_%E1%84%89%E1%85%B3%E1%84%8F%E1%85%B3%E1%84%85%E1%85%B5%E1%86%AB%E1%84%89%E1%85%A3%E1%86%BA+2020-07-30+%E1%84%8B%E1%85%A9%E1%84%92%E1%85%AE+6.29.37.png?auto=compress,format&amp;w=720\\"></div><ul><li class=\\"blog_content_list_item body2\\">역삼 트리하우스 (1인실) : <a href=\\"https://www.commontown.co/ko/house-page/treehouse\\">하우스 자세히 보러가기</a></li><li class=\\"blog_content_list_item body2\\">이태원 512 하우스&nbsp; (1인실~4인실) : <a href=\\"https://my.matterport.com/show/?m=erRaYnwBAJt\\">하우스 VR투어하기</a></li><li class=\\"blog_content_list_item body2\\">센트럴 261 하우스 (1인실)&nbsp; : <a href=\\"https://my.matterport.com/show/?m=hVxMLiDaFEP\\">하우스 VR투어하기</a>  |  <a href=\\"https://www.commontown.co/ko/house-page/central-261\\">하우스 자세히 보러가기</a></li></ul><div class=\\"blog_content_paragraph body2\\">6. 보증금 및 임대료 : <a href=\\"https://news.seoul.go.kr/economy/archives/508290\\">서울시 창업주거 지원 사업 페이지</a>를 통해 확인하세요.</div><div class=\\"blog_content_paragraph body2\\">* 해당 사업은 서울시가 주관하는 창업지원 사업으로, 따라서 사업 관련 문의는 서울시 투자창업과로 해주세요. (문의전화 : 02-2133-4768)</div><div class=\\"blog_content_paragraph body2\\">* 커먼타운 하우스와 관련된 궁금한 사항은 커먼타운에 문의하세요. (문의전화 : 010-9679-9775)</div></div>",
    "createdTime": "2021-03-15"
  },
  {
    "index": 1,
    "isRead": true,
    "title": "신도림 081 룸타입 정보",
    "writer": "커먼매니저",
    "content": "<div _ngcontent-jmp-c36=\\"\\" class=\\"room_type\\"> <p _ngcontent-jmp-c36=\\"\\" class=\\"title7\\">룸 타입</p><app-card-room-detail _ngcontent-jmp-c36=\\"\\" _nghost-jmp-c37=\\"\\" > <div _ngcontent-jmp-c37=\\"\\" class=\\"card_room_detail desktop\\"> <div _ngcontent-jmp-c37=\\"\\" class=\\"image_container_room_detail\\"> <img class=\\"room_card_slider YBynfBEAACMAI8OE\\" src=\\"https://images.prismic.io/commontown-sales/59b3a0cc-b8ae-4e36-8fbf-e39c66831b20_%E1%84%92%E1%85%A1%E1%84%8B%E1%85%AE%E1%84%89%E1%85%B3+%E1%84%89%E1%85%A1%E1%86%BC%E1%84%89%E1%85%A6+-+%E1%84%90%E1%85%A1%E1%84%8B%E1%85%B5%E1%86%B8+A+1.png\\"/> </div><div _ngcontent-jmp-c37=\\"\\" class=\\"info_room\\"> <div _ngcontent-jmp-c37=\\"\\" class=\\"header\\"> <span _ngcontent-jmp-c37=\\"\\" class=\\"name body1\\">Type A</span ><span _ngcontent-jmp-c37=\\"\\" class=\\"status\\" >오픈 프로모션 중</span > </div><div _ngcontent-jmp-c37=\\"\\" class=\\"price\\"> <span _ngcontent-jmp-c37=\\"\\" class=\\"body2\\">6개월</span ><span _ngcontent-jmp-c37=\\"\\" class=\\"btn2\\">₩890,000/월 ~</span> </div><div _ngcontent-jmp-c37=\\"\\" class=\\"price\\"> <span _ngcontent-jmp-c37=\\"\\" class=\\"body2\\">3개월</span ><span _ngcontent-jmp-c37=\\"\\" class=\\"btn2\\">₩1,080,000/월 ~</span> </div><div _ngcontent-jmp-c37=\\"\\" class=\\"includes body1\\">포함 내역</div><ul _ngcontent-jmp-c37=\\"\\" class=\\"includes_items\\"> <li _ngcontent-jmp-c37=\\"\\" class=\\"body4\\"> (실제 제공 가구, 가전 변동 가능) </li><li _ngcontent-jmp-c37=\\"\\" class=\\"body4\\">신발장</li><li _ngcontent-jmp-c37=\\"\\" class=\\"body4\\">주방 (쿡탑, 냉장고 포함)</li><li _ngcontent-jmp-c37=\\"\\" class=\\"body4\\">빌트인 옷장, 수납장</li><li _ngcontent-jmp-c37=\\"\\" class=\\"body4\\">빌트인 데스크</li><li _ngcontent-jmp-c37=\\"\\" class=\\"body4\\">세탁선반 &amp; 건조헹거</li><li _ngcontent-jmp-c37=\\"\\" class=\\"body4\\">매트리스</li><li _ngcontent-jmp-c37=\\"\\" class=\\"body4\\">스마트 도어락</li><li _ngcontent-jmp-c37=\\"\\" class=\\"body4\\">에어컨</li><li _ngcontent-jmp-c37=\\"\\" class=\\"body4\\">9kg 드럼세탁기</li><li _ngcontent-jmp-c37=\\"\\" class=\\"body4\\">화장실</li></ul> </div></div></app-card-room-detail ><app-card-room-detail _ngcontent-jmp-c36=\\"\\" _nghost-jmp-c37=\\"\\" > <div _ngcontent-jmp-c37=\\"\\" class=\\"card_room_detail desktop\\"> <div _ngcontent-jmp-c37=\\"\\" class=\\"image_container_room_detail\\"> <img class=\\"room_card_slider YBynfBEAACMAI8OE\\" src=\\"https://images.prismic.io/commontown-sales/3ad8cb77-c787-44f7-a54c-f0fbb0f4ef37_%E1%84%92%E1%85%A1%E1%84%8B%E1%85%AE%E1%84%89%E1%85%B3+%E1%84%89%E1%85%A1%E1%86%BC%E1%84%89%E1%85%A6+-+%E1%84%90%E1%85%A1%E1%84%8B%E1%85%B5%E1%86%B8+B+1.png\\"/> </div><div _ngcontent-jmp-c37=\\"\\" class=\\"info_room\\"> <div _ngcontent-jmp-c37=\\"\\" class=\\"header\\"> <span _ngcontent-jmp-c37=\\"\\" class=\\"name body1\\">Type B</span ><span _ngcontent-jmp-c37=\\"\\" class=\\"status\\" >오픈 프로모션 중</span > </div><div _ngcontent-jmp-c37=\\"\\" class=\\"price\\"> <span _ngcontent-jmp-c37=\\"\\" class=\\"body2\\">6개월</span ><span _ngcontent-jmp-c37=\\"\\" class=\\"btn2\\">₩920,000/월 ~</span> </div><div _ngcontent-jmp-c37=\\"\\" class=\\"price\\"> <span _ngcontent-jmp-c37=\\"\\" class=\\"body2\\">3개월</span ><span _ngcontent-jmp-c37=\\"\\" class=\\"btn2\\">₩1,110,000/월 ~</span> </div><div _ngcontent-jmp-c37=\\"\\" class=\\"includes body1\\">포함 내역</div><ul _ngcontent-jmp-c37=\\"\\" class=\\"includes_items\\"> <li _ngcontent-jmp-c37=\\"\\" class=\\"body4\\"> (실제 제공 가구, 가전 변동 가능) </li><li _ngcontent-jmp-c37=\\"\\" class=\\"body4\\">신발장</li><li _ngcontent-jmp-c37=\\"\\" class=\\"body4\\">주방 (쿡탑, 냉장고 포함)</li><li _ngcontent-jmp-c37=\\"\\" class=\\"body4\\"> 헹거형 시스템 옷장 겸 수납장 </li><li _ngcontent-jmp-c37=\\"\\" class=\\"body4\\">빌트인 데스크</li><li _ngcontent-jmp-c37=\\"\\" class=\\"body4\\">세탁선반 및 건조헹거</li><li _ngcontent-jmp-c37=\\"\\" class=\\"body4\\">매트리스</li><li _ngcontent-jmp-c37=\\"\\" class=\\"body4\\">스마트 도어락</li><li _ngcontent-jmp-c37=\\"\\" class=\\"body4\\">에어컨</li><li _ngcontent-jmp-c37=\\"\\" class=\\"body4\\">9kg 드럼세탁기</li><li _ngcontent-jmp-c37=\\"\\" class=\\"body4\\">화장실</li></ul> </div></div></app-card-room-detail ><app-card-room-detail _ngcontent-jmp-c36=\\"\\" _nghost-jmp-c37=\\"\\" > <div _ngcontent-jmp-c37=\\"\\" class=\\"card_room_detail desktop\\"> <div _ngcontent-jmp-c37=\\"\\" class=\\"image_container_room_detail\\"> <img class=\\"room_card_slider YBynfBEAACMAI8OE\\" src=\\"https://images.prismic.io/commontown-sales/4e4b4659-84ed-4d84-9375-22dbc0a20360_%E1%84%92%E1%85%A1%E1%84%8B%E1%85%AE%E1%84%89%E1%85%B3+%E1%84%89%E1%85%A1%E1%86%BC%E1%84%89%E1%85%A6+-+%E1%84%90%E1%85%A1%E1%84%8B%E1%85%B5%E1%86%B8+C+1.png\\"/> </div><div _ngcontent-jmp-c37=\\"\\" class=\\"info_room\\"> <div _ngcontent-jmp-c37=\\"\\" class=\\"header\\"> <span _ngcontent-jmp-c37=\\"\\" class=\\"name body1\\">Type C</span ><span _ngcontent-jmp-c37=\\"\\" class=\\"status\\" >오픈 프로모션 중</span > </div><div _ngcontent-jmp-c37=\\"\\" class=\\"price\\"> <span _ngcontent-jmp-c37=\\"\\" class=\\"body2\\">-</span ><span _ngcontent-jmp-c37=\\"\\" class=\\"btn2\\">12개월 이상 계약 가능</span> </div><div _ngcontent-jmp-c37=\\"\\" class=\\"price\\"> <span _ngcontent-jmp-c37=\\"\\" class=\\"body2\\">C-1 (42.9㎡)</span ><span _ngcontent-jmp-c37=\\"\\" class=\\"btn2\\">₩1,040,000/월</span> </div><div _ngcontent-jmp-c37=\\"\\" class=\\"price\\"> <span _ngcontent-jmp-c37=\\"\\" class=\\"body2\\">C-2 (46.2㎡)</span ><span _ngcontent-jmp-c37=\\"\\" class=\\"btn2\\">₩1,090,000/월</span> </div><div _ngcontent-jmp-c37=\\"\\" class=\\"price\\"> <span _ngcontent-jmp-c37=\\"\\" class=\\"body2\\">C-3 (50.8㎡)</span ><span _ngcontent-jmp-c37=\\"\\" class=\\"btn2\\">₩1,140,000/월</span> </div><div _ngcontent-jmp-c37=\\"\\" class=\\"price\\"> <span _ngcontent-jmp-c37=\\"\\" class=\\"body2\\">C-4 (53.8㎡)</span ><span _ngcontent-jmp-c37=\\"\\" class=\\"btn2\\">₩1,190,000/월</span> </div><div _ngcontent-jmp-c37=\\"\\" class=\\"price\\"> <span _ngcontent-jmp-c37=\\"\\" class=\\"body2\\">C-5 (65.3㎡)</span ><span _ngcontent-jmp-c37=\\"\\" class=\\"btn2\\">₩1,490,000/월</span> </div><div _ngcontent-jmp-c37=\\"\\" class=\\"includes body1\\">포함 내역</div><ul _ngcontent-jmp-c37=\\"\\" class=\\"includes_items\\"> <li _ngcontent-jmp-c37=\\"\\" class=\\"body4\\"> (실제 제공 가구, 가전 변동 가능) </li><li _ngcontent-jmp-c37=\\"\\" class=\\"body4\\">신발장</li><li _ngcontent-jmp-c37=\\"\\" class=\\"body4\\">주방 (쿡탑, 냉장고 포함)</li><li _ngcontent-jmp-c37=\\"\\" class=\\"body4\\">계단 하부 수납장</li><li _ngcontent-jmp-c37=\\"\\" class=\\"body4\\">세탁선반 및 건조헹거</li><li _ngcontent-jmp-c37=\\"\\" class=\\"body4\\">매트리스</li><li _ngcontent-jmp-c37=\\"\\" class=\\"body4\\"> 프라이빗 테라스(C-5만 해당) </li><li _ngcontent-jmp-c37=\\"\\" class=\\"body4\\">스마트 도어락</li><li _ngcontent-jmp-c37=\\"\\" class=\\"body4\\">에어컨</li><li _ngcontent-jmp-c37=\\"\\" class=\\"body4\\">9kg 드럼세탁기</li><li _ngcontent-jmp-c37=\\"\\" class=\\"body4\\">화장실</li></ul> </div></div></app-card-room-detail > </div>",
    "createdTime": "2021-02-27"
  }
]''';

  static final String historyJson = '''[
  {
    "index": 10,
    "serviceName": "호출",
    "summary": "-",
    "price": 0,
    "status": 0,
    "createdTime": "2021-05-05"
  },
  {
    "index": 9,
    "serviceName": "커먼플러스",
    "summary": "심플리오",
    "price": 12000,
    "status": 1,
    "createdTime": "2021-05-01"
  },
  {
    "index": 8,
    "serviceName": "세탁",
    "summary": "침구세트 세탁",
    "price": 5000,
    "status": 1,
    "createdTime": "2021-04-24"
  },
  {
    "index": 7,
    "serviceName": "택배",
      "summary": "2개",
      "price": 0,
      "status": 2,
    "createdTime": "2021-04-15"
  },
  {
    "index": 6,
    "serviceName": "생필품",
    "summary": "종량제 봉투 20L 외 2개",
    "price": 8000,
    "status": 2,
    "createdTime": "2021-04-02"
  },
  {
    "index": 5,
    "serviceName": "청소",
    "summary": "2021/03/15 예약",
    "price": 0,
    "status": 2,
    "createdTime": "2021-03-30"
  },
  {
    "index": 4,
    "serviceName": "팻케어",
    "summary": "간식 1개",
    "price": 1000,
    "status": 2,
    "createdTime": "2021-03-10"
  },
  {
    "index": 3,
    "serviceName": "세탁",
    "summary": "수건 세탁",
    "price": 2000,
    "status": 2,
    "createdTime": "2021-02-14"
  },
  {
    "index": 2,
    "serviceName": "생필품",
    "summary": "휴지 4개 외 4건",
    "price": 6000,
    "status": 2,
    "createdTime": "2021-01-28"
  },
  {
    "index": 1,
    "serviceName": "호출",
    "summary": "-",
    "price": 0,
    "status": 2,
    "createdTime": "2021-01-03"
  }
]''';

  static final String serviceJson = '''[
  {
    "objectId": "1",
    "name": "청소",
    "type": "call",
    "image": "assets/icons/service/cleaning.svg",
    "items": [
      {
        "objectId": "0",
        "type": "resultMessage",
        "value": "예약되었습니다.​"
      },
      {
        "objectId": "1",
        "type": "text",
        "value": "개인룸 청소를 신청합니다.\\n(기본 월 1회 무료,\\n이후 회당 20,000원의 요금이 발생하며\\n다음달 관리비에 적용됩니다.)"
      },
      {
        "objectId": "2",
        "type": "dateTime",
        "value": ""
      }
    ]
  },
  {
    "objectId": "2",
    "name": "세탁",
    "type": "call",
    "image": "assets/icons/service/laundry.svg",
    "items": [
      {
        "objectId": "0",
        "type": "resultMessage",
        "value": "신청되었습니다."
      },
      {
        "objectId": "1",
        "type": "text",
        "value": "세탁서비스를 신청합니다.\\n다음날 오전 10시에 수거,\\n오후 6시에 배달됩니다.\\n(개인룸 내 수거함을 이용바랍니다.)"
      },
      {
        "objectId": "2",
        "type": "count",
        "value": "침구세트 세탁"
      },
      {
        "objectId": "3",
        "type": "count",
        "value": "수건(7장) 세탁"
      }
    ]
  },
  {
    "objectId": "3",
    "name": "출차",
    "type": "call",
    "image": "assets/icons/service/car.svg",
    "items": [
      {
        "objectId": "0",
        "type": "resultMessage",
        "value": "신청되었습니다."
      },
      {
        "objectId": "1",
        "type": "text",
        "value": "5-10분 내로 출차됩니다."
      }
    ]
  },
  {
    "objectId": "4",
    "name": "관리실 호출",
    "type": "call",
    "image": "assets/icons/service/call.svg",
    "items": [
      {
        "objectId": "0",
        "type": "resultMessage",
        "value": "신청되었습니다."
      },
      {
        "objectId": "1",
        "type": "text",
        "value": "커먼매니저를 호출합니다.\\n10분 내로 방문 예정입니다."
      }
    ]
  },
  {
    "objectId": "common_plus",
    "name": "커먼플러스",
    "type": "shop",
    "image": "assets/icons/service/move.svg",
    "items": []
  },
  {
    "objectId": "pet",
    "name": "펫케어",
    "type": "shop",
    "image": "assets/icons/service/pet.svg",
    "items": []
  },
  {
    "objectId": "7",
    "name": "택배",
    "type": "call",
    "image": "assets/icons/service/delivery.svg",
    "items": [
      {
        "objectId": "0",
        "type": "resultMessage",
        "value": "신청되었습니다."
      },
      {
        "objectId": "1",
        "type": "text",
        "value": "택배 수거를 요청합니다."
      },
      {
        "objectId": "2",
        "type": "count",
        "value": "개수"
      },
      {
        "objectId": "3",
        "type": "input",
        "value": "요청사항"
      }
    ]
  },
  {
    "objectId": "8",
    "name": "분리수거",
    "type": "call",
    "image": "assets/icons/service/recycle.svg",
    "items": [
      {
        "objectId": "0",
        "type": "resultMessage",
        "value": "신청되었습니다."
      },
      {
        "objectId": "1",
        "type": "text",
        "value": "5분 내로 관리실 직원이 방문 할 예정입니다."
      }
    ]
  },
  {
    "objectId": "daily_necessity",
    "name": "생필품 신청",
    "type": "shop",
    "image": "assets/icons/service/trashbag.svg",
    "items": []
  },
  {
    "objectId": "interior",
    "name": "인테리어",
    "type": "shop",
    "image": "assets/icons/service/interior.svg",
    "items": []
  },
  {
    "objectId": "goshop",
    "name": "고샵",
    "type": "shop",
    "image": "assets/sample/commontown/service/se1.png",
    "items": [
      {
        "objectId": "99",
        "type": "position",
        "value": "bottom",
        "children": [
          {
            "objectId": "1000",
            "type": "businessPeriod",
            "value": "00:00 ~ 24:00"
          },
          {
            "objectId": "1001",
            "type": "hashTag",
            "value": "",
            "children": [
              {
                "objectId": "2001",
                "type": "text",
                "value": "멀티샵"
              },
              {
                "objectId": "2002",
                "type": "text",
                "value": "생필품"
              },
              {
                "objectId": "2003",
                "type": "text",
                "value": "세계주류"
              },
              {
                "objectId": "2004",
                "type": "text",
                "value": "굿즈"
              }
            ]
          }
        ]
      }
    ]
  },
  {
    "objectId": "westdoor",
    "name": "웨스트도어",
    "type": "shop",
    "image": "assets/sample/commontown/service/se2.png",
    "items": [
      {
        "objectId": "99",
        "type": "position",
        "value": "bottom",
        "children": [
          {
            "objectId": "1000",
            "type": "businessPeriod",
            "value": "00:00 ~ 24:00"
          },
          {
            "objectId": "1001",
            "type": "hashTag",
            "value": "",
            "children": [
              {
                "objectId": "2001",
                "type": "text",
                "value": "멀티샵"
              },
              {
                "objectId": "2002",
                "type": "text",
                "value": "생필품"
              },
              {
                "objectId": "2003",
                "type": "text",
                "value": "세계주류"
              },
              {
                "objectId": "2004",
                "type": "text",
                "value": "굿즈"
              }
            ]
          }
        ]
      }
    ]
  },
  {
    "objectId": "13",
    "name": "비베러디쉬",
    "type": "shop",
    "image": "assets/sample/commontown/service/se3.png",
    "items": [
      {
        "objectId": "99",
        "type": "position",
        "value": "bottom",
        "children": [
          {
            "objectId": "1000",
            "type": "businessPeriod",
            "value": "00:00 ~ 24:00"
          },
          {
            "objectId": "1001",
            "type": "hashTag",
            "value": "",
            "children": [
              {
                "objectId": "2001",
                "type": "text",
                "value": "멀티샵"
              },
              {
                "objectId": "2002",
                "type": "text",
                "value": "생필품"
              },
              {
                "objectId": "2003",
                "type": "text",
                "value": "세계주류"
              },
              {
                "objectId": "2004",
                "type": "text",
                "value": "굿즈"
              }
            ]
          }
        ]
      }
    ]
  },
  {
    "objectId": "14",
    "name": "본보야지",
    "type": "shop",
    "image": "assets/sample/commontown/service/se4.png",
    "items": [
      {
        "objectId": "99",
        "type": "position",
        "value": "bottom",
        "children": [
          {
            "objectId": "1000",
            "type": "businessPeriod",
            "value": "00:00 ~ 24:00"
          },
          {
            "objectId": "1001",
            "type": "hashTag",
            "value": "",
            "children": [
              {
                "objectId": "2001",
                "type": "text",
                "value": "멀티샵"
              },
              {
                "objectId": "2002",
                "type": "text",
                "value": "생필품"
              },
              {
                "objectId": "2003",
                "type": "text",
                "value": "세계주류"
              },
              {
                "objectId": "2004",
                "type": "text",
                "value": "굿즈"
              }
            ]
          }
        ]
      }
    ]
  }
]''';

  static final String categoryJson = '''[
  {
    "objectId": "common_plus_1",
    "serviceObjectId": "common_plus",
    "name": "심플리오",
    "products": []
  },
  {
    "objectId": "common_plus_2",
    "serviceObjectId": "common_plus",
    "name": "오드리선",
    "products": []
  },
  {
    "objectId": "common_plus_3",
    "serviceObjectId": "common_plus",
    "name": "마타주",
    "products": []
  },
  {
    "objectId": "common_plus_4",
    "serviceObjectId": "common_plus",
    "name": "런드리라운지24",
    "products": []
  },
  {
    "objectId": "westdoor_1",
    "serviceObjectId": "westdoor",
    "name": "COFFEE",
    "products": []
  },
  {
    "objectId": "westdoor_2",
    "serviceObjectId": "westdoor",
    "name": "LATTE-WITH COFFEE",
    "products": []
  },
  {
    "objectId": "westdoor_3",
    "serviceObjectId": "westdoor",
    "name": "LATTE-NON COFFEE",
    "products": []
  },
  {
    "objectId": "westdoor_4",
    "serviceObjectId": "westdoor",
    "name": "TEA",
    "products": []
  },
  {
    "objectId": "westdoor_5",
    "serviceObjectId": "westdoor",
    "name": "ADE",
    "products": []
  },
  {
    "objectId": "westdoor_6",
    "serviceObjectId": "westdoor",
    "name": "FRAPPE",
    "products": []
  },
  {
    "objectId": "westdoor_7",
    "serviceObjectId": "westdoor",
    "name": "SMOOTHIE",
    "products": []
  },
  {
    "objectId": "westdoor_8",
    "serviceObjectId": "westdoor",
    "name": "DESSERT",
    "products": []
  },
  {
    "objectId": "interior_1",
    "serviceObjectId": "interior",
    "name": "가구",
    "products": []
  },
  {
    "objectId": "interior_2",
    "serviceObjectId": "interior",
    "name": "패브릭",
    "products": []
  },
  {
    "objectId": "interior_3",
    "serviceObjectId": "interior",
    "name": "홈데코",
    "products": []
  },
  {
    "objectId": "pet_1",
    "serviceObjectId": "pet",
    "name": "사료",
    "products": []
  },
  {
    "objectId": "pet_2",
    "serviceObjectId": "pet",
    "name": "간식",
    "products": []
  },
  {
    "objectId": "pet_3",
    "serviceObjectId": "pet",
    "name": "용품",
    "products": []
  },
  {
    "objectId": "goshop_1",
    "serviceObjectId": "goshop",
    "name": "음료",
    "products": []
  },
  {
    "objectId": "goshop_2",
    "serviceObjectId": "goshop",
    "name": "컵라면",
    "products": []
  },
  {
    "objectId": "goshop_3",
    "serviceObjectId": "goshop",
    "name": "즉석식품",
    "products": []
  },
  {
    "objectId": "goshop_4",
    "serviceObjectId": "goshop",
    "name": "과자",
    "products": []
  },
  {
    "objectId": "goshop_5",
    "serviceObjectId": "goshop",
    "name": "생필품",
    "products": []
  },
  {
    "objectId": "daily_necessity_1",
    "serviceObjectId": "daily_necessity",
    "name": "생필품",
    "products": []
  }
]
''';

  static final String productJson = '''[
  {
    "objectId": "common_plus_1_1",
    "categoryObjectId": "common_plus_1",
    "images": ["assets/sample/commontown/item/commonplus/s11.jpg"],
    "name": "헤븐리 샴푸",
    "price": 6500,
    "options": []
  },
  {
    "objectId": "common_plus_1_2",
    "categoryObjectId": "common_plus_1",
    "images": ["assets/sample/commontown/item/commonplus/s12.jpg"],
    "name": "리프레싱 스칼프샴푸",
    "price": 6000,
    "options": []
  },
  {
    "objectId": "common_plus_1_3",
    "categoryObjectId": "common_plus_1",
    "images": ["assets/sample/commontown/item/commonplus/s13.jpg"],
    "name": "리프레싱 스칼프 린스",
    "price": 6000,
    "options": []
  },
  {
    "objectId": "common_plus_1_4",
    "categoryObjectId": "common_plus_1",
    "images": ["assets/sample/commontown/item/commonplus/s14.jpg"],
    "name": "비오틴 탈모케어 샴푸",
    "price": 17000,
    "options": []
  },
  {
    "objectId": "common_plus_1_5",
    "categoryObjectId": "common_plus_1",
    "images": ["assets/sample/commontown/item/commonplus/s15.jpg"],
    "name": "프로틴부스터 헤어트리트먼트",
    "price": 8500,
    "options": []
  },
  {
    "objectId": "common_plus_1_6",
    "categoryObjectId": "common_plus_1",
    "images": ["assets/sample/commontown/item/commonplus/s16.jpg"],
    "name": "샤이닝 헤어세럼",
    "price": 6000,
    "options": []
  },
  {
    "objectId": "common_plus_1_7",
    "categoryObjectId": "common_plus_1",
    "images": ["assets/sample/commontown/item/commonplus/s17.jpg"],
    "name": "내추럴 글로우 토너",
    "price": 10000,
    "options": []
  },
  {
    "objectId": "common_plus_1_8",
    "categoryObjectId": "common_plus_1",
    "images": ["assets/sample/commontown/item/commonplus/s18.jpg"],
    "name": "내추럴 글로우 크림",
    "price": 18000,
    "options": []
  },
  {
    "objectId": "common_plus_1_9",
    "categoryObjectId": "common_plus_1",
    "images": ["assets/sample/commontown/item/commonplus/s19.jpg"],
    "name": "리얼이펙트 EGF앰플",
    "price": 29000,
    "options": []
  },
  {
    "objectId": "common_plus_2_1",
    "categoryObjectId": "common_plus_2",
    "images": ["assets/sample/commontown/item/commonplus/s21.jpg"],
    "name": "특별패키지 6팩",
    "price": 33200,
    "options": []
  },
  {
    "objectId": "common_plus_2_2",
    "categoryObjectId": "common_plus_2",
    "images": ["assets/sample/commontown/item/commonplus/s22.jpg"],
    "name": "특별패키지 12팩",
    "price": 60300,
    "options": []
  },
  {
    "objectId": "common_plus_2_3",
    "categoryObjectId": "common_plus_2",
    "images": ["assets/sample/commontown/item/commonplus/s23.jpg"],
    "name": "코튼코어 유기농 순면 생리대 중형",
    "price": 15200,
    "options": []
  },
  {
    "objectId": "common_plus_2_4",
    "categoryObjectId": "common_plus_2",
    "images": ["assets/sample/commontown/item/commonplus/s24.jpg"],
    "name": "코튼코어 유기농 순면 생리대 대형",
    "price": 7900,
    "options": []
  },
  {
    "objectId": "common_plus_2_5",
    "categoryObjectId": "common_plus_2",
    "images": ["assets/sample/commontown/item/commonplus/s25.jpg"],
    "name": "코튼코어 유기농 순면 팬티라이너",
    "price": 7900,
    "options": []
  },
  {
    "objectId": "common_plus_2_6",
    "categoryObjectId": "common_plus_2",
    "images": ["assets/sample/commontown/item/commonplus/s26.jpg"],
    "name": "내츄럴코튼 화장솜 80매",
    "price": 5500,
    "options": []
  },
  {
    "objectId": "common_plus_2_7",
    "categoryObjectId": "common_plus_2",
    "images": ["assets/sample/commontown/item/commonplus/s27.jpg"],
    "name": "여성청결제(240ml)",
    "price": 15200,
    "options": []
  },
  {
    "objectId": "common_plus_3_1",
    "categoryObjectId": "common_plus_3",
    "images": ["assets/sample/commontown/item/commonplus/s31.png"],
    "name": "단기보관료-행거보관(월)",
    "price": 10000,
    "options": []
  },
  {
    "objectId": "common_plus_3_2",
    "categoryObjectId": "common_plus_3",
    "images": ["assets/sample/commontown/item/commonplus/s32.png"],
    "name": "단기보관료-상자보관(월)",
    "price": 8000,
    "options": []
  },
  {
    "objectId": "common_plus_3_3",
    "categoryObjectId": "common_plus_3",
    "images": ["assets/sample/commontown/item/commonplus/s33.png"],
    "name": "장기보관료-행거보관(월)",
    "price": 7000,
    "options": []
  },
  {
    "objectId": "common_plus_3_4",
    "categoryObjectId": "common_plus_3",
    "images": ["assets/sample/commontown/item/commonplus/s34.png"],
    "name": "장기보관료-상자보관(월)",
    "price": 5600,
    "options": []
  },
  {
    "objectId": "common_plus_3_5",
    "categoryObjectId": "common_plus_3",
    "images": ["assets/sample/commontown/item/commonplus/s35.png"],
    "name": "픽업료-예약방문",
    "price": 7000,
    "options": []
  },
  {
    "objectId": "common_plus_3_6",
    "categoryObjectId": "common_plus_3",
    "images": ["assets/sample/commontown/item/commonplus/s36.png"],
    "name": "픽업료-방문택배",
    "price": 5000,
    "options": []
  },
  {
    "objectId": "common_plus_3_7",
    "categoryObjectId": "common_plus_3",
    "images": ["assets/sample/commontown/item/commonplus/s37.png"],
    "name": "픽업료-무인택배함/편의점",
    "price": 3000,
    "options": []
  },
  {
    "objectId": "common_plus_3_8",
    "categoryObjectId": "common_plus_3",
    "images": ["assets/sample/commontown/item/commonplus/s38.png"],
    "name": "배송비-택배배송",
    "price": 5000,
    "options": []
  },
  {
    "objectId": "common_plus_3_9",
    "categoryObjectId": "common_plus_3",
    "images": ["assets/sample/commontown/item/commonplus/s39.png"],
    "name": "배송비-예약배송",
    "price": 7000,
    "options": []
  },
  {
    "objectId": "common_plus_4_1",
    "categoryObjectId": "common_plus_4",
    "images": ["assets/sample/commontown/item/commonplus/s41.png"],
    "name": "표준세탁",
    "price": 6000,
    "options": []
  },
  {
    "objectId": "common_plus_4_2",
    "categoryObjectId": "common_plus_4",
    "images": ["assets/sample/commontown/item/commonplus/s42.png"],
    "name": "표준온수세탁",
    "price": 6500,
    "options": []
  },
  {
    "objectId": "common_plus_4_3",
    "categoryObjectId": "common_plus_4",
    "images": ["assets/sample/commontown/item/commonplus/s43.png"],
    "name": "향균세탁",
    "price": 7000,
    "options": []
  },
  {
    "objectId": "common_plus_4_4",
    "categoryObjectId": "common_plus_4",
    "images": ["assets/sample/commontown/item/commonplus/s44.png"],
    "name": "향균온수세탁",
    "price": 7500,
    "options": []
  },
  {
    "objectId": "common_plus_4_5",
    "categoryObjectId": "common_plus_4",
    "images": ["assets/sample/commontown/item/commonplus/s45.png"],
    "name": "친환경세제세탁",
    "price": 7000,
    "options": []
  },
  {
    "objectId": "common_plus_4_6",
    "categoryObjectId": "common_plus_4",
    "images": ["assets/sample/commontown/item/commonplus/s46.png"],
    "name": "프리미엄세탁",
    "price": 8000,
    "options": []
  },
  {
    "objectId": "common_plus_4_7",
    "categoryObjectId": "common_plus_4",
    "images": ["assets/sample/commontown/item/commonplus/s47.png"],
    "name": "쾌속세탁",
    "price": 5500,
    "options": []
  },
  {
    "objectId": "common_plus_4_8",
    "categoryObjectId": "common_plus_4",
    "images": ["assets/sample/commontown/item/commonplus/s48.png"],
    "name": "세탁봉투",
    "price": 500,
    "options": []
  },
  {
    "objectId": "common_plus_4_9",
    "categoryObjectId": "common_plus_4",
    "images": ["assets/sample/commontown/item/commonplus/s49.png"],
    "name": "드라이시트(2매)",
    "price": 500,
    "options": []
  },
  {
    "objectId": "westdoor_1_1",
    "categoryObjectId": "westdoor_1",
    "images": ["assets/sample/commontown/item/westdoor/s11.png"],
    "name": "에스프레소",
    "price": 2500,
    "options": []
  },
  {
    "objectId": "westdoor_1_2",
    "categoryObjectId": "westdoor_1",
    "images": ["assets/sample/commontown/item/westdoor/s12.png"],
    "name": "아메리카노 (코스타리카)",
    "price": 2800,
    "options": []
  },
  {
    "objectId": "westdoor_1_3",
    "categoryObjectId": "westdoor_1",
    "images": ["assets/sample/commontown/item/westdoor/s13.png"],
    "name": "아메리카노 (모지아나)",
    "price": 2800,
    "options": []
  },
  {
    "objectId": "westdoor_1_4",
    "categoryObjectId": "westdoor_1",
    "images": ["assets/sample/commontown/item/westdoor/s14.png"],
    "name": "헤이즐넛 아메리카노",
    "price": 3200,
    "options": []
  },
  {
    "objectId": "westdoor_1_5",
    "categoryObjectId": "westdoor_1",
    "images": ["assets/sample/commontown/item/westdoor/s15.png"],
    "name": "카페모카",
    "price": 3800,
    "options": []
  },
  {
    "objectId": "westdoor_1_6",
    "categoryObjectId": "westdoor_1",
    "images": ["assets/sample/commontown/item/westdoor/s16.png"],
    "name": "아인슈페너",
    "price": 3800,
    "options": []
  },
  {
    "objectId": "westdoor_1_7",
    "categoryObjectId": "westdoor_1",
    "images": ["assets/sample/commontown/item/westdoor/s17.png"],
    "name": "웨스트도어 콜드브루 블랙",
    "price": 4200,
    "options": []
  },
  {
    "objectId": "westdoor_1_8",
    "categoryObjectId": "westdoor_1",
    "images": ["assets/sample/commontown/item/westdoor/s18.png"],
    "name": "웨스트도어 콜드브루 화이트",
    "price": 4500,
    "options": []
  },
  {
    "objectId": "westdoor_2_1",
    "categoryObjectId": "westdoor_2",
    "images": ["assets/sample/commontown/item/westdoor/s21.png"],
    "name": "카페라떼",
    "price": 3200,
    "options": []
  },
  {
    "objectId": "westdoor_2_2",
    "categoryObjectId": "westdoor_2",
    "images": ["assets/sample/commontown/item/westdoor/s22.png"],
    "name": "플랫화이트",
    "price": 3200,
    "options": []
  },
  {
    "objectId": "westdoor_2_3",
    "categoryObjectId": "westdoor_2",
    "images": ["assets/sample/commontown/item/westdoor/s23.png"],
    "name": "바닐라라떼",
    "price": 3500,
    "options": []
  },
  {
    "objectId": "westdoor_2_4",
    "categoryObjectId": "westdoor_2",
    "images": ["assets/sample/commontown/item/westdoor/s24.png"],
    "name": "카라멜라떼",
    "price": 3500,
    "options": []
  },
  {
    "objectId": "westdoor_3_1",
    "categoryObjectId": "westdoor_3",
    "images": ["assets/sample/commontown/item/westdoor/s31.png"],
    "name": "초콜릿라떼",
    "price": 3800,
    "options": []
  },
  {
    "objectId": "westdoor_3_2",
    "categoryObjectId": "westdoor_3",
    "images": ["assets/sample/commontown/item/westdoor/s32.png"],
    "name": "말차라떼",
    "price": 3800,
    "options": []
  },
  {
    "objectId": "westdoor_3_3",
    "categoryObjectId": "westdoor_3",
    "images": ["assets/sample/commontown/item/westdoor/s33.png"],
    "name": "토피넛라떼",
    "price": 3800,
    "options": []
  },
  {
    "objectId": "westdoor_3_4",
    "categoryObjectId": "westdoor_3",
    "images": ["assets/sample/commontown/item/westdoor/s34.png"],
    "name": "고구마라떼",
    "price": 3800,
    "options": []
  },
  {
    "objectId": "westdoor_3_5",
    "categoryObjectId": "westdoor_3",
    "images": ["assets/sample/commontown/item/westdoor/s35.png"],
    "name": "흑임자라떼",
    "price": 4800,
    "options": []
  },
  {
    "objectId": "westdoor_3_6",
    "categoryObjectId": "westdoor_3",
    "images": ["assets/sample/commontown/item/westdoor/s36.png"],
    "name": "밀크티",
    "price": 4200,
    "options": []
  },
  {
    "objectId": "westdoor_3_7",
    "categoryObjectId": "westdoor_3",
    "images": ["assets/sample/commontown/item/westdoor/s37.png"],
    "name": "딸기우유",
    "price": 5500,
    "options": []
  },
  {
    "objectId": "westdoor_3_8",
    "categoryObjectId": "westdoor_3",
    "images": ["assets/sample/commontown/item/westdoor/s38.png"],
    "name": "애플시나몬",
    "price": 5500,
    "options": []
  },
  {
    "objectId": "westdoor_4_1",
    "categoryObjectId": "westdoor_4",
    "images": ["assets/sample/commontown/item/westdoor/s41.png"],
    "name": "몬트리올",
    "price": 3900,
    "options": []
  },
  {
    "objectId": "westdoor_4_2",
    "categoryObjectId": "westdoor_4",
    "images": ["assets/sample/commontown/item/westdoor/s42.png"],
    "name": "생로랑",
    "price": 3900,
    "options": []
  },
  {
    "objectId": "westdoor_4_3",
    "categoryObjectId": "westdoor_4",
    "images": ["assets/sample/commontown/item/westdoor/s43.png"],
    "name": "루이보스",
    "price": 3900,
    "options": []
  },
  {
    "objectId": "westdoor_4_4",
    "categoryObjectId": "westdoor_4",
    "images": ["assets/sample/commontown/item/westdoor/s44.png"],
    "name": "얼그레이",
    "price": 3900,
    "options": []
  },
  {
    "objectId": "westdoor_4_5",
    "categoryObjectId": "westdoor_4",
    "images": ["assets/sample/commontown/item/westdoor/s45.png"],
    "name": "오렌지 카모마일 ",
    "price": 3900,
    "options": []
  },
  {
    "objectId": "westdoor_4_6",
    "categoryObjectId": "westdoor_4",
    "images": ["assets/sample/commontown/item/westdoor/s46.png"],
    "name": "유자차",
    "price": 3200,
    "options": []
  },
  {
    "objectId": "westdoor_4_7",
    "categoryObjectId": "westdoor_4",
    "images": ["assets/sample/commontown/item/westdoor/s47.png"],
    "name": "레몬차",
    "price": 3200,
    "options": []
  },
  {
    "objectId": "westdoor_4_8",
    "categoryObjectId": "westdoor_4",
    "images": ["assets/sample/commontown/item/westdoor/s48.png"],
    "name": "한라봉차",
    "price": 3200,
    "options": []
  },
  {
    "objectId": "westdoor_4_9",
    "categoryObjectId": "westdoor_4",
    "images": ["assets/sample/commontown/item/westdoor/s49.png"],
    "name": "복숭아아이스티",
    "price": 3800,
    "options": []
  },
  {
    "objectId": "westdoor_5_1",
    "categoryObjectId": "westdoor_5",
    "images": ["assets/sample/commontown/item/westdoor/s51.png"],
    "name": "오렌지에이드",
    "price": 4200,
    "options": []
  },
  {
    "objectId": "westdoor_5_2",
    "categoryObjectId": "westdoor_5",
    "images": ["assets/sample/commontown/item/westdoor/s52.png"],
    "name": "청포도에이드",
    "price": 4200,
    "options": []
  },
  {
    "objectId": "westdoor_5_3",
    "categoryObjectId": "westdoor_5",
    "images": ["assets/sample/commontown/item/westdoor/s53.png"],
    "name": "자몽에이드",
    "price": 4200,
    "options": []
  },
  {
    "objectId": "westdoor_5_4",
    "categoryObjectId": "westdoor_5",
    "images": ["assets/sample/commontown/item/westdoor/s54.png"],
    "name": "유자청에이드",
    "price": 4200,
    "options": []
  },
  {
    "objectId": "westdoor_5_5",
    "categoryObjectId": "westdoor_5",
    "images": ["assets/sample/commontown/item/westdoor/s55.png"],
    "name": "딸기에이드",
    "price": 6000,
    "options": []
  },
  {
    "objectId": "westdoor_6_1",
    "categoryObjectId": "westdoor_6",
    "images": ["assets/sample/commontown/item/westdoor/s61.png"],
    "name": "딸기 프라페",
    "price": 3900,
    "options": []
  },
  {
    "objectId": "westdoor_6_2",
    "categoryObjectId": "westdoor_6",
    "images": ["assets/sample/commontown/item/westdoor/s62.png"],
    "name": "망고 프라페",
    "price": 3900,
    "options": []
  },
  {
    "objectId": "westdoor_6_3",
    "categoryObjectId": "westdoor_6",
    "images": ["assets/sample/commontown/item/westdoor/s63.png"],
    "name": "블루베리 프라페",
    "price": 3900,
    "options": []
  },
  {
    "objectId": "westdoor_7_1",
    "categoryObjectId": "westdoor_7",
    "images": ["assets/sample/commontown/item/westdoor/s71.png"],
    "name": "플레인 요거트 스무디 ",
    "price": 4200,
    "options": []
  },
  {
    "objectId": "westdoor_7_2",
    "categoryObjectId": "westdoor_7",
    "images": ["assets/sample/commontown/item/westdoor/s72.png"],
    "name": "딸기 요거트 스무디",
    "price": 4200,
    "options": []
  },
  {
    "objectId": "westdoor_7_3",
    "categoryObjectId": "westdoor_7",
    "images": ["assets/sample/commontown/item/westdoor/s73.png"],
    "name": "망고 요거트 스무디",
    "price": 4200,
    "options": []
  },
  {
    "objectId": "westdoor_7_4",
    "categoryObjectId": "westdoor_7",
    "images": ["assets/sample/commontown/item/westdoor/s74.png"],
    "name": "블루베리 요거트 스무디",
    "price": 4200,
    "options": []
  },
  {
    "objectId": "westdoor_8_1",
    "categoryObjectId": "westdoor_8",
    "images": ["assets/sample/commontown/item/westdoor/s81.png"],
    "name": "크로플",
    "price": 3000,
    "options": []
  },
  {
    "objectId": "westdoor_8_2",
    "categoryObjectId": "westdoor_8",
    "images": ["assets/sample/commontown/item/westdoor/s82.png"],
    "name": "얼그레이 크로플 샌드",
    "price": 6000,
    "options": []
  },
  {
    "objectId": "westdoor_8_3",
    "categoryObjectId": "westdoor_8",
    "images": ["assets/sample/commontown/item/westdoor/s83.png"],
    "name": "감귤 크로플 샌드",
    "price": 6500,
    "options": []
  },
  {
    "objectId": "westdoor_8_4",
    "categoryObjectId": "westdoor_8",
    "images": ["assets/sample/commontown/item/westdoor/s84.png"],
    "name": "생크림 추가",
    "price": 1000,
    "options": []
  },
  {
    "objectId": "westdoor_8_5",
    "categoryObjectId": "westdoor_8",
    "images": ["assets/sample/commontown/item/westdoor/s85.png"],
    "name": "얼그레이 생크림 추가",
    "price": 1500,
    "options": []
  },
  {
    "objectId": "westdoor_8_6",
    "categoryObjectId": "westdoor_8",
    "images": ["assets/sample/commontown/item/westdoor/s86.png"],
    "name": "감귤 추가",
    "price": 1500,
    "options": []
  },
  {
    "objectId": "daily_necessity_1_1",
    "categoryObjectId": "daily_necessity_1",
    "images": ["assets/sample/daily_necessity/item/s1.png"],
    "name": "휴지",
    "price": 500,
    "options": []
  },
  {
    "objectId": "daily_necessity_1_2",
    "categoryObjectId": "daily_necessity_1",
    "images": ["assets/sample/daily_necessity/item/s2.jpg"],
    "name": "각티슈",
    "price": 1000,
    "options": []
  },
  {
    "objectId": "daily_necessity_1_3",
    "categoryObjectId": "daily_necessity_1",
    "images": ["assets/sample/daily_necessity/item/s3.jpg"],
    "name": "드럼세탁기 세제",
    "price": 3000,
    "options": []
  },
  {
    "objectId": "daily_necessity_1_4",
    "categoryObjectId": "daily_necessity_1",
    "images": ["assets/sample/daily_necessity/item/s4.png"],
    "name": "주방세제",
    "price": 2000,
    "options": []
  },
  {
    "objectId": "daily_necessity_1_5",
    "categoryObjectId": "daily_necessity_1",
    "images": ["assets/sample/daily_necessity/item/s5.jpg"],
    "name": "샴푸",
    "price": 9000,
    "options": []
  },
  {
    "objectId": "daily_necessity_1_6",
    "categoryObjectId": "daily_necessity_1",
    "images": ["assets/sample/daily_necessity/item/s6.png"],
    "name": "린스",
    "price": 9000,
    "options": []
  },
  {
    "objectId": "daily_necessity_1_7",
    "categoryObjectId": "daily_necessity_1",
    "images": ["assets/sample/daily_necessity/item/s7.jpg"],
    "name": "바디워시",
    "price": 7000,
    "options": []
  },
  {
    "objectId": "daily_necessity_1_8",
    "categoryObjectId": "daily_necessity_1",
    "images": ["assets/sample/daily_necessity/item/s8.png"],
    "name": "비누",
    "price": 1000,
    "options": []
  },
  {
    "objectId": "daily_necessity_1_9",
    "categoryObjectId": "daily_necessity_1",
    "images": ["assets/sample/daily_necessity/item/s9.png"],
    "name": "칫솔",
    "price": 1000,
    "options": []
  },
  {
    "objectId": "daily_necessity_1_10",
    "categoryObjectId": "daily_necessity_1",
    "images": ["assets/sample/daily_necessity/item/s10.jpg"],
    "name": "치약",
    "price": 2000,
    "options": []
  },
  {
    "objectId": "daily_necessity_1_11",
    "categoryObjectId": "daily_necessity_1",
    "images": ["assets/sample/daily_necessity/item/s11.jpg"],
    "name": "종량제봉투",
    "price": 1000,
    "options": [
      {
        "isRequired": true,
        "objectId": "daily_necessity_1_11_1_1",
        "parentObjectId": null,
        "name": "10L",
        "price": 0,
        "options": []
      },
      {
        "isRequired": true,
        "objectId": "daily_necessity_1_11_1_2",
        "parentObjectId": null,
        "name": "20L",
        "price": 1000,
        "options": []
      },
      {
        "isRequired": true,
        "objectId": "daily_necessity_1_11_1_3",
        "parentObjectId": null,
        "name": "50L",
        "price": 2000,
        "options": []
      }
    ]
  },
  {
    "objectId": "interior_1_1",
    "categoryObjectId": "interior_1",
    "images": [
      "assets/sample/commontown/item/interior/s111.png",
      "assets/sample/commontown/item/interior/s112.png",
      "assets/sample/commontown/item/interior/s113.png"
    ],
    "name": "회전의자",
    "price": 55000,
    "options": []
  },
  {
    "objectId": "interior_1_2",
    "categoryObjectId": "interior_1",
    "images": [
      "assets/sample/commontown/item/interior/s121.png",
      "assets/sample/commontown/item/interior/s122.png",
      "assets/sample/commontown/item/interior/s123.png"
    ],
    "name": "등받이 의자",
    "price": 44000,
    "options": []
  },
  {
    "objectId": "interior_2_1",
    "categoryObjectId": "interior_2",
    "images": [
      "assets/sample/commontown/item/interior/s211.png",
      "assets/sample/commontown/item/interior/s212.png",
      "assets/sample/commontown/item/interior/s213.png"
    ],
    "name": "벨벳의자",
    "price": 61000,
    "options": []
  },
  {
    "objectId": "interior_3_1",
    "categoryObjectId": "interior_3",
    "images": [
      "assets/sample/commontown/item/interior/s311.png",
      "assets/sample/commontown/item/interior/s312.png",
      "assets/sample/commontown/item/interior/s313.png"
    ],
    "name": "유리화병",
    "price": 12000,
    "options": []
  },
  {
    "objectId": "interior_3_2",
    "categoryObjectId": "interior_3",
    "images": [
      "assets/sample/commontown/item/interior/s321.png",
      "assets/sample/commontown/item/interior/s322.png",
      "assets/sample/commontown/item/interior/s323.png"
    ],
    "name": "화병세트",
    "price": 18000,
    "options": []
  },
  {
    "objectId": "interior_3_3",
    "categoryObjectId": "interior_3",
    "images": [
      "assets/sample/commontown/item/interior/s331.png",
      "assets/sample/commontown/item/interior/s332.png",
      "assets/sample/commontown/item/interior/s333.png"
    ],
    "name": "우산꽂이",
    "price": 18000,
    "options": []
  },
  {
    "objectId": "interior_3_4",
    "categoryObjectId": "interior_3",
    "images": [
      "assets/sample/commontown/item/interior/s341.png",
      "assets/sample/commontown/item/interior/s342.png",
      "assets/sample/commontown/item/interior/s343.png"
    ],
    "name": "가죽스툴",
    "price": 59000,
    "options": []
  },
  {
    "objectId": "interior_3_5",
    "categoryObjectId": "interior_3",
    "images": [
      "assets/sample/commontown/item/interior/s351.png",
      "assets/sample/commontown/item/interior/s352.png",
      "assets/sample/commontown/item/interior/s353.png"
    ],
    "name": "목재스툴",
    "price": 40000,
    "options": []
  },
  {
    "objectId": "interior_3_6",
    "categoryObjectId": "interior_3",
    "images": [
      "assets/sample/commontown/item/interior/s361.png",
      "assets/sample/commontown/item/interior/s362.png",
      "assets/sample/commontown/item/interior/s363.png"
    ],
    "name": "인테리어 스크린",
    "price": 21000,
    "options": []
  },
  {
    "objectId": "interior_3_7",
    "categoryObjectId": "interior_3",
    "images": [
      "assets/sample/commontown/item/interior/s371.png",
      "assets/sample/commontown/item/interior/s372.png",
      "assets/sample/commontown/item/interior/s373.png"
    ],
    "name": "테이블",
    "price": 98000,
    "options": []
  },
  {
    "objectId": "pet_1_1",
    "categoryObjectId": "pet_1",
    "images": ["assets/sample/commontown/item/pet/s11.jpg"],
    "name": "고양이사료(성묘용)",
    "price": 12000,
    "options": []
  },
  {
    "objectId": "pet_1_2",
    "categoryObjectId": "pet_1",
    "images": ["assets/sample/commontown/item/pet/s12.jpg"],
    "name": "고양이사료",
    "price": 15000,
    "options": []
  },
  {
    "objectId": "pet_1_3",
    "categoryObjectId": "pet_1",
    "images": ["assets/sample/commontown/item/pet/s13.jpg"],
    "name": "애견 사료(성견용)",
    "price": 12000,
    "options": []
  },
  {
    "objectId": "pet_1_4",
    "categoryObjectId": "pet_1",
    "images": ["assets/sample/commontown/item/pet/s14.jpg"],
    "name": "애견사료(puppy용)",
    "price": 15000,
    "options": []
  },
  {
    "objectId": "pet_2_1",
    "categoryObjectId": "pet_2",
    "images": ["assets/sample/commontown/item/pet/s21.jpg"],
    "name": "간식(캔)",
    "price": 5000,
    "options": []
  },
  {
    "objectId": "pet_2_2",
    "categoryObjectId": "pet_2",
    "images": ["assets/sample/commontown/item/pet/s22.jpg"],
    "name": "개껌",
    "price": 3000,
    "options": []
  },
  {
    "objectId": "pet_3_1",
    "categoryObjectId": "pet_3",
    "images": ["assets/sample/commontown/item/pet/s31.jpg"],
    "name": "애견목줄",
    "price": 8200,
    "options": []
  },
  {
    "objectId": "pet_3_2",
    "categoryObjectId": "pet_3",
    "images": ["assets/sample/commontown/item/pet/s32.jpg"],
    "name": "배변봉",
    "price": 5200,
    "options": []
  },
  {
    "objectId": "pet_3_3",
    "categoryObjectId": "pet_3",
    "images": ["assets/sample/commontown/item/pet/s33.jpg"],
    "name": "애견샴푸",
    "price": 18000,
    "options": []
  },
  {
    "objectId": "pet_3_4",
    "categoryObjectId": "pet_3",
    "images": ["assets/sample/commontown/item/pet/s34.png"],
    "name": "애견패드",
    "price": 1200,
    "options": []
  },
  {
    "objectId": "pet_3_5",
    "categoryObjectId": "pet_3",
    "images": ["assets/sample/commontown/item/pet/s35.png"],
    "name": "케이지",
    "price": 35000,
    "options": []
  },
  {
    "objectId": "goshop_1_1",
    "categoryObjectId": "goshop_1",
    "name": "박카스F(120ml)",
    "price": 990,
    "images": ["assets/sample/commontown/item/goshop/s1.png"],
    "options": []
  },
  {
    "objectId": "goshop_1_2",
    "categoryObjectId": "goshop_1",
    "name": "코카콜라(500ml)",
    "price": 1900,
    "images": ["assets/sample/commontown/item/goshop/s2.png"],
    "options": []
  },
  {
    "objectId": "goshop_1_3",
    "categoryObjectId": "goshop_1",
    "name": "갈아만든배(340ml)",
    "price": 990,
    "images": ["assets/sample/commontown/item/goshop/s3.png"],
    "options": []
  },
  {
    "objectId": "goshop_1_4",
    "categoryObjectId": "goshop_1",
    "name": "코코팜화이트(240ml)",
    "price": 990,
    "images": ["assets/sample/commontown/item/goshop/s4.png"],
    "options": []
  },
  {
    "objectId": "goshop_1_5",
    "categoryObjectId": "goshop_1",
    "name": "포카리스웨트(1.8L)",
    "price": 2900,
    "images": ["assets/sample/commontown/item/goshop/s5.png"],
    "options": []
  },
  {
    "objectId": "goshop_1_6",
    "categoryObjectId": "goshop_1",
    "name": "미닛메이드 오렌지(1.5L)",
    "price": 2490,
    "images": ["assets/sample/commontown/item/goshop/s6.png"],
    "options": []
  },
  {
    "objectId": "goshop_2_7",
    "categoryObjectId": "goshop_2",
    "name": "농심 신라면 소컵",
    "price": 1290,
    "images": ["assets/sample/commontown/item/goshop/s7.png"],
    "options": []
  },
  {
    "objectId": "goshop_2_8",
    "categoryObjectId": "goshop_2",
    "name": "삼양 불닭볶음면",
    "price": 1690,
    "images": ["assets/sample/commontown/item/goshop/s8.png"],
    "options": []
  },
  {
    "objectId": "goshop_2_9",
    "categoryObjectId": "goshop_2",
    "name": "팔도 비빔면",
    "price": 1690,
    "images": ["assets/sample/commontown/item/goshop/s9.png"],
    "options": []
  },
  {
    "objectId": "goshop_3_10",
    "categoryObjectId": "goshop_3",
    "name": "CJ햇반 컵반 사골곰탕국밥",
    "price": 3490,
    "images": ["assets/sample/commontown/item/goshop/s10.png"],
    "options": []
  },
  {
    "objectId": "goshop_3_11",
    "categoryObjectId": "goshop_3",
    "name": "CJ햇반 컵반 중화마파두부덮밥",
    "price": 3490,
    "images": ["assets/sample/commontown/item/goshop/s11.png"],
    "options": []
  },
  {
    "objectId": "goshop_3_12",
    "categoryObjectId": "goshop_3",
    "name": "CJ고메 토마토미트볼",
    "price": 4900,
    "images": ["assets/sample/commontown/item/goshop/s12.png"],
    "options": []
  },
  {
    "objectId": "goshop_3_13",
    "categoryObjectId": "goshop_3",
    "name": "CJ 비비고 전복죽",
    "price": 4900,
    "images": ["assets/sample/commontown/item/goshop/s13.png"],
    "options": []
  },
  {
    "objectId": "goshop_4_14",
    "categoryObjectId": "goshop_4",
    "name": "프링글스 오리지날맛",
    "price": 2490,
    "images": ["assets/sample/commontown/item/goshop/s14.png"],
    "options": []
  },
  {
    "objectId": "goshop_4_15",
    "categoryObjectId": "goshop_4",
    "name": "롯데 몽쉘크림(6입)",
    "price": 2900,
    "images": ["assets/sample/commontown/item/goshop/s15.png"],
    "options": []
  },
  {
    "objectId": "goshop_4_16",
    "categoryObjectId": "goshop_4",
    "name": "크라운 초코하입(6개입)",
    "price": 1490,
    "images": ["assets/sample/commontown/item/goshop/s16.png"],
    "options": []
  },
  {
    "objectId": "goshop_4_17",
    "categoryObjectId": "goshop_4",
    "name": "롯데 빼빼로아몬드",
    "price": 1490,
    "images": ["assets/sample/commontown/item/goshop/s17.png"],
    "options": []
  },
  {
    "objectId": "goshop_4_18",
    "categoryObjectId": "goshop_4",
    "name": "크라운 쿠크다스 커피(9입)",
    "price": 1900,
    "images": ["assets/sample/commontown/item/goshop/s18.png"],
    "options": []
  },
  {
    "objectId": "goshop_4_19",
    "categoryObjectId": "goshop_4",
    "name": "오리온 촉촉한초코칩",
    "price": 2490,
    "images": ["assets/sample/commontown/item/goshop/s19.png"],
    "options": []
  },
  {
    "objectId": "goshop_4_20",
    "categoryObjectId": "goshop_4",
    "name": "크라운 국희샌드",
    "price": 1490,
    "images": ["assets/sample/commontown/item/goshop/s20.png"],
    "options": []
  },
  {
    "objectId": "goshop_4_21",
    "categoryObjectId": "goshop_4",
    "name": "오리온 포카칩",
    "price": 1600,
    "images": ["assets/sample/commontown/item/goshop/s21.png"],
    "options": []
  },
  {
    "objectId": "goshop_5_22",
    "categoryObjectId": "goshop_5",
    "name": "토디앙 네이처그린 물티슈 캡(100매)",
    "price": 1900,
    "images": ["assets/sample/commontown/item/goshop/s22.png"],
    "options": []
  },
  {
    "objectId": "goshop_5_23",
    "categoryObjectId": "goshop_5",
    "name": "좋은느낌 유기농순면커버 슬날 중(14P)",
    "price": 5900,
    "images": ["assets/sample/commontown/item/goshop/s23.png"],
    "options": []
  },
  {
    "objectId": "goshop_5_24",
    "categoryObjectId": "goshop_5",
    "name": "니베아 쉐이빙폼",
    "price": 6900,
    "images": ["assets/sample/commontown/item/goshop/s24.png"],
    "options": []
  },
  {
    "objectId": "goshop_5_25",
    "categoryObjectId": "goshop_5",
    "name": "미쟝센 파워스윙 매트 왁스",
    "price": 9900,
    "images": ["assets/sample/commontown/item/goshop/s25.png"],
    "options": []
  },
  {
    "objectId": "goshop_5_26",
    "categoryObjectId": "goshop_5",
    "name": "PACE4 휴대용면도기(4입)",
    "price": 5900,
    "images": ["assets/sample/commontown/item/goshop/s26.png"],
    "options": []
  }
]
''';

  static HomeModel home() {
    return HomeModel.fromJson(jsonDecode(homeJson));
  }

  static List<NoticeModel> notices() {
    final list = jsonDecode(noticeJson) as List;
    return list.map((json) => NoticeModel.fromJson(json)).toList();
  }

  static List<HistoryModel> histories() {
    final list = jsonDecode(historyJson) as List;

    return list
        .map((json) => HistoryModel.fromJson(json))
        .map((e) => HistoryModel(
              index: e.index,
              serviceName: e.serviceName,
              summary: e.summary,
              amount: e.amount,
              status: e.status,
              createdTime: e.createdTime,
              detail: HistoryDetailModel(
                title: '종량제 봉투',
                createdTime: DateTime.now(),
                amount: 5300,
                paymentMethod: '국민카드',
                paymentData: '1234',
                detail: [
                  KeyValueModel(key: '20L', value: 1, price: 1000),
                  KeyValueModel(key: '50L', value: 1, price: 1800),
                  KeyValueModel(key: '100L', value: 1, price: 2500),
                ],
                reservedTime: DateTime.now(),
                request: '문앞에 두고 벨을 눌러주세요',
              ),
            ))
        .toList();
  }

  static List<ServiceModel> services() {
    final list = jsonDecode(serviceJson) as List;
    return list.map((json) => ServiceModel.fromJson(json)).toList();
  }

  static List<CategoryModel> categories(String serviceObjectId) {
    final list = jsonDecode(categoryJson) as List;

    final products = SampleData.products();

    return list
        .map((json) => CategoryModel.fromJson(json))
        .toList()
        .where((item) => item.serviceObjectId == serviceObjectId)
        .map((item) => CategoryModel(
              objectId: item.objectId,
              serviceObjectId: item.serviceObjectId,
              name: item.name,
              products: products
                  .where((product) => product.categoryObjectId == item.objectId)
                  .toList(),
            ))
        .toList();
  }

  static List<ProductModel> products() {
    final list = jsonDecode(productJson) as List;
    return list.map((json) => ProductModel.fromJson(json)).toList();
  }
}
