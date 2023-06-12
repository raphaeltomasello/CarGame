import processing.sound.*;

PImage pistaInicial, pista; // Imagem da pista
PImage i1, i2, c1, c2, NomesCreditos, s1, s2, cloud, over, Car, Car2, CarMy, TentarDeNovo, Fase1, Fase2, Fase3, Fase4, ComoJogar, Historia, HistoriaJogo, ComoJogarTexto;
int posPista = 0; // Variavel da pista 1
int posPista2 = 0; // Variavel da pista 2
int x, y, vx, vy, x1, y1, vx1, vx2; // Valores inteiros 0
int x2, y2, x3, y3, x4, y4; //Variaveis dos carrinhos
int dia = 0; //variavel de dia/noite
float r = 255; //Variavel de cor dia/noite
boolean menu = true; //Variavel do menu
int fade = 255; //Variavel do fade pós menu
int fade1 = 0; //Variavel do fade menu
float cloud1 = 0; //Variavel das imagens das nuvens
float cloud2 = 900; //Variavel das imagens das nuvens
int velpis = 1; //Velocidade em que a pista se move
int velcarro = 3; // velocidade do carro
int velpis1 = 0; //Velocidade em que a pista se move
int menu1 = 0; // variavel para game over
int cor = 255; //variavel de cor
int cor1 = 255; //variavel de cor
int level = 0;

boolean button_credito, button_ask, button_exit, button_historia;
boolean tela_credito, tela_ask, tela_historia;


int tempo_fase = 0;

