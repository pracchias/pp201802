#lang racket/base
(require racket/format)
 

(define-namespace-anchor a) 
(define ns (namespace-anchor->namespace a))


; ESPERA
(define (es-init-game) ((println "Iniciando jogo.") (loop "vo-")))
(define (es-minha-vez) ((println "O jogo não comecou.") (loop "es-")))
(define (es-passo) ((println "O jogo não começou.") (entrada "es-")))
(define (es-sair) (exit))


; SUA VEZ
(define (sv-init-game) ((println "Já está rodando. oláaaa") (loop "sv-")))
(define (sv-minha-vez) ((println "Vai logo!") (loop  "sv-")))
(define (sv-passo) ((println "Demorou.") (loop  "vo-" )))
(define (sv-sair) ((println "Essa partida terminou.") (loop "es-")))

; VEZ DO OUTRO
(define (vo-init-game) ((println "O jogo ja começou.") (loop "vo-")))
(define (vo-minha-vez) ((println "Mudando para sua vez.") (loop "sv-")))
(define (vo-passo) ((println "Você não pode passar pelo outro..") (loop "vo-")))
(define (vo-sair) ((println "Essa partida terminou.") (exit)))

; VEZ DO OUTRO
(define (init-game) (println "...init-game...." ))
(define (minha-vez) (println "...minha-vez...." ))
(define (passo) (println "...passo...."))
(define (sair) (exit))





; Main loop:
; verifica se há resposta do servidor
; 


(define (le-inputs pref) (read (open-input-string (string-append "(" pref (~a (read)) ")"))))

(define 
    (handle-entrada prefixo)
    (with-handlers ([exn:fail? 
            (lambda (exn) 
                ((displayln "Desculpe, comando não reconhecido.")
                (loop prefixo)))])
    (eval (le-inputs prefixo) ns)))

(define (entrada pref) (handle-entrada pref))
    
(define (loop pref) ((entrada pref) (loop pref)))

(define (main-thread) (lambda () (entrada "es-")))

(display "Bem vindo. Digite init-game, minha-vez, passo ou sair.\n")
(entrada "es-")
