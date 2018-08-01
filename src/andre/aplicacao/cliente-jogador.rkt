#lang racket
(require racket/tcp)




#|
    Esse cliente será capaz de realizar a interação com usuário. Ele receberá mensagens do servidor e as exibirá ao usuário.
    Também transmitirá mensagens ao servidor.

    Caso de Uso:
    1) Conectar-se. O usuário irá iniciar a aplicação, ela irá se conectar ao servidor.
    2) Aguardar outros jogadores. Após conectado, a aplicação torna-se inativa, e aguarda o servidor dizer que estamos prontos para começar.mensagens
        obs: idealmente deveríamos dar um feedback para o usuário de que a aplicação ainda funciona, mas isso não será implementado nesse projeto.
    3) Após todos os jogadores entrados, recebemos uma mensagem da aplicação: "JOGO_COMECOU", seguida de uma mensagem "X" - onde X é o número de jogadores.
e uma última mensagem constando as cartas do jogador.
    4) Com a mensagem recebida, exibimos as informações relevantes para o jogador.
    5) O cliente verifica se é a vez do usuário. Se não for, vá para (6)
    5b) Se for a vez do usuário, o servidor questiona a ação do usuário.aguarda
    5b-1) Jogador responde. Agora o turno é de outro.

    6) Cliente aguarda a próxima vez do jogador.
    7) Repete 4-5-6 até o fim do jogo.
    8) Anuncia vencedor. Fecha o jogo.aguarda
    #|



