# Interface do Jogador

Estou criando esse arquivo para falar somente da interface do jogador.


A princípio a interface será em CMD, é preciso fazer um sistema que aceite inputs do jogador e aceite ou recuse esses inputs. 

Se um input for realizado, a interface deverá chamar um método do sistema a fim de atender à requisição. 
Além disso a interface precisa mostrar informações sobre o jogo:
   	* jogador da vez
	* sua mão
	* carta no descarte


-------------------------------
Comandos -> Idéia original

* \create [nome_da_sala]: cria uma sala nova
* \join [nome_da_sala]: ingressa em uma sala existente
* \pronto
* \comprar_baralho
* \comprar_lixo
* \descartar [A]
* \bater
* \reordenar [A A A A A A A A A ]

-------------------------------
# CASOS DE USO

## Convenção de nomes nos Casos de Uso
 Essa convenção pode ser alterada para o projeto final. Só está aqui para facilitar a leitura dos casos de uso.

* Comandos na lingua inglesa, separados por hifem quando necessário.
* Naipes sempre no plural:
	* Paus
	* Copas
	* Espadas
	* Ouros
* VOCE: quando escrito com maiusculas, representa o apelido do jogador que está sendo "observado" através daquele Caso de Uso.
* Você: quando minúsculo, representa a palavra 'Você' impressa pelo terminal.
* game >: Textos impressos no terminal.
* user >: Comandos digitados pelo usuário.
* (parenteses): Quando numa impressão, significam parenteses. Quando fora, significam alguma ação que o jogador tomou que não envolve o sistema.
* game > [pp] : Quando a primeira palavra impressa pelo jogo no terminal for o nome da sala entre colchetes, significa que o texto foi impresso para todos os jogadores.

-------------------------------
## Caso de Uso - Criando servidor e iniciando um jogo

	game > Bem vindo ao nosso jogo PP4PP - Pife Pafe para Paradigmas da Programacao. Digite 'help' para obter uma lista dos comandos disponíveis. Digite list-games para obter uma lista dos jogos a iniciar, e digitae init-game <nome do jogo> para iniciar um novo jogo. Escolha um apelido com set-name <nome>.

	user > list-games

	game > Atualmente não há nenhum jogo criado.

	user > init-game

	game > Esse comando precisa de um argumento. Digite help para mais informações sobre os comandos.

	user > init-game pp

	game > Criado o jogo [pp]. Quando todos estiverem prontos, digite 'start' para começar o jogo. Digite 'list-players para obter a lista de jogadores e ver se estão prontos ou não.
	game > Você está conectado no jogo [pp]. Quando estiver pronto, digite 'ready'. Digite 'not-ready' se quiser declarar que não está pronto. Atualmente você não está pronto.

	user > list-players

	game > Listando Jogadores
	game > (Jogador sem apelido, não está pronto)
	game > Jogadores prontos: 0 de 1

	user > set-name Andre

	game > [pp] O jogador Jogador sem apelido agora chama-se Andre

	us > ready

	game > [pp] O jogador Andre está pronto. 
	game > [pp] Jogadores prontos: 1 de 1.

	us > start

	game > Jogar sozinho é um pouco chato. Espere mais alguém.

	user > (...esperando outro jogador...)

	game > [pp] O jogador B se conectou.

	user > start

	game > Existem jogadores que ainda não estão prontos. Quando todos estiverem prontos, tente novamente.

	user > (...esperando...)

	game > [pp] O jogador B está pronto.

	user > start

	game > [pp] Iniciando o jogo...

-------------------------------
### Comandos nesse caso de uso.

Comandos utilizados em qualquer lugar
* help
* set-name

Comandos utilizados fora da sala
* list-games
* init-game

Comandos utilizados dentro de uma sala
* list-players
* ready
* not-ready
* start

