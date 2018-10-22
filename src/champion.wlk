class Champion {

	var property vida
	var property ataque
	var property danio
	var property estaVivo = true
	var bloqueos
	var items

	method bloqueos() = bloqueos

	method bloqueos(cantidad) {
		bloqueos += cantidad
	}

	method atacar(alguien) {
		alguien.recibirAtaque(ataque)
	}

	method recibirAtaque(alguien) {
		if (bloqueos < 1) {
			self.recibirDanio(alguien.ataque())
			if (estaVivo) {
				estaVivo = false
			}
		} else {
			bloqueos -= 1
		}
	}

	method equiparItem(item) {
		items.add(item)
		item.efectoAlEquipar(self)
	}

	method desequiparItem(item) {
		items.remove(item)
		item.efectoAlDesequipar(self)
	}

	method recibirDanio(cantidad) {
		danio += cantidad
	}

	method recibirVida(cantidad) {
		vida += cantidad
	}

}