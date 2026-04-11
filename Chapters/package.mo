package Chapters "Getting Started with Modelica - Chapter Models and Exercises"
  annotation(
    Icon(
      coordinateSystem(extent = {{-100, -100}, {100, 100}}),
      graphics = {
        Polygon(origin = {0.248, 0.044}, lineColor = {56, 56, 56}, fillColor = {128, 202, 255}, fillPattern = FillPattern.Solid, points = {{99.752, 100}, {99.752, 59.956}, {99.752, -50}, {100, -100}, {49.752, -100}, {-19.752, -100.044}, {-100.248, -100}, {-100.248, -50}, {-90.248, 29.956}, {-90.248, 79.956}, {-40.248, 79.956}, {-20.138, 79.813}, {-0.248, 79.956}, {19.752, 99.956}, {39.752, 99.956}, {59.752, 99.956}}, smooth = Smooth.Bezier),
        Polygon(origin = {0, -13.079}, lineColor = {192, 192, 192}, fillColor = {255, 255, 255}, pattern = LinePattern.None, fillPattern = FillPattern.HorizontalCylinder, points = {{100, -86.921}, {50, -86.921}, {-50, -86.921}, {-100, -86.921}, {-100, -36.921}, {-100, 53.079}, {-100, 103.079}, {-50, 103.079}, {0, 103.079}, {20, 83.079}, {50, 83.079}, {100, 83.079}, {100, 33.079}, {100, -36.921}}, smooth = Smooth.Bezier),
        Polygon(origin = {0, -10.704}, lineColor = {113, 113, 113}, fillColor = {255, 255, 255}, points = {{100, -89.296}, {50, -89.296}, {-50, -89.296}, {-100, -89.296}, {-100, -39.296}, {-100, 50.704}, {-100, 100.704}, {-50, 100.704}, {0, 100.704}, {20, 80.704}, {50, 80.704}, {100, 80.704}, {100, 30.704}, {100, -39.296}}, smooth = Smooth.Bezier)
      }
    ),
    Documentation(info = "<html>
<h1>Getting Started with Modelica - Companion Models</h1>
<p>This package contains all models from the book, organized by chapter. Each chapter package includes:</p>
<ul>
<li>All models described and built in the chapter text</li>
<li>A <b>TryThis</b> sub-package containing the end-of-chapter exercise models</li>
</ul>

<h2>Chapter Overview</h2>
<ul>
<li><b>Chapter1</b> - Why Modelica? (RC circuit example)</li>
<li><b>Chapter2</b> - The Modelica Standard Library and Your First Model (heat transfer)</li>
<li><b>Chapter3</b> - Causal vs. Acausal Modeling (mass-spring-damper)</li>
<li><b>Chapter4</b> - Writing Your First Textual Model (HelloWorld, SpeedToPower, Resistor, ResistorWithHeat)</li>
<li><b>Chapter5</b> - Naming Conventions, Units, and Package Design (unit checking)</li>
<li><b>Chapter6</b> - Arrays and For Loops (resistor arrays)</li>
<li><b>Chapter7</b> - Events and Hybrid Models (time events, sample, pre, reinit, bouncing ball)</li>
<li><b>Chapter8</b> - Inheritance and Partial Models (ResistorWithPowerMeter)</li>
<li><b>Chapter9</b> - Records and Replaceable Components (turbine data, friction shaft)</li>
<li><b>Chapter10</b> - Functions, Enumerations, inner/outer, assert (heated pipe system)</li>
<li><b>Chapter11</b> - Using Data: Tables, Lookups, and Export (wind turbine data pipeline)</li>
<li><b>Chapter12</b> - How Modelica Solves Equations (thermal coupling, equation browser)</li>
<li><b>Chapter14</b> - Experiments, Solvers, and FMI (stiff model)</li>
</ul>

<p>Chapters 13, 15, and 16 are reflective/conceptual chapters with no simulatable models.</p>
</html>")
  );
end Chapters;
