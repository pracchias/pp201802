#lang racket
(require racket/tcp)
(require "conexao-lib.rkt")

;;;     Esse cliente será capaz de realizar a interação com usuário. Ele receberá mensagens do servidor e as exibirá ao usuário.
;;;     Também transmitirá mensagens ao servidor.

;;;     Caso de Uso:
;;;     1) Conectar-se. O usuário irá iniciar a aplicação, ela irá se conectar ao servidor.
;;;     2) Aguardar outros jogadores. Após conectado, a aplicação torna-se inativa, e aguarda o servidor dizer que estamos prontos para começar.mensagens
;;;         obs: idealmente deveríamos dar um feedback para o usuário de que a aplicação ainda funciona, mas isso não será implementado nesse projeto.
;;;     3) Após todos os jogadores entrados, recebemos uma mensagem da aplicação: "JOGO_COMECOU", seguida de uma mensagem "X" - onde X é o número de jogadores.
;;; e uma última mensagem constando as cartas do jogador.
;;;     4) Com a mensagem recebida, exibimos as informações relevantes para o jogador.
;;;     5) O cliente verifica se é a vez do usuário. Se não for, vá para (6)
;;;     5b) Se for a vez do usuário, o servidor questiona a ação do usuário.aguarda
;;;     5b-1) Jogador responde. Agora o turno é de outro.

;;;     6) Cliente aguarda a próxima vez do jogador.
;;;     7) Repete 4-5-6 até o fim do jogo.
;;;     8) Anuncia vencedor. Fecha o jogo.aguarda
    



;Variaveis para configuração do cliente.
; em conexao-lib

(define (inicializacao)  
    (define sockets (tenta-conectar server-name portas-jogo))
    (if (pair? sockets) (display "Sucesso na Conexão.\n") (display "Falha na Conexão.\n"))
    sockets)
    
(define (tenta-conectar server lista-de-portas)
    (cond [(null? lista-de-portas) (display "Não há vagas nesse servidor. Tente outro.\n ")]
        [else 
            (with-handlers ([exn:fail? (lambda (exn) (tenta-conectar server (cdr lista-de-portas)))]) ; se não conseguir conectar, tenta conectar na proxima porta.
                (printf "Tentando conectar na porta ~a\n" (car lista-de-portas))
                (define-values (sin sout) (tcp-connect server-name (car lista-de-portas)))
                (printf "Conectado em ~a\n" (car lista-de-portas))
                (cons sin sout))]))



;;; (display "\tvs\n")
;;; ;(display portas)
;;; ;(display (list? portas))
;;; (define par-portas (inicializacao))
;;; (displayln "Esperando resposta do servidor...")
;;; (printf "Resposta recebida ~a\n" (read (car par-portas)));
;;; (displayln "................FIM.................")
;;; ;(read)

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
