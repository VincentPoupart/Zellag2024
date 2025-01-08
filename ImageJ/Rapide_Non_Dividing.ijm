setBatchMode(true);
run("Close All");
run("Collect Garbage");
listc= getList("image.titles");
  if (listc.length==0)
     print("No image window are open in list c");
 else {
    print("Image windows in list c:");
     for (m=0; m<listc.length; m++)
        print("   "+listc[m]);
  }
 print("");

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
boby8 = "spin_non_dividing";
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



GetFiles(Spheres_at_Patchdirii);

GetFilesIV(Spheres_at_Patchdirii);




function GetFiles(Spheres_at_Patchdirii ) {//////// get txt files and send to sphere function
	liste = getFileList(Spheres_at_Patchdirii);
	Array.sort(liste); 
	for (m=0; m<liste.length; m++)
        print("   "+liste[m]);
        
        lista = newArray(0);
    for (i=0; i<liste.length; i++) {
    	
    		if ((endsWith(liste[i], ".txt"))){ //&& (matches(lista[i], "_Sphere_Cell_"))) {
    			lista = Array.concat(lista, ""+liste[i]+""); 
    					}
    }
    Array.sort(lista);	
    for (i=0; i<lista.length; i++) {
    				path = Spheres_at_Patchdirii+lista[i];
    				print("   "+lista[i]);
    				close("ROI Manager");
    				close("Histo*");
    				close("Log");
    				close("*.txt");
    				run("Close All");
    				run("Collect Garbage");
    			    sphere(path);
    			    Ext.closeFileOnly();
    			    Ext.close();
    			    close("*");
    			    run("Fresh Start");
                    run("Reset...", "reset=[Undo Buffer]");
    		}		run("Reset...", "reset=Clipboard");		
}	


function GetFilesIV(Spheres_at_Patchdirii) {//////// get tiff binary files and send to gonadeSeg function
	listb = getFileList(Spheres_at_Patchdirii);
	Array.sort(listb);
	listd = newArray(0); 
    for (i=0; i<listb.length; i++) {
    		if ((endsWith(listb[i], ".zip"))){
    			 listd = Array.concat(listd, ""+listb[i]+"");
    		}
    }
    Array.sort(listd);
    for (i=0; i<listd.length; i++) {
    				path = Spheres_at_Patchdirii+listd[i];
    				print("   "+listd[i]);
    				MeasureFluo(path);
    		}	
    }

// Closes the "Results" and "Log" windows and all image windows
function cleanUp() {
    
    if (isOpen("Results")) {
         selectWindow("Results"); 
         run("Close" );
    {
    if (isOpen("Log")) {
         selectWindow("Log");
         run("Close" );
    }
    while (nImages()>0) {
          selectImage(nImages());  
          run("Close");
    }
}
}
}

function MeasureFluo(path) {//////////measure background in a small sphere around the SM


////Make a list of zip files of spheres corresponding to the gonad


E = indexOf(""+listd[i]+"", "_Sphere");
F = substring(""+listd[i]+"", 0, E); 
Fr = substring(""+listd[i]+"", 2, E); 
SpecificMoviedir = ""+Moviedir+"\\"+Fr+"\\";
if(i == 0){
open(""+SpecificMoviedir+""+F+".tif");
selectImage(""+F+".tif");
run("Split Channels");
selectImage("C1-"+F+".tif");
close();
}
if(i > 0){
A = indexOf(""+listd[i-1]+"", "_Sphere");
B = substring(""+listd[i-1]+"", 0, A); 
Ab = substring(""+listd[i-1]+"", 2, A);
if(B != F) {
run("Close All");
run("Collect Garbage");		
open(""+SpecificMoviedir+""+F+".tif");
selectImage(""+F+".tif");
run("Split Channels");
selectImage("C1-"+F+".tif");
close();
}
}
        
                    
                    roiManager("reset");
                    
                    roiManager("open", ""+Spheres_at_Patchdirii+""+listd[i]+"");//////open the  corresponding sphere ROIs list
                    numROIs = roiManager("count");
                    if (numROIs>0){  
                    print(""+listd[i]+"");
                    selectImage("C2-"+F+".tif");
                    ResultsFluo();////measure the FI and arrange results
                    saveAs("Results", ""+Spheres_at_Patchdirii+""+listd[i]+".txt");
                    wait(50);
                    if (isOpen("Results")) { 
                    selectWindow("Results"); 
                    run("Close"); 
                    }
    		        }
    		        

}

