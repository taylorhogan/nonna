botHeight = 110;

topHeightBase = 30;
topInsideHeight = 5;
tempProbeDiameter = 6.3;
smidge = 1;
insideDiameter = 70;
wallThickness = 3;
lensDiameter = 23;
lensZ = 46;
lensBore = 10;
cordHoleZ = 30;
cordHoldDiameter = 10;
cordHoleLength = 20;

module holeCutOut ()
{
	translate ([-insideDiameter/2-lensBore,0,cordHoleZ])
	rotate ([0,90,0])	
	{
		cylinder(h = 30, r = (cordHoldDiameter)/2, $fn = 100);
		translate ([0,-cordHoldDiameter/2,0])
		cube (size = [cordHoleLength, cordHoldDiameter, 30]);
	}
}

module lensCutOut ()
{
	translate ([insideDiameter/2-lensBore,0,lensZ])
	rotate ([0,90,0])	
	{
		cylinder(h = 30, r = (lensDiameter)/2, $fn = 100);
	}
}

module mainShell ()
{
	difference ()
	{
		cylinder(h = botHeight, r = (insideDiameter + wallThickness)/2, $fn = 100);
		translate ([0,0,wallThickness])
		cylinder(h = botHeight, r = (insideDiameter)/2, $fn = 100);		
	}
}

module cutouts ()
{
	lensCutOut ();
	holeCutOut ();
}

module mainThing()
{	
	difference ()
	{
		mainShell ();
		cutouts ();		
	}
}

module topOutside ()
{
	cylinder(h = topHeightBase, r = (insideDiameter + wallThickness)/2, $fn = 100);
	translate ([0,0,topHeightBase])
	cylinder(h = topInsideHeight, r = (insideDiameter)/2, $fn = 100);	
}

module tempCutOut ()
{
	translate ([insideDiameter/4,0,-smidge])
	cylinder(h = topHeightBase + topInsideHeight + 20, r = tempProbeDiameter/2, $fn = 100);
}

module topBore ()
{
	translate ([0,0,wallThickness])
	cylinder(h = topInsideHeight + topHeightBase + smidge , r = (insideDiameter - wallThickness)/2, $fn = 100);
}

module topShape ()
{
	difference ()
	{
		topOutside ();
		topBore ();
	}		
}

module top ()
{
	difference ()
	{
		topShape ();
		tempCutOut ();
	}
}

mainThing ();

//top ();




