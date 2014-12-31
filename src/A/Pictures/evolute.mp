vardef bound_it(expr pic, ratio) =
begingroup
  save x, p;
  path p; save a; pair a[];

  x = ratio * arclength(llcorner pic--ulcorner pic);

  a0 = llcorner pic + (-x, -x);
  a1 = lrcorner pic + (x, -x);
  a2 = urcorner pic + (x, x);
  a3 = ulcorner pic + (-x, x);

  p = a0--a1--a2--a3--cycle;

  p
endgroup
enddef;



a = .5;
vardef parabola(expr a, start_x) =
begingroup
  save x, y, delta, p;
  path p;

  delta = 0.05;
  x = start_x;
  y = 2sqrt(a*x);

  z0 = (x, -y);
  j = 0;

  forever:
    x := x - delta;
    exitif (x < 0);
    y := 2sqrt(a*x);
    j := j + 1;
    z[j] = (x, -y);
  endfor;

  x := 0;
  forever:
    x := x + delta;
    exitif (x > start_x);
    j := j + 1;
    y := 2sqrt(a*x);
    z[j] = (x, y);
  endfor;
  
  p = z0
  for i = 1 upto j:
    ..z[i]
  endfor;

  % The returned path
  p

endgroup
enddef;



% A tangent at given point P
vardef myTangent(expr P) = 
  begingroup
    save d, c;
    pair d, c;
    
    if xpart P <> 0:
      xpart d = (xpart P + 1);
      ypart d = 2a*(xpart d + (xpart P)) / (ypart P);
      

      xpart c = xpart P - 1;
      ypart c = 2a*(xpart c + (xpart P)) / ypart P;    
    else:
      c = (0, -1);
      d = (0, 1);
    fi;
    (c--d)
  endgroup
enddef;


vardef normal(expr P, tgt) =
  begingroup
    save dm, theta;
    pair dm;
    
    dm = (unitvector direction .5 of tgt);
    theta = angle(dm);

%    show theta;
    if theta = 90:
      dm := (1, 0) shifted P;
    elseif theta > 0:
      dm := (unitvector direction .5 of tgt) rotated -90 shifted P;
    elseif theta < 0:
      dm := (unitvector direction .5 of tgt) rotated 90 shifted P;
    fi;
    dm
    
  endgroup
enddef;

vardef centerOfCurvature(expr F, P, tgt) =
  begingroup
    save dm, N, R, O, theta;
    pair dm, N, R, O;

    % draw perpendicular to the tangent

    dm = normal(P, tgt);

    theta = angle(dm);
    if theta > 0:
      N = whatever[P, dm] = whatever[origin, (infinity,0)];
      dm := (unitvector direction .5 of (N--P)) rotated 90 shifted N;
      R = whatever[P,F] = whatever[N, dm];
      dm := (unitvector direction .5 of (R--P)) rotated -90 shifted R;
      O = whatever[R,dm] = whatever[P,N];
    elseif theta < 0:
      N = whatever[P, dm] = whatever[origin, (infinity,0)];
      dm := (unitvector direction .5 of (N--P)) rotated -90 shifted N;
      R = whatever[P,F] = whatever[N, dm];
      dm := (unitvector direction .5 of (R--P)) rotated 90 shifted R;
      O = whatever[R,dm] = whatever[P,N];
    else
      O = 2F;
    fi;
    O
  endgroup
enddef;

vardef myEvolute(expr a, start_x) =
  begingroup
    save n, x, y, delta, O, d, F, p, q;
    pair d[], O, F;
    path p, q;
    F = (a, 0);
    delta = 0.05;
    n = 0;
    for x = start_x step -delta until 0:
      y := -2sqrt(a*x);
      tgt := myTangent((x,y));
      O := centerOfCurvature((a, 0), (x, y), tgt);
      d[n] = O;
%      show n;
      n := n + 1;
%      draw O scaled u withpen pencircle scaled 2pt;
  endfor;

  d[n] = (2a, 0);
  
  p = d[0]
  for i = 1 upto n:
    ..d[i]
  endfor;


  n := 0;
  for x := start_x step delta until start_x:
    y := 2sqrt(a*x);
    tgt := myTangent((x,y));
    O := centerOfCurvature((a, 0), (x, y), tgt);
    d[n] := O;
%    show n;
    n := n + 1;
