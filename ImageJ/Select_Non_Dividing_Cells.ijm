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
boby6 = "NonDividingCellsList";

fluo_resultsdir = ""+root+"\\"+bo+"\\";
normaldir = ""+root+"\\"+bo+"\\"+boby1+"\\";
spindledir = ""+root+"\\"+bo+"\\"+boby2+"\\";
orthodir = ""+root+"\\"+bo+"\\"+boby3+"\\";
NonDividingLateraldir = ""+root+"\\"+bo+"\\"+boby4+"\\";
NonDividingNormaldir = ""+root+"\\"+bo+"\\"+boby5+"\\";
NonDividingCellsListdir = ""+root+"\\"+bo+"\\"+boby6+"\\";

File.makeDirectory(fluo_resultsdir);
File.makeDirectory(NonDividingCellsListdir);

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
		NonDividingCells(path);	
		}
	}

function NonDividingCells(path) {
	run("Close All");
	run("Collect Garbage");
	run("Clear Results"); 
	if (isOpen("Log")) {
		selectWindow("Log");
        run("Close" ); 
        }
    movie = substring(path, lastIndexOf(path, "/")+1, lengthOf(path));
    MovieName = substring(movie, 0, indexOf(movie,".tif"));
    print(MovieName);
	open(path);
	Stack.setDisplayMode("composite");	
	setTool("multipoint");
	run("Set Measurements...", "stack redirect=None decimal=3");
	waitForUser("SVP, cliquez sur 5 cellules");
	run("Clear Results");
	run("Measure");
	saveAs("Results", ""+NonDividingCellsListdir+"\\"+MovieName+".csv");
	}
