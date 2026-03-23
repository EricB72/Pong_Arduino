//VARIABLES
float pala1Y, pala2Y, ballX, ballY;
float ballIncrement, ballSpeedX, ballSpeedY, palaSpeed, ballAngle;

int offsetX;
int sizeX, sizeY, ballSize;
int player1, player2;
int textSize;

boolean moveUp1, moveUp2, moveDown1, moveDown2;

PFont textFont;

//2k min, 5/6k max LDR

//SETUP
void setup() {
  size(1200, 800);
  background(0);

  rectMode(CENTER);
  imageMode(CENTER);

  //Set Variables to Arduino


  //Other variables
  palaSpeed = 6;
  offsetX = 100;
  sizeX = 30;
  sizeY = 100;
  ballSize = 50;
  textSize = 100;
  player1 = 0;
  player2 = 0;

  textFont = createFont("pong-score.otf", textSize);
  Restart();
}

//DRAW
void draw() {
  background(0);

  //Draw
  rect(offsetX, pala1Y, sizeX, sizeY);
  rect(width - offsetX, pala2Y, sizeX, sizeY);
  circle(ballX, ballY, ballSize);

  //Temporal
  movePalas();
  moveBall();
  drawText();
}

//FUNCTIONS
void keyPressed() {
  if (key == 'w' || key == 'W') moveUp1 = true;
  if (key == 's' || key == 'S') moveDown1 = true;
  if (keyCode == UP) moveUp2 = true;
  if (keyCode == DOWN) moveDown2 = true;
  if (key == 'r' || key == 'R') {
    Restart();
    key = 'p';
  }
}

void keyReleased() {
  if (key == 'w' || key == 'W') moveUp1 = false;
  if (key == 's' || key == 'S') moveDown1 = false;
  if (keyCode == UP) moveUp2 = false;
  if (keyCode == DOWN) moveDown2 = false;
}

void movePalas() {
  if ((pala1Y - sizeY / 2) > 0)
  {
    if (moveUp1)
    {
      pala1Y -= palaSpeed;
    }
  }

  if ((pala1Y + sizeY / 2) < height)
  {
    if (moveDown1)
    {
      pala1Y += palaSpeed;
    }
  }

  if ((pala2Y - sizeY / 2) > 0)
  {
    if (moveUp2)
    {
      pala2Y -= palaSpeed;
    }
  }

  if ((pala2Y + sizeY / 2) < height)
  {
    if (moveDown2)
    {
      pala2Y += palaSpeed;
    }
  }
}

void moveBall()
{
  ballX += ballSpeedX * ballIncrement;
  ballY += ballSpeedY * ballIncrement;

  //Ball collision
  PVector ball_min, ball_max, other1_min, other1_max, other2_min, other2_max;
  ball_min = new PVector(ballX - ballSize / 2, ballY - ballSize / 2);
  ball_max = new PVector(ballX + ballSize / 2, ballY + ballSize / 2);
  other1_min = new PVector(offsetX - sizeX / 2, pala1Y - sizeY / 2);
  other1_max = new PVector(offsetX + sizeX / 2, pala1Y + sizeY / 2);
  other2_min = new PVector(width - offsetX - sizeX / 2, pala2Y - sizeY / 2);
  other2_max = new PVector(width - offsetX + sizeX / 2, pala2Y + sizeY / 2);

  if (!((ball_max.x < other2_min.x) || (ball_max.y < other2_min.y) || (other2_max.x < ball_min.x) || (other2_max.y < ball_min.y)) || !((ball_max.x < other1_min.x) || (ball_max.y < other1_min.y) || (other1_max.x < ball_min.x) || (other1_max.y < ball_min.y))) {
    //Ball hit
    ballSpeedX *= -1;
    ballIncrement += 0.1f;
  }

  if ((ballY + ballSize / 2) > height || (ballY - ballSize / 2) < 0) {
    ballSpeedY *= -1;
    ballIncrement += 0.1f;
  }

  if ((ballX - ballSize / 2) > width)
  {
    player1++;
    Restart();
  }

  if ((ballX + ballSize / 2) < 0)
  {
    player2++;
    Restart();
  }
}

void Restart() {
  ballX = width/2;
  ballY = height/2;
  ballAngle = random(360);
  ballSpeedX = cos(ballAngle);
  ballSpeedY = sin(ballAngle);
  ballIncrement = 5;
  pala1Y = height/2; //Light sensor
  pala2Y = height/2; //Spin sensor
}

void drawText() {
  textSize(textSize);
  textFont(textFont);
  text(player1, width/2 - (200 + textSize / 2), textSize + 50);
  text(player2, width/2 + (200 - textSize / 2), textSize + 50);
}
