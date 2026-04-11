within Chapters;
package Chapter9 "Records and Replaceable Components"

  record TurbineData "Base record for wind turbine parameters"
    parameter Real area "Rotor swept area (m2)";
    parameter Real efficiency "Aerodynamic efficiency (-)";
  end TurbineData;

  record Turbine1 "First turbine variant"
    extends TurbineData(area = 3, efficiency = 0.6);
  end Turbine1;

  record Turbine2 "Second turbine variant"
    extends TurbineData(area = 5, efficiency = 0.5);
  end Turbine2;

  model WindTurbine "Wind turbine model using a record for parameters"
    replaceable Turbine1 data constrainedby TurbineData "Turbine data record";
    parameter Real airDensity = 1.225 "Air density (kg/m3)";
    Modelica.Blocks.Interfaces.RealInput v "Wind speed (m/s)";
    Modelica.Blocks.Interfaces.RealOutput power "Generated power (W)";
  equation
    power = 0.5 * airDensity * data.area * v ^ 3 * data.efficiency;
    annotation(
      Icon(
        coordinateSystem(extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
          Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
        }
      ),
      Documentation(info = "<html><p>Wind turbine model using a replaceable record for parameter management. The data record can be swapped between Turbine1, Turbine2, etc. without changing the model equations.</p></html>")
    );
  end WindTurbine;

  partial model FrictionBase "Base interface for all friction models"
    Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a;
    Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b;
    Modelica.Units.SI.Torque tau "Friction torque";
    Modelica.Units.SI.AngularVelocity w;
  equation
    w = der(flange_a.phi);
    flange_a.phi = flange_b.phi;
    flange_a.tau + flange_b.tau + tau = 0;
    annotation(
      Icon(
        coordinateSystem(extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
          Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
        }
      ),
      Documentation(info = "<html><p>Partial model defining the interface every friction variant must satisfy. Declares connectors, angular velocity, and torque balance. Does not specify how tau is calculated.</p></html>")
    );
  end FrictionBase;

  model CoulombFriction "Coulomb (dry) friction"
    extends FrictionBase;
    parameter Real mu = 0.1 "Friction coefficient";
  equation
    tau = -mu * sign(w);
    annotation(
      Icon(
        coordinateSystem(extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
          Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
        }
      ),
      Documentation(info = "<html><p>Constant friction torque opposing motion. tau = -mu * sign(w).</p></html>")
    );
  end CoulombFriction;

  model ViscousFriction "Viscous (linear) friction"
    extends FrictionBase;
    parameter Real d = 0.5 "Viscous damping coefficient (N.m.s/rad)";
  equation
    tau = -d * w;
    annotation(
      Icon(
        coordinateSystem(extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
          Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
        }
      ),
      Documentation(info = "<html><p>Friction torque proportional to velocity. tau = -d * w.</p></html>")
    );
  end ViscousFriction;

  model NoFriction "Ideal frictionless model"
    extends FrictionBase;
  equation
    tau = 0;
    annotation(
      Icon(
        coordinateSystem(extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
          Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
        }
      ),
      Documentation(info = "<html><p>No friction at all. tau = 0. For idealized analysis.</p></html>")
    );
  end NoFriction;

  model Shaft "Rotational shaft with replaceable friction"
    Modelica.Mechanics.Rotational.Interfaces.Flange_a flange_a;
    Modelica.Mechanics.Rotational.Interfaces.Flange_b flange_b;
    replaceable CoulombFriction friction constrainedby FrictionBase "Replaceable friction model";
    Modelica.Mechanics.Rotational.Components.Inertia inertia(J = 1);
  equation
    connect(inertia.flange_a, flange_a);
    connect(inertia.flange_b, friction.flange_a);
    connect(friction.flange_b, flange_b);
    annotation(
      Icon(
        coordinateSystem(extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
          Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
        }
      ),
      Documentation(info = "<html><p>Shaft model with a replaceable friction slot. Default is CoulombFriction. Users can redeclare to ViscousFriction, NoFriction, or any model extending FrictionBase.</p></html>")
    );
  end Shaft;

  package TryThis "Try This exercises for Chapter 9"

    model TestShaft "Test the Shaft model with a torque step"
      Shaft shaft;
      Modelica.Mechanics.Rotational.Sources.ConstantTorque constantTorque(tau_constant = 1);
      Modelica.Mechanics.Rotational.Components.Fixed fixed;
    equation
      connect(constantTorque.flange, shaft.flange_a);
      connect(shaft.flange_b, fixed.flange);
      annotation(
        Icon(
          coordinateSystem(extent = {{-100, -100}, {100, 100}}),
          graphics = {
            Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
            Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
          }
        ),
        experiment(StopTime = 10),
        Documentation(info = "<html><p>Try This: Apply 1 N.m constant torque to the shaft. Simulate with CoulombFriction (default), then redeclare to ViscousFriction and NoFriction. Overlay angular velocity curves. NoFriction reaches highest velocity; ViscousFriction has smoothest acceleration curve.</p></html>")
      );
    end TestShaft;

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
    Documentation(info = "<html><p>Chapter 9: Records and Replaceable Components. Covers records for structured parameter containers, replaceable components for swappable implementations, constrainedby for type safety, and the friction shaft example.</p></html>")
  );
end Chapter9;
