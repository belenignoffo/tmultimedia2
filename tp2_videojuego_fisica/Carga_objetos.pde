// ---- INICIALIZACIÓN DE VARIABLES
void iniciarVariablesNumericas() {
  // Posición
  cincuentaPX = 50;
  // Jugabilidad
  puntos = 0;
  vidas = 3;
  contador_rosas = 0;
  contador_violetas = 0;
  contador_amarillos = 0;
  contador_celestes = 0;
  // Movimiento caramelera
  contador = 0;
  currentFrame_cm = 0;
  loopFrame_cm = 74;
  delay_cm = 0;
  valor_cm = 1;
  contador_caramelos = 0;
  valorIncremento = 1;
  valorIncremento_caramelos = 1;
  // Fondo inicio
  currentFrame_fondo = 0;
  loopFrame_fondo = 34;
  delay_fondo = 0;
  valor_fondo = 1;
  
  x0 = random(250, width-250);
  x1 = random(250, width-250);
  x2 = random(250, width-250);
  x3 = random(250, width-250);
  
  y0 = random(400, height-300);
  y1 = random(400, height-300);
  y2 = random(400, height-300);
  y3 = random(400, height-300);
  
}
void iniciarBooleanas() {
  // Movimiento péndulos
  m_0 = false;
  m_1 = false;
  m_2 = false;
  // Movimiento caramelera
  derecha_cm = false;
  centro_cm = false;
  izquierda_cm = false;
  ciclo = false;
}

// --- CARGA DE IMÁGENES
void cargaDeImagenes() {
  bolsaroja = loadImage("bolsa_roja.png");
  golosina = new PImage[9];
  for (int i = 0; i < golosina.length; i++) {
    golosina[i] = loadImage("golosina" + nf(i, 2) + ".png");
  }
  caramelera = new PImage[74];
  for (int i = 0; i < caramelera.length; i++) {
    caramelera[i] = loadImage("caramelera_" + nf(i, 2) + ".png");
  }
  fondo = new PImage[34];
  for (int i = 0; i < fondo.length; i++) {
    fondo[i] = loadImage("fondo_" + nf(i, 2) + ".png");
  }
  fondo_final = loadImage("fondo_bolsa.png");
  img_manchas = new PImage[4];
  for(int i = 0; i < img_manchas.length; i++){
    img_manchas[i] = loadImage("mancha_" + nf(i, 2) + ".png");
  }
  reglas = loadImage("instrucciones.png");
  bolsa_puntos = loadImage("bolsita.png");
  img_vidas = loadImage("vidas.png");
}

// --- INICIALIZACIÓN OBJETOS
void iniciarObjetos() {
  // --- bordes
  bi = new Borde(0, 0);
  bd = new Borde(width-39, 0);
  borde_i = new Plataforma(40, height);
  borde_i.iniciarBorde(20, height/2);
  borde_d = new Plataforma(40, height);
  borde_d.iniciarBorde(width-20, height/2);

  // --- péndulos
  p = new Pendulo[3];
  for (int i = 0; i < p.length; i++) {
    p[i] = new Pendulo("chupetin" + i);
  }
  p[0].iniciarPendulo(width/2, 280);
  p[1].iniciarPendulo(width/2 + (cincuentaPX*5), 475);
  p[2].iniciarPendulo(width/2 - (cincuentaPX*5), 475);

  // --- objetos pantalla INICIO
  c_inicio = new Caramelo(40);
  c_inicio.dibujarCarameloInicio(width/2-(cincuentaPX*2)-25, 600);
  b_inicio = new Plataforma(cincuentaPX, cincuentaPX);
  b_inicio.iniciarBloqueInicio();
  bolsai = new Plataforma(105, 100);
  bolsai.iniciarBolsa_(width/2-(cincuentaPX*2)-25, height-70, bolsaroja);

  // --- bolsa
  bolsa = new Plataforma(105, 100);
  bolsa.iniciarBolsa(width/2, height-70, bolsaroja);

  // --- piso
  piso = new Plataforma(width, 10);
  piso.iniciarPiso(width/2, height-10);
  
  // --- tipografia
  font = createFont("Gaegu-Regular.ttf", 50);
}

