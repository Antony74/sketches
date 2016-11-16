
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
  
    walk.add(new StickFigure(
        50.0,                               // Size
        new PVector(104.0, 361.0),          // Pelvis
        new PVector(94.785576, 410.14362),  // Left knee
        new PVector(128.36832, 404.65988),  // Right knee
        new PVector(75.84354, 456.4167),    // Left foot
        new PVector(128.92888, 454.65674),  // Right foot
        new PVector(104.0, 311.0),          // Chest
        new PVector(104.0, 261.0),          // Neck
        new PVector(104.00003, 210.99997),  // Head
        new PVector(79.29953, 304.47284),   // Left elbow
        new PVector(129.31003, 304.1208),   // Right elbow
        new PVector(73.11563, 354.08893),   // Left hand
        new PVector(136.19186, 353.64478)));// Right hand

    walk.add(new StickFigure(
        50.0,                               // Size
        new PVector(111.0, 362.0),          // Pelvis
        new PVector(101.785576, 411.14362), // Left knee
        new PVector(145.82376, 397.87903),  // Right knee
        new PVector(82.84354, 457.4167),    // Left foot
        new PVector(157.13533, 446.5827),   // Right foot
        new PVector(111.0, 312.0),          // Chest
        new PVector(111.0, 262.0),          // Neck
        new PVector(111.00003, 211.99997),  // Head
        new PVector(86.29953, 305.47284),   // Left elbow
        new PVector(136.31003, 305.1208),   // Right elbow
        new PVector(80.11563, 355.08893),   // Left hand
        new PVector(143.19186, 354.64478)));// Right hand

    walk.add(new StickFigure(
        50.0,                               // Size
        new PVector(124.0, 363.0),          // Pelvis
        new PVector(121.43926, 412.9344),   // Left knee
        new PVector(157.82025, 399.8265),   // Right knee
        new PVector(80.64006, 441.8381),    // Left foot
        new PVector(167.78326, 448.82382),  // Right foot
        new PVector(124.0, 313.0),          // Chest
        new PVector(124.0, 263.0),          // Neck
        new PVector(124.00003, 212.99997),  // Head
        new PVector(99.29953, 306.47284),   // Left elbow
        new PVector(149.31003, 306.1208),   // Right elbow
        new PVector(93.11563, 356.08893),   // Left hand
        new PVector(156.19186, 355.64478)));// Right hand

    walk.add(new StickFigure(
        50.0,                               // Size
        new PVector(136.0, 362.0),          // Pelvis
        new PVector(143.68535, 411.40582),  // Left knee
        new PVector(155.3069, 408.12204),   // Right knee
        new PVector(109.64462, 448.02872),  // Left foot
        new PVector(157.4431, 458.0764),    // Right foot
        new PVector(136.0, 312.0),          // Chest
        new PVector(136.0, 262.0),          // Neck
        new PVector(136.00003, 212.0),      // Head
        new PVector(111.29953, 305.4729),   // Left elbow
        new PVector(161.31, 305.12073),     // Right elbow
        new PVector(105.11562, 355.08887),  // Left hand
        new PVector(168.19191, 354.64474)));// Right hand

    walk.add(new StickFigure(
        50.0,                               // Size
        new PVector(136.0, 362.0),          // Pelvis
        new PVector(154.72314, 408.3621),   // Left knee
        new PVector(136.89272, 411.99203),  // Right knee
        new PVector(129.90625, 451.7686),   // Left foot
        new PVector(132.38156, 461.78812),  // Right foot
        new PVector(136.0, 312.0),          // Chest
        new PVector(136.0, 262.0),          // Neck
        new PVector(136.00003, 212.0),      // Head
        new PVector(111.29953, 305.4729),   // Left elbow
        new PVector(161.31, 305.12073),     // Right elbow
        new PVector(105.11562, 355.08887),  // Left hand
        new PVector(168.19191, 354.64474)));// Right hand

    walk.add(new StickFigure(
        50.0,                               // Size
        new PVector(145.0, 363.0),          // Pelvis
        new PVector(138.0902, 412.52023),   // Left knee
        new PVector(164.23077, 409.15384),  // Right knee
        new PVector(139.18661, 462.5082),   // Left foot
        new PVector(168.41156, 458.97876),  // Right foot
        new PVector(145.0, 313.0),          // Chest
        new PVector(145.0, 263.0),          // Neck
        new PVector(145.00003, 213.0),      // Head
        new PVector(120.29953, 306.4729),   // Left elbow
        new PVector(170.31, 306.12073),     // Right elbow
        new PVector(114.11562, 356.08887),  // Left hand
        new PVector(177.19191, 355.64474)));// Right hand
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