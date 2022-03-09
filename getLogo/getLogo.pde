    size(300, 100);
    try {
      Runtime.getRuntime().exec("curl https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_92x30dp.png --output logo.png");
    } catch (IOException e) {
      println(e);
    }
    
    PImage img = loadImage("logo.png");
    image(img, 0, 0);
