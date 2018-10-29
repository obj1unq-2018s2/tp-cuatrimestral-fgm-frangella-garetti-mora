class OleadaDeMinions {

	var property cantMinions
	var plus
	var property dineroQueEntrega = cantMinions
	
	method estaViva() = cantMinions > 0

	method ataque() = cantMinions + plus

	method recibirAtaque(cantidad) {
		if (cantidad > cantMinions) {
			dineroQueEntrega = cantMinions
			cantMinions = 0
		} else {
			cantMinions -= cantidad
			dineroQueEntrega = cantidad
		}
	}

}

