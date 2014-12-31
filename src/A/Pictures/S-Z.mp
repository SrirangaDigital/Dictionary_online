

u:= 1cm;

beginfig(1)

  pair a,b,c;

  numeric r;

  r = 2cm;

  a = (0,0);
  b = .65r*dir(0);
  c = 1.2r*dir(90);

  draw a--b--c--a;

  pair d,e,f;

  d = (.85r,0);
  e = d + 1.1r*dir(0);
  f = d + .55r*dir(50);

  draw d--e--f--d;

  pair g,h,i;

  g = (0,1.35r);
  h = g + 1.5r*dir(-5);
  i = g + 2.25r*dir(-28);

  draw g--h--i--g;
  
endfig;



beginfig(2)

  pair a,b,c,d;

  numeric r;


  r = 2cm;
  
  a = (0,0);
  b = (r,0);
  c = (0,r);
  d = b+c;

  draw a--b--d--c--a;

  draw b--c;

  pair e,f,g;

  e = .5[d,c];
  f = .5[b,d];
  g = .5[e,f];

  pair h,i;

  h =.25[c,b];
  i = .25[b,c];
  
  draw a--g;
  draw e--f;
  draw e--h; draw g--i;

  
  endfig;


  beginfig(3)

    pair a,b,c;

    numeric r;

    r = 1cm;
    
    a = (0,0);
    b = r *dir(0);
    c = r *dir(110);

    draw a--b--c--a;
    label.bot(btex $\scriptstyle{D}$ etex,.5[a,b]);

    pair d,e,f;

    d = (1.25r,0);
    e = d+ r*dir(0);
    f = d+.8r*dir(70);

    draw d--e--f--d;
    label.bot(btex $\scriptstyle{E}$ etex,.5[d,e]);
    
    
    pair g,h,i;

    g = (2.75r,0);
    h = g + 1.2r*dir(0);
    i = g + .65r*dir(120);

    draw g--h--i--g;

    label.bot(btex $\scriptstyle{F}$ etex,.5[g,h]);

    pair A,B,C;

    A = (0,1.3r);
    B = A + r*dir(0);
    C = A + r *dir(90);

    draw A--B--C--A;

    label.bot(btex $\scriptstyle{A}$ etex,.5[A,B]);

    pair  D,E,F;

    D = (1.3r,1.3r);
    E = D+1.1r*dir(0);
    F = D + 1.1r*dir(60);

    draw D--E--F--D;

    label.bot(btex $\scriptstyle{B}$ etex, .5[D,E]);


      pair  G,H,I;

    G = (2.75r,1.3r);
    H = G+1.35r*dir(0);
    I = G + 1.35r*dir(60);

    draw G--H--I--G;

    label.bot(btex $\scriptstyle{C}$ etex, .5[G,H]);
  
  endfig;
  


  beginfig(4)

    numeric rad;

    rad = 2cm;
    path p[];
    
    p0 = fullcircle scaled rad;% yscaled 2cm;% yscaled 2cm;

    pair a,b;

    a = point .5length p0 of p0;
    b = point 0length p0 of p0;

   draw p0;
   % p1 = a{down}..{up}origin;

   % p2 = a{up}..{down}origin;

   % draw p1;
   % draw p2 xscaled -1;
    

    path q[],lyne;

    q0 = a..b{up}..{down}origin{down}..{up}a..cycle;
    %q1 = b..a{down}..{up}origin{up}..{down}cycle;
q1 = b{up}..{down}origin{down}..{up}a..b..cycle;
    
    %draw q0; %withpen pencircle scaled 2pt;
    %draw q1; %withpen pencircle scaled 5pt;

    
    lyne:=-100*dir(60)--100*dir(60);

    for i:=0 upto 50:
    draw lyne shifted (0,5*i);
    if(i<>0):
      draw lyne shifted (0,-5*i);
    fi;
  endfor;

    clip currentpicture to q1;
  picture pic;

  pic:= currentpicture;
  currentpicture:=nullpicture;

  
   lyne:=-100*dir(60)--100*dir(60);

    for i:=0 upto 50:
    draw lyne shifted (0,5*i);
    if(i<>0):
      draw lyne shifted (0,-5*i);
    fi;
  endfor;

  path r ;

  r = fullcircle scaled .15rad shifted (.25rad,0);

  
  %draw r  shifted (.25rad,0);
  %draw r shifted (-.25rad,0);
  
  clip currentpicture to r;
 
  picture pict;
  pict:= currentpicture;
 % currentpicture:=nullpicture;
 
  path s;
  s = fullcircle scaled .15rad shifted (-.25rad,0);

  fill s withcolor (1,1,1);
  draw s;
  picture pictu;
  pictu:= currentpicture;

  fill q0 withcolor red+green;
  fill q1 withcolor red+green;
  draw a..b{up}..{down}origin{down}..{up}a withpen pencircle scaled 1pt;
  draw p0 withpen pencircle scaled 1pt;
  draw r; 
 
  
  

  draw q0;
  draw pic;
  draw pict;

  draw pictu;

  picture pictur;

  pictur:= currentpicture;

  draw pictur rotated 180 shifted (2rad,0);

  draw pictur;
endfig;


