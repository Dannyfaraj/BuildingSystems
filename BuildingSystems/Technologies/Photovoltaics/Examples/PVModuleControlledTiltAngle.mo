within BuildingSystems.Technologies.Photovoltaics.Examples;
model PVModuleControlledTiltAngle
  "Example of a MPP controlled PV generator which has a changing tilt angle"
  extends Modelica.Icons.Example;
  BuildingSystems.Technologies.Photovoltaics.PVModules.PVModuleSimpleMPP pvField(
    nModPar = 3,
    nModSer = 10,
    redeclare BuildingSystems.Technologies.Photovoltaics.Data.PhotovoltaicModules.TSM230PC05 pvModuleData,
    use_AngleDegTil_in=true,
    angleDegAzi_constant=0.0)
    annotation (Placement(transformation(extent={{-56,34},{-36,54}})));
  BuildingSystems.Climate.WeatherData.WeatherDataReader weatherData(
    redeclare block WeatherData = BuildingSystems.Climate.WeatherDataMeteonorm.USA_SanFrancisco_Meteonorm_NetCDF)
    annotation(Placement(transformation(extent={{-96,84},{-84,96}})));
  BuildingSystems.Climate.SolarRadiationTransformers.SolarRadiationTransformerIsotropicSky radiation(
    rhoAmb = 0.2,
    angleDegL = 0.0)
    annotation (Placement(transformation(extent={{-74,62},{-54,82}})));
  Modelica.Blocks.Sources.Sine sine(
   amplitude=45,
   freqHz=1/86400,
   phase=0,
   offset=45,
   startTime=0)
   annotation (Placement(transformation(extent={{-22,60},{-34,72}})));
equation
  connect(radiation.radiationPort, pvField.radiationPort)
    annotation (Line(
      points={{-56,71.8},{-46,71.8},{-46,52}},
      color={255,255,0},
      smooth=Smooth.None));
  connect(pvField.angleDegTil, radiation.angleDegTil) annotation (Line(
    points={{-52,52},{-76,52},{-76,70},{-71.6,70}},          color={0,0,127}));
  connect(pvField.angleDegAzi, radiation.angleDegAzi) annotation (Line(
    points={{-52,50},{-76,50},{-76,66},{-71.6,66}},          color={0,0,127}));
  connect(pvField.angleDegTil_in, sine.y) annotation (Line(points={{-48,52},{-48,
    52},{-48,66},{-34.6,66}}, color={0,0,127}));

  connect(weatherData.latitudeDeg, radiation.latitudeDeg) annotation (Line(
        points={{-83.4,95.4},{-67.8,95.4},{-67.8,79.6}}, color={0,0,127}));
  connect(weatherData.longitudeDeg, radiation.longitudeDeg) annotation (Line(
        points={{-83.4,94.2},{-64,94.2},{-64,79.6}}, color={0,0,127}));
  connect(weatherData.longitudeDeg0, radiation.longitudeDeg0) annotation (Line(
        points={{-83.4,93},{-60,93},{-60,79.6}}, color={0,0,127}));
  connect(weatherData.TAirRef, pvField.TAmb) annotation (Line(points={{-94.2,83.4},
          {-94.2,56},{-44,56},{-44,52}}, color={0,0,127}));
  connect(weatherData.IrrDirHor, radiation.IrrDirHor) annotation (Line(points={{
          -91.8,83.4},{-91.8,78},{-71.6,78}}, color={0,0,127}));
  connect(weatherData.IrrDifHor, radiation.IrrDifHor) annotation (Line(points={{
          -90.6,83.4},{-90.6,74},{-71.6,74}}, color={0,0,127}));

  annotation(Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,0},{-20,100}}), graphics={
    Text(extent={{-62,22},{-62,18}},lineColor={0,0,255},fontSize=22,
    textString="PV generator with 3 parallel and
    10 serial connected
    and MPP controlled PV modules
    (1 diode model) and a changing
    tilt angle of the modules")}),
    experiment(StartTime=0.0, StopTime=3.1536e+007),
    __Dymola_Commands(file="modelica://BuildingSystems/Resources/Scripts/Dymola/Technologies/Photovoltaics/Examples/PVModuleControlledTiltAngle.mos" "Simulate and plot"),
Documentation(info="<html>
<p> This example tests the implementation of
<a href=\"modelica://BuildingSystems.Technologies.Photovoltaics.PVModuleSimpleMPP\">
BuildingSystems.Technologies.Photovoltaics.PVModuleSimpleMPP in combination with a changing tilt angle
of the module</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
June 14, 2018, by Christoph Nytsch-Geusen:<br/>
Adaptation to the new interfaces of the weather data reader.
</li>
<li>
March 7, 2015, by Christoph Nytsch-Geusen:<br/>
First implementation.
</li>
</ul>
</html>"));
end PVModuleControlledTiltAngle;
