/* --- En esta clase están cargados los sprites de los bordes
 
 currentFrame = indice actual de imagen / frame actual
 loopFrame = cantidad total de imágenes / cada cuántos frames se reinicia el sprite
 delay = variable que nos ayuda a controlar la velocidad del sprite
 
 */
class Borde {
  float x, y;
  int borde_currentFrame, borde_loopFrame, borde_delay;
  PImage [] borde_sprite;

  Borde(float x, float y) {
    this.x = x;
    this.y = y;
    borde_currentFrame = 0;
    borde_loopFrame = 8;
    borde_delay = 0;
    borde_sprite = new PImage[borde_loopFrame];
    for (int i = 0; i < borde_sprite.length; i++) {
      borde_sprite[i] = loadImage("borde" + nf(i, 2) + ".png");
    }
  }

  // Dibujamos la imagen en pantalla
  void dibujarBorde() {
    image(borde_sprite[borde_currentFrame], x, y);
    display();
  }

  // Hacemos correr los sprites aumentando el valor del [] de imagen
  void display() {
    if (borde_delay == 0) {
      borde_currentFrame = (borde_currentFrame + 1) % borde_loopFrame;
    }
    borde_delay = (borde_delay+1)%10; // A mayor módulo del delay menor velocidad (y viceversa)
  }
}
