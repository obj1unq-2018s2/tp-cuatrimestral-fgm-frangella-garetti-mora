class Items {
	
	method costo()

	method efectoAlActivar(champion)

	method puntosDeVida(champion)

	method puntosDeAtaque(champion)

	method efectoAlEquipar(champion)

	method efectoAlDesequipar(champion)

}

class AnilloDeDoran inherits Items {
	
	override method costo() = 300

	override method efectoAlActivar(champion){}

	override method puntosDeVida(champion) = 60

	override method puntosDeAtaque(champion) = 15

	override method efectoAlEquipar(champion) {
		champion.recibirDanio(5)
	}

	override method efectoAlDesequipar(champion) {
		champion.quitarDanio(10)
	}

}

class TomoAmplificador inherits Items {
	
	override method costo() = 500
	
	override method efectoAlActivar(champion) {
		var usos = 1
		if (usos > 0 and champion.dinero() < 500 and champion.tieneItem(self)){
			champion.dinero(500)
			usos -= 1
		}
	}
	override method puntosDeVida(champion) = champion.danio() * 0.25 // Correccion etapa 1

	override method puntosDeAtaque(champion) = champion.danio() * 0.05 // Correccion etapa 1

	override method efectoAlEquipar(champion) {
		champion.sumarBloqueos(2)
	}

	override method efectoAlDesequipar(champion) {
		champion.sumarBloqueos(1)
		champion.recibirDanio(30)
	}

}

class SombreroDeRabadon inherits TomoAmplificador {
	
	override method costo() = super() + 100

	override method puntosDeVida(champion) = super(champion) + 5

	override method puntosDeAtaque(champion) = champion.ataqueBase() * 2

	override method efectoAlEquipar(champion) {
		super(champion)
		champion.recibirDanio(5)
	}

	override method efectoAlDesequipar(champion) {}
}

class PocionDeVida inherits Items {
	
	override method costo() = 50
	
	override method efectoAlActivar(champion){
		var usos = 2
		if(usos > 0 and champion.tieneItem(self)){
			champion.quitarDanio(50)
			usos -= 1
		}
	}

	override method puntosDeVida(champion){}

	override method puntosDeAtaque(champion){}

	override method efectoAlEquipar(champion){}

	override method efectoAlDesequipar(champion){}

}
class BastonDelVacio inherits Items {
	var property items = []
	
	method agregarItem(item){
		items.add(item)
	}
	
	method quitarItem(item){
		items.remove(item)
	}
	
	override method costo() = 0
	
	override method efectoAlActivar(champion) = 
		items.forEach{ item => item.efectoAlActivar(champion) }
	
	override method puntosDeVida(champion) = 
		items.sum{ item => item.puntosDeVida(champion) / 2 }
	
	override method puntosDeAtaque(champion) = 
		items.sum{ item => item.puntosDeAtaque(champion) }

	override method efectoAlEquipar(champion) {}
	
	override method efectoAlDesequipar(champion){}
}