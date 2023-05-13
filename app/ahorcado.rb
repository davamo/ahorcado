require 'set'

class Palabra
    attr_reader :letras
    
    def initialize(palabra)
      @letras = palabra.chars
    end
    
    def completada_por?(letras_adivinadas)
      letras.to_set.subset?(letras_adivinadas.to_set)
    end
    
    def mostrar_como_adivinanza(letras_adivinadas)
      letras.map { |letra| letras_adivinadas.include?(letra) ? letra : "_" }.join(" ")
    end
    
    def contiene_letra?(letra)
      letras.include?(letra)
    end
  end
  
  class Jugador
    attr_reader :intentos_disponibles, :letras_adivinadas, :letras_incorrectas
    
    def initialize(intentos_disponibles)
      @intentos_disponibles = intentos_disponibles
      @letras_adivinadas = Set.new
      @letras_incorrectas = Set.new
    end
    
    def intentar_letra(letra, palabra)
      if letras_adivinadas.include?(letra) || letras_incorrectas.include?(letra)
        puts "Ya intentaste esa letra antes. Intenta con otra."
      elsif palabra.contiene_letra?(letra)
        letras_adivinadas << letra
        puts "¡Correcto! La palabra sí contiene la letra #{letra}."
        if palabra.completada_por?(letras_adivinadas)
          puts "¡Felicitaciones! ¡Ganaste!"
          exit
        end
      else
        letras_incorrectas << letra
        @intentos_disponibles -= 1
        puts "Incorrecto. La palabra no contiene la letra #{letra}. Te quedan #{intentos_disponibles} intentos."
      end
    end
  end
  
  class JuegoAhorcado
    def initialize(intentos_disponibles, palabras_disponibles)
      @intentos_disponibles = intentos_disponibles
      @palabra = Palabra.new(palabras_disponibles.sample)
      @jugador = Jugador.new(intentos_disponibles)
    end
    
    def jugar
      puts "La palabra que debes adivinar tiene #{palabra.letras.size} letras."
      
      while jugador.intentos_disponibles > 0
        puts "Letras adivinadas: #{palabra.mostrar_como_adivinanza(jugador.letras_adivinadas)}"
        puts "Ingresa una letra:"
        letra = gets.chomp.downcase
        jugador.intentar_letra(letra, palabra)
      end
      
      puts "Lo siento, te quedaste sin intentos. La palabra era '#{palabra.letras.join("")}'."
    end
    
    private
    
    attr_reader :intentos_disponibles, :palabra, :jugador
  end
  
  