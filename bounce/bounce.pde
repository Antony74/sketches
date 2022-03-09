    float positionX = 100;
    float positionY = 100;
    float velocityX = 7;
    float velocityY = 31;
    
    void setup() {
      size(400, 400);
    }
    
    void draw() {
      line(positionX, positionY, positionX + velocityX, positionY + velocityY);
      positionX += velocityX;
      positionY += velocityY;
      
      if (positionX < 0) {
        velocityX = abs(velocityX);
      }
      
      if (positionX > width) {
        velocityX = -abs(velocityX);
      }
      
      if (positionY < 0) {
        velocityY = abs(velocityY);
      }
      
      if (positionY > height) {
        velocityY = -abs(velocityY);
      }
      
    }
    
    
