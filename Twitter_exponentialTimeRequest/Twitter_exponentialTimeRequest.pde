int t=0;
for(int i=150; i>0; i--){
  t+=pow(150,2)-pow(i,2);
  println((150-i+1)+" requête: "+map(t,0,2238725,0,600));
}
