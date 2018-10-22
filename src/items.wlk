class Items {

	method puntosDeVida()

	method puntosDeAtaque()

	method efectoAlEquipar(champion)

	method efectoAlDesequipar(champion)

}

class AnilloDeDoran inherits Items {

	override method puntosDeVida() = 60

	override method puntosDeAtaque() = 15

	override method efectoAlEquipar(champion) {
		champion.recibirDanio(5)
	}

	override method efectoAlDesequipar(champion) {
		champion.recibirVida(10)
	}

}

class TomoAmplificador inherits Items {

	method puntosDeVida(champion) = champion.danio() * 0.75

	method puntosDeAtaque(champion) = champion.ataque() * 0.95

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

	override method puntosDeAtaque(champion) = champion.ataque() * 2

	override method efectoAlEquipar(champion) {
		super(champion)
		champion.recibirDanio(5)
	}

	override method efectoAlDesequipar(champion) {}
	
}

