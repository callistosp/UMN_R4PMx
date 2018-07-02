//Hands-on simple PBPK model for a typical adult male


$PROB simplePBPK


$PARAM 
  //Tissue volumes (L); source: https://www.ncbi.nlm.nih.gov/pubmed/14506981
  Vli = 1.8 //liver
  Vlu = 0.5 //lungs
  Vmu = 29 //muscle
  Vve = 3.948 //venous blood
  Var = 1.652 //arterial blood
  
  //Tissue blood flows (L/h); Cardiac output = 6.5 (L/min); source: https://www.ncbi.nlm.nih.gov/pubmed/14506981
  Qmu = 0.17*6.5*60
  Qli = 0.245*6.5*60
  Qlu = 6.5*60
  
  //partition coefficients (voriconazole); as estimated by Poulin and Theil https://jpharmsci.org/article/S0022-3549(16)30889-9/fulltext
  Kpli = 4.66
  Kplu = 0.83
  Kpmu = 2.94
  Kpre = 4 //calculated as average of non adipose Kps
  BP = 1  //blood to plasma concentration ratio
  
  //other parameters
  WEIGHT = 73 //(kg); adult male body weight
  fup = 0.42 //fraction of unbound drug in plasma
  Cl_hepatic = 10  //hepatic clearance
  

$CMT 
  LIVER LUNG MUSCLE REST ART VEN


$MAIN
  double Vre = WEIGHT - (Vli+Vlu+Vmu+Vve+Var); //volume of rest of the body compartment
  double Qre = Qlu - (Qli + Qmu);  //blood flow to rest of body compartment


$ODE
  //Calculation of tissue drug concentrations (mg/L)
  double Cliver = LIVER/Vli; 
  double Clung = LUNG/Vlu; 
  double Cmuscle = MUSCLE/Vmu;
  double Crest = REST/Vre;
  double Carterial = ART/Var;
  double Cvenous = VEN/Vve;

  //ODEs
  dxdt_LIVER = Qli*(Carterial - Cliver/(Kpli/BP)) - Cl_hepatic*fup*(Cliver/(Kpli/BP)); 
  dxdt_LUNG = Qlu*(Cvenous - Clung/(Kplu/BP));
  dxdt_MUSCLE = Qmu*(Carterial - Cmuscle/(Kpmu/BP));
  dxdt_REST = Qre*(Carterial - Crest/(Kpre/BP));
  dxdt_VEN = Qli*(Cliver/(Kpli/BP)) + Qmu*(Cmuscle/(Kpmu/BP)) + Qre*(Crest/(Kpre/BP)) - Qlu*Cvenous;
  dxdt_ART = Qlu*(Clung/(Kplu/BP) - Carterial);

  
  
  