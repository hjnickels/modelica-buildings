within Buildings.Controls.OBC.ASHRAE.G36_PR1.AHUs.MultiZone.VAV.Validation;
model Controller "Validation controller model"

  Buildings.Controls.OBC.ASHRAE.G36_PR1.AHUs.MultiZone.VAV.Controller conAHU(
    numZon=2,
    AFlo={50,50},
    have_perZonRehBox=false,
    controllerTypeMinOut=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
    controllerTypeFre=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
    controllerTypeFanSpe=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
    minZonPriFlo={(50*3/3600)*6,(50*3/3600)*6},
    VPriSysMax_flow=0.7*(50*3/3600)*6*2,
    have_occSen=true,
    controllerTypeTSup=Buildings.Controls.OBC.CDL.Types.SimpleController.PI)
                      "Multiple zone AHU controller"
    annotation (Placement(transformation(extent={{20,48},{100,152}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant TSetRooCooOn(
    final k=273.15 + 24)
    "Cooling on setpoint"
    annotation (Placement(transformation(extent={{-100,133},{-80,154}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant TSetRooHeaOn(
    final k=273.15 + 20)
    "Heating on setpoint"
    annotation (Placement(transformation(extent={{-220,131},{-200,151}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant TOutCut(
    final k=297.15)
    "Outdoor temperature high limit cutoff"
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant opeMod(
    final k=Buildings.Controls.OBC.ASHRAE.G36_PR1.Types.OperationModes.occupied)
    "AHU operation mode is occupied"
    annotation (Placement(transformation(extent={{48,0},{68,20}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp TZon[2](
    each height=6,
    each offset=273.15 + 17,
    each duration=3600) "Measured zone temperature"
    annotation (Placement(transformation(extent={{-100,100},{-80,120}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp TDis[2](
    each height=4,
    each duration=3600,
    each offset=273.15 + 18) "Terminal unit discharge air temperature"
    annotation (Placement(transformation(extent={{-220,60},{-200,80}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp numOfOcc1(
    height=2,
    duration=3600)
    "Occupant number in zone 1"
    annotation (Placement(transformation(extent={{-170,20},{-150,40}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp numOfOcc2(
    duration=3600,
    height=3)
    "Occupant number in zone 2"
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp TSup(
    height=4,
    duration=3600,
    offset=273.15 + 14) "AHU supply air temperature"
    annotation (Placement(transformation(extent={{-220,20},{-200,40}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp VOut_flow(
    duration=1800,
    offset=0.02,
    height=0.0168)
    "Measured outdoor airflow rate"
    annotation (Placement(transformation(extent={{-220,-20},{-200,0}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp vavBoxFlo1(
    height=1.5,
    offset=1,
    duration=3600)
    "Ramp signal for generating VAV box flow rate"
    annotation (Placement(transformation(extent={{-220,-60},{-200,-40}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp vavBoxFlo2(
    offset=1,
    height=0.5,
    duration=3600)
    "Ramp signal for generating VAV box flow rate"
    annotation (Placement(transformation(extent={{-130,-60},{-110,-40}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp TMixMea(
    height=4,
    duration=1,
    offset=273.15 + 2,
    startTime=0)
    "Measured mixed air temperature"
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Sine TOut(
    amplitude=5,
    offset=18 + 273.15,
    freqHz=1/3600) "Outdoor air temperature"
    annotation (Placement(transformation(extent={{-220,100},{-200,120}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Sine ducStaPre(
    offset=200,
    amplitude=150,
    freqHz=1/3600) "Duct static pressure"
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Sine sine(
    offset=3,
    amplitude=2,
    freqHz=1/9600) "Duct static pressure setpoint reset requests"
    annotation (Placement(transformation(extent={{-220,-150},{-200,-130}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Sine sine1(
    amplitude=6,
    freqHz=1/9600)
    "Maximum supply temperature setpoint reset"
    annotation (Placement(transformation(extent={{-220,-110},{-200,-90}})));
  Buildings.Controls.OBC.CDL.Continuous.Abs abs
    "Block generates absolute value of input"
    annotation (Placement(transformation(extent={{-130,-110},{-110,-90}})));
  Buildings.Controls.OBC.CDL.Continuous.Abs abs1
    "Block generates absolute value of input"
    annotation (Placement(transformation(extent={{-130,-150},{-110,-130}})));
  Buildings.Controls.OBC.CDL.Continuous.Round round1(n=0)
    "Round real number to given digits"
    annotation (Placement(transformation(extent={{-94,-110},{-74,-90}})));
  Buildings.Controls.OBC.CDL.Continuous.Round round2(n=0)
    "Round real number to given digits"
    annotation (Placement(transformation(extent={{-94,-150},{-74,-130}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger ducPreResReq "Convert real to integer"
    annotation (Placement(transformation(extent={{-60,-150},{-40,-130}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger maxSupResReq
    "Convert real to integer"
    annotation (Placement(transformation(extent={{-60,-110},{-40,-90}})));

  CDL.Conversions.RealToInteger occConv1 "Convert real to integer"
    annotation (Placement(transformation(extent={{-140,20},{-120,40}})));
  CDL.Conversions.RealToInteger occConv2 "Convert real to integer"
    annotation (Placement(transformation(extent={{-70,20},{-50,40}})));
equation
  connect(sine.y,abs1. u)
    annotation (Line(points={{-199,-140},{-132,-140}}, color={0,0,127}));
  connect(abs1.y,round2. u)
    annotation (Line(points={{-109,-140},{-96,-140}}, color={0,0,127}));
  connect(round2.y, ducPreResReq.u)
    annotation (Line(points={{-73,-140},{-62,-140}}, color={0,0,127}));
  connect(sine1.y, abs.u)
    annotation (Line(points={{-199,-100},{-132,-100}}, color={0,0,127}));
  connect(abs.y,round1. u)
    annotation (Line(points={{-109,-100},{-96,-100}}, color={0,0,127}));
  connect(round1.y, maxSupResReq.u)
    annotation (Line(points={{-73,-100},{-62,-100}}, color={0,0,127}));
  connect(TSetRooCooOn.y, conAHU.TZonCooSet)
    annotation (Line(points={{-79,143.5},{-20,143.5},{-20,154.167},{18,154.167}},
      color={0,0,127}));
  connect(TZon.y, conAHU.TZon)
    annotation (Line(points={{-79,110},{-50,110},{-50,141.167},{18,141.167}},
      color={0,0,127}));
  connect(TOutCut.y, conAHU.TOutCut)
    annotation (Line(points={{-79,70},{-26,70},{-26,123.833},{18,123.833}},
      color={0,0,127}));
  connect(TSup.y, conAHU.TSup)
    annotation (Line(points={{-199,30},{-180,30},{-180,52},{-60,52},{-60,
          108.667},{18,108.667}},   color={0,0,127}));
  connect(VOut_flow.y, conAHU.VOut_flow)
    annotation (Line(points={{-199,-10},{-180,-10},{-180,10},{-34,10},{-34,
          95.6667},{18,95.6667}},
                      color={0,0,127}));
  connect(ducStaPre.y, conAHU.ducStaPre)
    annotation (Line(points={{-79,-10},{-30,-10},{-30,91.3333},{18,91.3333}},
      color={0,0,127}));
  connect(vavBoxFlo1.y, conAHU.VDis_flow[1])
    annotation (Line(points={{-199,-50},{-140,-50},{-140,-30},{-40,-30},{-40,
          83.75},{18,83.75}},      color={0,0,127}));
  connect(vavBoxFlo2.y, conAHU.VDis_flow[2])
    annotation (Line(points={{-109,-50},{-100,-50},{-100,-26},{-44,-26},{-44,
          85.9167},{18,85.9167}},  color={0,0,127}));
  connect(TMixMea.y, conAHU.TMix)
    annotation (Line(points={{-59,-50},{-22,-50},{-22,80.5},{18,80.5}},
      color={0,0,127}));
  connect(opeMod.y, conAHU.uOpeMod)
    annotation (Line(points={{69,10},{80,10},{80,30},{0,30},{0,71.8333},{18,
          71.8333}},color={255,127,0}));
  connect(maxSupResReq.y, conAHU.uZonTemResReq)
    annotation (Line(points={{-39,-100},{-16,-100},{-16,61},{18,61}},
      color={255,127,0}));
  connect(ducPreResReq.y, conAHU.uZonPreResReq)
    annotation (Line(points={{-39,-140},{-12,-140},{-12,54.5},{18,54.5}},
      color={255,127,0}));
  connect(TOut.y, conAHU.TOut)
    annotation (Line(points={{-199,110},{-180,110},{-180,126},{-60,126},{-60,
          145.5},{18,145.5}},      color={0,0,127}));
  connect(TDis.y, conAHU.TDis)
    annotation (Line(points={{-199,70},{-180,70},{-180,92},{-40,92},{-40,132.5},
          {18,132.5}},             color={0,0,127}));
  connect(TSetRooHeaOn.y, conAHU.TZonHeaSet)
    annotation (Line(points={{-199,141},{-180,141},{-180,160},{-20,160},{-20,
          158.5},{18,158.5}},      color={0,0,127}));

  connect(numOfOcc1.y, occConv1.u)
    annotation (Line(points={{-149,30},{-142,30}}, color={0,0,127}));
  connect(numOfOcc2.y, occConv2.u)
    annotation (Line(points={{-79,30},{-72,30}}, color={0,0,127}));
  connect(occConv1.y, conAHU.nOcc[1]) annotation (Line(points={{-119,30},{-110,
          30},{-110,50},{-48,50},{-48,98.9167},{18,98.9167}}, color={255,127,0}));
  connect(occConv2.y, conAHU.nOcc[2]) annotation (Line(points={{-49,30},{-46,30},
          {-46,101.083},{18,101.083}},
                                     color={255,127,0}));
annotation (experiment(StopTime=3600.0, Tolerance=1e-06),
  __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/ASHRAE/G36_PR1/AHUs/MultiZone/VAV/Validation/Controller.mos"
    "Simulate and plot"),
    Documentation(info="<html>
<p>
This example validates
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.G36_PR1.AHUs.MultiZone.VAV.Controller\">
Buildings.Controls.OBC.ASHRAE.G36_PR1.AHUs.MultiZone.VAV.Controller</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
January 12, 2019, by Michael Wetter:<br/>
Removed wrong use of <code>each</code>.
</li>
<li>
October 30, 2017, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"),
Diagram(coordinateSystem(extent={{-240,-180},{240,180}})),
    Icon(coordinateSystem(extent={{-240,-180},{240,180}}),
         graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent = {{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points = {{-36,60},{64,0},{-36,-60},{-36,60}})}));
end Controller;
