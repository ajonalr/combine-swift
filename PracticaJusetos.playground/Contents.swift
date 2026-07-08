import Foundation
import Combine

print("--- 1. CONFIGURANDO LOS SUJETOS ---")

// El Estado: Siempre empieza con un valor (la canción inicial)
let cancionActual = CurrentValueSubject<String, Never>("Comfortably Numb - Pink Floyd")

// El Evento: No tiene valor inicial, es solo una tubería vacía
let botonMeGustaTrigger = PassthroughSubject<Void, Never>()

private var cancellables = Set<AnyCancellable>()

// === SITUACIÓN A: LA PANTALLA PRINCIPAL YA ESTÁ ABIERTA ===
// La pantalla principal se conecta de inmediato a escuchar ambos sujetos

cancionActual
    .sink { cancion in
        print("📺 [Pantalla Principal] Canción actual en reproducción: \(cancion)")
    }
    .store(in: &cancellables)

botonMeGustaTrigger
    .sink { _ in
        print("❤️ [Pantalla Principal] ¡Animación de corazón explotando en pantalla!")
    }
    .store(in: &cancellables)


print("\n--- 2. INTERACCIÓN DEL USUARIO ---")
// El usuario interactúa con la app
botonMeGustaTrigger.send() // Le da tap al corazón
cancionActual.send("Bohemian Rhapsody - Queen") // Cambia de canción


print("\n--- 3. ENTRA UNA SEGUNDA PANTALLA TARDE ---")
// Imagina que el usuario abre un modal secundario o conecta sus audífonos bluetooth
// y este nuevo componente apenas se va a suscribir a los flujos

print("🎧 [Audífonos Bluetooth] Conectándose a los flujos...")

cancionActual
    .sink { cancion in
        print("🎧 [Audífonos Bluetooth] Sincronizando audio con: \(cancion)")
    }
    .store(in: &cancellables)
botonMeGustaTrigger.send()

botonMeGustaTrigger
    .sink { _ in
        print("🎧 [Audífonos Bluetooth] Esto NUNCA se va a imprimir aquí.")
    }
    .store(in: &cancellables)
