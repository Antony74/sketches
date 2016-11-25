
class Poses {
  ArrayList<StickFigure> walk = new ArrayList<StickFigure>();
  ArrayList<StickFigure> walkShort = new ArrayList<StickFigure>();
  ArrayList<StickFigure> lift = new ArrayList<StickFigure>();
  
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
        -0.7266761,                          // Left foot (direction of left knee)
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

    // Use the same walk sequence for the shorter figure
    for (int n = 0; n < walk.size(); ++n) {
      StickFigure fig = walk.get(n).copy();
      fig.setSize(40);
      walkShort.add(fig);
    }

    // Lift sequence

    sequence = lift;

    sequence.add(new StickFigure(
        40.0,                                // Size
        new PVector(360.0, 368.0),           // Pelvis position
        -1.5195594,                          // Left knee (direction of pelvis)
        -2.024135,                           // Right knee (direction of pelvis)
        -1.4645538,                          // Left foot (direction of left knee)
        -1.6416645,                          // Right foot (direction of right knee)
        -4.712389,                           // Chest (direction of pelvis)
        -4.712389,                           // Neck (direction of chest)
        -4.712389,                           // Head (direction of neck
        -1.07145,                            // Left elbow (direction of neck)
        -2.098871,                           // Right elbow (direction of neck)
        -1.4641491,                          // Left hand (direction of left elbow)
        -1.7061719));                        // Right hand (direction of right elbow)
    
    sequence.add(new StickFigure(
        40.0,                                // Size
        new PVector(360.0, 364.0),           // Pelvis position
        -1.1547322,                          // Left knee (direction of pelvis)
        -1.8281202,                          // Right knee (direction of pelvis)
        -1.3480434,                          // Left foot (direction of left knee)
        -1.8847771,                          // Right foot (direction of right knee)
        -4.782044,                           // Chest (direction of pelvis)
        -4.782044,                           // Neck (direction of chest)
        -4.782044,                           // Head (direction of neck
        -1.1411049,                          // Left elbow (direction of neck)
        -2.168526,                           // Right elbow (direction of neck)
        -1.533804,                           // Left hand (direction of left elbow)
        -1.7758268));                        // Right hand (direction of right elbow)

    sequence.add(new StickFigure(
        40.0,                                // Size
        new PVector(356.0, 378.0),           // Pelvis position
        -0.9318824,                          // Left knee (direction of pelvis)
        -1.951303,                           // Right knee (direction of pelvis)
        -1.3275571,                          // Left foot (direction of left knee)
        -2.1932058,                          // Right foot (direction of right knee)
        -4.9371,                             // Chest (direction of pelvis)
        -4.9371,                             // Neck (direction of chest)
        -4.9371,                             // Head (direction of neck
        -1.1726749,                          // Left elbow (direction of neck)
        -2.0587656,                          // Right elbow (direction of neck)
        -1.565374,                           // Left hand (direction of left elbow)
        -1.6660665));                        // Right hand (direction of right elbow)

    sequence.add(new StickFigure(
        40.0,                                // Size
        new PVector(354.0, 391.0),           // Pelvis position
        -0.6340227,                          // Left knee (direction of pelvis)
        -2.082027,                           // Right knee (direction of pelvis)
        -1.3437419,                          // Left foot (direction of left knee)
        -2.4674277,                          // Right foot (direction of right knee)
        -4.9371,                             // Chest (direction of pelvis)
        -4.9371,                             // Neck (direction of chest)
        -4.9371,                             // Head (direction of neck
        -0.9674952,                          // Left elbow (direction of neck)
        -1.7393539,                          // Right elbow (direction of neck)
        -1.6387225,                          // Left hand (direction of left elbow)
        -1.1848625));                        // Right hand (direction of right elbow)
    
    sequence.add(new StickFigure(
        40.0,                                // Size
        new PVector(347.0, 403.0),           // Pelvis position
        -0.46364784,                         // Left knee (direction of pelvis)
        -2.1527019,                          // Right knee (direction of pelvis)
        -1.4168835,                          // Left foot (direction of left knee)
        -2.710081,                           // Right foot (direction of right knee)
        -5.120538,                           // Chest (direction of pelvis)
        -5.120538,                           // Neck (direction of chest)
        -5.120538,                           // Head (direction of neck
        -1.1509335,                          // Left elbow (direction of neck)
        -1.9227922,                          // Right elbow (direction of neck)
        -1.8221608,                          // Left hand (direction of left elbow)
        -1.3683008));                        // Right hand (direction of right elbow)

    // End of lift sequence

  }


};