class Items {

	method puntosDeVida(champion)

	method puntosDeAtaque(champion)

	method efectoAlEquipar(champion)

	method efectoAlDesequipar(champion)

}

class AnilloDeDoran inherits Items {

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
	
	
	
	override method puntosDeVida(champion) = champion.danio() * 0.25

	override method puntosDeAtaque(champion) = champion.danio() * 0.05

	override method efectoAlEquipar(champion) {
		champion.bloqueos(2)
	}

	override method efectoAlDesequipar(champion) {
		champion.bloqueos(1)
		champion.recibirDanio(30)
	}

}

class SombreroDeRabadon inherits TomoAmplificador {

	override method puntosDeVida(champion) = super(champion) + 5

	override method puntosDeAtaque(champion) = champion.ataqueBase() * 2

	override method efectoAlEquipar(champion) {
		super(champion)
		champion.recibirDanio(5)
	}

	override method efectoAlDesequipar(champion) {}
	
}

