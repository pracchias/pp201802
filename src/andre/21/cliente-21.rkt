#lang racket
(require racket/tcp)
(require "conexao-lib.rkt")
(require "blackjack-msgs.rkt")
(require "blackjack-rules.rkt")
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
(displayln "\tVersao 0.3\n")

(define (conecta-ao-servidor)  
    (define sockets (tenta-conectar server-name porta-jogo))
    (if (pair? sockets) (display "Sucesso na Conexao. ") ((display "Falha na Conexão.\n") (exit 1)))
    sockets)
    
(define (inicia-jogo)
  	(displayln "Tentando se conectar ao servidor.")
 	(let 	([conexao (conecta-ao-servidor)])	
		(let ([entrada (get-in conexao)]
		      [saida (get-out conexao)])
		  (displayln "Portas obtidas com sucesso.\n\n")
		  (displayln "Iniciando jogo.")
		  (roda-jogo entrada saida))))
		   
; Esse método é o loop principal do jogo.
(define (roda-jogo entrada saida)
  	; Primeiro ele recebe a mensagem do servidor, que conterá: Cartas do Jogador, Cartas do Dealer e uma Flag indicando o estado do jogo.
  	(define mensagem (read entrada))

	; Agora ele exibe as cartas do jogador e do dealer  
	(display "\n\tSuas cartas:\n\t")	
  	(exibe-suas-cartas mensagem)
	(display "\n\tCartas do DEALER:\n\t")
	(exibe-cartas-do-dealer mensagem)

	; O sistema verifica o estado do jogo e reage de acordo.
	(cond [(jogo-acabou? mensagem) (game-over mensagem) (envia-sair saida)]
	      [(jogador-parou? mensagem) (espera-dealer entrada saida)]
	      [else 	(tentar-responder saida)
	 		(displayln "---- ---- ---- \n")
	      		(roda-jogo entrada saida)]))

;; FIM RODA-JOGO


(define (game-over mensagem)
	(displayln "\n\n\tFIM DE JOGO\n")
	(cond [(jogador-venceu? mensagem) (displayln "Parabens! Voce venceu.")]
		[(jogador-estourou? mensagem) (displayln "ESTOURO! Voce perdeu.")]
		[(dealer-venceu? mensagem) (displayln "A vitoria dessa vez foi para o DEALER.")])
	(displayln "Obrigado por ter jogado."))
		

(define (tentar-responder saida)
	;(envia-mensagem "Resposta automatica." saida)
	(displayln "\nDigite 'hit' para comprar uma carta, 'stop' para parar de comprar e 'sair' para abandonar o jogo.")
	(define resposta (read))
	(displayln "Resposta:")
	(write resposta)
	(displayln "")
	(cond [(respondeu-hit? resposta) (envia-hit saida)]
		[(respondeu-stop? resposta) (envia-stop saida)]
		[(respondeu-sair? resposta) (envia-sair saida)]
		[else (displayln "Desculpa, comando não reconhecido.") (tentar-responder saida)]))
	

(define (espera-dealer entrada saida)
	(displayln "")
	(display "\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r")
	(display "Esperando dealer...")
	(sleep 0.8)
	(display "\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r")
	(display "                              ")
	(sleep 0.5)
	(display "\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r")
	(display "Esperando dealer...")
	(sleep 0.8)
	(display "\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r\r                                   ")
	(envia-stop saida)
	(roda-jogo entrada saida))

	
(define (sair) (displayln "Esperamos que tenha se divertido. Obrigado.") (exit))

;; TODO	
(define (envia-hit saida)
    (envia-mensagem "hit" saida))

(define (envia-stop saida)
	(envia-mensagem "stop" saida))

(define (envia-sair saida)
	(envia-mensagem "sair" saida)
	(sair))

(define (exibe-suas-cartas mensagem)
	(define suas-cartas (get-cartas-jogador mensagem))
	(printf "Valor da mao: ~a. Cartas: ~a\n" (valor-da-mao suas-cartas) suas-cartas))
	
(define (exibe-cartas-do-dealer mensagem)
	(define cartas-dealer (get-cartas-dealer mensagem))
	(printf "Valor da mao: ~a. Cartas: ~a\n" (valor-da-mao cartas-dealer) cartas-dealer))
	


#|(define (teste)
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
|#

(displayln "Iniciando o jogo")
(inicia-jogo)
(displayln "Finalizando o jogo")