%      draw O scaled u withpen pencircle scaled 2pt;
  endfor;

  q = reverse(p);
  q := q yscaled -1;
  

  p & q
  endgroup
enddef;


beginfig(1);
  numeric u,  start_x, delta;
  path p, tgt, Q;
  u = 1cm;


  start_x = 5;

  p = parabola(a, start_x);
  Q = myEvolute(a, 1.5);


  draw p scaled u withpen pencircle scaled 1.8pt withcolor blue;
  draw Q scaled u withpen pencircle scaled 2.4pt withcolor red;

  % Labelling and axes

  pair X, X';
  X = (1.1xpart lrcorner currentpicture, 0);
  X' = (-.1xpart X, 0);
  ahlength := 6; ahangle := 30;
  drawarrow X'--X;

  pair P, Q, A, B, C;

  A = (2a, 0) scaled u;

  P = point .55length p of p;
  tgt := myTangent(P);
  B = centerOfCurvature((a,0), P, tgt); 
  pair xtra; xtra = 1.6[P,B];
  draw (P--xtra) scaled u withpen pencircle scaled .8pt;

  label.top(btex $P$ etex, P scaled u);
  label.llft(btex $B$ etex, B scaled u);

  label.llft(btex $A$ etex, A );
%  draw (tgt) 

  draw (P scaled u) withpen pencircle scaled 4pt;
  draw (B scaled u) withpen pencircle scaled 4pt;

  
  P := point .61length p of p;
  tgt := myTangent(P);
  B := centerOfCurvature((a,0), P, tgt); 
  xtra := 1.5[P,B];
  draw (P--xtra) scaled u withpen pencircle scaled .8pt;

