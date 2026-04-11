within Chapters;
package Chapter11 "Using Data: Tables, Lookups, and Export"

  block SpeedToPower "Wind speed to available power"
    Modelica.Blocks.Interfaces.RealInput speed;
    Modelica.Blocks.Interfaces.RealOutput power;
    parameter Real airDensity = 1.225 "Air density (kg/m3)";
    parameter Real rotorArea = 1.0 "Swept area (m2)";
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
      )
    );
  end SpeedToPower;

  model DataTest "CombiTimeTable feeding wind speed data"
    SpeedToPower speedToPower;
    Modelica.Blocks.Sources.CombiTimeTable windSource(
      table = [0, 4.0;
               3, 6.5;
               6, 8.2;
               9, 11.0;
               12, 9.5;
               15, 7.8;
               18, 5.5;
               21, 3.2;
               24, 4.0],
      timeScale = 3600) "24-hour wind speed profile";
  equation
    connect(windSource.y[1], speedToPower.speed);
    annotation(
      Icon(
        coordinateSystem(extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
          Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
        }
      ),
      experiment(StopTime = 86400),
      Documentation(info = "<html><p>Demonstrates CombiTimeTable with inline 24-hour wind data. timeScale=3600 converts hours to seconds. Connect to SpeedToPower to compute available power.</p></html>")
    );
  end DataTest;

  package TryThis "Try This exercises for Chapter 11"

    model WindSpeedProfile "Full wind turbine data pipeline"
      Modelica.Blocks.Sources.CombiTimeTable windSource(
        table = [0, 4.0;
                 3, 6.5;
                 6, 8.2;
                 9, 11.0;
                 12, 9.5;
                 15, 7.8;
                 18, 5.5;
                 21, 3.2;
                 24, 4.0],
        timeScale = 3600) "24-hour wind speed profile";
      SpeedToPower speedToPower "Compute available power from wind speed";
      Modelica.Blocks.Tables.CombiTable1Ds efficiencyTable(
        table = [2, 0.20;
                 4, 0.45;
                 6, 0.62;
                 8, 0.78;
                 10, 0.88;
                 12, 0.95;
                 14, 0.91;
                 16, 0.83;
                 18, 0.72;
                 20, 0.58;
                 22, 0.30;
                 25, 0.00]) "Wind speed to efficiency lookup";
      Modelica.Blocks.Math.Product product "Multiply available power by efficiency";
    equation
      connect(windSource.y[1], speedToPower.speed);
      connect(windSource.y[1], efficiencyTable.u);
      connect(speedToPower.power, product.u1);
      connect(efficiencyTable.y[1], product.u2);
      annotation(
        Icon(
          coordinateSystem(extent = {{-100, -100}, {100, 100}}),
          graphics = {
            Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
            Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
          }
        ),
        experiment(StopTime = 86400),
        Documentation(info = "<html><p>Try This: Full data pipeline. CombiTimeTable provides wind speed over 24 hours. SpeedToPower computes available power. CombiTable1Ds provides efficiency lookup. Product block gives actual power. Actual power drops near zero at low-wind hours (0h, 21h) and peaks mid-morning.</p></html>")
      );
    end WindSpeedProfile;

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
    Documentation(info = "<html><p>Chapter 11: Using Data. Covers CombiTimeTable for time-series input, CombiTable1Ds for lookup tables, smoothness/extrapolation settings, CSV file loading, and data export.</p></html>")
  );
end Chapter11;