beginfig(5)

  numeric rad;

  rad=1cm;
  path p,lyne;

  p = (-rad,0)..(0,rad)..(rad,0);
  %draw p;

  path q;
  
  q = p{up}..(0,0){-1,-2}..{up}cycle;


  draw q;
  lyne:=-100*dir(60)--100*dir(60);

  for i:=0 upto 50:
    draw lyne shifted (0,5*i);
    if(i<>0):
      draw lyne shifted (0,-5*i);
    fi;
  endfor;


  clip currentpicture to q;
  picture pic;
  pic:=currentpicture;


  
  
   lyne:=-100*dir(60)--100*dir(60);

    for i:=0 upto 50:
    draw lyne shifted (0,4*i);
    if(i<>0):
      draw lyne shifted (0,-4*i);
    fi;
  endfor;

  path r ;

  r = fullcircle scaled .35rad shifted (.55rad,0);

  
  %draw r  shifted (.25rad,0);
  %draw r shifted (-.25rad,0);
  
  clip currentpicture to r;
 
  picture pict;
  pict:= currentpicture;
 % currentpicture:=nullpicture;
 
  path s;
  s = fullcircle scaled .35rad shifted (-.55rad,0);


  fill s withcolor (1,1,1);
  draw s;
  picture pictu;
  pictu:= currentpicture;

  
  draw pic;
  draw p..(0,-1cm)..cycle;

  draw pict;
  draw r;
  draw pictu;
 



endfig;



beginfig(6)

  numeric rad;

  rad = 1cm;

  path p;
  
  p = fullcircle scaled 2rad;

  draw p;
  
  pair A,B,C,D;

  A = origin;
  D = rad*dir(0); 
  B = D+(2.25*rad)*dir(90);
  C = rad*dir(60);
  
  
  draw A--D--B--A;

  label.llft(btex $\scriptstyle{A}$ etex,A);
  label.lrt(btex $\scriptstyle{D}$ etex,D);
  label.top(btex $\scriptstyle{B}$ etex,B);
  label.ulft(btex $\scriptstyle{C}$ etex,C);
  
endfig;


%solomon's Seal


beginfig(7)


  pair a,b,c,d,e,f,d',e', f';

  numeric s;

  s:= 2cm;
  
  a = origin;
  b = 1.3s*dir(0);
  c = 1.3s*dir(60);

  d = .5[a,c];
  e = .5[b,c];
  f = .5[a,b];

  d'= 1.25[b,d];
  e' = 1.25[a,e];
  f' = 1.25[c,f];

  pair A,B,C;
  
  
  A = 1.43[b,d];
  B = 1.43[a,e];
  C = 1.43[c,f];

  pair D,E,F;

  
  %draw f'--e';
  %draw a--b withpen pencircle scaled 2pt;
  %draw b--c withpen pencircle scaled 2pt;
  

  draw a--b--c--d--a withpen pencircle scaled 5pt;
  %draw e' withpen pencircle scaled 2pt;
  %draw f' withpen pencircle scaled 6pt;
  
  draw C--B--A--C;
  
  
  drawoptions(withpen pencircle scaled 6pt withcolor white);
  
  draw d'--e'--f'--d';
  drawoptions();

  draw d'--e'--f'--d'; %withpen pencircle scaled 0pt;
                        

  
endfig;





  beginfig(8)


  pair a,b,c,d,e,f,d',e', f';

  numeric s;

  s:= 2cm;
  
  a = origin;
  b = 1.3s*dir(0);
  c = 1.3s*dir(60);

  d = .5[a,c];
  e = .5[b,c];
  f = .5[a,b];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  
  d'= 1.25[b,d];
  e' = 1.25[a,e];
  f' = 1.25[c,f];

  pair g,h,i;

  g = .5[d',e'];
  h = .5[f',e'];
  i = .5[d',f'];

  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
  pair A,B,C;
  
  
  A = 1.43[b,d];
  B = 1.43[a,e];
  C = 1.43[c,f];

  pair D,E,F;

  D = .5[A,B];
  E = .5[B,C];
  F = .5[A,C];

  
  
  draw a--f withpen pencircle scaled 3pt;
  draw f--f';
  draw F--C;

  draw f'--e';
  draw C--B;
  draw f--b withpen pencircle scaled 3pt;
  

  
  
  endfig;



  beginfig(9)

    drawoptions(withpen pencircle scaled 6pt );
    
    numeric r;

    r = 1cm;

    pair a,b,c,d;

    a = (0,0);
    b = (r,0);
    c = (r,1.5r);
    d = (2r,1.5r);

    draw a--b--c--d;


    pair e,g,f,h;

    e = (0,1.5r);
    f = (0,.75r);
    g =(2r,.75r);
    h = (2r,0);

    draw e--f--g--h;


    picture pic;

    pic:=currentpicture;

    draw pic reflectedabout ((2cm,2cm),(2cm,-2cm)) shifted (1.75cm,0cm);
    endfig;



    beginfig(10)

  pair a,b,c,d,e,f,d',e', f';

  numeric s;

  s:= 2cm;
  
  a = origin;
  b = s*dir(0);
  c = s*dir(60);

  d = .5[a,c];
  e = .5[b,c];
  f = .5[a,b];

  d'= 1.25[b,d];
  e' = 1.25[a,e];
  f' = 1.25[c,f];

  pair A,B,C;
  
  
  A = 1.43[b,d];
  B = 1.43[a,e];
  C = 1.43[c,f];

  pair D,E,F;

  
 
  draw a--b--c--d--a; 
 % draw C--B--A--C;
  draw d'--e'--f'--d';
                      
  
endfig;


  
end;
