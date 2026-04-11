within Chapters;
package Chapter2 "The Modelica Standard Library and Your First Model"

  model MyFirstModel "Heat transfer between two thermal masses"
    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor1(C = 1, T(start = 283.15, fixed = true)) "Thermal mass 1 at 10 deg C";
    Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor2(C = 1, T(start = 293.15, fixed = true)) "Thermal mass 2 at 20 deg C";
    Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor1(G = 1) "Conductor between the two masses";
  equation
    connect(heatCapacitor1.port, thermalConductor1.port_a);
    connect(thermalConductor1.port_b, heatCapacitor2.port);
    annotation(
      Icon(
        coordinateSystem(extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
          Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
        }
      ),
      experiment(StopTime = 10),
      Documentation(info = "<html><p>Two thermal masses (both 1 J/K) at 10 deg C and 20 deg C connected by a conductor (G=1 W/K). They equilibrate at 15 deg C.</p></html>")
    );
  end MyFirstModel;

  package TryThis "Try This exercises for Chapter 2"

    model AsymmetricCapacities "Try This: C1=1 J/K, C2=3 J/K"
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor1(C = 1, T(start = 283.15, fixed = true)) "1 J/K at 10 deg C";
      Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor2(C = 3, T(start = 293.15, fixed = true)) "3 J/K at 20 deg C";
      Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor1(G = 1) "Conductor";
    equation
      connect(heatCapacitor1.port, thermalConductor1.port_a);
      connect(thermalConductor1.port_b, heatCapacitor2.port);
      annotation(
        Icon(
          coordinateSystem(extent = {{-100, -100}, {100, 100}}),
          graphics = {
            Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
            Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
          }
        ),
        experiment(StopTime = 30),
        Documentation(info = "<html><p>Try This: Asymmetric capacities. C1=1 J/K at 10 deg C, C2=3 J/K at 20 deg C. Equilibrium temperature = (1*10 + 3*20)/(1+3) = 17.5 deg C.</p></html>")
      );
    end AsymmetricCapacities;

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
    Documentation(info = "<html><p>Chapter 2: The Modelica Standard Library and Your First Model. Covers the MSL structure, parameters vs variables, and the complete simulation workflow with a heat transfer example.</p></html>")
  );
end Chapter2;
