# methods_payment

A new Flutter project.

## Getting Started


A implementação do mercado pago em sua aplicação.



// --> primeiro passo instalar nas dependencias ( pubspec.yaml ) mercado_pago_mobile_checkout e http <-->

// --> segundo passo acessar o mercado pago e gerar uma credencial para o (usuario vendedor) , atraves do link --> https://www.mercadopago.com.br/settings/account/credentials --> pegar a publicKey e utilizar o acess token para postagems de produto que deseja vender.

// --> defini uma variavel para salvar a publicKey do mercadoPago

// --> criar uma funcionalidade para gerar as preferencias da venda, ou seja as informacoes de produtos vendido e valor que vai fazer uma requisição http do tipo POST para persistir os dados do usuario e gerar uma preferencia de venda.

// --> pegar o retorno da minha funcionalidade que me retorna todas informações do usuario e da venda e gera automaticamente uma chave de preferencia 
// na minha funcionalidade retorno simplesmente o id da minha preferencia, armazeno ele em uma variavel na minha view e utilizo para iniciar meu checkout.

// --> ai inicializo meu checkout PaymentResult result = await MercadoPagoMobileCheckout.startCheckout
(publicKey --> chave do usuario mercadoPago,await preferenceKey --> as informações da venda que eu mesmo defino o valor e quantidade, passado para um mapa e convertido
para um JSON posteriormente,);

// --> ao fazer isso, vai aparecer as informações de pagamento com cartão de credito ou debito, ou como pagar em uma loterica (BOLETO), inserindo os dados se der certo, 
automaticamente consigo verificar o resultado atraves da minha variavel (result) => que você vai utilizar pra fazer toda a regra de negocio de sua aplicação desejada.





