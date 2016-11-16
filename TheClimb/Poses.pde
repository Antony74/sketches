
class Poses {
  ArrayList<StickFigure> walk = new ArrayList<StickFigure>();
  
  Poses() {

    walk.add(new StickFigure(
      50.0,                               // Size
      new PVector(99.0, 360.0),           // Pelvis
      new PVector(89.785576, 409.14362),  // Left knee
      new PVector(113.63571, 407.81),     // Right knee
      new PVector(70.84354, 455.4167),    // Left foot
      new PVector(110.58897, 457.71704),  // Right foot
      new PVector(99.0, 310.0),           // Chest
      new PVector(99.0, 260.0),           // Neck
      new PVector(99.00003, 209.99997),   // Head
      new PVector(74.29953, 303.47284),   // Left elbow
      new PVector(124.31003, 303.1208),   // Right elbow
      new PVector(68.11563, 353.08893),   // Left hand
      new PVector(131.19186, 352.64478)));// Right hand
  }
};

StickFigure createPose(String sName) {

  if (sName.equals("walk1")) {
    return null;
  } else {
    println("Pose " + sName + " not found");
    return null;
  }
}