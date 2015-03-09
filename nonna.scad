CAP_HEIGHT_BASE = 30;
CAP_INSET_HEIGHT = 5;
CAP_HEIGHT = CAP_HEIGHT_BASE + CAP_INSET_HEIGHT;

MID_HEIGHT = 110;



tempProbeDiameter = 6.3;
TEMP_HUMID_X = 10;
TEMP_HUMID_Y = 20;

smidge = 1;
insideDiameter = 70;
wallThickness = 3;
lensDiameter = 23;
lensZ = 46;
lensBore = 10;
cordHoleZ = 30;
cordHoldDiameter = 16;
cordHoleLength = 20;
airVentR = 2;
domeInset = 10;

BOTTOM_EXTENSION = 10;
DISPLAY_SEP = 10;



module holeCutOut ()
{
	translate ([-insideDiameter/2-lensBore,0,cordHoleZ])
	rotate ([0,90,0])	
	{
		cylinder(h = 30, r = (cordHoldDiameter)/2, $fn = 100);		
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
	bottomExtension();
	translate ([0,0,BOTTOM_EXTENSION])
	difference ()
	{
		cylinder(h = MID_HEIGHT, r = (insideDiameter + wallThickness)/2, $fn = 100);
		translate ([0,0,wallThickness])
		cylinder(h = MID_HEIGHT, r = (insideDiameter)/2, $fn = 100);		
	}
	
}

module bottomExtension ()
{
	difference ()
	{
		cylinder(h = BOTTOM_EXTENSION, r = (insideDiameter + wallThickness)/2, $fn = 100);
		translate ([0,0,-wallThickness])
		cylinder(h = BOTTOM_EXTENSION+(wallThickness *3), r = (insideDiameter)/2, $fn = 100);				
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
	cylinder(h = CAP_HEIGHT_BASE, r = (insideDiameter + wallThickness)/2, $fn = 100);
	translate ([0,0,CAP_HEIGHT_BASE])
	cylinder(h = CAP_INSET_HEIGHT, r = (insideDiameter)/2, $fn = 100);	
}

module tempCutOut ()
{
	translate ([insideDiameter/4,0,-smidge])
	cylinder(h = topHeightBase + topInsideHeight + 20, r = tempProbeDiameter/2, $fn = 100);
}

module topBore ()
{
	translate ([0,0,wallThickness])
	cylinder(h = CAP_INSET_HEIGHT + CAP_HEIGHT_BASE + smidge , r = (insideDiameter - wallThickness)/2, $fn = 100);
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
		airVents(10, 20);
	}
}

module domeOutside ()
{	
	difference ()
	{
		sphere((insideDiameter + wallThickness)/2, $fn=100);
		cylinder(h = (insideDiameter + wallThickness), r = (insideDiameter + wallThickness)/2, $fn = 100);
	}
}
module domeInside ()
{	
	sphere((insideDiameter)/2, $fn=100);
}

module domeFitting ()
{
	translate ([0,0,-10])
	{
		difference ()
		{
			cylinder(h = topInsideHeight+domeInset, r = (insideDiameter)/2-.5, $fn = 100);
			translate ([0,0,-5])
			cylinder(h = topInsideHeight+domeInset+10, r = (insideDiameter-wallThickness)/2-.5, $fn = 100);
		}	
	}
}

module domeShell ()
{
	difference ()
	{
		domeOutside ();
		domeInside();
	}
	
}
module airVents (y, angle)
{
	translate ([0,0, y])
	rotate ([90,0,0])
	for (i = [0 : angle : 360] )
	{	 
		rotate (i, [0,1,0])
		{
			 cylinder (100, r= airVentR,  $fn = 16);
		}
	}

}


module mid ()
{
	difference ()
	{
		mainThing ();
		airVents(BOTTOM_EXTENSION + 10, 20);
	}
}

module dome()
{
	rotate ([0, 180, 0])

	difference ()
	{
		domeShell ();
		airVents(-20, 45);

	}
}

module bottom ()
{
	top();
}

/*
bottom ();

translate ([0,0,CAP_HEIGHT+DISPLAY_SEP])

*/
mid();
/*
translate ([0,0,BOTTOM_EXTENSION+CAP_HEIGHT+MID_HEIGHT+DISPLAY_SEP*8])
{
	rotate ([180,0,0])
	top ();
}
*/

