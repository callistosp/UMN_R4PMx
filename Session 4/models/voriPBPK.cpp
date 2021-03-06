//Voriconazole PBPK model for a typical adult male


$PROB voriPBPK


$PARAM 
  //Tissue volumes (L); source: https://www.ncbi.nlm.nih.gov/pubmed/14506981
  Vad = 18.2 //adipose
  Vbo = 10.5 //bone
  Vbr = 1.45 //brain
  VguWall = 0.65  //gut wall
  VguLumen = 0.35 //gut lumen
  Vhe = 0.33 //heart
  Vki = 0.31 //kidneys
  Vli = 1.8 //liver
  Vlu = 0.5 //lungs
  Vmu = 29 //muscle
  Vsp = 0.15 //spleen
  Vbl = 5.6  //blood
  
  
  //Tissue blood flows (L/h); Cardiac output = 6.5 (L/min); source: https://www.ncbi.nlm.nih.gov/pubmed/14506981
  Qad = 0.05*6.5*60
  Qbo = 0.05*6.5*60
  Qbr = 0.12*6.5*60
  Qgu = 0.15*6.5*60 
  Qhe = 0.04*6.5*60
  Qki = 0.19*6.5*60
  Qmu = 0.17*6.5*60
  Qsp = 0.03*6.5*60
  Qha = 0.065*6.5*60  //hepatic artery
  Qlu = 6.5*60  //same as cardiac output
  
  //partition coefficients estimated by Poulin and Theil method https://jpharmsci.org/article/S0022-3549(16)30889-9/fulltext
  Kpad = 9.89  //adipose:plasma
  Kpbo = 7.91  //bone:plasma
  Kpbr = 7.35  //brain:plasma
  Kpgu = 5.82  //gut:plasma
  Kphe = 1.95  //heart:plasma
  Kpki = 2.9  //kidney:plasma
  Kpli = 4.66  //liver:plasma
  Kplu = 0.83  //lungs:plasma
  Kpmu = 0.78  //muscle:plasma; optimized
  Kpsp = 2.96  //spleen:plasma
  Kpre = 4 //calculated as average of non adipose Kps
  BP = 1.2 //blood:plasma ratio; optimized
  
  //other parameters
  WEIGHT = 73 //(kg)
  Ka = 0.849 //absorption rate constant(/hr) 
  fup = 0.42 //fraction of unbound drug in plasma
  
  //in vitro hepatic clearance parameters http://dmd.aspetjournals.org/content/38/1/25.long
  fumic = 0.711 //fraction of unbound drug in microsomes
  MPPGL = 30.3 //adult mg microsomal protein per g liver (mg/g)
  VmaxH = 40 //adult hepatic Vmax (pmol/min/mg)
  KmH = 9.3 //adult hepatic Km (uM)
  
  //Task 8: in vitro intestinal clearance parameters
  MPPGI = 30.3/21 //adult mg microsomal protein per g intestine (mg/g)
  VmaxG = 40 //adult intestinal Vmax (pmol/min/mg)
  KmG = 9.3 //adult intestinal Km (uM)



$CMT 
  D ADIPOSE BRAIN GUT HEART BONE 
  KIDNEY LIVER LUNG MUSCLE SPLEEN REST 
  ART VEN


$MAIN
  //additional volume derivations
  double Vgu = VguWall + VguLumen;  //total gut volume
  double Vve = 0.705*Vbl; //venous blood
  double Var = 0.295*Vbl; //arterial blood
  double Vre = WEIGHT - (Vli+Vki+Vsp+Vhe+Vlu+Vbo+Vbr+Vmu+Vad+VguWall+Vbl); //volume of rest of the body compartment
  
  //additional blood flow derivation
  double Qli = Qgu + Qsp + Qha;
  double Qtot = Qli + Qki + Qbo + Qhe + Qmu + Qad + Qbr;
  double Qre = Qlu - Qtot;
  
  //intrinsic hepatic clearance calculation
  double scale_factor_H = MPPGL*Vli*1000; //hepatic scale factor (mg)
  double CLintHep = (VmaxH/KmH)*scale_factor_H*60*1e-6; //(L/hr)
  CLintHep = CLintHep/fumic; 
  
  double scale_factor_G = MPPGI*VguWall*1000; //intestinal scale factor (mg)
  double CLintGut = (VmaxG/KmG)*scale_factor_G*60*1e-6; //(L/hr)
  CLintGut = CLintGut/fumic;
  
  //renal clearance https://link.springer.com/article/10.1007%2Fs40262-014-0181-y
  double CLrenal = 0.096; //(L/hr)

$ODE
  //Calculation of tissue drug concentrations (mg/L)
  double Cadipose = ADIPOSE/Vad;
  double Cbone = BONE/Vbo;
  double Cbrain = BRAIN/Vbr; 
  double Cgut = GUT/VguWall; 
  double Cheart = HEART/Vhe; 
  double Ckidney = KIDNEY/Vki;
  double Cliver = LIVER/Vli; 
  double Clung = LUNG/Vlu; 
  double Cmuscle = MUSCLE/Vmu;
  double Cspleen = SPLEEN/Vsp;
  double Crest = REST/Vre;
  double Carterial = ART/Var;
  double Cvenous = VEN/Vve;
  double Cgut_D = D/Vgu;
  
  //Free Concentration Calculations
  double Cliverfree = Cliver*fup; 
  double Ckidneyfree = Ckidney*fup;
  
  
  //ODEs; Task 1 Code here:



$CAPTURE Cvenous
  
  
  