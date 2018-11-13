class Champion {

	const property vidaBase // Correccion etapa 1
	const property ataqueBase // Correccion etapa 1
	var property danio = 0
	var bloqueos = 0
	var items = []
	var property dinero

	method estaVivo() = danio <= self.vida()

	method items() = items

	method tieneItem(item) = items.contains(item)

	method vida() = vidaBase + self.items().sum{ item => item.puntosDeVida(self) }

	method ataque() = ataqueBase + self.items().sum{ item => item.puntosDeAtaque(self) }

	method bloqueos() = bloqueos

	method sumarBloqueos(cantidad) {
		bloqueos += cantidad
	}

	method atacar(alguien) {
		var ataqueEnemigo = alguien.ataque() // variables locales para que el danio no se modifique por quien pega primero
		var ataquePropio = self.ataque() // recordamos el valor de ataque de ambos antes de recibir danio y se modifique
		self.recibirAtaque(ataqueEnemigo)
		alguien.recibirAtaque(ataquePropio)
		self.ganarDinero(alguien.dineroQueEntrega())
	}

	method recibirAtaque(cantidad) {
		self.recibirDanioOBloquear(cantidad)
	}

	method recibirDanioOBloquear(cantidad) {
		if (!self.puedeBloquear(cantidad)) {
			self.recibirDanio(cantidad)
		} else {
			bloqueos -= 1
		}
	}

	// chequeamos que la cantidad sea mayor a 0 para no gastar un bloqueo por un ataque de 0 danio
	method puedeBloquear(cantidad) = bloqueos >= 1 && cantidad > 0 
	
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

	method quitarDanio(cantidad) { // Correccion etapa 1
		if (cantidad > danio) {
			danio = 0
		} else {
			danio -= cantidad
		}
	}

	method comprar(item) {
		if (self.tieneDineroSuficientePara(item)) {
			self.equiparItem(item)
			self.quitarDinero(item.costo())
		}
	}

	method tieneDineroSuficientePara(item) = dinero >= item.costo()

	method vender(item) {
		self.desequiparItem(item)
		self.ganarDinero(self.valorDeVenta(item))
	}

	method ganarDinero(cantidad) {
		dinero += cantidad
	}

	method quitarDinero(cantidad) {
		dinero -= cantidad
	}

	method valorDeVenta(item) = item.costo() / 2

}

class Support inherits Champion {

	var vinculo // campeon

	override method atacar(alguien) {
		super(alguien)
		vinculo.quitarDanio(10)
	}

	method itemsVinculo() = vinculo.items()

	method vincular(campeon) {
		// la idea era chequear si lo que estoy tratando de vincular es un champion, sino que tire error
		// if (campeon.kindName().equals("a Champion")){ 
		vinculo = campeon
	// } else {
	// self.error("Solo se pueden vincular campeones")
	// } Dejo todo esto comentado hasta saber si esta bien o es hacer de mas al pedo
	}

	override method items() = super() + vinculo.items()

}

