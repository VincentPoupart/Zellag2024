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
boby8 = "Spheres_translation_along_spin_vect";
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
//GetFiles(Spheres_at_Patchdirii);
run("Collect Garbage");
GetFilesIV(BINARYdir);
run("Collect Garbage");



function GetFiles(Spheres_at_Patchdirii ) {//////// get csv files and send to sphere function
	lista = getFileList(Spheres_at_Patchdirii);
	Array.sort(lista); 
	for (m=0; m<lista.length; m++)
        print("   "+lista[m]);
    for (i=0; i<lista.length; i++) {
    	
    		if ((endsWith(lista[i], ".csv"))){ //&& (matches(lista[i], "_Sphere_Cell_"))) {
    			 
    				path = Spheres_at_Patchdirii+lista[i];
    				
    				sphere(path);
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
    		}	
    }
}


function GetFilesIV(BINARYdir) {//////// get tiff binary files and send to gonadeSeg function
	listb = getFileList(BINARYdir);
	Array.sort(listb); 
    for (i=0; i<listb.length; i++) {
    		if ((endsWith(listb[i], ".xlsx"))){ 
    				path = BINARYdir+listb[i];
    				
    				MeasureFluo(path);
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
    		}	
    }
}

function MeasureFluo(path) {//////////measure background in a small sphere around the SM


////Make a list of zip files of spheres corresponding to the gonad
listA = getFileList(Spheres_at_Patchdirii);
zipfiles = newArray(0);
E = indexOf(""+listb[i]+"", ".xlsx");
F = substring(""+listb[i]+"", 0, E); 
Fr = substring(""+listb[i]+"", 2, E); 
    for (k=0; k<listA.length; k++) {
    		if (endsWith(""+listA[k]+"", ".zip")) {
    			G = indexOf(""+listA[k]+"", "_Sphere_Cell");
    			H = substring(""+listA[k]+"", 0, G);
    			if (H == F) {/////check if the beginning of name of the csv file correspond to the name of the original tif
    				zipfiles = Array.concat(zipfiles, ""+listA[k]+"");
    		}
    }
    }

SpecificMoviedir = ""+Moviedir+"\\"+Fr+"\\";
open(""+SpecificMoviedir+""+F+".tif");
selectImage(""+F+".tif");
run("Split Channels");
selectImage("C1-"+F+".tif");
close();
                    for (l=0; l<zipfiles.length; l++) {  //////Loop through the corresponding zip files
                    //roote = substring(path, 0, lastIndexOf(path, "\\")+1);
	                bobe = ""+zipfiles[l]+"";
                    
                    roiManager("reset");
                    
                    roiManager("open", ""+Spheres_at_Patchdirii+""+zipfiles[l]+"");//////open the  corresponding sphere ROIs list
                    numROIs = roiManager("count");
                    if (numROIs>0){  
                    roiManager("sort");
                    selectImage("C2-"+F+".tif");
                    ResultsFluo();////measure the FI and arrange results
                    saveAs("Results", ""+Spheres_at_Patchdirii+""+zipfiles[l]+".csv");
                    wait(500);
                    if (isOpen("Results")) { 
                    selectWindow("Results"); 
                    run("Close"); 
                    }
    		        }
    		        }
selectImage("C2-"+F+".tif");        
close();         

        if (isOpen("Results")) { 
         selectWindow("Results"); 
         run("Close"); 
         } 
run("Close All");
close("*");
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
    print(path);
	Table.open(path);
	
	rootii = substring(path, 0, lastIndexOf(path, "\\")+1);
	bobii = ""+lista[i]+"";
    salii = substring(bobii, 0, lastIndexOf(bobii, ".csv"));
	File.makeDirectory(""+rootii+"\\"+salii+"\\");
	outii = ""+rootii+"\\"+salii+"\\";



    selectWindow(""+lista[i]+"");   
	FramesNumber = Table.size;


	///////get data in the csv file
    
	
	Frames = Table.getColumn("C1");
    xcoord = Table.getColumn("C2");
    ycoord = Table.getColumn("C3");
    zcoord = Table.getColumn("C4");
    radius = Table.getColumn("C5");
    V1x = Table.getColumn("C6");
    V1y = Table.getColumn("C7");
    V1z = Table.getColumn("C8");
    V2x = Table.getColumn("C9");
    V2y = Table.getColumn("C10");
    V2z = Table.getColumn("C11");
    radius2 = Table.getColumn("C12");
    
    selectWindow(""+lista[i]+"");
    run("Close");    
 
    
    A = indexOf(""+lista[i]+"", "_Sphere_");  
    B = substring(""+lista[i]+"", 0, A);
    C = substring(""+lista[i]+"", 2, A);
    SpecificMoviedir = ""+Moviedir+"\\"+C+"\\";
    
   ///////check the size of the original tif image (B) corresponding to the csv file
  
   run("Bio-Formats Macro Extensions"); 
   //Ext.openImagePlus(pathy);
   Ext.setId(""+SpecificMoviedir+""+B+".tif"); 
   Ext.getSizeX(width);
   Ext.getSizeY(height); 
   Ext.getSizeZ(slices); 
   Ext.getSizeT(sizeT);
   Ext.getPixelsPhysicalSizeX(sizeX);
   Ext.getPixelsPhysicalSizeZ(sizeZ);
   
   Array.getStatistics(Frames, min, max, mean, stdDev);//////get statistics of the Frames column of the csv file


    
  for (j=1; j<(sizeT+1); j++) {
 
   if ((j >= min) & (j <= max)){  ////check if the frame has a sphere for the cell
   if ((ycoord[j-min]-radius[j-min]>0) & (ycoord[j-min]+radius[j-min]<height) & (xcoord[j-min]-radius[j-min]>0) & (xcoord[j-min]+radius[j-min]<width)& (zcoord[j-min]-radius[j-min]>0) & (zcoord[j-min]+radius[j-min]<sizeZ*slices)) {///check if the sphere is completely inside the movie

  
   //////// Draw the ellipsoid

   run("3D Draw Shape", "size="+width+","+height+","+slices+" center="+xcoord[j-min]+","+ycoord[j-min]+","+zcoord[j-min]+"radius="+radius[j-min]+","+radius2[j-min]+","+radius2[j-min]+" vector1=["+V1x[j-min]+","+V1y[j-min]+","+V1z[j-min]+"]vector2=["+V2x[j-min]+","+V2y[j-min]+","+V2z[j-min]+"] res_xy="+sizeX+" res_z="+sizeZ+" unit=microns value=255 display=[New stack]");
   selectImage("Shape3D");
   saveAs("Tiff", ""+outii+"Sphere_Frame_"+j+".tif");
   selectImage("Sphere_Frame_"+j+".tif");
   wait(50);
   run("Close");
   }
   
   ///////// if not, draw a sphere of size 0
   else {run("3D Draw Shape", "size="+width+","+height+","+slices+" center=1,1,1 radius=0,0,0 vector1=1.0,0.0,0.0 vector2=0.0,1.0,0.0 res_xy="+sizeX+" res_z="+sizeZ+" unit=microns value=255 display=[New stack]");
   selectImage("Shape3D");
   saveAs("Tiff", ""+outii+"Sphere_Frame_"+j+".tif");
   selectImage("Sphere_Frame_"+j+".tif");
   wait(50);
   run("Close");
   }
   }
   else {run("3D Draw Shape", "size="+width+","+height+","+slices+" center=1,1,1 radius=0,0,0 vector1=1.0,0.0,0.0 vector2=0.0,1.0,0.0 res_xy="+sizeX+" res_z="+sizeZ+" unit=microns value=255 display=[New stack]");
   selectImage("Shape3D");
   saveAs("Tiff", ""+outii+"Sphere_Frame_"+j+".tif");
   selectImage("Sphere_Frame_"+j+".tif");
   wait(50);
   run("Close");
   }
}
   

   /////////open the serie of spheres and make an hyperstack
 run("Image Sequence...", "open=["+outii+"Sphere_Frame_"+1+".tif] sort");
 run("Stack to Hyperstack...", "order=xyczt(default) channels=1 slices="+slices+" frames="+sizeT+" display=Color");
   
   for (j=1; j<(sizeT+1); j++) {
  File.delete(""+outii+"Sphere_Frame_"+j+".tif");
   }
  File.delete(outii);
  C = indexOf(""+lista[i]+"", ".csv");
  D = substring(""+lista[i]+"", 0, C);
 
   selectImage(D);   
   setAutoThreshold("Default dark");
   run("Threshold...");
   setOption("BlackBackground", false);
   run("Convert to Mask", "method=Default background=Dark calculate");
   roiManager("reset");
   run("Analyze Particles...", "add stack");
   numROIs = roiManager("count");
   if (numROIs>0){
   roiManager("Save", ""+Spheres_at_Patchdirii+""+D+".zip");
   roiManager("delete");
   }
  selectImage(D); 
  wait(50);
  run("Close");

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
