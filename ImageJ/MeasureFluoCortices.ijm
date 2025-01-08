setBatchMode(true);
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
boby6 = "vert";
boby7 = "NonDividingVert";
boby8 = "OrthoDP";
boby9 = "NonDividingOrthoDP";
boby10 = "ProphaseVert";
boby11 = "ProphaseOrthoDP";
boby12 = "ProphaseNormal";
boby13 = "ProphaseBasalScored";

normaldir = ""+root+"\\"+bo+"\\"+boby1+"\\";
spindledir = ""+root+"\\"+bo+"\\"+boby2+"\\";
orthodir = ""+root+"\\"+bo+"\\"+boby3+"\\";
vertdir = ""+root+"\\"+bo+"\\"+boby6+"\\";
NonDividingLateraldir = ""+root+"\\"+bo+"\\"+boby4+"\\";
NonDividingNormaldir = ""+root+"\\"+bo+"\\"+boby5+"\\";
NonDividingVertdir = ""+root+"\\"+bo+"\\"+boby7+"\\";
OrthoDPdir = ""+root+"\\"+bo+"\\"+boby8+"\\";
NonDividingOrthoDPdir = ""+root+"\\"+bo+"\\"+boby9+"\\";
ProphaseOrthoDPdir = ""+root+"\\"+bo+"\\"+boby11+"\\";
ProphaseNormaldir = ""+root+"\\"+bo+"\\"+boby12+"\\";
ProphaseVertdir = ""+root+"\\"+bo+"\\"+boby10+"\\";
ProphaseBasalScoreddir = ""+root+"\\"+bo+"\\"+boby13+"\\";

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
		//GenerateDisksROIs(path, normaldir);
	    //GenerateDisksROIs(path, spindledir);
		//GenerateDisksROIs(path, orthodir);
		//GenerateDisksROIs(path, vertdir);
		//GenerateDisksROIs(path, NonDividingNormaldir);
		//GenerateDisksROIs(path, NonDividingVertdir);
		//GenerateDisksROIs(path, OrthoDPdir);
		//GenerateDisksROIs(path, NonDividingOrthoDPdir);
		//GenerateDisksROIs(path, ProphaseOrthoDPdir);
		//GenerateDisksROIs(path, ProphaseVertdir);
		//GenerateDisksROIs(path, ProphaseNormaldir);
		GenerateDisksROIs(path, ProphaseBasalScoreddir);
		SendChannelsToMeasure(path);	
		}
	}

