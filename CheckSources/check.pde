String[][] sources;
String[][] tmp;

void setup(){
	sources = new String[checkedFiles.length][];
	for (int i = 0; i<checkedFiles.length; i++){
		sources[i]=loadStrings(checkedFiles[i]);
	}
	tmp = new String[checkedFiles.length][];
}

void draw(){
	for (int i = 0; i<checkedFiles.length; i++){
		tmp[i]=loadStrings(checkedFiles[i]);
		for (int j = 0; j < tmp[i].length; j++) {
			if(tmp[i][j].equals(sources[i][j])==false){
				document.location.reload();
			}
		}
	}
}