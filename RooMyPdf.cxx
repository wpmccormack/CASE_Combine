/***************************************************************************** 
 * Project: RooFit                                                           * 
 *                                                                           * 
 * This code was autogenerated by RooClassFactory                            * 
 *****************************************************************************/ 

// Your description goes here... 

#include "Riostream.h" 

#include "RooMyPdf.h" 
#include "RooAbsReal.h" 
#include "RooAbsCategory.h" 
#include <math.h> 
#include "TMath.h" 

ClassImp(RooMyPdf); 

 RooMyPdf::RooMyPdf(const char *name, const char *title, 
                        RooAbsReal& _x,
                        RooAbsReal& _p0,
                        RooAbsReal& _p1,
                        RooAbsReal& _p2,
                        RooAbsReal& _p3) :
   RooAbsPdf(name,title), 
   x("x","x",this,_x),
   p0("p0","p0",this,_p0),
   p1("p1","p1",this,_p1),
   p2("p2","p2",this,_p2),
   p3("p3","p3",this,_p3)
 { 
 } 


 RooMyPdf::RooMyPdf(const RooMyPdf& other, const char* name) :  
   RooAbsPdf(other,name), 
   x("x",this,other.x),
   p0("p0",this,other.p0),
   p1("p1",this,other.p1),
   p2("p2",this,other.p2),
   p3("p3",this,other.p3)
 { 
 } 



 Double_t RooMyPdf::evaluate() const 
 { 
   // ENTER EXPRESSION IN TERMS OF VARIABLE ARGUMENTS HERE 
   return (p0 * pow((1.-x/13000.),p1))/(pow((x/13000.),(p2 + p3*log(x/13000.)))) ; 
 } 



