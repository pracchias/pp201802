#lang racket
(require racket/tcp)
(require "conexao-lib.rkt")

;;;     Esse cliente será capaz de realizar a interação com usuário. Ele receberá mensagens do servidor e as exibirá ao usuário.
;;;     Também transmitirá mensagens ao servidor.

;;;     Caso de Uso:
;;;     1) Conectar-se. O usuário irá iniciar a aplicação, ela irá se conectar ao servidor.
;;;[not]  2) Aguardar outros jogadores. Após conectado, a aplicação torna-se inativa, e aguarda o servidor dizer que estamos prontos para começar.mensagens
;;;         obs: idealmente deveríamos dar um feedback para o usuário de que a aplicação ainda funciona, mas isso não será implementado nesse projeto.
;;; [not] 3) Após todos os jogadores entrados, recebemos uma mensagem da aplicação: "JOGO_COMECOU", seguida de uma mensagem "X" - onde X é o número de jogadores.
;;; e uma última mensagem constando as cartas do jogador.
;;;     4) Com a mensagem recebida, exibimos as informações relevantes para o jogador.
;;;     5) O cliente verifica se é a vez do usuário. Se não for, vá para (6)
;;;     5b) Se for a vez do usuário, o servidor questiona a ação do usuário.aguarda
;;;     5b-1) Jogador responde. Agora o turno é de outro.

;;;     6) Cliente aguarda a próxima vez do jogador.
;;;     7) Repete 4-5-6 até o fim do jogo.
;;;     8) Anuncia vencedor. Fecha o jogo.aguarda

(define (conecta-ao-servidor)  
    (define sockets (tenta-conectar server-name portas-jogo))
    (if (pair? sockets) (display "Sucesso na Conexão.\n") (display "Falha na Conexão.\n") (exit 1))
    sockets)
    
(define (inicia-jogo)
  	(displayln "Tentando se conectar ao servidor.")
 	(let 	([conexao (conecta-ao-servidor)])	
		(let ([entrada (get-in conexao)]
		      [saida (get-out conexao)])
		  (displayln "Conexão efetuada com sucesso.")
		  (roda-jogo entrada saida))))
		   
; Esse método é o loop principal do jogo.
(define (roda-jogo entrada saida)
  	; Primeiro ele recebe a mensagem do servidor, que conterá: Cartas do Jogador, Cartas do Dealer e uma Flag indicando o estado do jogo.
  	(define mensagem (recebe entrada)
	 
	; Agora ele exibe as cartas do jogador e do dealer  
	(displayln "Recebendo suas cartas: ")	
  	(exibe-suas-cartas mensagem)
	(displayln "As cartas do DEALER são: ")
	(exibe-cartas-do-dealer mensagem)

	; O sistema verifica o estado do jogo e reage de acordo.
	(cond [(jogo-acabou? mensagem) (game-over mensagem)]
	      [(jogador-parou? mensagem) (espera-dealer saida)]
	      [else 	(tenta-responder saida)
	 		(displayln "----\n----")
	      		(roda-jogo entrada saida)])))

(define (game-over mensagem)
	(cond [(jogador-venceu? mensagem) (displayln "Parabens! Você venceu.")]
		[(jogador-estourou? mensagem) (displayln "ESTOURO! Você perdeu.")]
		[(dealer-venceu? mensagem) (displayln "A vitoria dessa vez foi para o DEALER.")])
	(displayln "Obrigado por ter jogado."))
		

(define (tentar-responder saida)
	(displayln "Digite 'hit' para comprar uma carta, 'stop' para parar de comprar e 'sair' para abandonar o jogo.")
	(define resposta (read))
	(cond [(respondeu-hit? resposta) (envia-hit saida)]
		[(respondeu-stop? resposta) (envia-stop saida)]
		[(respondeu-sair? resposta) (sair)]
		[else (displayln "Desculpa, comando não reconhecido.")]))
	
(define (espera-dealer entrada saida)
	(envia-stop saida)
	(roda-jogo entrada saida))
	
(define (sair) (displayln "Esperamos que tenha se divertido. Obrigado.") (exit

;; TODO	
(define (envia-hit saida))
(define (envia-stop saida))

(define (respondeu-hit? resposta))
(define (respondeu-stop? resposta))
(define (respondeu-sair? resposta))

(define (jogador-venceu? mensagem))
(define (jogador-estourou? mensagem))
(define (dealer-venceu? mensagem))


(define (teste)
    (displayln "\tTESTE\n")
    (define sockets-distribuidor (conecta-em server-name porta-distribuidor))
      (define porta-recebida (read (get-in sockets-distribuidor)))
      (write porta-recebida)
      (printf "porta é número? ~a" (number? porta-recebida))
      (define sockets-principais (tenta-conectar server-name porta-recebida))
      (displayln "Esperando resposta do servidor...")
      (printf "Resposta recebida ~a\n" (read (car sockets-principais)))
      (displayln "................FIM.................")
      (read))

(teste)