function ResultsFluo(){///////measure fluorescence and make compilation by frames.


numROIs = roiManager("count");

Area = newArray(numROIs);
Mean = newArray(numROIs);
IntDen = newArray(numROIs);
RawIntDen = newArray(numROIs);
Slices = newArray(numROIs);
Frames = newArray(numROIs); 
        for(u=0; u<numROIs;u++) {
        roiManager("Select", u);
        Stack.getPosition(channel, slice, frame);
        Slices[u] = slice;
        Frames[u] = frame;
        run("Set Measurements...", "area mean integrated stack redirect=None decimal=3");
        run("Measure");	
        Area[u] = getResult("Area", u);
        Mean[u] = getResult("Mean", u);
        IntDen[u] = getResult("IntDen", u);
        RawIntDen[u] = getResult("RawIntDen", u);
        }
run("Clear Results");                 
        for(u=0; u<numROIs;u++) {//////arrange results
        setResult("Slices", u, ""+Slices[u]+"");
        setResult("Frames", u, ""+Frames[u]+"");
        setResult("Area", u, ""+Area[u]+"");
        setResult("Mean", u, ""+Mean[u]+"");
        setResult("RawIntDen", u, ""+RawIntDen[u]+"");
        }        
Table.update;
numCorr = lengthOf(IntDen);
Frame = newArray(numCorr+1);
IntDen = newArray(numCorr);
Mean = newArray(numCorr);
Area = newArray(numCorr);
numFrames = lengthOf(Frames);
        
        for(g=0; g<numCorr;g++) {
        Frame[g] = getResult("Frames", g);
        RawIntDen[g] = getResult("RawIntDen", g);
        Mean[g] = getResult("Mean", g);
        Area[g] = getResult("Area", g);
        }        
drum = newArray("0");
drumM = newArray("0");
drumA = newArray("0");
drumF = newArray("0");
Array.getStatistics(Frames, min, max, mean, stdDev);
Total = newArray(0);
TotalM = newArray(0);
TotalA = newArray(0);
TotalF = newArray(0);
        for(w=0; w<=numFrames;w++) {
        if(w == 0){
        	drum[0] = RawIntDen[w];
        	drumM[0] = Mean[w];
        	drumA[0] = Area[w];	
        	drumF[0] = Frame[w];
        }
        else {if(Frame[w-1] == Frame[w]){           	
            drum = Array.concat(drum, ""+RawIntDen[w]+"");
            drumM = Array.concat(drumM, ""+Mean[w]+"");
            drumA = Array.concat(drumA, ""+Area[w]+"");
            drumF = Array.concat(drumF, ""+Frame[w]+"");
            }             
        else {
              Table.setColumn("RawIntDenFrame"+Frame[w-1]+"", drum);
              Table.setColumn("MeanFrame"+Frame[w-1]+"", drumM);
              Table.setColumn("AreaFrame"+Frame[w-1]+"", drumA);
              Table.setColumn("Frame"+Frame[w-1]+"", drumF);
              
                 total = 0;
                 totalM = 0;
                 totalA = 0;
                 totalF = ""+Frame[w-1]+"";
              for (x=0;x<lengthOf(drum);x++){ 
                 total = total+drum[x];
                 totalM = totalM+drumM[x];
                 totalA = totalA+drumA[x];
                 
                }
              totalM = totalM/lengthOf(drum);////make the mean of mean fluorenscence int., total and totalA stay simple addition. 
              Total = Array.concat(Total, total);
              TotalM = Array.concat(TotalM, totalM);
              TotalA = Array.concat(TotalA, totalA);
              TotalF =  Array.concat(TotalF, totalF);
              drum = newArray("0");
              drumM = newArray("0");
              drumA = newArray("0");
              drumF = newArray("0");
              if(w < numFrames-1){
              drum[0]=RawIntDen[w];
              drumM[0]=Mean[w];
              drumA[0]=Area[w]; 
              drumF[0]=Frame[w]; 
              }
        }
        }
        }        
run("Clear Results"); 
Table.setColumn("Frame", TotalF);
Table.setColumn("RawIntDenTotal", Total);
Table.setColumn("MeanTotal", TotalM);
Table.setColumn("AreaTotal", TotalA); 
           
}