-------------------------------
## Caso de Uso - Sequencia no Jogo
Suponha os jogadores conectados A, B, C e VOCE. Acompanharemos a visão do cliente VOCE:

	game > Bem vindo ao jogo [pp].
	game >  A ordem dos jogadores será:
	game >  A, B, VOCE, C.
	game >  Suas cartas são:
	game >   [1] (A, Copas)    [2] (A, Espadas)  [3] (4, Ouros)
	game >   [4] (5, Ouros)    [5] (5, Copas)    [6] (7, Ouros)
	game >   [7] (J, Espadas)  [8] (J, Espadas)  [9] (K, Paus)

	game >  [pp] O jogo começa com o jogador A.

	game >  [pp] O jogador A comprou do monte.

	game >  [pp] A está escolhendo a carta para descartar.
	
	game >  [pp] A descartou (7, Copas)

	game >  [pp] Agora é a vez do jogador B.

	game >  [pp] B está decidindo se compra do monte ou do lixo.

	game >  [pp] B comprou do monte.

	game >  [pp] B está escolhendo a carta para descartar.

	game >  [pp] B descartou (Q, Espadas).

	game >  [pp] Agora é a vez de VOCE.
	
	game >  [pp] VOCE está decidindo se compra do monte ou do lixo.

	game >  Sua vez.
	game >  Suas cartas são:
	game >   [1] (A, Copas)    [2] (A, Espadas)  [3] (4, Ouros)
	game >   [4] (5, Ouros)    [5] (5, Copas)    [6] (7, Ouros)
	game >   [7] (J, Espadas)  [8] (J, Espadas)  [9] (K, Paus)
	game >  A carta no lixo é (Q, Espadas).
	game >  Você deseja comprar do monte ou do lixo? (digite 'monte'/'lixo' para escolher).

	user > lixo

	game >  [pp] VOCE comprou do lixo: (Q, Espadas).
	
	game >  [pp] VOCE está escolhendo a carta para descartar.

	game > Você comprou: (Q, Espadas).

	game >  Escolha a carta de descarte. Digite o número da carta, ou os dados da carta (<valor> <naipe>)
	game >  Suas cartas são:
	game >   [0] (Q, Espadas)
	game >   [1] (A, Copas)    [2] (A, Espadas)  [3] (4, Ouros)
	game >   [4] (5, Ouros)    [5] (5, Copas)    [6] (7, Ouros)
	game >   [7] (J, Espadas)  [8] (J, Espadas)  [9] (K, Paus)

	user > 8   ;(ou então user > J Espadas)


	game >  [pp] VOCE descartou (J, Espadas).

	game >  [pp] Agora é a vez de C.

	(segue repetindo até que um jogador possa bater)
-------------------------------
### Comandos nesse caso de uso.

Comandos utilizados dentro do jogo
* <numero>: indica a carta que será descartada pelo jogador.
* <valor> <numero>: indica a carta que será descartada pelo jogador.
* lixo: indica que o jogador comprará a carta do lixo
* monte: indica que o jogador comprará a carta do lixo

-------------------------------
## Caso de Uso - Bater Convencionalmente

O jogador VOCE pode bater após comprar uma carta:

	game >  [pp] VOCE está decidindo se compra do monte ou do lixo.

	game >  Sua vez.
	game >  Suas cartas são:
	game >  [1] (A, Copas)    [2] (A, Espadas)  [3] (A, Ouros)
	game >  [4] (5, Ouros)    [5] (6, Ouros)    [6] (7, Ouros)
	game >  [7] (J, Espadas)  [8] (Q, Espadas)  [9] (K, Paus)
	game >  A carta no lixo é (4, Ouros).

	game >  Você deseja comprar do monte ou do lixo? (digite 'monte'/'lixo' para escolher).

	game > monte

	game >  [pp] VOCE comprou do monte.
	game >  [pp] VOCE está escolhendo a carta para descartar.

	game > Você comprou: (K, Espadas).

	game >  Você pode bater. Digite 'bater' para bater. Ou descarte uma carta para continuar o jogo.

	game >  Escolha a carta de descarte. Digite o número da carta, ou os dados da carta (<valor> <naipe>)
	game >  Suas cartas são:
	game >   [0] (K, Espadas)
	game >   [1] (A, Copas)    [2] (A, Espadas)  [3] (A, Ouros)
	game >   [4] (5, Ouros)    [5] (6, Ouros)    [6] (7, Ouros)
	game >   [7] (J, Espadas)  [8] (Q, Espadas)  [9] (K, Paus)

	user > bater

	game >  [pp] O jogador VOCE bateu. As cartas de VOCE são:
	game >  [pp] [0] (K, Espadas)
	game >  [pp] [1] (A, Copas)    [2] (A, Espadas)  [3] (A, Ouros)
	game >  [pp] [4] (5, Ouros)    [5] (6, Ouros)    [6] (7, Ouros)
	game >  [pp] [7] (J, Espadas)  [8] (Q, Espadas)  [9] (K, Paus)

	game >  Digite qualquer coisa para ser redirecionado à tela inicial.

-------------------------------
### Comandos novos nesse caso de uso.

* bater: se o jogador estiver apto a bater, ele vence o jogo.

-------------------------------