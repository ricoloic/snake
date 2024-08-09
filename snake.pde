int scl = 30;
int cols;
int rows;

Head snake;
Food food;

ArrayList<PVector> grid = new ArrayList<>();

ArrayList<Direction> buffer = new ArrayList<>();

void setup() {
  fullScreen();
  frameRate(5);

  cols = width / scl;
  rows = height / scl;
 
  snake = new Head(cols / 2, rows / 2);
  
  for (int x = 0; x < cols; x++) {
    for (int y = 0; y < rows; y++) {
      grid.add(new PVector(x, y));
    }
  }
  
  food = createFood();
}

void draw() {
  noStroke();
  fill(33);
  rect(0, 0, cols * scl, rows * scl);
  
  if (buffer.size() > 0) {
    snake.rotate(buffer.get(0));
    buffer.remove(0);
  }

  food.show(scl);
  snake.update();
  snake.show(scl);  
  if (snake.eat(food)) {
    snake.grow();
    food = createFood();
  }
}

void keyPressed() {
  if (keyCode == UP) {
    buffer.add(Direction.UP);
  } else if (keyCode == DOWN) {
    buffer.add(Direction.DOWN);
  } else if (keyCode == LEFT) {
    buffer.add(Direction.LEFT);
  } else if (keyCode == RIGHT) {
    buffer.add(Direction.RIGHT);
  }
  
  if (buffer.size() > 2) {
    buffer.remove(0);
  }
}

Food createFood() {
  ArrayList<PVector> available = new ArrayList<>(grid);
  ArrayList<PVector> used = snake.used();
  for (PVector space : used) {
    for (int i = 0; i < available.size(); i++) {
      PVector p = available.get(i);
      if (p.x == space.x && p.y == space.y) {
        available.remove(i);
        break;
      }
    }
  }
  PVector foodPos = available.get(floor(random(available.size())));
  return new Food((int) foodPos.x, (int) foodPos.y);
}