function sphere(path) {//////draw the spheres on the size according to matlab, please adjust the radius because the segmentation of the rachis is not perfect

	Table.open(path);
	
	rootii = substring(path, 0, lastIndexOf(path, "\\")+1);
	bobii = ""+lista[i]+"";
    salii = substring(bobii, 0, lastIndexOf(bobii, ".txt"));
	//File.makeDirectory(""+rootii+"\\"+salii+"\\");
	outii = ""+rootii+"\\"+salii+"\\";

  print(""+lista[i]+"");

    selectWindow(""+lista[i]+"");   
	FramesNumber = Table.size;
    

	///////get data in the txt file
    
	
	Frames = Table.getColumn("Frames");
    xcoord = Table.getColumn("xcoord");
    ycoord = Table.getColumn("ycoord");
    zcoord = Table.getColumn("zcoord");
    radius = Table.getColumn("radius");
    V1x = Table.getColumn("V1x");
    V1y = Table.getColumn("V1y");
    V1z = Table.getColumn("V1z");
    V2x = Table.getColumn("V2x");
    V2y = Table.getColumn("V2y");
    V2z = Table.getColumn("V2z");
    radius2 = Table.getColumn("radius2");
    
    
    selectWindow(""+lista[i]+"");
    close("*.txt");   
    run("Close All"); 
    
    

    
A = indexOf(""+lista[i]+"", "_Sphere_");  
B = substring(""+lista[i]+"", 0, A);
C = substring(""+lista[i]+"", 2, A);
SpecificMoviedir = ""+Moviedir+"\\"+C+"\\";
///////check the size of the original tif image (B) corresponding to the txt file
//////get statistics of the Frames column of the txt file


   run("Bio-Formats Macro Extensions"); 
   Ext.setId(""+SpecificMoviedir+""+B+".tif"); 
   Ext.getSizeX(width);
   Ext.getSizeY(height); 
   Ext.getSizeZ(slices); 
   Ext.getSizeT(sizeT);
   Ext.getPixelsPhysicalSizeX(sizeX);
   Ext.getPixelsPhysicalSizeZ(sizeZ);
 

  

Array.getStatistics(Frames, min, max, mean, stdDev);    
    
   
    
    
///////check the size of the original tif image (B) corresponding to the txt file
//////get statistics of the Frames column of the txt file


  
 
  
 
     ////check if the frame has a sphere for the cell
   	
   if ((ycoord[0]-radius2[0]>0) & (ycoord[0]+radius2[0]<height) & (xcoord[0]-radius2[0]>0) & (xcoord[0]+radius2[0]<width)& (zcoord[0]-radius2[0]>0) & (zcoord[0]+radius2[0]<sizeZ*slices)) {///check if the sphere is completely inside the movie

  
   //////// Draw the ellipsoid

   
   run("3D Draw Shape", "size="+width+","+height+","+slices+" centre="+xcoord[0]+","+ycoord[0]+","+zcoord[0]+" radius="+radius[0]+","+radius2[0]+","+radius2[0]+" vector1="+V1x[0]+","+V1y[0]+","+V1z[0]+" vector2="+V2x[0]+","+V2y[0]+","+V2z[0]+" res_xy="+sizeX+" res_z="+sizeZ+" unit=microns value=255 display=[New stack]");
   setAutoThreshold("Default dark");
   run("Threshold...");
   setOption("BlackBackground", false);
   run("Convert to Mask", "method=Default background=Dark calculate");
   close("Threshold");
   roiManager("reset");
   run("Analyze Particles...", "add stack");
   selectImage("Shape3D");
   
  C = indexOf(""+lista[i]+"", ".txt");
  D = substring(""+lista[i]+"", 0, C);
  numROIs = roiManager("count");
  if (numROIs>0){
   for(u=0; u<numROIs;u++) {
        roiManager("Select", u);
        Roi.getPosition(channel, slice, frame);
        frame = Frames[0];
        Roi.setPosition(channel, slice, frame);
   }	
   roiManager("Save", ""+Spheres_at_Patchdirii+""+D+".zip");
   //wait(10);
   roiManager("delete");
   selectImage("Shape3D");
   run("Close All");
   }
   }
  run("Close All");
  run("Collect Garbage");
  roiManager("reset");
  listc= getList("image.titles");
  if (listc.length==0)
     print("No image window are open in list c");
 else {
   print("Image windows in list c:");
    for (m=0; m<listc.length; m++)
        print("   "+listc[m]);
  }
 print("");
for (m=0; m<listc.length; m++){
        close(listc[m]);
          }	 


run("Close All");
    
}

run("Collect Garbage");