function GenerateDisksROIs(PathToMovie, DirROIs) {
	movie = substring(PathToMovie, lastIndexOf(PathToMovie, "/")+1, lengthOf(PathToMovie));
	listA = getFileList(DirROIs);
	if (listA.length > 0) {
		txtfiles = newArray(0);
 		E = indexOf(movie, ".tif");
    	F = substring(movie, 0, E);
    	run("Bio-Formats Macro Extensions"); 
    	Ext.setId(PathToMovie); 
    	Ext.getSizeX(width);
    	Ext.getSizeY(height); 
    	Ext.getSizeZ(slices); 
    	Ext.getSizeT(sizeT);
    	Ext.getPixelsPhysicalSizeX(sizeX);
    	Ext.getPixelsPhysicalSizeZ(sizeZ);
    	for (k=0; k<listA.length; k++) {
    		if (endsWith(""+listA[k]+"", ".txt")) {
    			if (indexOf(""+listA[k]+"", "channel") == -1) { 
    				G = indexOf(""+listA[k]+"", "_Disk_Cell");
    				H = substring(""+listA[k]+"", 0, G);
    				if (H == F) {
    					txtfiles = Array.concat(txtfiles, ""+listA[k]+"");
    					}
    				}
    			}
    		}
    	for (l=0; l<txtfiles.length; l++) {
    		C = indexOf(""+txtfiles[l]+"", ".txt");
    		D = substring(""+txtfiles[l]+"", 0, C);
    		if (File.exists(""+DirROIs+""+D+".zip") == 0){  
    			bobe = ""+txtfiles[l]+"";
		    	Table.open(""+DirROIs+""+txtfiles[l]+"");
		    	fou = substring(txtfiles[l],0,lastIndexOf(txtfiles[l], ".txt"));
		    	foo = DirROIs+"\\"+fou+"\\";
		    	File.makeDirectory(foo);
		    	selectWindow(""+txtfiles[l]+"");   
		    	FramesNumber = Table.size;
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
		    	selectWindow(""+txtfiles[l]+"");
		    	run("Close");    
		    	Array.getStatistics(Frames, min, max, mean, stdDev);
		    	roiManager("reset");
		    	for (j=1; j<(sizeT+1); j++) {
		    		roiManager("reset");
		    		if ((j >= min) & (j <= max)){ 
		    			roiManager("reset");
				    	if ((ycoord[j-min]-radius2[j-min]>0) & (ycoord[j-min]+radius2[j-min]<height) & (xcoord[j-min]-radius2[j-min]>0) & (xcoord[j-min]+radius2[j-min]<width)& (zcoord[j-min]-radius2[j-min]>0) & (zcoord[j-min]+radius2[j-min]<sizeZ*slices)) {///check if the sphere is completely inside the movie
				    		run("3D Draw Shape", "size="+width+","+height+","+slices+" centre="+xcoord[j-min]+","+ycoord[j-min]+","+zcoord[j-min]+" radius="+radius[j-min]+","+radius2[j-min]+","+radius2[j-min]+" vector1="+V1x[j-min]+","+V1y[j-min]+","+V1z[j-min]+" vector2="+V2x[j-min]+","+V2y[j-min]+","+V2z[j-min]+" res_xy="+sizeX+" res_z="+sizeZ+" unit=microns value=255 display=[New stack]");
					    	selectImage("Shape3D");
					    	run("Convert to Mask", "method=Default background=Dark calculate");
					    	roiManager("reset");
					    	run("Analyze Particles...", "add stack");
					    	}
				    	numROIs = roiManager("count");
				    	if (numROIs>0) {
					    	selectImage("Shape3D");
					    	for(u=0; u<numROIs;u++) {
						    	roiManager("Select", u);
						    	Roi.getPosition(channel, slice, frame);
						    	channel = 1;
						    	frame = Frames[j-min]; 
						    	Roi.setPosition(channel, slice, frame);
						    	}
					    	roiManager("deselect");
					    	roiManager("save", foo+"Disk_Frame_"+j+".zip");
					    	selectImage("Shape3D");
					    	run("Close");
					    	}
				    	roiManager("reset");
				    	}
			    	}
		    	roiManager("reset");
		    	for (j=1; j<(sizeT+1); j++) {
			    	if (File.exists(""+foo+"Disk_Frame_"+j+".zip") == 1) {	
			    		roiManager("open", ""+foo+"Disk_Frame_"+j+".zip");
				     	File.delete(""+foo+"Disk_Frame_"+j+".zip");
				    	}
			    	}
		    	File.delete(foo);
		    	C = indexOf(""+txtfiles[l]+"", ".txt");
		    	D = substring(""+txtfiles[l]+"", 0, C);
		    	numROIs = roiManager("count");
		    	if (numROIs>0) {
			    	roiManager("Save", ""+DirROIs+""+D+".zip");
			    	roiManager("delete");
			    	}
		    	roiManager("reset");
		    	listc= getList("image.titles");
		    	for (m=0; m<listc.length; m++) {
			    	close(listc[m]);
			    	}
		    	run("Close All");
		    	}
	    	}  
    	}
	}

function SendChannelsToMeasure(fazer) { 
	// function description
	movie = substring(fazer, lastIndexOf(fazer, "/")+1, lengthOf(fazer));
	open(fazer);
	selectImage(movie);
	run("Split Channels");
	//MeasureFluoCh("C1-"+movie, normaldir);
	//MeasureFluoCh("C1-"+movie, spindledir);
	//MeasureFluoCh("C1-"+movie, orthodir);
	//MeasureFluoCh("C1-"+movie, vertdir);
	//MeasureFluoCh("C1-"+movie, NonDividingNormaldir);
	//MeasureFluoCh("C1-"+movie, NonDividingVertdir);
	//MeasureFluoCh("C1-"+movie, OrthoDPdir);
	//MeasureFluoCh("C1-"+movie, NonDividingOrthoDPdir);
	//MeasureFluoCh("C1-"+movie, ProphaseOrthoDPdir);
	//MeasureFluoCh("C1-"+movie, ProphaseNormaldir);
	//MeasureFluoCh("C1-"+movie, ProphaseVertdir);
	MeasureFluoCh("C1-"+movie, ProphaseBasalScoreddir);
	selectImage("C1-"+movie);
	close();

	//MeasureFluoCh("C2-"+movie, normaldir);
	//MeasureFluoCh("C2-"+movie, spindledir);
	//MeasureFluoCh("C2-"+movie, orthodir);
	//MeasureFluoCh("C2-"+movie, vertdir);
	//MeasureFluoCh("C2-"+movie, NonDividingNormaldir);
	//MeasureFluoCh("C2-"+movie, NonDividingVertdir);
	//MeasureFluoCh("C2-"+movie, OrthoDPdir);
	//MeasureFluoCh("C2-"+movie, NonDividingOrthoDPdir);
	//MeasureFluoCh("C2-"+movie, ProphaseOrthoDPdir);
	//MeasureFluoCh("C2-"+movie, ProphaseNormaldir);
	//MeasureFluoCh("C2-"+movie, ProphaseVertdir);
	MeasureFluoCh("C2-"+movie, ProphaseBasalScoreddir);
	selectImage("C2-"+movie);
	close();
	}

