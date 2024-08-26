;Diretivas
#Requires AutoHotkey v2.0
#SingleInstance Force ;Impede múltipla instância

;Inclusão de API's
#Include API\AI.ahk
#Include API\app.ahk
#Include API\avatar.ahk 
#Include API\graphics.ahk
#Include API\input.ahk
#Include API\queue.ahk

;Inclusão de LIB's
#Include lib\abstractions.ahk
#Include lib\creatures.ahk 
#Include lib\game.ahk
#Include lib\objects.ahk
#Include lib\scenery.ahk
#Include lib\statemachine.ahk

;Declarações
ListLines()
Application := App("Plataforma")

;Inicio
Application.Start()

/*
# Criar Animação e encaixar a mudança no Renderizar

# Criar entidade do bloco para conter os avatares senao vai ficar dando erro

# AVISOS
    ## NEM VI ISSO AINDA
        Quando criar um objeto dentro do game ele avisa/reporta sua existência para aa API gráfica e ela passa a observá-lo. Assim mantenho as coisas conectadas mas ao mesmo isoladas.
        Consertar fila e pilha.
    ## VER COMO CONSERTA ACENTUAÇÃO
        Ele está diferenciando acentuadas e sem acento e é pra ignorar acentuação.
        
*/