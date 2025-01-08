setBatchMode(true);
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
boby8 = "spin_non_dividing";///////////////////////////////////////////////////////Change this according which cortex
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

GetFilesIV(BINARYdir);




function GetFiles(Spheres_at_Patchdirii ) {//////// get txt files and send to sphere function
	lista = getFileList(Spheres_at_Patchdirii);
	Array.sort(lista); 
    for (i=0; i<lista.length; i++) {
    	
    		if ((endsWith(lista[i], ".txt"))){ //&& (matches(lista[i], "_Sphere_Cell_"))) {
    			 
    				path = Spheres_at_Patchdirii+lista[i];
    				
    				sphere(path);
    				run("Close All");
                    run("Collect Garbage");
                     if (isOpen("Log")) {
         selectWindow("Log");
         run("Close" );
                     } 
listc= getList("image.titles");
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
    		if ((endsWith(listb[i], ".txt"))){ 
    				path = BINARYdir+listb[i];
    				
    				MeasureFluo(path);
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

function MeasureFluo(path) {//////////measure background in a small sphere around the SM
run("Close All");
run("Collect Garbage");
if (isOpen("Log")) {
         selectWindow("Log");
         run("Close" ); 
}
////Make a list of zip files of spheres corresponding to the gonad
listA = getFileList(Spheres_at_Patchdirii);
zipfiles = newArray(0);
E = indexOf(""+listb[i]+"", ".txt");
F = substring(""+listb[i]+"", 0, E); 
Fr = substring(""+listb[i]+"", 2, E); 
    for (k=0; k<listA.length; k++) {
    		if (endsWith(""+listA[k]+"", ".zip")) {
    			G = indexOf(""+listA[k]+"", "_Sphere_Cell");
    			H = substring(""+listA[k]+"", 0, G);
    			if (H == F) {/////check if the beginning of name of the txt file correspond to the name of the original tif
    				zipfiles = Array.concat(zipfiles, ""+listA[k]+"");
    		}
    }
    }

SpecificMoviedir = ""+Moviedir+"\\"+Fr+"\\";
open(""+SpecificMoviedir+""+F+".tif");
selectImage(""+F+".tif");
run("Split Channels");
selectImage("C2-"+F+".tif");
close();
                    for (l=0; l<zipfiles.length; l++) {  //////Loop through the corresponding zip files
                    //roote = substring(path, 0, lastIndexOf(path, "\\")+1);
	                bobe = ""+zipfiles[l]+"";
                    
                    roiManager("reset");
                    
                    roiManager("open", ""+Spheres_at_Patchdirii+""+zipfiles[l]+"");//////open the  corresponding sphere ROIs list
                    numROIs = roiManager("count");
                    if (numROIs>0){  
                   
                    selectImage("C1-"+F+".tif");
                    ResultsFluo();////measure the FI and arrange results
                    saveAs("Results", ""+Spheres_at_Patchdirii+""+zipfiles[l]+"_channel_1.txt");
                    wait(500);
                    if (isOpen("Results")) { 
                    selectWindow("Results"); 
                    run("Close"); 
                    }
    		        }
    		        }
selectImage("C1-"+F+".tif");        
close();         

        if (isOpen("Results")) { 
         selectWindow("Results"); 
         run("Close"); 
         } 
run("Close All");
close("*");
}

function ResultsFluo(){///////measure fluorescence and make compilation by frames.

if (isOpen("Log")) {
         selectWindow("Log");
         run("Close" ); 
}
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
run("Close All");   
run("Collect Garbage");    
Table.open(path);
rootii = substring(path, 0, lastIndexOf(path, "\\")+1);
bobii = ""+lista[i]+"";
salii = substring(bobii, 0, lastIndexOf(bobii, ".txt"));
File.makeDirectory(""+rootii+"\\"+salii+"\\");
outii = ""+rootii+"\\"+salii+"\\";



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
    run("Close");    
 
    
    A = indexOf(""+lista[i]+"", "_Sphere_");  
    B = substring(""+lista[i]+"", 0, A);
    C = substring(""+lista[i]+"", 2, A);
    SpecificMoviedir = ""+Moviedir+"\\"+C+"\\";
    
   ///////check the size of the original tif image (B) corresponding to the txt file
  
   run("Bio-Formats Macro Extensions"); 
   //Ext.openImagePlus(pathy);
   Ext.setId(""+SpecificMoviedir+""+B+".tif"); 
   Ext.getSizeX(width);
   Ext.getSizeY(height); 
   Ext.getSizeZ(slices); 
   Ext.getSizeT(sizeT);
   Ext.getPixelsPhysicalSizeX(sizeX);
   Ext.getPixelsPhysicalSizeZ(sizeZ);
   
   Array.getStatistics(Frames, min, max, mean, stdDev);//////get statistics of the Frames column of the txt file


  roiManager("reset");  
  for (j=1; j<(sizeT+1); j++) {
  roiManager("reset");
   if ((j >= min) & (j <= max)){  ////check if the frame has a sphere for the cell
   	roiManager("reset");
   if ((ycoord[j-min]-radius2[j-min]>0) & (ycoord[j-min]+radius2[j-min]<height) & (xcoord[j-min]-radius2[j-min]>0) & (xcoord[j-min]+radius2[j-min]<width)& (zcoord[j-min]-radius2[j-min]>0) & (zcoord[j-min]+radius2[j-min]<sizeZ*slices)) {///check if the sphere is completely inside the movie

  
   //////// Draw the ellipsoid

   
   run("3D Draw Shape", "size="+width+","+height+","+slices+" centre="+xcoord[j-min]+","+ycoord[j-min]+","+zcoord[j-min]+" radius="+radius[j-min]+","+radius2[j-min]+","+radius2[j-min]+" vector1="+V1x[j-min]+","+V1y[j-min]+","+V1z[j-min]+" vector2="+V2x[j-min]+","+V2y[j-min]+","+V2z[j-min]+" res_xy="+sizeX+" res_z="+sizeZ+" unit=microns value=255 display=[New stack]");
   selectImage("Shape3D");
   run("Convert to Mask", "method=Default background=Dark calculate");
   roiManager("reset");
   
   run("Analyze Particles...", "add stack");
   
   numROIs = roiManager("count");
   if (numROIs>0){
   selectImage("Shape3D");
   for(u=0; u<numROIs;u++) {
        roiManager("Select", u);
   Roi.getPosition(channel, slice, frame);
   channel = 1;
   frame = Frames[j-min]; 
     
   Roi.setPosition(channel, slice, frame);      
   
   }
   roiManager("deselect");
   roiManager("save", ""+outii+"Sphere_Frame_"+j+".zip");
   selectImage("Shape3D");
   run("Close");
   }
   roiManager("reset");
  }
  }
  roiManager("reset");
}
 

   /////////open the serie of spheres and make an hyperstack
   
   roiManager("reset");
   for (j=1; j<(sizeT+1); j++) {
   if (File.exists(""+outii+"Sphere_Frame_"+j+".zip") == 1){;	
   roiManager("open", ""+outii+"Sphere_Frame_"+j+".zip");
   File.delete(""+outii+"Sphere_Frame_"+j+".zip");
   //File.delete(""+outii+"Sphere_Frame_"+j+".tif");
   }
   }	
  File.delete(outii);
  C = indexOf(""+lista[i]+"", ".txt");
  D = substring(""+lista[i]+"", 0, C);
 
   
   numROIs = roiManager("count");
    
  
   
   if (numROIs>0){
   	
   roiManager("Save", ""+Spheres_at_Patchdirii+""+D+".zip");
   roiManager("delete");
   }
  
  roiManager("reset");
  listc= getList("image.titles");
for (m=0; m<listc.length; m++){
        close(listc[m]);
          }	 


run("Close All");
    
}

run("Collect Garbage");