function MeasureFluoCh(movie, DirROIs) { 
	// function description
    listA = getFileList(DirROIs);
    if (listA.length>0) {
    	MovieName = substring(movie, 3);
        ChannelNumber = substring(movie, 1, 2);
        zipfiles = newArray(0);
		E = indexOf(MovieName, ".tif");
		F = substring(MovieName, 0, E); 
		for (k=0; k<listA.length; k++) {
			if (endsWith(""+listA[k]+"", ".zip")) {
				G = indexOf(""+listA[k]+"", "_Disk_Cell");
				H = substring(""+listA[k]+"", 0, G);
				if (H == F) {
					zipfiles = Array.concat(zipfiles, ""+listA[k]+"");
					}
				}
			}
			for (l=0; l<zipfiles.length; l++) {  
				bobe = ""+zipfiles[l]+"";
				roiManager("reset");
				roiManager("open", ""+DirROIs+""+zipfiles[l]+"");
				numROIs = roiManager("count");
				if (File.exists(""+DirROIs+""+zipfiles[l]+"_channel_"+ChannelNumber+".txt") == 0){  
					if (numROIs>0) {  
						selectImage(movie);
                        ResultsFluo();
        				saveAs("Results", ""+DirROIs+""+zipfiles[l]+"_channel_"+ChannelNumber+".txt");
        				if (isOpen("Results")) { 
        					selectWindow("Results"); 
        					run("Close"); 
        					}
        				}
        			}
    			}
			}
		}
function ResultsFluo() {
	if (isOpen("Log")) {
		selectWindow("Log");
		run("Close" ); 
		}
	numROIs = roiManager("count");
	Area = newArray(numROIs);
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
    	IntDen[u] = getResult("IntDen", u);
    	RawIntDen[u] = getResult("RawIntDen", u);
    	}
		run("Clear Results");
	for(u=0; u<numROIs;u++) {
		setResult("Slices", u, ""+Slices[u]+"");
    	setResult("Frames", u, ""+Frames[u]+"");
    	setResult("Area", u, ""+Area[u]+"");
    	setResult("RawIntDen", u, ""+RawIntDen[u]+"");
    	}        
	Table.update;
	numCorr = lengthOf(IntDen);
	Frame = newArray(numCorr+1);
	IntDen = newArray(numCorr);
	Area = newArray(numCorr);
	numFrames = lengthOf(Frames);
	for(g=0; g<numCorr;g++) {
		Frame[g] = getResult("Frames", g);
    	RawIntDen[g] = getResult("RawIntDen", g);
    	Area[g] = getResult("Area", g);
    	}        
	drum = newArray("0");
	drumA = newArray("0");
	drumF = newArray("0");
	Array.getStatistics(Frames, min, max, mean, stdDev);
	Total = newArray(0);
	TotalA = newArray(0);
	TotalF = newArray(0);
	for(w=0; w<=numFrames;w++) {
		if(w == 0){
			drum[0] = RawIntDen[w];
        	drumA[0] = Area[w];	
        	drumF[0] = Frame[w];
        	}
        else { 
        	if(Frame[w-1] == Frame[w])	{
        		drum = Array.concat(drum, ""+RawIntDen[w]+"");
            	drumA = Array.concat(drumA, ""+Area[w]+"");
            	drumF = Array.concat(drumF, ""+Frame[w]+"");
            	}
            else {
            	Table.setColumn("RawIntDenFrame"+Frame[w-1]+"", drum);
            	Table.setColumn("AreaFrame"+Frame[w-1]+"", drumA);
                Table.setColumn("Frame"+Frame[w-1]+"", drumF);
                total = 0;
               	totalA = 0;
                totalF = ""+Frame[w-1]+"";
                for (x=0;x<lengthOf(drum);x++){ 
                	total = total+drum[x];
                	totalA = totalA+drumA[x];
                	}
                Total = Array.concat(Total, total);
                TotalA = Array.concat(TotalA, totalA);
                TotalF =  Array.concat(TotalF, totalF);
                drum = newArray("0");
                drumA = newArray("0");
                drumF = newArray("0");
                if(w < numFrames-1){
                	drum[0]=RawIntDen[w];
                	drumA[0]=Area[w]; 
                	drumF[0]=Frame[w]; 
                	}
                }
            }
        }        
	run("Clear Results"); 
	Table.setColumn("Frame", TotalF);
	Table.setColumn("RawIntDenTotal", Total);
	Table.setColumn("AreaTotal", TotalA);           
	}








