class OleadaDeMinions {

	var cantMinions
	var plus
	
	method estaViva() = cantMinions > 0
	method ataque() = cantMinions + plus 
	
	method recibirAtaque(cantidad){
		cantMinions-=cantidad
	}
	

}

