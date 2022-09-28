// --- Devuelve el nombre del cuerpo
String conseguirNombre(FBody cuerpo) {

  String nombre = "nada";
  if (cuerpo != null) {
    nombre = cuerpo.getName();
    if (nombre == null) {
      nombre = "nada";
    }
  }
  return nombre;
}

// --- Evalúa si hay colision entre dos objetos
boolean hayColisionEntre(FContact contact, String nombreUno, String nombreDos) {
  boolean resultado = false;
  FBody uno = contact.getBody1();
  FBody dos = contact.getBody2();
  String etiquetaUno = uno.getName();
  String etiquetaDos = dos.getName();

  if (etiquetaUno != null && etiquetaDos != null) {
    if (nombreUno.equals( etiquetaUno ) && nombreDos.equals( etiquetaDos ) || (nombreUno.equals( etiquetaDos ) && nombreDos.equals( etiquetaUno ))) {
      resultado = true;
    }
  }
  return resultado;
}

// ---
void contactStarted(FContact contact) {
  FBody uno = contact.getBody1();
  FBody dos = contact.getBody2();
  String nombreUno = conseguirNombre(uno);
  String nombreDos = conseguirNombre(dos);

  if (estado.equals("inicio")) {
    if (hayColisionEntre(contact, "c_inicio", "b_inicio")) {
      estado = "instrucciones";
      r.setTimer(11);
    }
  }
  if (estado.equals("jugando")) {
    // --- Movimiento de los péndulos
    if ((hayColisionEntre(contact, "caramelo_rosa", "chupetin0")) || (hayColisionEntre(contact, "caramelo_violeta", "chupetin0"))
      || (hayColisionEntre(contact, "caramelo_amarillo", "chupetin0")) || (hayColisionEntre(contact, "caramelo_celeste", "chupetin0"))) {
      m_0 = true;
      s.playReboteChupetin();
    }
    if ((hayColisionEntre(contact, "caramelo_rosa", "chupetin1")) || (hayColisionEntre(contact, "caramelo_violeta", "chupetin1"))
      || (hayColisionEntre(contact, "caramelo_amarillo", "chupetin1")) || (hayColisionEntre(contact, "caramelo_celeste", "chupetin1"))) {
      m_1 = true;
      s.playReboteChupetin();
    }
    if ((hayColisionEntre(contact, "caramelo_rosa", "chupetin2")) || (hayColisionEntre(contact, "caramelo_violeta", "chupetin2"))
      || (hayColisionEntre(contact, "caramelo_amarillo", "chupetin2")) || (hayColisionEntre(contact, "caramelo_celeste", "chupetin2"))) {
      m_2 = true;
      s.playReboteChupetin();
    }

    // --- Colisión de caramelos con la bolsa
    if ((uno == bolsa && dos != piso) || (dos == bolsa && uno != piso)) {
      FBody ball = null;
      if (uno == bolsa && nombreDos != "movible") {
        ball = dos;
      } else if (dos == bolsa && nombreUno != "movible") {
        ball = uno;
      }
      if (ball == null) {
        return;
      }
      mundo.remove(ball);

      // Puntaje
      if (ball.getName() == "caramelo_rosa") {
        puntos += 10;
        contador_rosas += 1;
        s.playPuntos();
      } else if (ball.getName() == "caramelo_violeta") {
        puntos += 15;
        contador_violetas += 1;
        s.playPuntos();
      } else if (ball.getName() == "caramelo_amarillo") {
        puntos += 25;
        contador_amarillos += 1;
        s.playPuntos();
      } else if (ball.getName() == "caramelo_celeste") {
        puntos +=40;
        contador_celestes += 1;
        s.playPuntos();
      }
    }
    // --- Colisión de caramelos con el piso
    if ((uno == piso && dos != bolsa) || (dos == piso && uno != bolsa)) {
      FBody ball = null;
      if (uno == piso && nombreDos != "movible" && dos != bolsa) {
        ball = dos;
        vidas--;
      } else if (dos == piso && nombreUno != "movible" && uno != bolsa) {
        ball = uno;
        vidas--;
      }
      if (ball == null) {
        return;
      }
      mundo.remove(ball);
      if (ball.getName() == "caramelo_rosa") {
        s.playMancha();
        manchas.add(img_manchas[0]);
      } else if (ball.getName() == "caramelo_violeta") {
        s.playMancha();
        manchas.add(img_manchas[1]);
      } else if (ball.getName() == "caramelo_amarillo") {
        s.playMancha();
        manchas.add(img_manchas[2]);
      } else if (ball.getName() == "caramelo_celeste") {
        s.playMancha();
        manchas.add(img_manchas[3]);
      }

      if (vidas < 1) {
        estado = "fin";
        s.playFin();
        rfin.setTimer(3);
      }
    }
  }
}

void agregarCaramelos(float valor, float x, float y, float fuerza) {
  for (int i = 0; i < valor; i++) {
    Caramelo c = new Caramelo(40);
    c.iniciarCaramelo(x, y);
    cs.add(c);
    c.addForce(fuerza, 20);
  }
}

void borrarCaramelos() {
  for (int i = 0; i < cs.size(); i++) {
    cs.get(i).resetearCaramelos();
  }
}

void dibujarManchas(int valor, float posx, float posy) {

  if (manchas.size() > valor) {

    image(manchas.get(valor), posx, posy);
  }
}
