
import java.lang.Integer;
import java.util.Map;

HashMap<Integer,Integer> hm=new HashMap<Integer,Integer>();

int nok=17;
class pian_key{
   int x=0;
  int y=0;
  int wdth=width/(nok);
  int hght=height;
  boolean pressed=false;
  int posx,posy;
  pian_key()
  {
    x=0;
   y=0; 
  }
  
}
//___________________________________________________
class pian_key_white extends pian_key{
  int wdth=width/(nok);
  int hght=height;
  
  void drawme(int transx,int indx)
  {
    fill(255);
    stroke(0);
    rect(x+transx,y,wdth,hght-1,5,5,5,5);
    posx=x+transx;
    posy=y;
    for(int i=0;i<wdth;i++)
    for(int j=0;j<hght-1;j++)
    {
      hm.put((i+x+transx)+(j+y)*width,new Integer(indx));
    }
  }
  void redrawme(int fill,boolean val)
  {
    pressed=true;
    fill(fill);
    stroke(0);
    rect(posx+1,posy-1,wdth-2,(hght-1)-1,5,5,5,5);
  }
}

//___________________________________________________
class pian_key_black extends pian_key{
  int wdth=width/(nok*2);
  int hght=height+height/4;
  int posx,posy;
  void drawme(int transx,int indx)
  {
    fill(0);
    stroke(0);
    rect(x+transx+wdth*3/2,y,wdth,(hght-1)/2,3,3,3,3);
    posx=x+transx+wdth*3/2;
    posy=y;
    for(int i=0;i<wdth;i++)
    for(int j=0;j<(hght-1)/2;j++)
    {//arx[x+transx+i+wdth*3/2][j+y]=indx;
    hm.put((x+transx+i+wdth*3/2)+(j+y)*width,new Integer(indx));
    }
  }
  void redrawme(int fill,boolean val)
  {
    pressed=true;
    fill(fill);
    stroke(0);
    rect(posx+1,posy-1,wdth-2,(hght-1)/2-2,3,3,3,3);
  }
}
//____________________________________________________

pian_key_white pk[]=new pian_key_white[nok];
pian_key_black bk[]=new pian_key_black[2*nok-1];



void setup()
{
  //orientation(LANDSCAPE);
  size((displayWidth),(displayHeight));
  
  background(0);
  
    for(int i=0;i<nok;i++)
    {
      pk[i]=new pian_key_white();
      pk[i].drawme(i*width/(nok),i);     
    }

int iu=0;
    for(int i=0;i<nok-1;i++)
    {
      if(i%7!=2 && i%7!=6)
     {bk[iu+nok]=new pian_key_black();
     bk[iu+nok].drawme(i*width/(nok),nok+iu);
     iu++;
     }
    }

}
int valm;
int pval=0;
void reset_bk(int df)
{
  bk[df].redrawme(0,false);
}

void reset_pk(int df)
{
  pk[df].redrawme(255,false);
}
void draw()
{
  
  if(mousePressed )  {
    valm=mouseX+mouseY*width;
    
   if(!hm.get(valm).equals(null))
   { 
    //text(hm.get(valm)+"",mouseX,mouseY);
    if(hm.get(valm)>=nok)
      bk[hm.get(valm)].redrawme(255,true);
    else if(hm.get(valm)<nok) 
      pk[hm.get(valm)].redrawme(0,true);
    //  println(hm.get(valm).getClass()+"");
    pval=hm.get(valm);
    }
  }  
  
}
void mouseReleased( )
{
  for(int i=0;i<nok;i++)
    reset_pk(i);
  for(int i=nok;i<nok+nok-(nok-3)/7-(nok-7)/7-2;i++)
    reset_bk(i);  
}
