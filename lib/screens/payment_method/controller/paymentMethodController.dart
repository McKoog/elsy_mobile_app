import 'dart:async';

import '/screens/payment_method/paymentMethodComponent.dart' as PaymentMethod;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:tinkoff_acquiring/tinkoff_acquiring.dart';
import 'package:tinkoff_acquiring_flutter/tinkoff_acquiring_flutter.dart';
import 'dart:math' as math;
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher_platform_interface/url_launcher_platform_interface.dart';



class PaymentMethodController extends GetxController{
  BuildContext? myContext;
  var cardNumberFormatter = new MaskTextInputFormatter(mask: '#### #### #### ####', filter: { "#": RegExp(r'[0-9]') });
  var cardDateFormatter = new MaskTextInputFormatter(mask: '##/##', filter: { "#": RegExp(r'[0-9]') });
  var cardCvvFormatter = new MaskTextInputFormatter(mask: '###', filter: { "#": RegExp(r'[0-9]') });
  BoxConstraints? constraints;

  // List<dynamic> CardList = [].obs;
  // List<CardData> cardsInfo = [];

  void createCard(String cardNumber, String cardDate, String cardCvv){
    PaymentMethod.PaymentMethod.cardsInfo.add(CardData(
      pan: cardNumber,
      expDate: cardDate,
      cvv: cardCvv,
    ));
  }
  // addCardToList(Widget widget){
  //   PaymentMethod.CardList.add(widget);
  // }

  showCardInformation(int index){
    print('ZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZZ');
    print(PaymentMethod.PaymentMethod.cardsInfo[index].pan);
    print(PaymentMethod.PaymentMethod.cardsInfo[index].expDate);
    print(PaymentMethod.PaymentMethod.cardsInfo[index].cvv);
  }

  Future<String> pay(int index) async {
    const String terminalKey = '1655724316760';
    const String password = 'kjaty6sjyo93gghw';
    const String publicKey = 'MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAv5yse9ka3ZQE0feuGtemYv3IqOlLck8zHUM7lTr0za6lXTszRSXfUO7jMb+L5C7e2QNFs+7sIX2OQJ6a+HG8k'
        'r+jwJ4tS3cVsWtd9NXpsU40PE4MeNr5RqiNXjcDxA+L4OsEm/BlyFOEOh2epGyYUd5/iO3OiQFRNicomT2saQYAeqIwuELPs1XpLk9HLx5qPbm8fRrQhjeUD5TLO8b+4yCnObe8vy/BMUwBfq+ieWA'
        'DIjwWCMp2KTpMGLz48qnaD9kdrYJ0iyHqzb2mkDhdIzkim24A3lWoYitJCBrrB2xM05sm9+OdCI1f7nPNJbl5URHobSwR94IRGT7CJcUjvwIDAQAB';
    const int amount = 100;
    print(publicKey);

    String cardData = CardData(
        pan: '4276220014958501',
        expDate: '1222',
        cvv: '139',
        cardHolder: 'ANDREY KOLYADICH'
    ).encode(publicKey);
    /*print(PaymentMethod.PaymentMethod.cardsInfo[index]);
    String cardData = PaymentMethod.PaymentMethod.cardsInfo[index].encode(publicKey);*/
    print(cardData);

      final TinkoffAcquiring acquiring = TinkoffAcquiring(
          TinkoffAcquiringConfig(
            terminalKey: terminalKey,
            password: password,
            debug: false,
          )
      );

      final InitResponse init = await acquiring.init(InitRequest(
          orderId: (99 +
              math.Random(DateTime
                  .now()
                  .millisecondsSinceEpoch)
                  .nextInt(100000))
              .toString(),
          amount: amount,
          language: Language.ru,
          payType: PayType.one,
          /*receipt: Receipt(taxation: Taxation.osn, items: [Items(
            name: 'name',
            amount: amount.toString(),
            tax: Tax.vat10,
            price: '100',
            quantity: '1.00',
          )
          ], email: 'koliandru@mail.ru')*/
      ));

      print("INIT : " + init.status.toString());

      /*final CancelResponse cancel = await acquiring.cancel(CancelRequest(paymentId: int.parse(init.paymentId!)));

      print("CANCEL: " + cancel.status.toString());*/

    //   final getQr = await acquiring.getQr(
    //     GetQrRequest(
    //         paymentId: int.parse('${init.paymentId!}') ,
    //     )
    //   );
    // final url = await getQr.data;
    // print(await url);
    //
    //   await launch(
    //     url!,
    //     //forceWebView: true,
    //     enableJavaScript: true,
    //     enableDomStorage: true,
    //   );

      final Check3DSVersionResponse check3DSVersion =
      await acquiring.check3DSVersion(Check3DSVersionRequest(
        paymentId: int.parse(init.paymentId!),
        cardData: cardData,
      ));

      final Completer<Map<String, String>> data =
      Completer<Map<String, String>>();
      if (check3DSVersion.is3DsVersion2) {
        CollectData(
          context: myContext!,
          config: acquiring.config,
          serverTransId: check3DSVersion.serverTransId!,
          threeDsMethodUrl: check3DSVersion.threeDsMethodUrl!,
          onFinished: (Map<String, String> v) {
            data.complete(v);
          },
        );
      } else {
        data.complete(<String, String>{});
      }


      final FinishAuthorizeResponse fa =
      await acquiring.finishAuthorize(FinishAuthorizeRequest(
        paymentId: int.parse(init.paymentId!),
        cardData: cardData,
        data: await data.future,
      ));



      final Completer<Submit3DSAuthorizationResponse?> webView =
      Completer<Submit3DSAuthorizationResponse?>();
      if (fa.status == Status.threeDsChecking) {
        Navigator.of(myContext!).push(MaterialPageRoute<void>(
          builder: (BuildContext context) => Scaffold(
            body: WebView3DS(
              config: acquiring.config,
              is3DsVersion2: fa.is3DsVersion2 || check3DSVersion.is3DsVersion2,
              serverTransId: fa.serverTransId ?? check3DSVersion.serverTransId,
              acsUrl: fa.acsUrl!,
              md: fa.md,
              paReq: fa.paReq,
              acsTransId: fa.acsTransId,
              version: check3DSVersion.version,
              onLoad: (bool v) {
                debugPrint('WebView load: $v');
              },
              onFinished: (Submit3DSAuthorizationResponse? v) {
                Navigator.of(context).pop();
                webView.complete(v);
              },
            ),
          ),
        ));
      } else {

        webView.complete(null);
      }

      final GetStateResponse getState = await acquiring.getState(
        GetStateRequest(
          paymentId: int.parse(init.paymentId!),
        ),
      );
      return getState.status.toString();
    }
}