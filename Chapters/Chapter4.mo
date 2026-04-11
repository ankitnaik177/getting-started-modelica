within Chapters;
package Chapter4 "Writing Your First Textual Model"

  model HelloWorld "Simplest Modelica model: x = sin(time)"
    Real x;
  equation
    x = sin(time);
    annotation(
      Icon(
        coordinateSystem(extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
          Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
        }
      ),
      experiment(StopTime = 10),
      Documentation(info = "<html><p>The simplest Modelica model. One variable, one equation. Demonstrates the equation section, the = sign as equality (not assignment), and the built-in time variable.</p></html>")
    );
  end HelloWorld;

  model HelloWorldDer "Linear ramp using der() operator"
    Real x;
  equation
    der(x) = 1;
    annotation(
      Icon(
        coordinateSystem(extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
          Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
        }
      ),
      experiment(StopTime = 10),
      Documentation(info = "<html><p>Demonstrates the der() operator. x increases at a constant rate of 1, starting from the default initial value of 0.</p></html>")
    );
  end HelloWorldDer;

  model HelloWorldInitial "der(x)=1 with initial equation"
    Real x;
  initial equation
    x = 1;
  equation
    der(x) = 1;
    annotation(
      Icon(
        coordinateSystem(extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
          Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
        }
      ),
      experiment(StopTime = 10),
      Documentation(info = "<html><p>Demonstrates the initial equation section. x starts at 1 and increases linearly.</p></html>")
    );
  end HelloWorldInitial;

  model HelloWorldStartFixed "der(x)=1 with start/fixed attribute"
    Real x(start = 1, fixed = true);
  equation
    der(x) = 1;
    annotation(
      Icon(
        coordinateSystem(extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
          Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
        }
      ),
      experiment(StopTime = 10),
      Documentation(info = "<html><p>Equivalent to HelloWorldInitial but using start and fixed=true attributes on the variable declaration.</p></html>")
    );
  end HelloWorldStartFixed;

  block SpeedToPower "Wind speed to available power (causal block)"
    Modelica.Blocks.Interfaces.RealInput speed;
    Modelica.Blocks.Interfaces.RealOutput power;
    parameter Real airDensity(unit = "kg/m3") = 1.225 "Density of air at standard conditions";
    parameter Real rotorArea(unit = "m2") = 1.0 "Swept area of the rotor blades";
  protected
    Real speedMagnitude;
  algorithm
    speedMagnitude := abs(speed);
    power := 0.5 * airDensity * rotorArea * speedMagnitude ^ 3;
    annotation(
      Icon(
        coordinateSystem(extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
          Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
        }
      ),
      Documentation(info = "<html><p>Causal block that computes available wind power from wind speed using P = 0.5 * rho * A * |v|^3. Uses the algorithm section with := assignment and a protected intermediate variable.</p></html>")
    );
  end SpeedToPower;

  model TestBlock "Test model for SpeedToPower block"
    SpeedToPower speedToPower;
    Modelica.Blocks.Sources.Sine sine(amplitude = 1, f = 1);
  equation
    connect(sine.y, speedToPower.speed);
    annotation(
      Icon(
        coordinateSystem(extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
          Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
        }
      ),
      experiment(StopTime = 5),
      Documentation(info = "<html><p>Drives SpeedToPower with a 1 Hz sine wave. Speed oscillates positive/negative; power is always positive due to abs() and the cube relationship.</p></html>")
    );
  end TestBlock;

  model Resistor "Custom resistor with two pins and Ohm's law"
    Modelica.Electrical.Analog.Interfaces.PositivePin p;
    Modelica.Electrical.Analog.Interfaces.NegativePin n;
    Real i "Current through the resistor (A)";
    Real v "Voltage drop across the resistor (V)";
    parameter Real resistance(unit = "Ohm") = 1.0 "Resistance value";
  equation
    p.i + n.i = 0;
    i = p.i;
    v = p.v - n.v;
    v = resistance * i;
    annotation(
      Icon(
        coordinateSystem(extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
          Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
        }
      ),
      Documentation(info = "<html><p>A resistor built from scratch. Two pins, KCL, voltage/current definitions, and Ohm's law. Four equations for the complete two-terminal component.</p></html>")
    );
  end Resistor;

  model TestResistor "Test circuit for the custom Resistor"
    Resistor resistor(resistance = 1);
    Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V = 5);
    Modelica.Electrical.Analog.Basic.Ground ground;
  equation
    connect(constantVoltage.p, resistor.p);
    connect(resistor.n, constantVoltage.n);
    connect(constantVoltage.n, ground.p);
    annotation(
      Icon(
        coordinateSystem(extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
          Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
        }
      ),
      experiment(StopTime = 1),
      Documentation(info = "<html><p>5V source across a 1 Ohm resistor. Expect 5A current and 5V drop. Verifies Ohm's law.</p></html>")
    );
  end TestResistor;

  model ResistorWithHeat "Resistor with thermal port for heat dissipation"
    Modelica.Electrical.Analog.Interfaces.PositivePin p;
    Modelica.Electrical.Analog.Interfaces.NegativePin n;
    Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort;
    parameter Real resistance(unit = "Ohm") = 1.0 "Resistance value";
    Real i "Current through the resistor (A)";
    Real v "Voltage drop across the resistor (V)";
  equation
    p.i + n.i = 0;
    i = p.i;
    v = p.v - n.v;
    v = resistance * i;
    heatPort.Q_flow = -(v * i);
    annotation(
      Icon(
        coordinateSystem(extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
          Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
        }
      ),
      Documentation(info = "<html><p>Multi-domain resistor: electrical behavior identical to Resistor, plus a thermal port. The coupling equation heatPort.Q_flow = -(v*i) connects electrical dissipation to heat output.</p></html>")
    );
  end ResistorWithHeat;

  model TestResistorWithHeat "Test circuit for ResistorWithHeat"
    ResistorWithHeat resistorWithHeat(resistance = 1);
    Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V = 5);
    Modelica.Electrical.Analog.Basic.Ground ground;
    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C = 10, T(start = 293.15, fixed = true));
  equation
    connect(constantVoltage.p, resistorWithHeat.p);
    connect(resistorWithHeat.n, constantVoltage.n);
    connect(constantVoltage.n, ground.p);
    connect(resistorWithHeat.heatPort, heatCapacitor.port);
    annotation(
      Icon(
        coordinateSystem(extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
          Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
        }
      ),
      experiment(StopTime = 60),
      Documentation(info = "<html><p>5V across 1 Ohm ResistorWithHeat connected to a 10 J/K heat capacitor. Electrical: constant 5A. Thermal: temperature rises linearly at 25W / 10 J/K = 2.5 K/s.</p></html>")
    );
  end TestResistorWithHeat;

  package TryThis "Try This exercises for Chapter 4"

    model Capacitor "Custom capacitor built from scratch"
      Modelica.Electrical.Analog.Interfaces.PositivePin p;
      Modelica.Electrical.Analog.Interfaces.NegativePin n;
      Real i "Current through the capacitor (A)";
      Real v "Voltage across the capacitor (V)";
      parameter Real capacitance(unit = "F") = 0.001 "Capacitance value";
    equation
      p.i + n.i = 0;
      i = p.i;
      v = p.v - n.v;
      i = capacitance * der(v);
      annotation(
        Icon(
          coordinateSystem(extent = {{-100, -100}, {100, 100}}),
          graphics = {
            Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
            Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
          }
        ),
        Documentation(info = "<html><p>Try This: A capacitor built from scratch using the Resistor as a template. Same structure (two pins, KCL, variable definitions) but with i = C * der(v) instead of Ohm's law.</p></html>")
      );
    end Capacitor;

    model TestRC "RC circuit using custom Resistor and Capacitor"
      Chapter4.Resistor resistor(resistance = 1);
      Capacitor capacitor(capacitance = 0.001);
      Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V = 5);
      Modelica.Electrical.Analog.Basic.Ground ground;
    equation
      connect(constantVoltage.p, resistor.p);
      connect(resistor.n, capacitor.p);
      connect(capacitor.n, ground.p);
      connect(constantVoltage.n, ground.p);
      annotation(
        Icon(
          coordinateSystem(extent = {{-100, -100}, {100, 100}}),
          graphics = {
            Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
            Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
          }
        ),
        experiment(StopTime = 0.05),
        Documentation(info = "<html><p>Try This: RC circuit with R=1 Ohm, C=0.001 F, 5V source. Time constant tau = RC = 0.001 s. Capacitor voltage rises exponentially toward 5V. At t=0.001s, voltage should be ~63% of 5V (about 3.15V).</p></html>")
      );
    end TestRC;

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
    Documentation(info = "<html><p>Chapter 4: Writing Your First Textual Model. Covers model structure, variable declarations, equation vs algorithm sections, der(), initial conditions, building causal blocks and acausal components, multi-domain coupling, and the class hierarchy.</p></html>")
  );
end Chapter4;
