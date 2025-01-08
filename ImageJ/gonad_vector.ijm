setBatchMode(false);
run("Close All");
run("Collect Garbage");
listc= getList("image.titles");
for (m=0; m<listc.length; m++){
        close(listc[m]);
          }	

               
dir = getDirectory("Please choose a source directory.");
close("*");

root = substring(dir, 0, lastIndexOf(dir, "\\"));
bo = "fluo_results";
bob = "Spheres";
bobi = "BINARY";
boba = "MOVIES";
bobu = "Intersection";
boby = "Background";
boby2 = "Bleaching";
boby3 =  "FluoAtSpherePatch";
boby4 = "BackgroundSpheres";
boby6 = "Spheres_at_centrosome";
boby7 = "Spheres_at_Patch_translation";
boby8 = "Spindle_all_1";
BackgroundSpheresdir = ""+root+"\\"+bo+"\\"+boby4+"\\";
Intersectiondir = ""+root+"\\"+bo+"\\"+bobu+"\\";
Spheresdir = ""+root+"\\"+bo+"\\"+bob+"\\";
BINARYdir = ""+root+"\\"+bobi+"\\";
Moviedir = ""+root+"\\"+boba+"\\";
Backgrounddir = ""+root+"\\"+bo+"\\"+boby+"\\";
Bleachingdir = ""+root+"\\"+bo+"\\"+boby2+"\\";
FluoAtSpherePatchdir = ""+root+"\\"+bo+"\\"+boby3+"\\";
Spheres_at_centrosomedir = ""+root+"\\"+bo+"\\"+boby6+"\\";
Spheres_at_Patchdir = ""+root+"\\"+bo+"\\"+boby7+"\\";
Spheres_at_Patchdirii = ""+root+"\\"+bo+"\\"+boby8+"\\";


GetFilesIV(BINARYdir);






function GetFilesIV(BINARYdir) {//////// get tiff binary files and send to gonadeSeg function
	listb = getFileList(BINARYdir);
	Array.sort(listb); 
    for (i=0; i<listb.length; i++) {
    		if ((endsWith(listb[i], ".xlsx"))){ 
    				path = BINARYdir+listb[i];
    				
    				gonadvector(path);
    				run("Close All");
                    run("Collect Garbage");
listc= getList("image.titles");
 
if (isOpen("Log")) {
         selectWindow("Log");
         run("Close" ); 
}
for (m=0; m<listc.length; m++){
        close(listc[m]);
          }	
    		}	
    }
}

function gonadvector(path) {
run("Close All");
run("Collect Garbage");
run("Clear Results"); 
if (isOpen("Log")) {
         selectWindow("Log");
         run("Close" ); 
}

zipfiles = newArray(0);
E = indexOf(""+listb[i]+"", ".xlsx");
F = substring(""+listb[i]+"", 0, E); 
Fr = substring(""+listb[i]+"", 2, E); 
SpecificMoviedir = ""+Moviedir+"\\"+Fr+"\\";
run("Bio-Formats Macro Extensions"); 
//Ext.openImagePlus(pathy);
Ext.setId(""+SpecificMoviedir+""+F+".tif"); 
Ext.getSizeX(width);
Ext.getSizeY(height); 
Ext.getSizeZ(slices); 
Ext.getSizeT(sizeT);
Ext.getPixelsPhysicalSizeX(sizeX);
Ext.getPixelsPhysicalSizeZ(sizeZ);
print(sizeZ);
open(""+SpecificMoviedir+""+F+".tif");
Stack.setDisplayMode("composite");	
setTool("multipoint");
X1= newArray();
X2= newArray();
Y1= newArray();
Y2= newArray();
Z1= newArray();
Z2= newArray();
Frame = newArray();
for (n=0; n<sizeT; n++){
	if (n == 0) {
		Stack.setPosition(1, slices/2, n+1);
		waitForUser("SVP, cliquez sur les deux extrémités du rachis");
		Stack.getPosition(channel, slice, frame);
	}
	else {
		Stack.setPosition(1, slice, n+1);
		waitForUser("SVP, cliquez sur les deux extrémités du rachis");
		Stack.getPosition(channel, slice, frame);
	}
    run("Measure");
    run("Select None");
    X1 = Array.concat(X1, getResult("X", 0));
    X2 = Array.concat(X2, getResult("X", 1));	
    Y1 = Array.concat(Y1, getResult("Y", 0));
    Y2 = Array.concat(Y2, getResult("Y", 1));
    Z1 = Array.concat(Z1, getResult("Slice", 0)*sizeZ);
    Z2 = Array.concat(Z2, getResult("Slice", 1)*sizeZ);
    Frame = Array.concat(Frame, getResult("Frame", 0));
    run("Clear Results");
}
LX = lengthOf(X1);	 
for (n=0; n<LX; n++){
	setResult("X1", n, X1[n]);
	setResult("X2", n, X2[n]);
	setResult("Y1", n, Y1[n]);
	setResult("Y2", n, Y2[n]);
	setResult("Z1", n, Z1[n]);
	setResult("Z2", n, Z2[n]);
	setResult("Frame", n, Frame[n]);	
}
saveAs("Results", ""+Moviedir+"\\"+Fr+"\\"+F+".txt");
}
