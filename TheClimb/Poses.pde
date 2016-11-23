
class Poses {
  ArrayList<StickFigure_old> walk = new ArrayList<StickFigure_old>();
  
  Poses() {

    ArrayList<StickFigure_old> sequence = walk;
    
    sequence.add(new StickFigure_old(
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
  
    sequence.add(new StickFigure_old(
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

    sequence.add(new StickFigure_old(
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

    sequence.add(new StickFigure_old(
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

    sequence.add(new StickFigure_old(
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

    sequence.add(new StickFigure_old(
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

    sequence.add(new StickFigure_old(
        50.0,                                // Size
        new PVector(147.0, 363.0),           // Pelvis
        new PVector(177.89108, 402.31592),   // Left knee
        new PVector(147.89272, 412.99203),   // Right knee
        new PVector(166.14085, 450.91565),   // Left foot
        new PVector(136.92668, 461.7747),    // Right foot
        new PVector(147.0, 313.0),           // Chest
        new PVector(147.0, 263.0),           // Neck
        new PVector(147.00003, 213.0),       // Head
        new PVector(122.29953, 306.4729),    // Left elbow
        new PVector(172.31, 306.12073),      // Right elbow
        new PVector(116.11562, 356.08887),   // Left hand
        new PVector(179.19191, 355.64474))); // Right hand

    sequence.add(new StickFigure_old(
        50.0,                                // Size
        new PVector(164.0, 363.0),           // Pelvis
        new PVector(202.41107, 395.00922),   // Left knee
        new PVector(169.2893, 412.71945),    // Right knee
        new PVector(201.0545, 444.9908),     // Left foot
        new PVector(151.0503, 459.27414),    // Right foot
        new PVector(164.0, 313.0),           // Chest
        new PVector(164.0, 263.0),           // Neck
        new PVector(164.00003, 213.0),       // Head
        new PVector(139.29953, 306.4729),    // Left elbow
        new PVector(189.31, 306.12073),      // Right elbow
        new PVector(133.11563, 356.08887),   // Left hand
        new PVector(196.19191, 355.64474))); // Right hand
    
    sequence.add(new StickFigure_old(
        50.0,                                // Size
        new PVector(174.0, 364.0),           // Pelvis
        new PVector(205.23476, 403.04346),   // Left knee
        new PVector(165.96622, 413.35037),   // Right knee
        new PVector(203.862, 453.0246),      // Left foot
        new PVector(136.07613, 453.43256),   // Right foot
        new PVector(174.0, 314.0),           // Chest
        new PVector(174.0, 264.0),           // Neck
        new PVector(174.00003, 214.0),       // Head
        new PVector(149.29953, 307.4729),    // Left elbow
        new PVector(199.31, 307.12073),      // Right elbow
        new PVector(143.11563, 357.08887),   // Left hand
        new PVector(206.19191, 356.64474))); // Right hand

    sequence.add(new StickFigure_old(
        50.0,                                // Size
        new PVector(191.0, 365.0),           // Pelvis
        new PVector(215.43018, 408.6253),    // Left knee
        new PVector(191.0, 415.0),           // Right knee
        new PVector(213.06767, 458.56946),   // Left foot
        new PVector(167.93848, 459.36404),   // Right foot
        new PVector(191.0, 315.0),           // Chest
        new PVector(191.0, 265.0),           // Neck
        new PVector(191.00003, 215.0),       // Head
        new PVector(166.29953, 308.4729),    // Left elbow
        new PVector(216.31, 308.12073),      // Right elbow
        new PVector(160.11563, 358.08887),   // Left hand
        new PVector(223.19191, 357.64474))); // Right hand

    // End of walk sequence
  }

};