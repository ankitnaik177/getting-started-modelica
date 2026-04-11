within Chapters;
package Chapter1 "Why Modelica? - Introductory RC Circuit Example"

  model RC "Simple RC circuit from Chapter 1"
    Modelica.Electrical.Analog.Basic.Resistor resistor(R = 10) annotation(
      Placement(transformation(origin = {0, 40}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Basic.Capacitor capacitor(C = 0.001) annotation(
      Placement(transformation(origin = {40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -90)));
    Modelica.Electrical.Analog.Basic.Ground ground annotation(
      Placement(transformation(origin = {0, -60}, extent = {{-10, -10}, {10, 10}})));
    Modelica.Electrical.Analog.Sources.ConstantVoltage EMF(V = 5) annotation(
      Placement(transformation(origin = {-40, 0}, extent = {{-10, -10}, {10, 10}}, rotation = -270)));
  equation
    connect(EMF.n, resistor.p) annotation(
      Line(origin = {-30, 30}, points = {{-10, -20}, {-10, 10}, {20, 10}}, color = {0, 0, 255}));
    connect(resistor.n, capacitor.p) annotation(
      Line(origin = {30, 30}, points = {{-20, 10}, {10, 10}, {10, -20}}, color = {0, 0, 255}));
    connect(capacitor.n, ground.p) annotation(
      Line(origin = {20, -27.5}, points = {{20, 17.5}, {20, -12.5}, {-20, -12.5}, {-20, -22.5}}, color = {0, 0, 255}));
    connect(EMF.p, ground.p) annotation(
      Line(origin = {-20, -27.5}, points = {{-20, 17.5}, {-20, -12.5}, {20, -12.5}, {20, -22.5}}, color = {0, 0, 255}));
    annotation(
      Icon(
        coordinateSystem(extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
          Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
        }
      ),
      experiment(StopTime = 0.05),
      Diagram(coordinateSystem(extent = {{-150, -90}, {150, 90}})),
      Documentation(info = "<html><p>Simple RC circuit introduced in Chapter 1 to illustrate what a Modelica model looks like. A 5V source charges a 0.001F capacitor through a 10 Ohm resistor.</p></html>")
    );
  end RC;

  annotation(
    Icon(
      coordinateSystem(extent = {{-100, -100}, {100, 100}}),
      graphics = {
        Polygon(origin = {0.248, 0.044}, lineColor = {56, 56, 56}, fillColor = {128, 202, 255}, fillPattern = FillPattern.Solid, points = {{99.752, 100}, {99.752, 59.956}, {99.752, -50}, {100, -100}, {49.752, -100}, {-19.752, -100.044}, {-100.248, -100}, {-100.248, -50}, {-90.248, 29.956}, {-90.248, 79.956}, {-40.248, 79.956}, {-20.138, 79.813}, {-0.248, 79.956}, {19.752, 99.956}, {39.752, 99.956}, {59.752, 99.956}}, smooth = Smooth.Bezier),
        Polygon(origin = {0, -13.079}, lineColor = {192, 192, 192}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.HorizontalCylinder, points = {{100, -86.921}, {50, -86.921}, {-50, -86.921}, {-100, -86.921}, {-100, -36.921}, {-100, 53.079}, {-100, 103.079}, {-50, 103.079}, {0, 103.079}, {20, 83.079}, {50, 83.079}, {100, 83.079}, {100, 33.079}, {100, -36.921}}, smooth = Smooth.Bezier),
        Polygon(origin = {0, -10.704}, lineColor = {113, 113, 113}, fillColor = {255, 255, 255}, points = {{100, -89.296}, {50, -89.296}, {-50, -89.296}, {-100, -89.296}, {-100, -39.296}, {-100, 50.704}, {-100, 100.704}, {-50, 100.704}, {0, 100.704}, {20, 80.704}, {50, 80.704}, {100, 80.704}, {100, 30.704}, {100, -39.296}}, smooth = Smooth.Bezier)
      }
    ),
    Documentation(info = "<html><p>Chapter 1: Why Modelica? This chapter is primarily conceptual, introducing equation-based, acausal, multi-domain modeling. The RC model is the only code example shown.</p></html>")
  );
end Chapter1;