%  draw (tgt) 

  draw (P scaled u) withpen pencircle scaled 4pt;
  draw (B scaled u) withpen pencircle scaled 4pt;
  
  
  label.top(btex $Q$ etex, P scaled u);
  label.llft(btex $C$ etex, B scaled u);

  label.llft(btex $O$ etex, X');


  path border;
  picture savepic;
  color bg_color;
  
  bg_color = (1, 215/255, 232/255);
  border = bound_it(currentpicture, .05);

  % SAVE the currentpicture
  savepic = currentpicture;
  currentpicture := nullpicture;


  fill border withcolor bg_color;
  draw border;

  draw savepic;

    ahlength := 4bp; ahangle := 45;
endfig;


beginfig(2);
  numeric u, r, R,  theta, delta, radius;
  pair c[], save_pt; path p, inner, outer, save_outer;
  u = 1cm;

  R = 3.5u;
  r = R/5;
  
  radius = R - r;
    
  inner = fullcircle scaled 2R;
  outer = fullcircle scaled 2r shifted (radius, 0);

  theta = 360 * (r/R);
  delta = theta / 360;

  numeric whichpoint;
  whichpoint = 1;

  z0 = point whichpoint*length outer of outer;
  c0 = (radius, 0);
  
  for i = 1 upto 360:
    c1 := radius * dir (i * delta);
    outer := outer rotatedabout (c0, -1);
    outer := outer rotated delta;
    
    z[i] = point whichpoint*length outer of outer;

    if (i = 100):
      save_outer = outer;
      save_pt = z[i];
    fi;
    c0 := c1;
  endfor;
    
  p = z0
  for i = 1 upto 360:
    ..z[i]
  endfor;

  draw inner withpen pencircle scaled 1.6pt withcolor red;
  draw save_outer withpen pencircle scaled 1pt;

  dotlabel.llft(btex $P$ etex, save_pt);
  for i = 0 upto 4:
    draw (p rotated (i * 72)) withpen pencircle scaled 1.6pt withcolor blue;
  endfor;
  
  %draw p;
  pair d[];
  
  label.ulft(btex $R$ etex,  point .52length save_outer of save_outer);

  label.llft(btex $M$ etex, point .6length p of p);


  picture pic;

  d0 := point .7length p of (p rotated 72);
  d1 := point .3length p of (p rotated 144);

  d3 = .75[origin, .5[d0, d1]];

  pic = thelabel(btex $M$ etex, d3);

  draw pic;
  
  d4 = .5[llcorner bbox pic, ulcorner bbox pic];

  draw d1--d4--d0;


  d0 := point .7length p of (p rotated (72*3));
  d1 := point .3length p of (p rotated (72*4));
  

  d3 := .75[origin, .5[d0, d1]];

  pic := thelabel(btex $M$ etex, d3);

  draw pic;
  
  d4 := .5[llcorner bbox pic, lrcorner bbox pic];

  draw d1--d4--d0;

  label.ulft(btex $F$ etex, point .3length inner of inner);

  path border;
  picture savepic;
  color bg_color;
  
  bg_color = (1, 215/255, 232/255);
  border = bound_it(currentpicture, .05);

  % SAVE the currentpicture
  savepic = currentpicture;
  currentpicture := nullpicture;


  fill border withcolor bg_color;
  draw border;
  draw savepic;
  
endfig;



beginfig(3);
  numeric u, xrad, yrad, ht;
  path p[];
  pair apex, a[];

  u = 1cm;
  ht = 7.5u;
  
  xrad = 3u;
  yrad = .75u;

  p0 = fullcircle xscaled 2xrad yscaled 2yrad;
  apex = (0, ht);


  draw p0;

  a0 = point .477length p0 of p0;

  a1 = a0 xscaled -1;
  
  draw a0--apex--a1;

  

endfig;


beginfig(5);

  numeric u;
  u = .5cm;
  pair a[];
  path border, c[], r[];
  picture savepic;

  z0 = (2.5u,6u); z1 = (-.35u, 6u);
  z2 = (0, 5.75u); z3 = (0,2u); z4 = (2u,u); z5 = (2.5u,.5u);

  z6 = z4 reflectedabout((2.5u,0),(2.5u,6u));
  z7 = z3 reflectedabout((2.5u,0),(2.5u,6u));
  z8 = z2 reflectedabout((2.5u,0),(2.5u,6u));
  z9 = z1 reflectedabout((2.5u,0),(2.5u,6u));


  
  r0 = z0--z1{dir 0}..{dir -90}z2--z3{dir -90}..{dir -70}z5{dir 70}..
  z7{dir 90}--z8{up}..{dir 0}z9--cycle;

  c0 = z9--z1;
  c1 = z1{dir 0}..{dir -90}z2--z3{dir -90};
  c2 = z5{dir 70}..z7{dir 90}--z8{up}..{dir 0}z9;
  

  draw r0 withpen pencircle scaled 1pt;

  a0 = ulcorner currentpicture;
  a1 = lrcorner currentpicture;

  
  
  c3 = (a0--a1) shifted (1.15u,0);
  c4 = (a1--a0) shifted (-.9u, 0);

  %c5 = c3--c4--cycle;

  draw c1; draw c4;

  c5 = buildcycle(c1, c4, c2, c3, c0);

  currentpicture := nullpicture;

%%%%%%%%%%%%%%%%%%%% Hashing %%%%%%%%%%%%%%%%%%%
  c0 := (0, -500)--(0,500);

  pickup pencircle scaled .8pt;
  draw c0;
  for i = 1 upto 35:
    draw c0 shifted (3*i,0);
    draw c0 shifted (-3 * i,0);
  endfor;


%%%%%%%%%%%%% End Hashing %%%%%%%%%%%%%%%%%%%%%%

  clip currentpicture to r0;
  unfill c5;draw c5;
  draw r0 withpen pencircle scaled 1pt;

  a0 := center (c5);

  draw a0 withpen pencircle scaled 1pt;

  numeric theta;
  theta = angle(unitvector direction .5 of c4);

  a1 := (1.9u * dir (theta)) shifted a0;
  a2 := a1 rotatedabout (a0, 180);
%(1.2u * dir -(180 - theta)) shifted a0;

  draw a2 withpen pencircle scaled 1pt;
  draw a1 withpen pencircle scaled 1pt;


  path ellipse;

  ellipse = fullcircle xscaled .5u yscaled .75u;

  for i = 0 upto 2:
    fill ellipse shifted a[i];
  endfor;



  picture pic;

  pic = currentpicture;
  currentpicture := nullpicture;


  numeric side;

  side = arclength(llcorner pic--urcorner pic);

  side := .5side;
  side := side /sind(45);


  path mysq;
  mysq = (side, 0)--(0,side)--(-side, 0)--(0, -side)--cycle;


  draw pic;


  c0 := mysq shifted (a0+(0,5));
  
  fill c0 withcolor black;
  
  unfill r0;
  
  draw pic;
  c1 := (mysq scaled 1.1) shifted (a0 + (0,5));
  
  draw c1;
endfig;



beginfig(6);
  numeric u, n, r, theta;
  path p[];
  pair a[];
  u = 2cm;
  r = u;

  n = 7;
  theta = 360/n;

  z0 = (0, r);

  for i = 1 upto n - 1:
    z[i] = z0 rotated (i * theta);
  endfor;


  p0 = z0 for i = 1 upto n - 1: --z[i] endfor --cycle;

  a0 = origin;
  a1 = (u * dir 120); a2 = .75u * dir 60 shifted a1;
  a3 = .6u * dir 30 shifted a2;
  a4 = u * dir -30 shifted a3;

  a5 = .7u * dir -70 shifted a4;
  a6 = (u, 0);

  p1 =  a0--a1--a2--a3--a4--a5--a6--cycle;


  draw p0 withpen pencircle scaled 1pt withcolor blue;
  draw (p1 shifted (2u, y3)) withpen pencircle scaled 1pt withcolor blue;

  label.bot("heptagons", .5[llcorner bbox currentpicture, lrcorner bbox currentpicture]);
  path border;
  picture savepic;
  color bg_color;
  
  bg_color = (1, 215/255, 232/255);
  border = bound_it(currentpicture, .1);

  % SAVE the currentpicture
  savepic = currentpicture;
  currentpicture := nullpicture;

  fill border withcolor bg_color;
  draw border;
  draw savepic;
endfig;  

beginfig(7);
  numeric u, rad, n, theta;
  path p[];
  pair a[];

  u = 1cm;
  rad = 1.7u;

  n = 6;
  theta = 360/n;

  z0 = (0, rad);

  for i = 1 upto n - 1:
    z[i] = z0 rotated (i * theta);
  endfor;


  p0 = z0 for i = 1 upto n - 1: --z[i] endfor --cycle;

  p1 = fullcircle scaled 2rad;

  a0 = (rad * dir 10);
  a1 = rad * dir 90;
  a2 = rad * dir 150;
  a3 = rad * dir 225;
  a4 = rad * dir 280;
  a5 = rad * dir 340;

  p3 = a0--a1--a2--a3--a4--a5--cycle;


  label.lrt(btex $1$ etex, .2[z4,z3]);
  label.llft(btex $2$ etex, (a2 shifted (2.5rad, 0)));
  
  draw p0 withpen pencircle scaled 1pt withcolor blue;
  draw (p3 shifted (2.5rad, 0)) withpen pencircle scaled 1pt withcolor blue;
  
  
  label.bot(btex hexagons: 1. regular. etex, .5[llcorner bbox currentpicture, lrcorner bbox currentpicture]);

label.bot(btex 2. irregular. etex, .5[llcorner bbox currentpicture, lrcorner bbox currentpicture]);
  
    path border;
  picture savepic;
  color bg_color;
  
  bg_color = (1, 215/255, 232/255);
  border = bound_it(currentpicture, .1);

  % SAVE the currentpicture
  savepic = currentpicture;
  currentpicture := nullpicture;

  fill border withcolor bg_color;
  draw border;
  draw savepic;

endfig;

beginfig(8);
  numeric u, rad, n, theta;
  path p;
  
  u = 1cm;
  rad = 2.5u;

  n = 3;
  theta = 360/n;

  z0 = (0, rad);

  for i = 1 upto n - 1:
    z[i] = z0 rotated (i * theta);
  endfor;


  p = z0 for i = 1 upto n - 1: --z[i] endfor --cycle;


  draw p withpen pencircle scaled 1.6pt withcolor blue;
  draw (p yscaled -1) withpen pencircle scaled 1.6pt withcolor blue;
  
  label.bot("hexagram", .5[llcorner bbox currentpicture, lrcorner bbox currentpicture]);

    path border;
  picture savepic;
  color bg_color;
  
  bg_color = (1, 215/255, 232/255);
  border = bound_it(currentpicture, .1);

  % SAVE the currentpicture
  savepic = currentpicture;
  currentpicture := nullpicture;

  fill border withcolor bg_color;
  draw border;
  draw savepic;
  
endfig;


beginfig(9);
  numeric u, l;
  picture pic[];
  path p[];
  
  u = 1cm;

  l = 3u;

  z0 = (-l, 0); z1 = origin; z2 = (0, l);


  draw z0--z1--z2--cycle withpen pencircle scaled 1.6pt withcolor blue;

  p0 = quartercircle scaled .9l rotated 90;

  ahangle := 30;
  ahlength := 6bp;
  drawdblarrow  p0;


  pic0 = thelabel(btex $90^\circ$ etex, point .5length p0 of p0);
  color bg_color;
  
  bg_color = (1, 215/255, 232/255);

  
  unfill bbox pic0;
  fill bbox pic0 withcolor bg_color;
  draw pic0;


  label(btex $\rm hyptenuse$ etex rotated 45, (1.13* l*sind(45)) * dir 135); 
%  draw pic1;
  ahangle := 45;
  ahlength := 4bp;

      path border;
  picture savepic;
  border = bound_it(currentpicture, .1);

  % SAVE the currentpicture
  savepic = currentpicture;
  currentpicture := nullpicture;

  fill border withcolor bg_color;
  draw border;
  draw savepic;

endfig;



beginfig(10);
  numeric u, rad, n, theta;
  path p[];
  pair a[];

  u = 1cm;
  rad = 3u;

  n = 6;
  theta = 360/n;

  z0 = rad * dir 70;

  for i = 1 upto n - 1:
    z[i] = z0 rotated (i * theta);
  endfor;


  p0 = z0 for i = 1 upto n - 1: --z[i] endfor --cycle;


  draw p0 withpen pencircle scaled 1.6pt withcolor blue;

  pickup pencircle scaled 1.6pt;

  draw z2--z0 withcolor blue;
  draw z3--z5 withcolor blue;

  z6 = .5[z0,z2];

  draw z1--z6 withcolor blue;


  z7 = 1/4[z3,z5];
  z8 = 3/4[z3,z5];

  draw z2--z7--z6--z8--z0 withcolor blue;

  z9 = .1[.5[z3,z5], z1];

  z10 = .15[z2,z3]; z11 = .15[z0,z5];

  z12 = .2[z10,z11];
  z13 = .2[z11,z10];


  pickup pencircle scaled .8pt
  draw z3--z9--z5 dashed evenly withcolor blue;
  draw z4--z9  dashed evenly withcolor blue;
  draw z2--z12--z13--z0 dashed evenly withcolor blue;
  draw z3--z12--z9--z13--z5 dashed evenly withcolor blue;
  draw z12--z1--z13 dashed evenly withcolor blue;

  label.bot("icosahedron", .5[llcorner bbox currentpicture, lrcorner bbox currentpicture]);

  label.bot("(regular)", .5[llcorner bbox currentpicture, lrcorner bbox currentpicture]);

  path border;
  picture savepic;
  border = bound_it(currentpicture, .1);

  % SAVE the currentpicture
  savepic = currentpicture;
  currentpicture := nullpicture;

  fill border withcolor bg_color;
  draw border;
  draw savepic;


endfig;


beginfig(11);
  numeric u, ht, wid;

  u = 1cm;
  ht = 2u; 
  wid = 5u;

  z0 = origin; z1 = (wid, 0);
  z2 = (wid, ht); z3 = (0, ht);


  draw z0--z1 withpen pencircle scaled 1pt;
  draw z3--z2 withpen pencircle scaled 1pt;


  z4 = (1.5u, -u);
  z5 = z2 + (-1.5u ,u);


  draw z4--z5 withpen pencircle scaled 1pt;

  
  label.bot(btex $A$ interior angle. etex, .5[llcorner bbox currentpicture, lrcorner bbox currentpicture]);
  
  label.bot(btex $B$ exterior angle. etex, .5[llcorner bbox currentpicture, lrcorner bbox currentpicture]);
  

  z6 = whatever[z0,z1] = whatever[z4,z5];
  z7 = whatever[z2,z3] = whatever[z4,z5];


  label.urt(btex $B$ etex, z7);
  label.ulft(btex $B$ etex, z7);
  label.llft(btex $A$ etex, z7- (3,0));
  label.lrt(btex $A$ etex, z7);
  
  label.urt(btex $A$ etex, z6);
  label.ulft(btex $A$ etex, z6);
  label.llft(btex $B$ etex, z6 -(3,0));
  label.lrt(btex $B$ etex, z6 );
  
  
  path border;
  picture savepic;
  border = bound_it(currentpicture, .1);

  % SAVE the currentpicture
  savepic = currentpicture;
  currentpicture := nullpicture;

  fill border withcolor bg_color;
  draw border;
  draw savepic;
endfig;


% involute page 2786
beginfig(12);
  numeric u, radius, l, theta, n, theta;
  pair d[];
  
  u = 1cm;

  radius = u;

  n = 12;
  theta = 360/n;

  z0 = radius * dir 90;

  for i = 1 upto n - 1:
    z[i] = z0 rotated (i * -theta);
  endfor;
  
  l = arclength (fullcircle scaled 2radius) / n;


  zeta = 180;

  for i = 0 upto n - 1:
    d[i] = ( (i * l) * dir (zeta) ) shifted z[i];
    zeta := zeta - theta;
  endfor;
  z12 = z0;
  show zeta;
  d[n] = (12l * dir (-zeta)) shifted z0;
  path involute;

  involute = d0
  for i = 1 upto n:
    ..d[i]
  endfor;

  draw fullcircle scaled 2radius withpen pencircle scaled 1.2pt withcolor blue;
  draw involute withpen pencircle scaled 1.8pt withcolor red;



  % some labelling


  color bg_color;
  bg_color = (1, 215/255, 232/255);

  pair dm;
  picture pic;

  label.ulft(btex $A$ etex, z0);

  label.urt(btex $I_1$ etex, d4);

  dm = .5[z4, d4];
  draw z4--d4 dashed evenly withpen pencircle scaled .8pt;


  pic = thelabel(btex $r_1$ etex, dm);

  unfill (llcorner pic -- lrcorner pic--urcorner pic--ulcorner pic--cycle);
  fill (llcorner pic -- lrcorner pic--urcorner pic--ulcorner pic--cycle) withcolor
  bg_color;
  
  draw pic;


  dm := .5[z8, d8];
  draw z8--d8 dashed evenly withpen pencircle scaled .8pt;
  pic := thelabel(btex $r_2$ etex, dm);

  label.lrt(btex $I_2$ etex, d8);
  unfill (bbox pic);
  fill (bbox pic) withcolor  bg_color;
  draw pic;



  
  dm := .5[z11, d11];
  draw z11--d11 dashed evenly withpen pencircle scaled .8pt;
  pic := thelabel(btex $r_3$ etex, dm);
  unfill (llcorner pic -- lrcorner pic--urcorner pic--ulcorner pic--cycle);
fill (llcorner pic -- lrcorner pic--urcorner pic--ulcorner pic--cycle) withcolor
  bg_color;
  draw pic;
  label.llft(btex $I_3$ etex, d11);
  
 
  dm := .5[z12, d12];
  draw z12--d12 dashed evenly withpen pencircle scaled .8pt;
  pic := thelabel(btex $r_4$ etex, dm);
  unfill (llcorner pic -- lrcorner pic--urcorner pic--ulcorner pic--cycle);
fill (llcorner pic -- lrcorner pic--urcorner pic--ulcorner pic--cycle) withcolor
  bg_color;
  draw pic;
  label.llft(btex $I_4$ etex, d12);
  label.top(btex $I$ etex, d12);
  

  
  path border;
  picture savepic;
  border = bound_it(currentpicture, .1);

  % SAVE the currentpicture
  savepic = currentpicture;
  currentpicture := nullpicture;

  fill border withcolor bg_color;
  draw border;
  draw savepic;


endfig;

beginfig(13);
  numeric u, l, a[];
  path vline, hline;
  
  u = 1cm;

  l = u;

  vline = origin--(0, 3l);
  hline = origin--(3l, 0);

  pickup pencircle scaled .8pt;
  for i = 0 upto 3:
    draw vline shifted (i * u, 0);
    draw hline shifted (0, i * u);
  endfor;

  a0 = 6; a1 = 5; a2 = 10; a3 = 11; a4 = 7; a5 = 3;
  a6 = 4; a7 = 9; a8 = 8;
  
  
  z0 = (l/2, l/2);
  z1 = z0 + (0,l);
  z2 = z1 + (0,l);

  z3 = z0 + (l, 0);
  z4 = z3 + (0,l);
  z5 = z4 + (0,l);

  z6 = z3 + (l,0);
  z7 = z6 + (0,l);
  z8 = z7 + (0,l);
  
  for i = 0 upto 8:
    label(decimal(a[i]), z[i]);
  endfor;

  label.bot(btex magic square etex, .5[llcorner bbox currentpicture, lrcorner bbox currentpicture]);

  
  color bg_color;
  bg_color = (1, 215/255, 232/255);
  path border;
  picture savepic;
  border = bound_it(currentpicture, .1);

  % SAVE the currentpicture
  savepic = currentpicture;
  currentpicture := nullpicture;

  fill border withcolor bg_color;
  draw border;
  draw savepic;

  
endfig;

beginfig(14);

  
  numeric u;
  u = .5cm;
  pair a[];
  path border, c[], r[];
  picture savepic;

  z0 = (2.5u,6u); z1 = (-.35u, 6u);
  z2 = (0, 5.75u); z3 = (0,2u); z4 = (2u,u); z5 = (2.5u,.5u);

  z6 = z4 reflectedabout((2.5u,0),(2.5u,6u));
  z7 = z3 reflectedabout((2.5u,0),(2.5u,6u));
  z8 = z2 reflectedabout((2.5u,0),(2.5u,6u));
  z9 = z1 reflectedabout((2.5u,0),(2.5u,6u));


  
  r0 = z0--z1{dir 0}..{dir -90}z2--z3{dir -90}..{dir -70}z5{dir 70}..
  z7{dir 90}--z8{up}..{dir 0}z9--cycle;

  c0 = z9--z1;
  c1 = z1{dir 0}..{dir -90}z2--z3{dir -90};
  c2 = z5{dir 70}..z7{dir 90}--z8{up}..{dir 0}z9;
  

  draw r0 withpen pencircle scaled 1pt;

  a0 = ulcorner currentpicture;
  a1 = lrcorner currentpicture;

  
  
  c3 = (a0--a1) shifted (.8u,0);
  c4 = (a1--a0) shifted (-.8u, 0);

  c5 = buildcycle(c1, c4, c2, c3, c0);

  fill c5;
  c6 = c5 reflectedabout ( z5, (x5, y5 + 4));
  fill c6;

  color bg_color;
  bg_color = (1, 215/255, 232/255);
  path border;
  picture savepic;
  border = bound_it(currentpicture, .09);

  % SAVE the currentpicture
  savepic = currentpicture;
  currentpicture := nullpicture;

  fill border withcolor bg_color;
  draw border;
  draw savepic;
endfig;


beginfig(15);
  numeric u, theta;
  pair a[];
  picture pic[];
  
  u = .5cm;

  z0 = (0, 4u);
  z1 = origin;
  z2 = (3u, 0);

  pickup pencircle scaled .8pt;
  draw z0--z1--z2--cycle;

  pic0 = currentpicture;

  currentpicture := nullpicture;
  a0 = origin;
  a1 = 5u * dir 0;
  a2 = 2u * dir 40;

  draw a0--a1--a2--cycle;

  pic1 = currentpicture shifted
  (1.2arclength (llcorner pic0--lrcorner pic0), 0);

  currentpicture := nullpicture;

  a0 := origin;
  a1 := 8u * dir -20;
  a2 := 3.9u * dir 0;

  draw a0--a1--a2--cycle;
  pic2 = currentpicture shifted (0, 1.1arclength (llcorner pic0--ulcorner pic0));

  currentpicture := nullpicture;
  draw pic0; draw pic1; draw pic2;
  
  
  color bg_color;
  bg_color = (1, 215/255, 232/255);
  path border;
  picture savepic;
  border = bound_it(currentpicture, .09);

  % SAVE the currentpicture
  savepic = currentpicture;
  currentpicture := nullpicture;

  fill border withcolor bg_color;
  draw border withpen pencircle scaled .4pt;
  draw savepic;  
endfig;


beginfig(16);
  numeric u, radius, l;
  
  u = 1cm;
  radius = 1.3u;

  l = 2radius;

  z0 = origin;

  z1 = (radius, 0);
  z2 = (radius, ht);

  z3 = radius * dir (angle (unitvector direction .5 of (z0--z2)));


  draw fullcircle scaled 2radius withpen pencircle scaled 1pt;
  draw  z0--z1--z2--cycle withpen pencircle scaled 1pt;


  label.bot(btex $A$ etex, origin);
  label.lrt(btex $D$ etex, z1);
  label.urt(btex $B$ etex, z2);
  label.lft(btex $C$ etex, .68[z0,z2]);
  
  
  color bg_color;
  bg_color = (1, 215/255, 232/255);
  path border;
  picture savepic;
  border = bound_it(currentpicture, .09);

  % SAVE the currentpicture
  savepic = currentpicture;
  currentpicture := nullpicture;

  fill border withcolor bg_color;
  draw border withpen pencircle scaled .4pt;
  draw savepic;  
endfig;





end;
