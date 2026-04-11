within Chapters;
package Chapter12 "How Modelica Solves Equations"

  model ThermalSystem "Three capacitors with direct coupling (creates coupled block)"
    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor cap(C = 100);
    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor cap1(C = 10);
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor cond1(G = 1);
    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor cap2(C = 10);
  equation
    connect(cap1.port, cond1.port_a);
    connect(cap.port, cond1.port_b);
    connect(cap1.port, cap2.port);
    annotation(
      Icon(
        coordinateSystem(extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
          Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
        }
      ),
      experiment(StopTime = 200),
      Documentation(info = "<html><p>Thermal system where cap1 and cap2 share a port directly, creating an instantaneous coupling visible as a blue block in the equation browser.</p></html>")
    );
  end ThermalSystem;

  model ThermalSystemFixed "Fixed version: conductor inserted between cap1 and cap2"
    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor cap(C = 100);
    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor cap1(C = 10);
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor cond1(G = 1);
    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor cap2(C = 10);
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor cond2(G = 1) "Breaks the direct coupling";
  equation
    connect(cap1.port, cond1.port_a);
    connect(cap.port, cond1.port_b);
    connect(cap1.port, cond2.port_b);
    connect(cond2.port_a, cap2.port);
    annotation(
      Icon(
        coordinateSystem(extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
          Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
        }
      ),
      experiment(StopTime = 200),
      Documentation(info = "<html><p>Fixed version: a ThermalConductor (cond2) inserted between cap1 and cap2 breaks the direct coupling. The equation browser should show all green single-equation blocks.</p></html>")
    );
  end ThermalSystemFixed;

  package TryThis "Try This exercises for Chapter 12"

    model ThermalLoopSimple "Simple thermal model for equation browser exploration"
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor cap(C = 100);
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor cond(G = 1);
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambient(T = 293.15);
    equation
      connect(cap.port, cond.port_a);
      connect(cond.port_b, ambient.port);
      annotation(
        Icon(
          coordinateSystem(extent = {{-100, -100}, {100, 100}}),
          graphics = {
            Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
            Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
          }
        ),
        experiment(StopTime = 200),
        Documentation(info = "<html><p>Try This: Simple thermal model for reading the equation browser. Compile and examine: How many blocks? What color? Which block is solved first? The block containing der(cap.T) should be the last block.</p></html>")
      );
    end ThermalLoopSimple;

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
    Documentation(info = "<html><p>Chapter 12: How Modelica Solves Equations. Covers the symbolic preprocessing pipeline: flattening, simplification, state selection, index reduction, bipartite graph, maximum matching, strongly connected components, block triangular form, and the equation browser.</p></html>")
  );
end Chapter12;
