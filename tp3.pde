//Acá va el link de tu video

boolean usarColor = false;  // inicialmente no usa el color azul
PImage imagen;
float achicarElipse = 1.0; // para cambiar tamaño de las elipses


void setup() {
  size(800, 400); 
  noStroke(); // para dibujar sin borde las elipses
  imagen = loadImage("07.png");
  dibujar(); 
}

void draw() {
}

void mousePressed() { 
  usarColor = !usarColor;  // alterno entre gris y azul en cada clic
  if (achicarElipse == 1.0) {
    achicarElipse = 0.7;
  } else {
    achicarElipse = 1.0;
  }
  dibujar(); 
}

void keyPressed() {
  if (key == 'r' || key == 'R') { 
    usarColor = false;           
    achicarElipse = 1.0;         
    dibujar();                   
  }
}

void dibujarElipse(float centroX, float centroY, float ancho, float alto, color c) { 
  fill(c); // relleno de la figura es el color c
  ellipse(centroX, centroY, ancho, alto);
}

color calcularColor(float t) { // calcula el color (su intensidad) segun la posicion de la elipse, ya que va en degrade
  float intensidad = map(abs(t), 0, 1, 50, 180); // cuanto mas cerca del centro (0) más oscuro el color

  if (usarColor) {
    return color(0, 0, intensidad); // azul si usarColor es true
  } else {
    return color(intensidad); // gris si usarColor es false
  }
}

void dibujar() {
  
  background(255);
  image(imagen, 0, 0, 400, 400); // la foto de referencia a la izquierda
  int columnas = 30;
  int filas = 35;
  float espaciadoX = (width / 2) / float(columnas);

  for (int fila = 0; fila < filas; fila++) {
    float t = map(fila, 0, filas - 1, -1, 1); 
    float centroY = height / 2 + t * height * 0.5 * pow(abs(t), 0.5); // posicion vertical de la elipse

    float ancho = espaciadoX * 1.3 * achicarElipse;
    float altoMax = ancho; 
    float altoMin = ancho * 0.1; // el al alto minimo que llegan a tener
    float alto = map(abs(t), 0, 1, altoMin, altoMax); // cuanto mas lejos del centro (mayor abs(t)) más alta es la elipse

    color c = calcularColor(t);

    for (int columna = 0; columna < columnas; columna++) {
      if ((fila % 2 == 0 && columna % 2 == 0) || (fila % 2 == 1 && columna % 2 == 1)) {
        float centroX = columna * espaciadoX + espaciadoX / 2 + width / 2;
        dibujarElipse(centroX, centroY, ancho, alto, c);
      }
    }
  }
}
