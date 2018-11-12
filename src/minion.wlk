class OleadaDeMinions {

	var property cantMinions
	var property dineroQueEntrega = cantMinions
	var plus

	method estaViva() = cantMinions > 0

	method ataque() = if (self.estaViva()) cantMinions + plus else 0

	method recibirAtaque(cantidad) {
		if (self.muereLaOleada(cantidad)) {
			dineroQueEntrega = cantMinions
			cantMinions = 0
		} else {
			cantMinions -= cantidad
			dineroQueEntrega = cantidad
		}
	}

	method muereLaOleada(cantidad) = cantidad > cantMinions
}

