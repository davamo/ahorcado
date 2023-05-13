require './app/ahorcado.rb'
palabras_disponibles = ["programacion", "ruby", "openai", "inteligencia", "artificial", "ordenador", "tecnologia", "computadora", "algoritmo", "datos"]
juego = JuegoAhorcado.new(6, palabras_disponibles)
juego.jugar
