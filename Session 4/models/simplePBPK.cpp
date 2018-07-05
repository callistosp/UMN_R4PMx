//Task 1: Build a simple PBPK model for a typical adult male

$PARAM 
 //volumes
 Vli = 1.8//kg:L Volume of Liver
 Vmu = 29//L
 Vlu = 0.5//L
 Var = 3.9//L
 Vve = 1.7//L
 
 //flows; cardiac output for typical male = 6.5 L/min
 Qli = 0.245*6.5*60//L/hr
 Qmu = 0.17*6.5*60//L/hr
 Qlu = 6.5*60//L/hr
 
 //Partition coefficients; Poulin and Theil
 Kpli = 4.66
 Kpmu = 2.94
 Kplu = 0.83
 Kpre = 4
 BP = 1
 
 //general parameters
 WEIGHT = 73//kg
 fup = 0.43
 CL_hepatic = 10 // L/hr
 
$CMT
 ART VEN MUSCLE LIVER REST LUNG

$MAIN //C++
 double Vre = WEIGHT - (Vmu+Vlu+Var+Vve+Vli);
 double Qre = Qlu - (Qli+Qmu);
 
// can put the ODE params in global too
$GLOBAL
// don't need semicolon at end of #define calls
#define Cart (ART/Var)

$ODE
// double Cart = ART/Var;
double Cven = VEN/Vve;
double Cli = LIVER/Vli;
double Cmu = MUSCLE/Vmu;
double Clu = LUNG/Vlu;
double Cre = REST/Vre;

dxdt_MUSCLE = Qmu*Cart - Qmu*(Cmu/(Kpmu/BP));
dxdt_ART = Qlu*(Clu/(Kplu/BP)) - Qmu*Cart - Qli*Cart - Qre*Cart;
dxdt_VEN = Qmu*(Cmu/(Kpmu/BP)) + Qli*(Cli/(Kpli/BP)) + Qre*(Cre/(Kpre/BP)) - Qlu*Cven;
dxdt_LIVER = Qli * Cart - Qli*(Cli/(Kpli/BP)) - CL_hepatic*fup*(Cli/(Kpli/BP));
dxdt_REST = Qre*(Cart-Cre/(Kpre/BP));
dxdt_LUNG = Qlu * (Cven-Clu/(Kplu/BP));
