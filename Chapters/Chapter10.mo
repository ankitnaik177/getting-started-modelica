within Chapters;
package Chapter10 "Functions, Enumerations, inner/outer, and assert"

  type FlowRegime = enumeration(Laminar, Transitional, Turbulent) "Flow regime classification"
    annotation(
      Icon(
        coordinateSystem(preserveAspectRatio = false, extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Rectangle(lineColor = {56, 56, 56}, fillColor = {192, 192, 192}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
          Text(textColor = {0, 114, 195}, extent = {{-90, -50}, {90, 50}}, textString = "1..n")
        }
      )
    );

  function ReynoldsNumber "Compute Reynolds number from flow parameters"
    input Real m_flow "Mass flow rate (kg/s)";
    input Real D "Pipe diameter (m)";
    input Real mu "Dynamic viscosity (Pa.s)";
    output Real Re "Reynolds number (-)";
  algorithm
    Re := (4 * m_flow) / (Modelica.Constants.pi * D * mu);
    annotation(
      Icon(
        coordinateSystem(extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
          Text(origin = {0, -5}, textColor = {255, 255, 255}, extent = {{-90, -80}, {90, 80}}, textString = "f")
        }
      ),
      Documentation(info = "<html><p>Computes the Reynolds number for pipe flow: Re = 4*m_flow / (pi*D*mu). Used to determine flow regime.</p></html>")
    );
  end ReynoldsNumber;

  model HeatedPipe "Heated pipe with functions, enumerations, outer, and assert"
    outer Modelica.Units.SI.Temperature T_ambient "Ambient temperature from system level";
    parameter Modelica.Units.SI.Diameter D = 0.05 "Pipe inner diameter";
    parameter Modelica.Units.SI.Length L = 1.0 "Pipe length";
    parameter Real R_wall(unit = "K/W") = 0.01 "Thermal wall resistance";
    parameter Real mu(unit = "Pa.s") = 1e-3 "Dynamic viscosity";
    parameter Modelica.Units.SI.Density rho = 1000 "Fluid density";
    parameter Real cp(unit = "J/(kg.K)") = 4182 "Specific heat capacity";
    parameter Modelica.Units.SI.Temperature T_in = 353.15 "Inlet temperature";
    parameter Modelica.Units.SI.MassFlowRate m_flow = 0.5 "Mass flow rate";
    Modelica.Units.SI.Temperature T_fluid(start = T_in, fixed = true) "Fluid temperature";
    Modelica.Units.SI.HeatFlowRate Q_loss "Heat lost to ambient (W)";
    Real Re "Reynolds number (-)";
    Modelica.Units.SI.Volume V "Pipe volume";
    FlowRegime regime "Current flow regime";
  equation
    Re = ReynoldsNumber(m_flow, D, mu);
    regime = if Re < 2300 then FlowRegime.Laminar
              else if Re < 4000 then FlowRegime.Transitional
              else FlowRegime.Turbulent;
    Q_loss = (T_fluid - T_ambient) / R_wall;
    V = (Modelica.Constants.pi * D ^ 2 / 4) * L;
    (rho * V * cp) * der(T_fluid) = m_flow * cp * (T_in - T_fluid) - Q_loss;
    assert(m_flow > 1e-6, "Mass flow rate too low: " + String(m_flow) + " kg/s. HeatedPipe requires positive flow.", AssertionLevel.error);
    assert(regime <> FlowRegime.Transitional, "Flow is in transitional regime (Re = " + String(Re) + "). Correlations are not validated for 2300 < Re < 4000.", AssertionLevel.warning);
    annotation(
      Icon(
        coordinateSystem(extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
          Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
        }
      ),
      experiment(StopTime = 100),
      Documentation(info = "<html><p>Heated pipe model demonstrating all four concepts: ReynoldsNumber function, FlowRegime enumeration, outer T_ambient (inner/outer), and assert guards. Must be simulated inside a PipeSystem that provides inner T_ambient.</p></html>")
    );
  end HeatedPipe;

  model PipeSystem "System-level model providing inner T_ambient"
    inner Modelica.Units.SI.Temperature T_ambient = 293.15 "Ambient temperature shared by all components";
    HeatedPipe pipe annotation(Placement(transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}})));
    annotation(
      Icon(
        coordinateSystem(extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
          Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
        }
      ),
      experiment(StopTime = 20),
      Documentation(info = "<html><p>Top-level system model that declares inner T_ambient and instantiates HeatedPipe. Simulate this model (not HeatedPipe directly). Change T_ambient here and all pipes in the hierarchy see the update.</p></html>")
    );
  end PipeSystem;

  package TryThis "Try This exercises for Chapter 10"

    model PipeSystem_Default "Default: m_flow=0.5, Re~12700, Turbulent"
      inner Modelica.Units.SI.Temperature T_ambient = 293.15;
      HeatedPipe pipe(m_flow = 0.5) annotation(Placement(transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}})));
      annotation(
        Icon(
          coordinateSystem(extent = {{-100, -100}, {100, 100}}),
          graphics = {
            Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
            Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
          }
        ),
        experiment(StopTime = 20),
        Documentation(info = "<html><p>Try This: Default parameters. Re~12700, regime=Turbulent, no assert messages.</p></html>")
      );
    end PipeSystem_Default;

    model PipeSystem_Transitional "m_flow=0.118 to trigger transitional warning"
      inner Modelica.Units.SI.Temperature T_ambient = 293.15;
      HeatedPipe pipe(m_flow = 0.118) annotation(Placement(transformation(origin = {0, 0}, extent = {{-10, -10}, {10, 10}})));
      annotation(
        Icon(
          coordinateSystem(extent = {{-100, -100}, {100, 100}}),
          graphics = {
            Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
            Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
          }
        ),
        experiment(StopTime = 20),
        Documentation(info = "<html><p>Try This: m_flow=0.118 gives Re~3000 (transitional). Simulation completes but warning appears in log.</p></html>")
      );
    end PipeSystem_Transitional;

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
    Documentation(info = "<html><p>Chapter 10: Functions, Enumerations, inner/outer, and assert. Four tools that make models more expressive: functions for named computations, enumerations for meaningful discrete states, inner/outer for system-level quantities, and assert for explicit assumptions.</p></html>")
  );
end Chapter10;
