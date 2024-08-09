enum Direction {
  UP,
  DOWN,
  LEFT,
  RIGHT
}

public class Head {
  public PVector pos;
  public Direction dir = Direction.LEFT;
  public ArrayList<PVector> tail = new ArrayList<>();
  public PVector pending = null;
  
  public Head(int x, int y) {
    this.pos = new PVector(x, y);
  }
  
  void update() {
    this.updateTail();

    if (this.dir == Direction.LEFT) {
      this.pos.x -= 1;
    } else if (this.dir == Direction.RIGHT) {
      this.pos.x += 1;
    } else if (this.dir == Direction.UP) {
      this.pos.y -= 1;
    } else if (this.dir == Direction.DOWN) {
      this.pos.y += 1;
    }
    
    if (pending != null) {
      this.tail.add(pending.copy());
      pending = null;
    }
  }
  
  void show(int scl) {
    pushMatrix();
    fill(30, 230, 30);
    stroke(33);
    rect(this.pos.x * scl, this.pos.y * scl, scl, scl);
    fill(255);
    for (PVector pos : this.tail) {
      rect(pos.x * scl, pos.y * scl, scl, scl);
    }
    popMatrix();
  }

  void rotate(Direction dir) {
    if (this.dir == Direction.LEFT && dir != Direction.RIGHT) {
      this.dir = dir;
      return;
    }
    
    if (this.dir == Direction.RIGHT && dir != Direction.LEFT) {
      this.dir = dir;
      return;
    }
    
    if (this.dir == Direction.UP && dir != Direction.DOWN) {
      this.dir = dir;
      return;
    }
    
    if (this.dir == Direction.DOWN && dir != Direction.UP) {
      this.dir = dir;
      return;
    }
  }
  
  void grow() {
    pending = this.tail.size() == 0 ?
      this.pos.copy() :
      this.tail.get(this.tail.size() - 1).copy(); 
  }
  
  private void updateTail() {
    for (int i = this.tail.size() - 1; i >= 0; i--) {
      PVector nextPos;
      if (i == 0) nextPos = this.pos;
      else nextPos = this.tail.get(i - 1);
      
      PVector section = this.tail.get(i);
      section.x = nextPos.x;
      section.y = nextPos.y;
    }
  }

  
  boolean eat(Food food) {
    return food.pos.x == this.pos.x && food.pos.y == this.pos.y;
  }
  
  ArrayList<PVector> used() {
    ArrayList<PVector> spaces = new ArrayList<>(tail);
    spaces.add(this.pos);
    return spaces;
  }
}
