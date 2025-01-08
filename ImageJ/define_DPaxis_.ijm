setBatchMode(false);
run("Close All");
run("Collect Garbage");
listc= getList("image.titles");
for (m=0; m<listc.length; m++){
        close(listc[m]);
          }	

               
dir = getDirectory("Please choose a source directory.");
root = substring(dir, 0, lastIndexOf(dir, "\\"));

bo = "fluo_results";
boby1 = "normal";
boby2 = "spindle";
boby3 = "ortho";
boby4 = "NonDividingLateral";
boby5 = "NonDividingNormal";
boby6 = "DPaxis";
boby7 = "MOVIES";

normaldir = ""+root+"\\"+bo+"\\"+boby1+"\\";
spindledir = ""+root+"\\"+bo+"\\"+boby2+"\\";
orthodir = ""+root+"\\"+bo+"\\"+boby3+"\\";
NonDividingLateraldir = ""+root+"\\"+bo+"\\"+boby4+"\\";
NonDividingNormaldir = ""+root+"\\"+bo+"\\"+boby5+"\\";
DPaxisdir = ""+root+"\\"+bo+"\\"+boby6+"\\";
Moviesdir = ""+root+"\\"+boby7+"\\";

File.makeDirectory(DPaxisdir);

GetFiles(Moviesdir);

function GetFiles(fazer) { 
	// function description
	MoviesList = newArray(0);
	list = getFileList(fazer);
	for (m=0; m<list.length; m++){
		if(endsWith(list[m], "/")){
			list2 = getFileList(fazer+"/"+list[m]);
			for (n=0; n<list2.length; n++){
				if (endsWith(list2[n], ".tif") && startsWith(list2[n], "r_")) {
				MoviesList = Array.concat(MoviesList, fazer+"/"+list[m]+list2[n]);
					}
				}
			}
		}
	for (o=0; o<MoviesList.length; o++){
		path = ""+MoviesList[o]+"";
		MeasureDPaxis(path);	
		}
	}


function MeasureDPaxis(PathToMovie) {
	run("Close All");
    run("Collect Garbage");
	movie = substring(PathToMovie, lastIndexOf(PathToMovie, "/")+1, lengthOf(PathToMovie));
	E = indexOf(movie, ".tif");
	F = substring(movie, 0, E);
	run("Bio-Formats Macro Extensions"); 
    Ext.setId(path); 
    Ext.getSizeX(width);
    Ext.getSizeY(height); 
    Ext.getSizeZ(slices); 
    Ext.getSizeT(sizeT);
    Ext.getPixelsPhysicalSizeX(sizeX);
    Ext.getPixelsPhysicalSizeZ(sizeZ);
	open(path);
	selectImage(""+F+".tif");
	Property.set("CompositeProjection", "Sum");
    Stack.setDisplayMode("composite");
	run("Set Measurements...", "area mean integrated stack redirect=None decimal=3");
	setTool("multipoint");
	x1 = newArray();
	x2 = newArray();
	y1 = newArray();
	y2 = newArray();
	z1 = newArray();
	z2 = newArray();
	
	for (m=0; m<1; m++){
		Stack.setPosition(0, 0, m+1); 
		waitForUser("SVP placez les deux extrémitées du DPaxis"); 
		run("Clear Results");	
		selectImage(""+F+".tif");
		run("Measure");
		X1 = newArray();
	    X2 = newArray();
	    Y1 = newArray();
	    Y2 = newArray();
	    Z1 = newArray();
	    Z2 = newArray();
		
		X1[0] = getResult("X", 0);
		X2[0] = getResult("X", 1);
		Y1[0] = getResult("Y", 0);
		Y2[0] = getResult("Y", 1);
		Z1[0] = getResult("Slice", 0);
		Z2[0] = getResult("Slice", 1);
		
		x1 = Array.concat(x1, X1);
		x2 = Array.concat(x2, X2);
		y1 = Array.concat(y1, Y1);
		y2 = Array.concat(y2, Y2);
		z1 = Array.concat(z1, Z1);
		z2 = Array.concat(z2, Z2);
		run("Select None");
		run("Clear Results");
		}
		for (m=0; m<x1.length; m++){
			setResult("x1", m, x1[m]);
			setResult("x2", m, x2[m]);
			setResult("y1", m, y1[m]);
			setResult("y2", m, y2[m]);
			setResult("z1", m, z1[m]);
			setResult("z2", m, z2[m]);		
			}
		 saveAs("Results", ""+DPaxisdir+""+F+"_DPaxis.csv");
		 run("Clear Results");
	}
