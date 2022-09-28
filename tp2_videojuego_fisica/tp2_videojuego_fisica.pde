/*
TRABAJO PRÁCTICO 02
COMISIÓN LISANDRO & ABRIL

ALUMNAS:
- Agustina Gil Tudor
- Lucía Soledad Vega
- Lara Belén Ignoffo
*/

import ddf.minim.*;
import fisica.*;

Minim minim;
FWorld inicio, mundo;

Sonido s;
Plataforma bolsa, bolsai, b_inicio, piso, borde_i, borde_d;
Pendulo [] p;

Caramelo c_inicio;
Borde bi, bd;

ArrayList <Caramelo> cs;
ArrayList <Plataforma> bloquesFijos, bloquesMovibles, bloquesDirIzq, bloquesDirDer;

PImage [] golosina;
PImage [] caramelera;
PImage [] fondo;
PImage [] img_manchas;
PImage bolsaroja, fondo_final, mancha, reglas, bolsa_puntos, img_vidas;

ArrayList <PImage> manchas;

int contador, cincuentaPX;
int puntos, vidas;
int contador_rosas, contador_violetas, contador_amarillos, contador_celestes;

String estado;
boolean m_0, m_1, m_2;

int currentFrame_cm, loopFrame_cm, delay_cm, valor_cm, contador_cm;
int valorIncremento, contador_caramelos, valorIncremento_caramelos;

int currentFrame_fondo, loopFrame_fondo, delay_fondo, valor_fondo;

float x0, x1, x2, x3, y0, y1, y2, y3;

boolean derecha_cm, centro_cm, izquierda_cm, ciclo;

Reloj r, rfin;
PFont font;
void setup() {
  size(1280, 960);
  Fisica.init(this);
  minim = new Minim(this);

  inicio = new FWorld();
  inicio.setEdges();
  mundo = new FWorld();
  mundo.setEdges();

  // --- variables numéricas
  iniciarVariablesNumericas();

  // --- booleanas
  iniciarBooleanas();

  estado = "inicio";

  // --- ArrayLists
  cs = new ArrayList<Caramelo>();
  bloquesFijos = new ArrayList<Plataforma>();
  bloquesMovibles = new ArrayList<Plataforma>();
  bloquesDirIzq = new ArrayList<Plataforma>();
  bloquesDirDer = new ArrayList<Plataforma>();
  manchas = new ArrayList<PImage>();
  // --- carga imágenes
  cargaDeImagenes();

  // --- métodos
  iniciarBloquesFijos();
  iniciarBloquesMovibles();
  iniciarBloquesDeDireccion();

  // --- objetos
  iniciarObjetos();

  s = new Sonido();
  s.playMusicaFondo();

  r = new Reloj();
  rfin = new Reloj();
}

