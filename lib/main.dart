import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mercado_pago_mobile_checkout/mercado_pago_mobile_checkout.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    initialRoute: 'init',
    routes: {
      'init': (_) => const Home(),
    },
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final String publicKey = 'TEST-41fa6116-fe1d-411d-9a2b-fb19403303ae';
  // --> pega a publicKey do usuario(VENDEDOR) no mercadoPago
  final String tokenAcess =
      'TEST-3070843847140697-040512-6401310aa21c05c200efdffc93666002-185567692';
  // --> token de acesso tambem incluido no mercadoPago logo abaixo de publicKey

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final preferenceKey = createPreference(
        tokenAcess); // --> armazeno o retorno da minha funcionalidade que vai conter
    // todos os dados de venda como os produtos, quantidade e etc, porém como eu fiz o retorno da funcionalidade pra me retornar simplesmente o id da preferencia
    // armazeno simplesmente em uma variavel e utilizo ela pra iniciar meu checkout de pagamento.

    return Scaffold(
      body: Center(
          child: ElevatedButton(
              onPressed: () async {
                /// --> criar uma funcionalidade para gerar as preferencias da venda, ou seja as informacoes de produtos vendido e valor, fazer uma requisicao
                /// http para persistir os dados de venda do produto.

                PaymentResult result =
                    await MercadoPagoMobileCheckout.startCheckout(
                  publicKey,
                  await preferenceKey,
                );
              },
              child: Text('testes'))),
    );
  }

  Future<String> createPreference(String tokenAcess) async {
    // --> receber o token de acesso como parametro e passar dentro para url

    var url = Uri.parse(
        'https://api.mercadopago.com/checkout/preferences?access_token=$tokenAcess');

    Map<String, String> header = {
      'Authorization':
          'Bearer TEST-3070843847140697-040512-6401310aa21c05c200efdffc93666002-185567692',
      'Content-type': 'application/json'
    };

    // --> o header e a autorização necessaria pra fazer minha requisição do tipo POST.

    final bodyPost = {
      "items": [
        {
          'title': 'nameProduct',
          'description': 'description',
          'picture_url': 'img_url',
          'category_id': 'category',
          'quantity': 2,
          'currency_id': 'BRL',
          'unit_price': 40,
        }
      ],
      "payer": {"email": 'userEmail@hotmail.com'}
    };

    // --> o bodyPost é o meu corpo que contem as informações de todos os produtos que estão no "carrinho", ou posso fazer como produto individual tambem
    // --> contem quantas unidades e preço e você passa tambem o email do pagador e tem como adicionar algums parametros tambem que estão disponiveis no site do
    // --> mercado pago para postagem. link: https://www.mercadopago.com.br/developers/pt/reference/payments/_payments/post

    // --> depois de definir o mapa você tem que transformar ele em um json utilizando o jsonEncode

    final toJson = jsonEncode(bodyPost);

    // --> apos isso você faz a requisição passando a url que contem seu token de acesso, precisa passar tambem seu header que é a autorização da requisição
    // --> e tambem é necessario passar meu corpo de informações ou seja(informações de venda do produto que é o meu bodyPost) porem eu transformei ele em um json
    // --> passo meu toJson.

    final postPreference = await http.post(url, headers: header, body: toJson);

    final decode = jsonDecode(postPreference.body);

    // --> o resultado da minha funcionalidade contem todos o dados do meu usuario e me retorna tambem o id da preferencia utilizado pra gerar o meu pagamento.
    // --> eu estou retornando apenas uma String que contem o id e vou utilizar pra gerar meu pagamento
    return decode['id'];
  }
}