SoundFile music_game;
SoundFile dead;
SoundFile button_play;
SoundFile button_sound;
//########################################################################
//------------------------------------------------------------------------
//########################################################################
void MenuPrincipal()
{
  //Background menu
  cursor(0);
  //Definição das imagens da pista
  image(pistaInicial, 0, 0);

  //Movimentação das nuvens
  cloud1 = cloud1 - 0.4;
  cloud2 = cloud2 - 0.6;

  //Velocidade do carrinho
  y2 = y2 + 5;

  image(Car2, x2, y2);
  image(cloud, cloud1, 5);
  image(cloud, cloud2, 150);
  image(i1, 550, 100);
  image(ComoJogar, 945, 10);
  image(Historia, 550, 200);
  image(c1, 550, 300);
  image(s1, 550, 400);

  //Variavel da posição do carro no menu
  if (y2 >= 550)
  {
    x2 = (int) random(100, 300);
    y2 = -100;
  }

  //Resetando as nuvens quando chegam ao fim
  if (cloud1 <= -300)
  {
    cloud1 = 1100;
  }

  if (cloud2 <= -300)
  {
    cloud2 = 1100;
  }

  //Fade para iniciar
  if (fade1 >= 1)
  {
    if (y2 >= 500)
    {
      y2 = 500;
    }
    fade = fade - 5;
    tint(fade, fade, fade);

    if (fade <= -200)
    {
      //Menu falso, começa o jogo
      menu = false;
    }
  }

  //Botão para iniciar
  if (mouseX >= 555 && mouseX <= 845 && mouseY >= 105 && mouseY <= 175)
  {
    if (mousePressed == true)
    {
      button_sound.play();
      button_play.play();
      fade1 = 1;
    }
  }

  //Botão Como jogo
  if (mouseX >= 945 && mouseX <= 1090 && mouseY >= 10 && mouseY <= 45)
  {
    if (mousePressed == true)
    {
      button_ask = true;
    }

    if (mousePressed == false && button_ask == true)
    {
      button_sound.play();
      button_ask = false;
      tela_ask =! tela_ask;
    }
  }

  if (tela_ask == true)
  {
    tela_credito = false;
    tela_historia = false;
    image(ComoJogarTexto, 50, 50);
  }

  //Botão Historia
  if (mouseX >= 555 && mouseX <= 845 && mouseY >= 200 && mouseY <= 270)
  {
    if (mousePressed == true)
    {
      button_historia = true;
    }

    if (mousePressed == false && button_historia == true)
    {
      button_sound.play();
      button_historia = false;
      tela_historia =! tela_historia;
    }
  }

  if (tela_historia == true)
  {
    tela_ask = false;
    tela_credito = false;
    image(HistoriaJogo, 20, 90);
  }

  //Botão Crédito
  if (mouseX >= 555 && mouseX <= 845 && mouseY >= 305 && mouseY <= 375)
  {
    if (mousePressed == true)
    {
      button_credito = true;
    }

    if (mousePressed == false && button_credito == true)
    {
      button_sound.play();
      button_credito = false;
      tela_credito =! tela_credito;
    }
  }

  if (tela_credito == true)
  {
    tela_ask = false;
    tela_historia = false;
    image(NomesCreditos, 40, 50);
  }

  //Botão sair
  if (mouseX >= 555 && mouseX <= 845 && mouseY >= 405 && mouseY <= 475)
  {
    if (mousePressed == true)
    {
      button_sound.play();
      exit();
    }
  }
}
//########################################################################
//------------------------------------------------------------------------
//########################################################################
void Game()
{
  noCursor(); //Desliga Cursor
  int mx = constrain(mouseX, 365, 677); //limitando o mouse x


  if (velcarro == 3)
  {
    level = 1;
    print("\nLevel");
    print(level);
  }
  //Se for maior que 2000, aumenta a velocidade do carro e da pista
  if (velpis1 >= 2000 && menu1 != 1)
  {
    velpis = velpis + 3;
    velcarro = velcarro + 1;
    velpis1 = 0;

    // Se a velocidade do carro for 20, mantenha 20
    if (velcarro == 5)
    {

      level = 2;
      print("\nLevel");
      print(level);
      velpis = 20;
    }

    //Se a velocidade da pista for igual 34 muda para 38
    if (velcarro == 8)
    {
      level = 3;
      print("\nLevel");
      print(level);
      velpis = 38;
    }

    //Sea velocidade da pista for igual 39 muda para 45
    if (velcarro == 10)
    {
      level = 4;
      print("\nLevel");
      print(level);
      velpis = 45;
    }
  }

  if (level < 3)
  {
    if (millis() - tempo_fase >= 50)
    {
      //Movimentação carros
      velpis1 = velpis1 + 10;// Varaiavel que define a velocidade da pista e do carro
      y = y + velcarro; //Variavel de velocidade do carro 1
      y1 = y1 + velcarro; //Velocidade carro 2
      y3 = y3 + velcarro; //Velocidade carro 3
      y4 = y4 + velcarro; //Velocidade carro 4
      //Movimentação da pista
      tempo_fase = millis();
    }
  } else
  {
    //Movimentação carros
    velpis1 = velpis1 + 10;// Varaiavel que define a velocidade da pista e do carro
    y = y + velcarro; //Variavel de velocidade do carro 1
    y1 = y1 + velcarro; //Velocidade carro 2
    y3 = y3 + velcarro; //Velocidade carro 3
    y4 = y4 + velcarro; //Velocidade carro 4
  }

  //Reposicionamneto dos carros quando chegam ao final
  posPista = posPista + velpis; //Posição da pista é a posição da pista + velocidade da pista
  posPista2 = posPista2 + velpis; //Posição da pista é a posição da pista + velocidade da pista
  //carro1
  if (y >= 500)
  {
    x = (int) random(365, 677);
    y = 0;
  }

  //carro2
  if (y1 >= 500)
  {
    x1 = (int) random(365, 677);
    y1 = (int) random(-100, 0);
  }

  //carro3
  if (y3 >= 500)
  {
    x3 = (int) random(365, 677);
    y3 = (int) random(-100, 0);
  }

  //carro4
  if (y4 >= 500)
  {
    x4 = (int) random(365, 677);
    y4 = (int) random(-100, 0);
  }

  //hitBox carro 1
  if (mx > x && mx < x + 20 && y > 360 && y < 440)
  {
    print("\nBateu 1");
    menu1 = 1; //Ativa o menu de Game Over
  }

  if (mx + 20 > x && mx + 20 < x + 20 && y > 360 && y < 440)
  {
    menu1 = 1; //Ativa o menu de Game Over
  }

  //hitBox carro 2
  if (mx > x1 && mx < x1 + 20 && y1 > 360 && y1 < 440)
  {
    menu1 = 1; //Ativa o menu de Game Over
  }

  if (mx + 20 > x1 && mx + 20 < x1 + 20 && y1 > 360 && y1 < 440)
  {
    menu1 = 1; //Ativa o menu de Game Over
  }

  //hitBox carro 3
  if (mx > x3 && mx < x3 + 20 && y3 > 360 && y3 < 440)
  {
    menu1 = 1; //Ativa o menu de Game Over
  }

  if (mx + 20 > x3 && mx + 20 < x3 + 20 && y3 > 360 && y3 < 440)
  {
    menu1 = 1; //Ativa o menu de Game Over
  }

  //hitBox carro 4
  if (mx > x4 && mx < x4 + 20 && y4 > 360 && y4 < 440)
  {
    menu1 = 1; //Ativa o menu de Game Over
  }

  if (mx + 20 > x4 && mx + 20 < x4 + 20 && y4 > 360 && y4 < 440)
  {
    menu1 = 1; //Ativa o menu de Game Over
  }

  //Ciclo dia e noite
  if (level >= 3)
  {
    if (dia == 0)
    {
      r = r - 0.5;
      if (r < 40)
      {
        dia = 1;
      }
    } else
    {
      r = r + 0.3;
      if (r > 100)
      {
        dia = 0;
      }
    }

    tint(r, r, r);
    fill(r, r, r);
  } else
  {
    tint(255, 255, 255);
    fill(255, 255, 255);
    r = 255;
  }


  //Movimentação pista
  if (posPista2 >= 550)
  {

    posPista = 0;
  }

  if (posPista2 >= 550)
  {
    posPista2 = 0;
  }

  image(pista, 0, posPista); //Pista2 repetindo no background
  image(pista, 0, posPista2 - 550); //Pista repetindo no background

  image(CarMy, mx, 400);

  //carro 2
  if (velcarro >= 3)
  {
    //carro com y1 entra em ação
    image(Car2, x1, y1);
  }

  //carro 3
  if (velcarro >= 3)
  {
    //carro com y1 entra em ação
    image(Car2, x3, y3);
  }

  //carro 4
  if (velcarro >= 3)
  {
    //carro com y1 entra em ação
    image(Car2, x4, y4);
  }

  image(Car2, x, y);
}
//########################################################################
//------------------------------------------------------------------------
//########################################################################
void GameOver()
{
  //Seo menu1 for 1, ative o game over
  if (menu1 == 1)
  {
    cursor(0); //Ativa o cursor
    r = 255; //Faz com que o tint seja 255
    tint(255, 255, 255);
    image(over, 80, -60);
    image(TentarDeNovo, 200, 360);
    image(s1, 600, 360);

    //Seo mouse estiver sobre tal local
    if (mouseX >= 200 && mouseX <= 490 && mouseY >= 360 && mouseY <= 430)
    {
      cor = (#D4E564); //Muda a variavel cor
      if (mousePressed)
      {
        button_sound.play();
        button_play.play();
        velpis = 0;
        velpis1 = 1900;
        velcarro = 3;
        menu = false;
        y = 0; //y do primeiro carrinho
        y1 = -10; //y do segundo carrinho
        y2 = -20; //y do carrinho do menu
        y3 = -5;
        y4 = -40;
        posPista = 0;
        posPista2 = 0;
        menu1 = 0;
        level = 1;
      }
    } else
    {
      cor = 255;
    }

    if (mouseX >= 600 && mouseX <= 890 && mouseY >= 360 && mouseY <= 430)
    {
      cor = (#D4E564); //Muda a variavel cor
      if (mousePressed)
      {
        button_sound.play();
        exit();
      }
    } else
    {
      cor1 = 255;
    }
  }
}

void SwitchLevel()
{
  switch(level)
  {
  case 1:
    image(Fase1, 5, 420);
    break;
  case 2:
    image(Fase2, 10, 400);
    break;
  case 3:
    image(Fase3, 10, 400);
    break;
  case 4:
    image(Fase4, 10, 400);
    break;
  }
}
//########################################################################
//------------------------------------------------------------------------
//########################################################################
void LoadImage()
{
  //Carregamneto das imagens
  pistaInicial = loadImage("Imagens/PistaInicial.png");
  pista = loadImage("Imagens/Pista.png");
  i1 = loadImage("Imagens/Jogar.png");//Iniciar 1
  i2 = loadImage("Imagens/Jogar.png");//Iniciar 2
  c1 = loadImage("Imagens/Creditos.png");//creditos 1
  c2 = loadImage("Imagens/Creditos.png");//creditos 2
  NomesCreditos = loadImage("Imagens/NomesCreditos.png");//creditos 3
  s1 = loadImage("Imagens/Sair.png"); //sair 1
  s2 = loadImage("Imagens/Sair.png");// sair 2
  cloud = loadImage("Imagens/cloud.png");
  over = loadImage("Imagens/GameOver.png");
  TentarDeNovo = loadImage("Imagens/TentarDeNovo.png");
  Fase1 = loadImage("Imagens/Fase1.png");
  Fase2 = loadImage("Imagens/Fase2.png");
  Fase3 = loadImage("Imagens/Fase3.png");
  Fase4 = loadImage("Imagens/Fase4.png");
  ComoJogar = loadImage("Imagens/ComoJogar.png");
  Historia = loadImage("Imagens/Historia.png");
  HistoriaJogo = loadImage("Imagens/HistoriaJogo.png");
  ComoJogarTexto = loadImage("Imagens/ComoJogarTexto.png");

  Car = loadImage("Imagens/Car.png");
  Car2 = loadImage("Imagens/Car2.png");
  CarMy = loadImage("Imagens/CarMy.png");
}
//########################################################################
//------------------------------------------------------------------------
//########################################################################
void LoadSound()
{
  music_game = new SoundFile(this, "Musics/game_sound.wav");
  button_sound = new SoundFile(this, "Musics/Button_Sound.wav");
  button_play = new SoundFile(this, "Musics/Play.wav");

  music_game.loop();
}
//########################################################################
//------------------------------------------------------------------------
//########################################################################
void InitSystem()
{
  x = (int) random(365, 677); // X do primeiro carrinho
  x1 = (int) random(365, 677); // X do segundo carrinho
  x2 = (int) random(100, 300); // X carrinho menu
  x3 = (int) random(365, 677); // X do terceiro carrinho
  x4 = (int) random(365, 677); // X do quarto carrinho

  y = -100; //y do primeiro carrinho
  y1= -800; //y do segundo carrinho
  y2= -100; //y do carrinho menu
  y3= -100; //y do terceiro carrinho
  y4= -800; //y do quarto carrinho

  menu = true; // Define menu on
  menu1 = 0; // menu1 começa com 0
}
//########################################################################
//------------------------------------------------------------------------
//########################################################################
void setup()
{
  size(1100, 500); //Tamanho da tela
  frameRate(60); //lock de frame
  cursor(0); // cursor

  LoadImage();
  LoadSound();
  InitSystem();
}

void draw()
{
  if (menu == true) // Se o menu for verdadeiro
  {
    MenuPrincipal();
  }
  //Jogo começa quando menu é declarado como falso
  if (menu == false)
  {
    Game();
  }
  SwitchLevel();
  GameOver();
}
