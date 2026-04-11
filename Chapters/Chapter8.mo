within Chapters;
package Chapter8 "Inheritance and Partial Models"

  model Resistor "Custom resistor (base for inheritance examples)"
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
      )
    );
  end Resistor;

  package TryThis "Try This exercises for Chapter 8"

    model ResistorWithPowerMeter "Resistor extended with power measurement"
      extends Chapter8.Resistor;
      Modelica.Units.SI.Power P "Power dissipated (W)";
      Modelica.Blocks.Interfaces.RealOutput P_out "Power dissipated as signal output";
    equation
      P = v * i;
      P_out = P;
      annotation(
        Icon(
          coordinateSystem(extent = {{-100, -100}, {100, 100}}),
          graphics = {
            Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
            Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
          }
        ),
        Documentation(info = "<html><p>Try This: Extends the base Resistor and adds power measurement. P = v*i is computed from inherited variables. The extends statement inherits all pins, variables, and equations.</p></html>")
      );
    end ResistorWithPowerMeter;

    model TestResistorWithPowerMeter "Test the extended resistor"
      ResistorWithPowerMeter resistor(resistance = 1);
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
        Documentation(info = "<html><p>Try This: 5V across 1 Ohm ResistorWithPowerMeter. Expect P=25W (V^2/R = 25/1). Change resistance to 2.0 via extends modifier and P updates to 12.5W.</p></html>")
      );
    end TestResistorWithPowerMeter;

    model ResistorWithPowerMeter2Ohm "ResistorWithPowerMeter with 2 Ohm resistance via modifier"
      extends Chapter8.Resistor(resistance = 2.0);
      Modelica.Units.SI.Power P "Power dissipated (W)";
      Modelica.Blocks.Interfaces.RealOutput P_out "Power dissipated as signal output";
    equation
      P = v * i;
      P_out = P;
      annotation(
        Icon(
          coordinateSystem(extent = {{-100, -100}, {100, 100}}),
          graphics = {
            Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
            Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
          }
        ),
        Documentation(info = "<html><p>Try This: Same as ResistorWithPowerMeter but with resistance overridden to 2 Ohm via extends modifier. P = 12.5W (25/2).</p></html>")
      );
    end ResistorWithPowerMeter2Ohm;

    model TestResistorWithPowerMeter2Ohm "Test the 2 Ohm variant"
      ResistorWithPowerMeter2Ohm resistor;
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
        Documentation(info = "<html><p>Try This: 5V across 2 Ohm resistor. P = 12.5W, demonstrating that the equation P=v*i needed no changes when resistance was modified via extends.</p></html>")
      );
    end TestResistorWithPowerMeter2Ohm;

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
    Documentation(info = "<html><p>Chapter 8: Inheritance and Partial Models. Covers extends, multiple inheritance, modifiers, partial models, and reading the MSL inheritance hierarchy.</p></html>")
  );
end Chapter8;
