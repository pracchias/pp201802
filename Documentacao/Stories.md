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



---------------
Interface Usuário
A principio o usuário poderá usar qualquer um desses comandos.

\create [nome_da_sala]: cria uma sala nova
\join [nome_da_sala]: ingressa em uma sala existente
\pronto
\comprar_baralho
\comprar_lixo
\descartar [A]
\bater
\reordenar [A A A A A A A A A ]

A princípio a interface será em CMD, é preciso fazer um sistema que aceite inputs do jogador e aceite ou recuse esses inputs. Se um input for realizado, a interface deverá chamar um método do sistema a fim de atender à requisição. Além disso a interface precisa mostrar informações sobre o jogo(jogador da vez, sua mão, dentre outros)
 

