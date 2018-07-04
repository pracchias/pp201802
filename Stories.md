Estruturas de dados
	* Carta
	* Baralho
	* Mão

Exemplos de Funções
	(bateu? mao)
	(eh-trio? cartaA cartaB cartaC) ou (eh-trio? listaDeTresCartas)
	(naipe carta) ; retorna o naipe da carta
	(valor carta) ; retorna o valor da carta
	(make-card valor naipe) ; cria uma carta
	(make-hand cartas)
	(make-baralho numBaralhos)

Outras ideias que temos que tratar:
	distribuicao de cartas
	controle de rodada
	interfaces entre sistemas
	funções de interação com o usuario
	servidor aguarde conexões.
	função que retorne X baralhos
	funções que manipulem a mão do jogador.
	funções que verifiquem trincas.
	abstrações para as listas que representam as cartas

Divisão atual:
	Comunicação Cliente - Servidor: Vitor
	Baralho: Lucas
	Validação: Iasmin
	Interface Usuário: André
	
