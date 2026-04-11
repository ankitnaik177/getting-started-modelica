within Chapters;
package Chapter6 "Arrays and For Loops"

  model Resistor "Custom resistor (local copy for array examples)"
    Modelica.Electrical.Analog.Interfaces.PositivePin p annotation(
      Placement(transformation(origin = {-60, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {-100, 0}, extent = {{-10, -10}, {10, 10}}))
    );
    Modelica.Electrical.Analog.Interfaces.NegativePin n annotation(
      Placement(transformation(origin = {60, 0}, extent = {{-10, -10}, {10, 10}}), iconTransformation(origin = {100, 0}, extent = {{-10, -10}, {10, 10}}))
    );
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
          Rectangle(lineColor = {0, 114, 195}, extent = {{-100, -100}, {100, 100}}, radius = 25),
          Line(origin = {4.087, 0}, points = {{-97.22, 5}, {-54.087, 75}, {-19.087, -75}, {20.913, 75}, {58.567, -75}, {90.913, -5}})
        }
      )
    );
  end Resistor;

  model TestResistorArray "Twenty resistors in series using arrays and for loops"
    Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V = 5) annotation(
      Placement(transformation(origin = {-80, 0}, extent = {{-10, 10}, {10, -10}}, rotation = -90))
    );
    Modelica.Electrical.Analog.Basic.Ground ground annotation(
      Placement(transformation(origin = {-20, -50}, extent = {{-10, -10}, {10, 10}}))
    );
    parameter Integer numElements = 5 "Number of resistors in series";
    Resistor resistors[numElements] "Array of resistor instances" annotation(
      Placement(transformation(origin = {-10, 40}, extent = {{-10, -10}, {10, 10}}))
    );
  equation
    connect(constantVoltage.p, resistors[1].p) annotation(
      Line(origin = {-55, 28.21}, points = {{-25, -18.21}, {-25, 11.79}, {35, 11.79}}, color = {0, 0, 255})
    );
    connect(resistors[numElements].n, ground.p) annotation(
      Line(origin = {5, -7.5}, points = {{5, 47.5}, {35, 47.5}, {35, -22.5}, {-25, -22.5}, {-25, -32.5}}, color = {0, 0, 255})
    );
    connect(constantVoltage.n, ground.p) annotation(
      Line(origin = {-50, -27.5}, points = {{-30, 17.5}, {-30, -2.5}, {30, -2.5}, {30, -12.5}}, color = {0, 0, 255})
    );
    for i in 1:numElements - 1 loop
      connect(resistors[i].n, resistors[i + 1].p);
    end for;
    annotation(
      Icon(
        coordinateSystem(extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
          Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
        }
      ),
      experiment(StopTime = 1),
      Documentation(info = "<html><p>Demonstrates arrays and for loops. An array of resistors connected in series using the boundary-interior pattern. With 5 resistors of 1 Ohm each driven by 5V, current = 1A. Change numElements to 20 for 0.25A.</p></html>")
    );
  end TestResistorArray;

  package TryThis "Try This exercises for Chapter 6"

    model VariableResistances "Series chain with individual resistance values"
      Modelica.Electrical.Analog.Sources.ConstantVoltage constantVoltage(V = 5) annotation(
        Placement(transformation(origin = {-80, 0}, extent = {{-10, 10}, {10, -10}}, rotation = -90))
      );
      Modelica.Electrical.Analog.Basic.Ground ground annotation(
        Placement(transformation(origin = {-20, -50}, extent = {{-10, -10}, {10, 10}}))
      );
      parameter Integer numElements = 5 "Number of resistors";
      parameter Real resistanceValues[numElements] = {1, 1, 10, 1, 1} "Individual resistance values";
      Resistor resistors[numElements](resistance = resistanceValues) "Array with per-element resistance" annotation(
        Placement(transformation(origin = {-10, 40}, extent = {{-10, -10}, {10, 10}}))
      );
    equation
      connect(constantVoltage.p, resistors[1].p) annotation(
        Line(origin = {-55, 28.21}, points = {{-25, -18.21}, {-25, 11.79}, {35, 11.79}}, color = {0, 0, 255})
      );
      connect(resistors[numElements].n, ground.p) annotation(
        Line(origin = {5, -7.5}, points = {{5, 47.5}, {35, 47.5}, {35, -22.5}, {-25, -22.5}, {-25, -32.5}}, color = {0, 0, 255})
      );
      connect(constantVoltage.n, ground.p) annotation(
        Line(origin = {-50, -27.5}, points = {{-30, 17.5}, {-30, -2.5}, {30, -2.5}, {30, -12.5}}, color = {0, 0, 255})
      );
      for i in 1:numElements - 1 loop
        connect(resistors[i].n, resistors[i + 1].p);
      end for;
      annotation(
        Icon(
          coordinateSystem(extent = {{-100, -100}, {100, 100}}),
          graphics = {
            Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
            Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
          }
        ),
        experiment(StopTime = 1),
        Documentation(info = "<html><p>Try This: Series chain with individual resistances {1,1,10,1,1}. Total R=14 Ohm, I=5/14 A. The middle resistor (10 Ohm) shows a proportionally larger voltage drop: V3 = 10 * (5/14) = 3.57V.</p></html>")
      );
    end VariableResistances;

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
    Documentation(info = "<html><p>Chapter 6: Arrays and For Loops. Covers array declarations, for loops in equation vs algorithm sections, the boundary-interior pattern, and structural parameters.</p></html>")
  );
end Chapter6;
