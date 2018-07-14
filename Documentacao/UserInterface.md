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

\create [nome_da_sala]: cria uma sala nova
\join [nome_da_sala]: ingressa em uma sala existente
\pronto
\comprar_baralho
\comprar_lixo
\descartar [A]
\bater
\reordenar [A A A A A A A A A ]


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