// --- INICIALIZACIÓN DE LAS GOLOSINAS
void iniciarBloquesFijos() {
  for (int i = 0; i < 24; i ++) {
    Plataforma bf = new Plataforma(cincuentaPX, cincuentaPX);
    bloquesFijos.add(bf);
  }
  // --- derecha
  bloquesFijos.get(0).iniciarBloquesFijos( width/2 + (cincuentaPX*2), 550, 0.85, golosina[8]);
  bloquesFijos.get(1).iniciarBloquesFijos( width/2 + (cincuentaPX*3), 400, 0.85, golosina[3]);
  bloquesFijos.get(2).iniciarBloquesFijos(width/2 + (cincuentaPX*6), 400, 0.85, golosina[6]);
  bloquesFijos.get(3).iniciarBloquesFijos(width/2 + (cincuentaPX*7), 450, 0.85, golosina[7]);
  bloquesFijos.get(4).iniciarBloquesFijos(width/2 + (cincuentaPX*10), 350, 0.85, golosina[5]);
  bloquesFijos.get(5).iniciarBloquesFijos(width/2 + (cincuentaPX*10), 400, 0.85, golosina[4]);
  bloquesFijos.get(6).iniciarBloquesFijos(width/2 + (cincuentaPX*3), 650, 1, golosina[4]);
  bloquesFijos.get(7).iniciarBloquesFijos(width/2 + (cincuentaPX*8), 650, 0.85, golosina[5]);
  bloquesFijos.get(8).iniciarBloquesFijos(width/2 + (cincuentaPX*9), 650, 0.85, golosina[7]);
  bloquesFijos.get(9).iniciarBloquesFijos(width/2 + (cincuentaPX*9), 600, 0.85, golosina[3]);
  bloquesFijos.get(10).iniciarBloquesFijos(width/2 + (cincuentaPX*10), 800, 1, golosina[2]);
  bloquesFijos.get(11).iniciarBloquesFijos(width/2 +(cincuentaPX*10), 500, 1, golosina[2]);
  // --- izquierda
  bloquesFijos.get(12).iniciarBloquesFijos(width/2 - (cincuentaPX*3), 400, 0.85, golosina[5]);
  bloquesFijos.get(13).iniciarBloquesFijos(width/2 - (cincuentaPX*3), 450, 0.85, golosina[4]);
  bloquesFijos.get(14).iniciarBloquesFijos(width/2 - (cincuentaPX*7), 400, 0.85, golosina[6]);
  bloquesFijos.get(15).iniciarBloquesFijos(width/2 - (cincuentaPX*8), 400, 0.85, golosina[3]);
  bloquesFijos.get(16).iniciarBloquesFijos(width/2 - (cincuentaPX*10), 350, 0.85, golosina[5]);
  bloquesFijos.get(17).iniciarBloquesFijos(width/2 - (cincuentaPX*10), 400, 0.85, golosina[7]);
  bloquesFijos.get(18).iniciarBloquesFijos(width/2 - (cincuentaPX*8), 550, 1, golosina[2]);
  bloquesFijos.get(19).iniciarBloquesFijos(width/2 - (cincuentaPX*9), 650, 0.85, golosina[4]);
  bloquesFijos.get(20).iniciarBloquesFijos(width/2 - (cincuentaPX*8), 650, 0.85, golosina[8]);
  bloquesFijos.get(21).iniciarBloquesFijos(width/2 - (cincuentaPX*5), 700, 1, golosina[2]);
  bloquesFijos.get(22).iniciarBloquesFijos(width/2 - (cincuentaPX*3), 700, 0.85, golosina[7]);
  bloquesFijos.get(23).iniciarBloquesFijos(width/2 - (cincuentaPX*10), 800, 1, golosina[2]);
}

void iniciarBloquesMovibles() {
  for (int i = 0; i < 11; i ++) {
    Plataforma bm = new Plataforma(cincuentaPX, cincuentaPX);
    bloquesMovibles.add(bm);
  }
  // --- centro
  bloquesMovibles.get(0).iniciarBloquesMovibles(width/2, 500);
  bloquesMovibles.get(1).iniciarBloquesMovibles(width/2 - cincuentaPX, 650);
  bloquesMovibles.get(2).iniciarBloquesMovibles(width/2 + (cincuentaPX*2), 700);
  // --- derecha
  bloquesMovibles.get(3).iniciarBloquesMovibles(width/2 + (cincuentaPX*4), 400);
  bloquesMovibles.get(4).iniciarBloquesMovibles(width/2 + (cincuentaPX*8), 450);
  bloquesMovibles.get(5).iniciarBloquesMovibles(width/2 + (cincuentaPX*6), 700);
  bloquesMovibles.get(8).iniciarBloquesMovibles(width/2 + (cincuentaPX*4), 800);
  // --- izquierda
  bloquesMovibles.get(6).iniciarBloquesMovibles(width/2 - (cincuentaPX*6), 450);
  bloquesMovibles.get(7).iniciarBloquesMovibles(width/2 - (cincuentaPX*6), 700);
  bloquesMovibles.get(9).iniciarBloquesMovibles(width/2 - (cincuentaPX*4), 800);
  bloquesMovibles.get(10).iniciarBloquesMovibles(width/2 - (cincuentaPX*2), 550);
}

void iniciarBloquesDeDireccion() {
  for (int i = 0; i < 3; i++) {
    Plataforma b = new Plataforma(cincuentaPX, cincuentaPX);
    bloquesDirIzq.add(b);
  }
  for (int i = 0; i < 3; i++) {
    Plataforma b = new Plataforma(cincuentaPX, cincuentaPX);
    bloquesDirDer.add(b);
  }

  bloquesDirIzq.get(0).iniciarBloquesFijos(width/2 + (cincuentaPX*5), 700, 0, golosina[1]);
  bloquesDirIzq.get(1).iniciarBloquesFijos(width/2 - (cincuentaPX*4), 450, 0, golosina[1]);
  bloquesDirIzq.get(2).iniciarBloquesFijos(width/2, 650, 1, golosina[1]);
  bloquesDirDer.get(0).iniciarBloquesFijos(width/2 + (cincuentaPX*7), 400, 0, golosina[0]);
  bloquesDirDer.get(1).iniciarBloquesFijos(width/2 - (cincuentaPX*9), 500, 0, golosina[0]);
  bloquesDirDer.get(2).iniciarBloquesFijos(width/2 - (cincuentaPX*3), 650, 0, golosina[0]);
}
