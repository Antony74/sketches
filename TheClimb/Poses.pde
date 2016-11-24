
class Poses {
  ArrayList<StickFigure> walk = new ArrayList<StickFigure>();
  
  Poses() {

    ArrayList<StickFigure> sequence = walk;
    
    sequence.add(new StickFigure(
        50.0,                                // Size
        new PVector(99.0, 359.0),            // Pelvis position
        -1.3843094,                          // Left knee (direction of pelvis)
        -1.8545908,                          // Right knee (direction of pelvis)
        -1.2047883,                          // Left foot (direction of left knee)
        -1.5490602,                          // Right foot (direction of right knee)
        -4.712389,                           // Chest (direction of pelvis)
        -4.712389,                           // Neck (direction of chest)
        -4.712389,                           // Head (direction of neck
        -1.07145,                            // Left elbow (direction of neck)
        -2.098871,                           // Right elbow (direction of neck)
        -1.4641491,                          // Left hand (direction of left elbow)
        -1.7061719));                        // Right hand (direction of right elbow)
        
    sequence.add(new StickFigure(
        50.0,                                // Size
        new PVector(104.0, 361.0),           // Pelvis position
        -1.3796121,                          // Left knee (direction of pelvis)
        -2.1401095,                          // Right knee (direction of pelvis)
        -1.200091,                           // Left foot (direction of left knee)
        -1.5382018,                          // Right foot (direction of right knee)
        -4.712389,                           // Chest (direction of pelvis)
        -4.712389,                           // Neck (direction of chest)
        -4.712389,                           // Head (direction of neck
        -1.07145,                            // Left elbow (direction of neck)
        -2.098871,                           // Right elbow (direction of neck)
        -1.4641491,                          // Left hand (direction of left elbow)
        -1.7061719));                        // Right hand (direction of right elbow)

  sequence.add(new StickFigure(
      50.0,                                // Size
      new PVector(110.0, 361.0),           // Pelvis position
      -1.4310871,                          // Left knee (direction of pelvis)
      -2.3669472,                          // Right knee (direction of pelvis)
      -1.1996619,                          // Left foot (direction of left knee)
      -1.7650394,                          // Right foot (direction of right knee)
      -4.712389,                           // Chest (direction of pelvis)
      -4.712389,                           // Neck (direction of chest)
      -4.712389,                           // Head (direction of neck
      -1.07145,                            // Left elbow (direction of neck)
      -2.098871,                           // Right elbow (direction of neck)
      -1.4641491,                          // Left hand (direction of left elbow)
      -1.7061719));                        // Right hand (direction of right elbow)

  sequence.add(new StickFigure(
      50.0,                                // Size
      new PVector(123.0, 364.0),           // Pelvis position
      -1.5316011,                          // Left knee (direction of pelvis)
      -2.3561945,                          // Right knee (direction of pelvis)
      -0.6203753,                          // Left foot (direction of left knee)
      -1.7542868,                          // Right foot (direction of right knee)
      -4.712389,                           // Chest (direction of pelvis)
      -4.712389,                           // Neck (direction of chest)
      -4.712389,                           // Head (direction of neck
      -1.07145,                            // Left elbow (direction of neck)
      -2.098871,                           // Right elbow (direction of neck)
      -1.4641491,                          // Left hand (direction of left elbow)
      -1.7061719));                        // Right hand (direction of right elbow)

    
    sequence.add(new StickFigure(
        50.0,                                // Size
        new PVector(136.0, 363.0),           // Pelvis position
        -1.7359449,                          // Left knee (direction of pelvis)
        -2.1045046,                          // Right knee (direction of pelvis)
        -0.8247191,                          // Left foot (direction of left knee)
        -1.5025969,                          // Right foot (direction of right knee)
        -4.712389,                           // Chest (direction of pelvis)
        -4.712389,                           // Neck (direction of chest)
        -4.712389,                           // Head (direction of neck
        -1.07145,                            // Left elbow (direction of neck)
        -2.098871,                           // Right elbow (direction of neck)
        -1.4641491,                          // Left hand (direction of left elbow)
        -1.7061719));                        // Right hand (direction of right elbow)

    sequence.add(new StickFigure(
        50.0,                                // Size
        new PVector(136.0, 363.0),           // Pelvis position
        -1.5554128,                          // Left knee (direction of pelvis)
        -1.9437838,                          // Right knee (direction of pelvis)
        -1.5659876,                          // Left foot (direction of left knee)
        -0.97914267,                         // Right foot (direction of right knee)
        -4.712389,                           // Chest (direction of pelvis)
        -4.712389,                           // Neck (direction of chest)
        -4.712389,                           // Head (direction of neck
        -1.07145,                            // Left elbow (direction of neck)
        -2.098871,                           // Right elbow (direction of neck)
        -1.4641491,                          // Left hand (direction of left elbow)
        -1.7061719));                        // Right hand (direction of right elbow)

    sequence.add(new StickFigure(
        50.0,                                // Size
        new PVector(147.0, 363.0),           // Pelvis position
        -2.1995926,                          // Left knee (direction of pelvis)
        -1.5565114,                          // Right knee (direction of pelvis)
        -1.3606353,                          // Left foot (direction of left knee)
        -1.3597236,                          // Right foot (direction of right knee)
        -4.712389,                           // Chest (direction of pelvis)
        -4.712389,                           // Neck (direction of chest)
        -4.712389,                           // Head (direction of neck
        -1.07145,                            // Left elbow (direction of neck)
        -2.098871,                           // Right elbow (direction of neck)
        -1.4641491,                          // Left hand (direction of left elbow)
        -1.7061719));                        // Right hand (direction of right elbow)

    sequence.add(new StickFigure(
        50.0,                                // Size
        new PVector(164.0, 364.0),           // Pelvis position
        -2.4149504,                          // Left knee (direction of pelvis)
        -1.6724854,                          // Right knee (direction of pelvis)
        -1.5759931,                          // Left foot (direction of left knee)
        -1.1943626,                          // Right foot (direction of right knee)
        -4.712389,                           // Chest (direction of pelvis)
        -4.712389,                           // Neck (direction of chest)
        -4.712389,                           // Head (direction of neck
        -1.07145,                            // Left elbow (direction of neck)
        -2.098871,                           // Right elbow (direction of neck)
        -1.4641491,                          // Left hand (direction of left elbow)
        -1.7061719));                        // Right hand (direction of right elbow)

    sequence.add(new StickFigure(
        50.0,                                // Size
        new PVector(174.0, 364.0),           // Pelvis position
        -2.2318397,                          // Left knee (direction of pelvis)
        -1.3940878,                          // Right knee (direction of pelvis)
        -1.5372262,                          // Left foot (direction of left knee)
        -0.9159651,                          // Right foot (direction of right knee)
        -4.712389,                           // Chest (direction of pelvis)
        -4.712389,                           // Neck (direction of chest)
        -4.712389,                           // Head (direction of neck
        -1.07145,                            // Left elbow (direction of neck)
        -2.098871,                           // Right elbow (direction of neck)
        -1.4641491,                          // Left hand (direction of left elbow)
        -1.7061719));                        // Right hand (direction of right elbow)

    sequence.add(new StickFigure(
        50.0,                                // Size
        new PVector(190.0, 364.0),           // Pelvis position
        -2.0899425,                          // Left knee (direction of pelvis)
        -1.570796,                           // Right knee (direction of pelvis)
        -1.5744677,                          // Left foot (direction of left knee)
        -1.0926733,                          // Right foot (direction of right knee)
        -4.712389,                           // Chest (direction of pelvis)
        -4.712389,                           // Neck (direction of chest)
        -4.712389,                           // Head (direction of neck
        -1.07145,                            // Left elbow (direction of neck)
        -2.098871,                           // Right elbow (direction of neck)
        -1.4641491,                          // Left hand (direction of left elbow)
        -1.7061719));                        // Right hand (direction of right elbow)

    // End of walk sequence
  }

};