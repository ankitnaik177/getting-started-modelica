within Chapters;
package Chapter3 "Causal vs. Acausal Modeling"

  model MassSpringCausal "Causal (signal-flow) mass-spring-damper"
    Modelica.Blocks.Math.Add summer(k1 = -1, k2 = -1) "Sum spring and damping forces";
    Modelica.Blocks.Math.Gain massInverse(k = 1) "1/M gain (M=1 kg)";
    Modelica.Blocks.Math.Gain damping(k = 1) "Damping coefficient d";
    Modelica.Blocks.Math.Gain stiffness(k = 1) "Spring stiffness c";
    Modelica.Blocks.Continuous.TransferFunction velocity(b = {0, 1}, a = {1, 0}) "Integrator for velocity";
    Modelica.Blocks.Continuous.TransferFunction distance(b = {0, 1}, a = {1, 0}, initType = Modelica.Blocks.Types.Init.InitialState, x_start = {0.05}) "Integrator for displacement";
  equation
    connect(summer.y, massInverse.u);
    connect(massInverse.y, velocity.u);
    connect(velocity.y, distance.u);
    connect(distance.y, stiffness.u);
    connect(velocity.y, damping.u);
    connect(stiffness.y, summer.u1);
    connect(damping.y, summer.u2);
    annotation(
      Icon(
        coordinateSystem(extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
          Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
        }
      ),
      experiment(StopTime = 20),
      Documentation(info = "<html><p>Causal block-diagram implementation of a mass-spring-damper. The governing equation is rearranged to compute acceleration from displacement and velocity via feedback loops.</p></html>")
    );
  end MassSpringCausal;

  model MassSpringAcausal "Acausal (physical) mass-spring-damper"
    Modelica.Mechanics.Translational.Components.Fixed wall;
    Modelica.Mechanics.Translational.Components.SpringDamper springDamper(c = 100, d = 2, s_rel0 = 0);
    Modelica.Mechanics.Translational.Components.Mass mass(m = 1, s(start = 0.05, fixed = true));
  equation
    connect(wall.flange, springDamper.flange_a);
    connect(springDamper.flange_b, mass.flange_a);
    annotation(
      Icon(
        coordinateSystem(extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
          Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
        }
      ),
      experiment(StopTime = 20),
      Documentation(info = "<html><p>Acausal implementation of the same mass-spring-damper. Three components, two connections. The compiler determines causality automatically.</p></html>")
    );
  end MassSpringAcausal;

  model AcausalFlipped "Acausal model with SpringDamper flipped 180 degrees"
    Modelica.Mechanics.Translational.Components.Fixed wall;
    Modelica.Mechanics.Translational.Components.SpringDamper springDamper(c = 100, d = 2, s_rel0 = 0);
    Modelica.Mechanics.Translational.Components.Mass mass(m = 1, s(start = 0.05, fixed = true));
  equation
    connect(wall.flange, springDamper.flange_b);
    connect(springDamper.flange_a, mass.flange_a);
    annotation(
      Icon(
        coordinateSystem(extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
          Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
        }
      ),
      experiment(StopTime = 20),
      Documentation(info = "<html><p>The flip test: SpringDamper rotated 180 degrees. The result is identical to MassSpringAcausal, demonstrating that orientation is visual only in acausal models.</p></html>")
    );
  end AcausalFlipped;

  package TryThis "Try This exercises for Chapter 3"

    model DampingVariation_Undamped "d = 0 (undamped)"
      Modelica.Mechanics.Translational.Components.Fixed wall;
      Modelica.Mechanics.Translational.Components.SpringDamper springDamper(c = 100, d = 0, s_rel0 = 0);
      Modelica.Mechanics.Translational.Components.Mass mass(m = 1, s(start = 0.05, fixed = true));
    equation
      connect(wall.flange, springDamper.flange_a);
      connect(springDamper.flange_b, mass.flange_a);
      annotation(
        Icon(
          coordinateSystem(extent = {{-100, -100}, {100, 100}}),
          graphics = {
            Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
            Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
          }
        ),
        experiment(StopTime = 20)
      );
    end DampingVariation_Undamped;

    model DampingVariation_Underdamped "d = 0.5 (underdamped)"
      Modelica.Mechanics.Translational.Components.Fixed wall;
      Modelica.Mechanics.Translational.Components.SpringDamper springDamper(c = 100, d = 0.5, s_rel0 = 0);
      Modelica.Mechanics.Translational.Components.Mass mass(m = 1, s(start = 0.05, fixed = true));
    equation
      connect(wall.flange, springDamper.flange_a);
      connect(springDamper.flange_b, mass.flange_a);
      annotation(
        Icon(
          coordinateSystem(extent = {{-100, -100}, {100, 100}}),
          graphics = {
            Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
            Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
          }
        ),
        experiment(StopTime = 20)
      );
    end DampingVariation_Underdamped;

    model DampingVariation_CriticallyDamped "d = 2 (approximately critically damped)"
      Modelica.Mechanics.Translational.Components.Fixed wall;
      Modelica.Mechanics.Translational.Components.SpringDamper springDamper(c = 100, d = 2, s_rel0 = 0);
      Modelica.Mechanics.Translational.Components.Mass mass(m = 1, s(start = 0.05, fixed = true));
    equation
      connect(wall.flange, springDamper.flange_a);
      connect(springDamper.flange_b, mass.flange_a);
      annotation(
        Icon(
          coordinateSystem(extent = {{-100, -100}, {100, 100}}),
          graphics = {
            Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
            Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
          }
        ),
        experiment(StopTime = 20)
      );
    end DampingVariation_CriticallyDamped;

    model DampingVariation_Overdamped "d = 5 (overdamped)"
      Modelica.Mechanics.Translational.Components.Fixed wall;
      Modelica.Mechanics.Translational.Components.SpringDamper springDamper(c = 100, d = 5, s_rel0 = 0);
      Modelica.Mechanics.Translational.Components.Mass mass(m = 1, s(start = 0.05, fixed = true));
    equation
      connect(wall.flange, springDamper.flange_a);
      connect(springDamper.flange_b, mass.flange_a);
      annotation(
        Icon(
          coordinateSystem(extent = {{-100, -100}, {100, 100}}),
          graphics = {
            Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
            Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
          }
        ),
        experiment(StopTime = 20)
      );
    end DampingVariation_Overdamped;

    annotation(
      Icon(
        coordinateSystem(extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Polygon(origin = {0.248, 0.044}, lineColor = {56, 56, 56}, fillColor = {128, 202, 255}, fillPattern = FillPattern.Solid, points = {{99.752, 100}, {99.752, 59.956}, {99.752, -50}, {100, -100}, {49.752, -100}, {-19.752, -100.044}, {-100.248, -100}, {-100.248, -50}, {-90.248, 29.956}, {-90.248, 79.956}, {-40.248, 79.956}, {-20.138, 79.813}, {-0.248, 79.956}, {19.752, 99.956}, {39.752, 99.956}, {59.752, 99.956}}, smooth = Smooth.Bezier),
          Polygon(origin = {0, -13.079}, lineColor = {192, 192, 192}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.HorizontalCylinder, points = {{100, -86.921}, {50, -86.921}, {-50, -86.921}, {-100, -86.921}, {-100, -36.921}, {-100, 53.079}, {-100, 103.079}, {-50, 103.079}, {0, 103.079}, {20, 83.079}, {50, 83.079}, {100, 83.079}, {100, 33.079}, {100, -36.921}}, smooth = Smooth.Bezier),
          Polygon(origin = {0, -10.704}, lineColor = {113, 113, 113}, fillColor = {255, 255, 255}, points = {{100, -89.296}, {50, -89.296}, {-50, -89.296}, {-100, -89.296}, {-100, -39.296}, {-100, 50.704}, {-100, 100.704}, {-50, 100.704}, {0, 100.704}, {20, 80.704}, {50, 80.704}, {100, 80.704}, {100, 30.704}, {100, -39.296}}, smooth = Smooth.Bezier)
        }
      )
    );
  end TryThis;

  annotation(
    Icon(
      coordinateSystem(extent = {{-100, -100}, {100, 100}}),
      graphics = {
        Polygon(origin = {0.248, 0.044}, lineColor = {56, 56, 56}, fillColor = {128, 202, 255}, fillPattern = FillPattern.Solid, points = {{99.752, 100}, {99.752, 59.956}, {99.752, -50}, {100, -100}, {49.752, -100}, {-19.752, -100.044}, {-100.248, -100}, {-100.248, -50}, {-90.248, 29.956}, {-90.248, 79.956}, {-40.248, 79.956}, {-20.138, 79.813}, {-0.248, 79.956}, {19.752, 99.956}, {39.752, 99.956}, {59.752, 99.956}}, smooth = Smooth.Bezier),
        Polygon(origin = {0, -13.079}, lineColor = {192, 192, 192}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.HorizontalCylinder, points = {{100, -86.921}, {50, -86.921}, {-50, -86.921}, {-100, -86.921}, {-100, -36.921}, {-100, 53.079}, {-100, 103.079}, {-50, 103.079}, {0, 103.079}, {20, 83.079}, {50, 83.079}, {100, 83.079}, {100, 33.079}, {100, -36.921}}, smooth = Smooth.Bezier),
        Polygon(origin = {0, -10.704}, lineColor = {113, 113, 113}, fillColor = {255, 255, 255}, points = {{100, -89.296}, {50, -89.296}, {-50, -89.296}, {-100, -89.296}, {-100, -39.296}, {-100, 50.704}, {-100, 100.704}, {-50, 100.704}, {0, 100.704}, {20, 80.704}, {50, 80.704}, {100, 80.704}, {100, 30.704}, {100, -39.296}}, smooth = Smooth.Bezier)
      }
    ),
    Documentation(info = "<html><p>Chapter 3: Causal vs. Acausal Modeling. Builds the same mass-spring-damper system two ways to compare signal-flow and physical modeling approaches. Introduces connectors and conservation laws.</p></html>")
  );
end Chapter3;