void draw() {
  background(#D5ECF2);
  r.actualizar();

  if (estado.equals("inicio")) {
    image(fondo[0], 0, 0);
    inicio.step();
    inicio.draw();
    bi.dibujarBorde();
    bd.dibujarBorde();
    resetearValores_inicio();
  }
  if (estado.equals("instrucciones")) {
    //currentFrame_fondo = 10;
    r.actualizar();
    r.setTimer(10);
    image(fondo[currentFrame_fondo], 0, 0);
    if (delay_fondo == 0) {
      currentFrame_fondo = (currentFrame_fondo + valor_fondo) % loopFrame_fondo;
    }
    delay_fondo = (delay_fondo + 1)%5;
    if (currentFrame_fondo == 32) {
      valor_fondo = 0;
      image(reglas, 0, 0);
    }

    bi.dibujarBorde();
    bd.dibujarBorde();

    if (r.timer != 0) {
      if (r.timer < 1) {
        estado = "jugando";
        r.resetear();
      }
    }
  }
  if (estado.equals("jugando")) {
    image(fondo[30], 0, 0);
    image(bolsa_puntos, 70, 30);
    image(img_vidas, width-130, 45);
    mundo.step();
    mundo.draw();
    dibujarManchas(0, x0, y0);
    dibujarManchas(1, x1, y1);
    dibujarManchas(2, x2, y2);
    dibujarManchas(3, x3, y3);
    image(caramelera[currentFrame_cm], width/2-180, 0);
    pushStyle();
    textFont(font);
    fill(0);
    textSize(40);
    text(puntos, 160, 80);
    text(vidas, width-165, 80);
    popStyle();
    contador_cm += valorIncremento;
    if (contador_cm > 100) {
      bolsa.moverBolsa();
    }
    if (contador_cm == 200) {

      ciclo = true;
    }
    if (ciclo) {
      int sonido_l = 2;
      int caramelos_l = 45;
      int cantCaramelos;
      if (delay_cm == 0) {
        currentFrame_cm = (currentFrame_cm + valor_cm) % loopFrame_cm;
        if (currentFrame_cm == 8) {
          derecha_cm = true;
        }
      }

      // --- Propiedades caramelera "derecha"
      if (derecha_cm) {
        cantCaramelos = floor(random(1, 4));
        centro_cm = false;
        izquierda_cm = false;
        valorIncremento_caramelos = 1;
        contador_caramelos+= valorIncremento_caramelos;
        if (currentFrame_cm == 20) {
          valor_cm = 0;
        }
        if (contador_caramelos == sonido_l) {
          s.playCaramelera();
        }
        if (contador_caramelos == caramelos_l) {
          agregarCaramelos(cantCaramelos, width/2+cincuentaPX*2, 160, 10000);
          if (cantCaramelos > 2) {
            r.setTimer(20);
          } else {
            r.setTimer(12);
          }
        }
        if (r.timer != 0) {
          if (r.terminoTiempo()) {
            valor_cm = 1;
          }
        }
        if (currentFrame_cm == 28) {
          centro_cm = true;
          contador_caramelos = 0;
          valorIncremento_caramelos = 0;
          r.resetear();
        }
      }
      // --- Propiedades caramelera "centro"
      if (centro_cm) {
        cantCaramelos = floor(random(1, 4));
        derecha_cm = false;
        izquierda_cm = false;
        valorIncremento_caramelos = 1;
        contador_caramelos+= valorIncremento_caramelos;
        if (currentFrame_cm == 39) {
          valor_cm = 0;
        } else if (currentFrame_cm == 72) {
          valor_cm = 0;
        }
        if (contador_caramelos == sonido_l) {
          s.playCaramelera();
        }
        if (contador_caramelos == caramelos_l) {
          agregarCaramelos(cantCaramelos, width/2, 160, 0);
          if (cantCaramelos > 2) {
            r.setTimer(20);
          } else {
            r.setTimer(12);
          }
        }
        if (r.timer != 0) {
          if (r.terminoTiempo()) {
            valor_cm = 1;
          }
        }
        if (currentFrame_cm == 46) {
          izquierda_cm = true;
          contador_caramelos = 0;
          valorIncremento_caramelos = 0;
          r.resetear();
        } else if (currentFrame_cm == 73) {

          derecha_cm = true;
          contador_caramelos = 0;
          valorIncremento_caramelos = 0;
          r.resetear();
        }
      }
      // --- Propiedades caramelera "izquierda"
      if (izquierda_cm) {
        cantCaramelos = floor(random(1, 4));
        centro_cm = false;
        if (currentFrame_cm == 56) {
          valor_cm = 0;
        }
        valorIncremento_caramelos = 1;
        contador_caramelos+= valorIncremento_caramelos;
        if (currentFrame_cm == 39) {
          valor_cm = 0;
        }
        if (contador_caramelos == sonido_l) {
          s.playCaramelera();
        }
        if (contador_caramelos == caramelos_l) {
          agregarCaramelos(cantCaramelos, width/2-cincuentaPX*2, 160, -10000);
          if (cantCaramelos > 2) {
            r.setTimer(20);
          } else {
            r.setTimer(12);
          }
        }
        if (r.timer != 0) {
          if (r.terminoTiempo()) {
            valor_cm = 1;
          }
        }

        if (currentFrame_cm == 61) {
          centro_cm = true;
          contador_caramelos = 0;
          valorIncremento_caramelos = 0;
          r.resetear();
        }
      }
      for (Caramelo c : cs) {
        float x = c.getVelocityX();
        float y = c.getVelocityY();

        if (x <= 0 && y <= 0) {
          c.addImpulse(random(-50, 50), 0);
        }
      }
      delay_cm = (delay_cm+1) % 3;
    }

    bi.dibujarBorde();
    bd.dibujarBorde();
    if (m_0) {
      p[0].moverPendulo(180);
    }
    if (m_1) {
      p[1].moverPendulo(180);
    }
    if (m_2) {
      p[2].moverPendulo(100);
    }

    for (Plataforma p : bloquesDirIzq) {
      for (Caramelo c : cs) {
        if (c.isTouchingBody(p)) {
          c.addImpulse(-3, -1);
        }
      }
    }
    for (Plataforma p : bloquesDirDer) {
      for (Caramelo c : cs) {
        if (c.isTouchingBody(p)) {
          c.addImpulse(3, -1);
        }
      }
    }
  } else if (estado.equals("fin")) {
    ciclo = false;



    image(fondo_final, 0, 0);
    bi.dibujarBorde();
    bd.dibujarBorde();
    pushStyle();
    fill(0);
    textFont(font);
    textSize(40);
    text("Rosas", width/2 - 80, 475);
    text("Violetas", width/2 - 80, 530);
    text("Amarillos", width/2 - 80, 585);
    text("Celestes", width/2 - 80, 640);
    text(contador_rosas, width/2 + 140, 475);
    text(contador_violetas, width/2 + 140, 530);
    text(contador_amarillos, width/2 + 140, 585);
    text(contador_celestes, width/2 + 140, 640);
    text(puntos, width/2+140, 720);
    popStyle();

    resetearValores_fin();

    contador++;
    if (contador == 300) {
      s.playMusicaFondo();
      estado = "inicio";
    }
    //iniciarVariablesNumericas();
  }
}
void resetearValores_fin() {
  inicio.remove(bolsai);
  inicio.remove(c_inicio);
  inicio.remove(b_inicio);
  inicio.add(bolsai);
  inicio.add(c_inicio);
  inicio.add(b_inicio);
  b_inicio.resetearBloqueInicio();

  borrarCaramelos();
  contador_cm = 0;

  currentFrame_cm = 0;
  delay_cm = 0;
  valor_cm = 1;
  contador_caramelos = 0;
  valorIncremento = 1;
  valorIncremento_caramelos = 1;
  // Fondo inicio
  currentFrame_fondo = 0;
  delay_fondo = 0;
  valor_fondo = 1;

  iniciarBooleanas();
  for (int i = 0; i < 3; i++) {
    p[i].penduloQuieto();
  }
  for (Plataforma b : bloquesMovibles) {
    b.resetearBloques();
  }
  for (int i = 0; i < manchas.size(); i ++) {
    PImage m = manchas.get(i);

    manchas.remove(m);
  }
  bolsa.resetearBolsa();

  x0 = random(250, width-250);
  x1 = random(250, width-250);
  x2 = random(250, width-250);
  x3 = random(250, width-250);

  y0 = random(400, height-300);
  y1 = random(400, height-300);
  y2 = random(400, height-300);
  y3 = random(400, height-300);
}

void resetearValores_inicio() {
  contador = 0;
  puntos = 0;
  vidas = 5;
  contador_rosas = 0;
  contador_violetas = 0;
  contador_amarillos = 0;
  contador_celestes = 0;
}
