within Chapters;
package Chapter7 "Events and Hybrid Models"

  model TimeEvent "Simple time event: x steps from 0 to 1 at t=5"
    Real x(start = 0, fixed = true);
  equation
    when time >= 5 then
      x = 1;
    end when;
    annotation(
      Icon(
        coordinateSystem(extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
          Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
        }
      ),
      experiment(StopTime = 10),
      Documentation(info = "<html><p>Demonstrates a time event. x holds at 0, then steps to 1 at exactly t=5 seconds.</p></html>")
    );
  end TimeEvent;

  model SampleTest "Sampling a continuous signal at discrete intervals"
    discrete Real x(start = 0);
    Real y;
  equation
    y = sin(time);
    when sample(0, 0.5) then
      x = y;
    end when;
    annotation(
      Icon(
        coordinateSystem(extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
          Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
        }
      ),
      experiment(StopTime = 10),
      Documentation(info = "<html><p>Demonstrates the sample() operator. A sine wave is sampled every 0.5 seconds, producing a staircase approximation.</p></html>")
    );
  end SampleTest;

  model PreTest "Counter using the pre() operator"
    discrete Real x(start = 0);
  equation
    when sample(1, 1) then
      x = pre(x) + 1;
    end when;
    annotation(
      Icon(
        coordinateSystem(extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
          Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
        }
      ),
      experiment(StopTime = 10),
      Documentation(info = "<html><p>Demonstrates the pre() operator. A counter increments by 1 each second starting at t=1. pre(x) returns the value of x just before the event.</p></html>")
    );
  end PreTest;

  model IfVsWhen "Demonstrates the difference between if and when"
    Real x_if;
    Real x_when(start = 0, fixed = true);
  equation
    if time >= 5 then
      x_if = 1;
    else
      x_if = 0;
    end if;
    when time >= 5 then
      x_when = 1;
    end when;
    annotation(
      Icon(
        coordinateSystem(extent = {{-100, -100}, {100, 100}}),
        graphics = {
          Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
          Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
        }
      ),
      experiment(StopTime = 10),
      Documentation(info = "<html><p>Side-by-side comparison of if and when. Both produce x=1 after t=5, but if is continuously active while when fires once at the false-to-true transition.</p></html>")
    );
  end IfVsWhen;

  package TryThis "Try This exercises for Chapter 7"

    model BouncingBall "Bouncing ball with reinit()"
      Real h(start = 5.0, fixed = true) "Height (m)";
      Real v(start = 0.0, fixed = true) "Velocity (m/s)";
      parameter Real e = 0.8 "Restitution coefficient";
    equation
      der(h) = v;
      der(v) = -9.81;
      when h <= 0 then
        reinit(v, -e * pre(v));
      end when;
      annotation(
        Icon(
          coordinateSystem(extent = {{-100, -100}, {100, 100}}),
          graphics = {
            Ellipse(lineColor = {0, 114, 195}, fillColor = {0, 114, 195}, fillPattern = FillPattern.Solid, extent = {{-100, -100}, {100, 100}}),
            Polygon(lineColor = {0, 114, 195}, fillColor = {255, 255, 255}, fillPattern = FillPattern.Solid, points = {{-36, 60}, {64, 0}, {-36, -60}, {-36, 60}})
          }
        ),
        experiment(StopTime = 10),
        Documentation(info = "<html><p>Try This: Bouncing ball using reinit(). Ball starts at 5m, falls under gravity, bounces with restitution e=0.8. Each successive bounce reaches approximately e^2 = 64% of the previous peak height. Try reducing e to 0.3 to see the ball come to rest faster.</p></html>")
      );
    end BouncingBall;

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
    Documentation(info = "<html><p>Chapter 7: Events and Hybrid Models. Covers time events, state events, zero-crossing detection, sample(), pre(), reinit(), when vs if, noEvent(), and hysteresis.</p></html>")
  );
end Chapter7;
