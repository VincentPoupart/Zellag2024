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
boby6 = "RachisBackground";

normaldir = ""+root+"\\"+bo+"\\"+boby1+"\\";
spindledir = ""+root+"\\"+bo+"\\"+boby2+"\\";
orthodir = ""+root+"\\"+bo+"\\"+boby3+"\\";
NonDividingLateraldir = ""+root+"\\"+bo+"\\"+boby4+"\\";
NonDividingNormaldir = ""+root+"\\"+bo+"\\"+boby5+"\\";
RachisBackgrounddir = ""+root+"\\"+bo+"\\"+boby6+"\\";

File.makeDirectory(RachisBackgrounddir);

GetFiles(root);

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
		RachisBackground(path);	
		}
	}


function RachisBackground(PathToMovie) {
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
	run("Split Channels");
	selectImage("C1-"+F+".tif");
	close();
	selectImage("C2-"+F+".tif");
	run("Enhance Contrast", "saturated=0.35");
	run("Set Measurements...", "area mean integrated stack redirect=None decimal=3");
	Area = newArray();
	Mean = newArray();
	IntDen = newArray();
	RawIntDen = newArray();
	for (m=0; m<sizeT; m++){
		if (m == 0) {
			Stack.setPosition(0, 0, m+1); 
			makeRectangle(87, 275, 86, 544);
			waitForUser("SVP placez le rectangle"); 
			run("Properties... ", "list");
			a = getResult("X", 0) / sizeX;
	    	b = getResult("Y", 0) / sizeX;
			c = -1 * (a - (getResult("X", 2) / sizeX));
			d = -1 *  (b - (getResult("Y", 3) / sizeX));
			run("Clear Results");
			}
		if (m > 0) {
			Stack.setPosition(0, 0, m+1); 
			makeRectangle(a, b, c, d); 
			waitForUser("SVP placez le rectangle");
			run("Properties... ", "list");
			a = getResult("X", 0) / sizeX;
	    	b = getResult("Y", 0) / sizeX;
			c = -1 * (a - (getResult("X", 2) / sizeX));
			d = -1 *  (b - (getResult("Y", 3) / sizeX));
			run("Clear Results");	
			}
		run("Clear Results");
		selectWindow("XY_C2-"+F+".tif");
		run("Close");
		selectImage("C2-"+F+".tif");
		run("Measure");
		A = newArray();
		M = newArray();
		I = newArray();
		R = newArray();
		A[0] =  getResult("Area", 0);
		M[0] =  getResult("Mean", 0);
		I[0] =  getResult("IntDen", 0);
		R[0] =  getResult("RawIntDen", 0);
		Area = Array.concat(Area, A);
		Mean = Array.concat(Mean, M);
		IntDen = Array.concat(IntDen,I);
		RawIntDen = Array.concat(RawIntDen, R);
		run("Clear Results");
		}
		for (m=0; m<Area.length; m++){
			setResult("Area", m, Area[m]);
			setResult("Mean", m, Mean[m]);
			setResult("IntDen", m, IntDen[m]);
			setResult("RawIntDen", m, RawIntDen[m]);		
			}
		 saveAs("Results", ""+RachisBackgrounddir+""+F+"_Rachisbackground.csv");
		 run("Clear Results");
	}
