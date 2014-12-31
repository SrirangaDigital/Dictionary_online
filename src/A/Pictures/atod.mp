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



def my_arc(expr endofa, common, endofb, r) =
begingroup
  save tn, p;path p;
  tn := turningnumber(common--endofa--endofb--cycle);
  p = (unitvector(endofa-common){(endofa-common) rotated(tn*90)} .. unitvector(endofb-common))
  scaled r shifted common;
  p
endgroup
enddef;


beginfig(1);
  numeric u;
  color bg_color, line_color;
  picture savepic;
  path border;
  pair X, X', Y, Y';
  
  bg_color = (1, 215/255, 232/255);
  line_color = (80/255, 64/255, 1);

  u = 1cm;

  X = (3u,0);
  X' = X scaled -1;

  Y = (0, 3u);
  Y' = (0, -3u);

  z0 = (0,1.2u); z1 = (1.7u, y0); z2 = (x1, 0);

  draw z1 withpen pencircle scaled 3pt withcolor line_color;

  draw z0--z1--z2 withpen pencircle scaled .8pt dashed evenly
  withcolor line_color;
  drawarrow X'--X withpen pencircle scaled .8pt;
  drawarrow Y'--Y withpen pencircle scaled .8pt;


  % Labelling
  label.bot(btex $X$ etex, X');
  label.bot(btex $X$ etex, X);
  label.rt(btex $Y$ etex, Y);
  label.rt(btex $Y$ etex, Y');

  label.lft(btex $A$ etex, z0);
  label.bot(btex $B$ etex, z2);
  label.urt(btex $P$ etex, z1);

  label.rt("abscissa", (.8xpart X', .6ypart Y')); 


  
  border = bound_it(currentpicture, .05);

  % SAVE the currentpicture
  savepic = currentpicture;
  currentpicture := nullpicture;


  fill border withcolor bg_color;
  draw border;

  draw savepic;

  
endfig;


%%%%%%%%%%%%%%% Apothem %%%%%%%%%%%%%%%%
%%% Page 219 %%%
beginfig(2);
  numeric u, theta, n, radius;
  path p, border;
  picture savepic;  
  u = 1cm;
  n = 8; % No of sides
  theta = 360 / n;   % the angle of rotation

  radius = 2.3u;

  z0 = radius * dir (22.5);

  for i = 1 upto (n - 1):
    z[i] = z0 rotated (i * theta);
  endfor;


  p = z0 for i = 1 upto (n -1): --z[i] endfor --cycle;


  draw p withpen pencircle scaled .9pt withcolor line_color;

  z10 = .5[z5,z6];

  draw origin--z10 withpen pencircle scaled .8pt;

  path q; q = my_arc(z6, z10, origin, 10);

  drawdblarrow q withpen pencircle scaled .8pt;

  label.urt(btex $90^\circ$ etex, point .5length q of q);
  label.bot(btex $B$ etex, z10);
  label.top(btex $A$ etex, origin);
  
  border = bound_it(currentpicture, .05);

  % SAVE the currentpicture
  savepic = currentpicture;
  currentpicture := nullpicture;

  fill border withcolor bg_color;
  draw border;
  draw savepic;

endfig;

% Arc page 236
beginfig(3);
  numeric u;
  path p[], border;
  numeric st_ang[], end_ang[], r[];
  u = 1cm;

  st_ang[0] = 0;
  st_ang[1] = 135;
  st_ang[2] = 250; 
  st_ang[3] = -30;
  st_ang[4] = 100;
  st_ang[5] = 220;
  st_ang[6] = 40;
  st_ang[7] = 220;
  
  end_ang[0] = 100;
  end_ang[1] = 210;
  end_ang[2] = 330;
  end_ang[3] = 30;
  end_ang[4] = 180;
  end_ang[5] = 265;
  end_ang[6] = 120;
  end_ang[7] = 290;
  
  r0 = 1.7u; r1 = r0; r2 = r0;
  r3 = 3/4r0; r4 = r3; r5 = r3;
  r6 = .5r0; r7 = r6;
  

  for i = 0 upto 7:
    p[i] = my_arc(r[i] * dir (st_ang[i]), origin, r[i] * dir (end_ang[i]), r[i]);
  endfor;  

  


  for i = 0 upto 7:
    draw p[i] withpen pencircle scaled .9pt withcolor line_color;
  endfor;

  picture savepic;  
  
  border = bound_it(currentpicture, .05);

  % SAVE the currentpicture
  savepic = currentpicture;
  currentpicture := nullpicture;

  fill border withcolor bg_color;
  draw border;
  draw savepic;
endfig;




beginfig(4);

  numeric x, y, a, b, u, start_x, error;
  path p, q, border; 
  
  u = 10;
  a = 4;
  b = 4;
  
  error = 0.008;
  y = -10;
  
  x = a * sqrt( 1 + y**2 / (b*b));
  start_x = x;
  
  p = (x,y)..(x,y);
  
  delta = 0.1;
  forever:
    y := y + delta;
    
    x := a * sqrt( 1 + y**2 / (b*b));
    
    exitif ( abs (x - start_x) <= error);
    
    p := p..(x, y);
  endfor;
  p := p scaled u;
  draw p withpen pencircle scaled 1.6pt withcolor line_color;
  
  %q = p reflectedabout ( (0,-1),(0,1));
  
  %draw q withpen pencircle scaled .8pt;
  
  pair A, S;
  A = (a*u, 0);
  S = (3u,0);
  
 % draw A withpen pencircle scaled 3pt;
  
%  draw fullcircle scaled (2u * a);
  
%  draw unitsquare scaled (2*a*u) shifted (-a*u, -a*u);
  
  

  z0 = (a*u,-a*u); z1 = (a*u, a*u);
  
  z2 = 2.9[origin, z0];
  z3 = 2.9[origin, z1];
  
% DRaw the asymptotes
  draw z2--origin--z3 withpen pencircle scaled .8pt;

%  dotlabel("z0", z0);
%  dotlabel("z1", z1 );


  pair T, F;   T =  1.2z1;
  F = T + (-15, 30);


  picture savepic;
  savepic = currentpicture yscaled .8;

  currentpicture := nullpicture;

  draw savepic;

  T := T yscaled .8; F := F yscaled .8;

  ahlength := 7bp;
  ahangle := 30;
  drawarrow F--T;
  ahlength := 4bp;
  ahangle := 45;
  label.top("Asympote", F);


  pair Y, Y', X;

  Y = (0, ypart llcorner currentpicture);
  Y' = Y yscaled -1;

  X = (1.1xpart lrcorner currentpicture, 0);

  draw Y--Y' withpen pencircle scaled .8pt;
  draw origin--X withpen pencircle scaled .8pt;


  border = bound_it(currentpicture, .05);

  % SAVE the currentpicture
  savepic := currentpicture;
  currentpicture := nullpicture;

  fill border withcolor bg_color;
  draw border;
  draw savepic;  
endfig;



% bar page 370
beginfig(5);
  numeric u;

  u = .5cm;

  path p, q, border;
  picture savepic;
  p = (0,0)--(10u,0);
  q = (0,0)--(0,10u);


%  for i = 0 upto 10:
%    draw p shifted (0, i*u);

%    draw q shifted (i*u, 0);
%  endfor;


  pickup pencircle scaled 1pt;

%  draw (2.5u,6u)--(-.25u,6u);
%  draw (-.25u, 6u)--(0,5.75u);
%  draw (0,5.75u)--(0,2u);

%  draw (0,2u){down}..(2u,u){curl0};

%  draw (2u,u){right}..(2.5u,.5u){curl1};



  

  p := (2.5u,6u)--(-.25u,6u)--(0, 5.75u)--(0,2u){down}..
  (2u, u){curl0};

  p := p..(2u,u){right}..(2.5u,.5u){curl1};

  q := p reflectedabout((2.5u,0),(2.5u,6u));
  
  draw p withpen pencircle scaled 1.3pt;
  draw q withpen pencircle scaled 1.3pt;


  path r;

  r = (0, 3u)--(0,4u);

  numeric len, n, delta; len = 5u;

  n = 30; delta = len/n;


  draw (0,3u)--(5u,3u) withpen pencircle scaled 1pt;
  draw (0,4u)--(5u,4u) withpen pencircle scaled 1pt;

  for i = 1 upto n-1:
    draw r shifted (i * delta, 0);
  endfor;


  border = bound_it(currentpicture, .1);

  % SAVE the currentpicture
  savepic := currentpicture;
  currentpicture := nullpicture;

  fill border withcolor bg_color;
  draw border;
  draw savepic;    
endfig;

% Bend Sinister page 445
beginfig(6);
  numeric u;

  u = .5cm;

  path c[];

  
  path p, q, border;
  picture savepic;
  p = (0,0)--(10u,0);
  q = (0,0)--(0,10u);



  c0 = (0, -500)--(0,500);

  pickup pencircle scaled .8pt;
  draw c0;
  for i = 1 upto 35:
    draw c0 shifted (2.5*i,0);
    draw c0 shifted (-2.5 * i,0);
  endfor;


%  for 
  %for i = 0 upto 10:
  %  draw p shifted (0, i*u);

 %   draw q shifted (i*u, 0);
 % endfor;



  
  z0 = (2.5u,6u); z1 = (-.25u, 6u);
  z2 = (0, 5.75u); z3 = (0,2u); z4 = (2u,u); z5 = (2.5u,.5u);

  path r[];

  
  
  p := (2.5u,6u)--(-.25u,6u)--(0, 5.75u)--(0,2u){down}..
  (2u, u){curl0};

  p := p..(2u,u){right}..(2.5u,.5u){curl1};

  q := p reflectedabout((2.5u,0),(2.5u,6u));
  
  
  r0 = (5u,0)--(-u,6u);
  r1 = (7u, 0)--(0,7u);

  r3 = buildcycle(r0, p, r1, q);



  clip currentpicture to r3;
  
  
  draw r3 withpen pencircle scaled 1pt;

  draw p withpen pencircle scaled 1.3pt;
  draw q withpen pencircle scaled 1.3pt;

  numeric len, n, delta; len = 5u;

  n = 30; delta = len/n;


  

  % SAVE the currentpicture
  savepic := currentpicture yscaled -1;
  currentpicture := nullpicture;
  border = bound_it(savepic, .1);
  fill border withcolor bg_color;
  draw border;
  draw savepic;    
endfig;



%%%%%%%%%%%%%%%%% bordure, page 562
beginfig(7);
  numeric u;

  u = .5cm;

  path p, q, border;
  picture savepic;
  p = (0,0)--(10u,0);
  q = (0,0)--(0,10u);


%  for i = 0 upto 10:
%    draw p shifted (0, i*u);

%    draw q shifted (i*u, 0);
%  endfor;


  z0 = (2.5u,6u); z1 = (-.35u, 6u);
  z2 = (0, 5.75u); z3 = (0,2u); z4 = (2u,u); z5 = (2.5u,.5u);



  path r[];

  r0 =  z3{dir -90}..{dir -70}z5;
  %draw r0 withpen pencircle scaled 2pt;

  z6 = z4 reflectedabout((2.5u,0),(2.5u,6u));
  z7 = z3 reflectedabout((2.5u,0),(2.5u,6u));
  z8 = z2 reflectedabout((2.5u,0),(2.5u,6u));
  z9 = z1 reflectedabout((2.5u,0),(2.5u,6u));
  
  r1 = z5{dir 70}..z7{dir 90};
  draw r1 withpen pencircle scaled 2pt;


  r2 = z0--z1{dir 0}..{dir -90}z2--z3{dir -90}..{dir -70}z5{dir 70}..
  z7{dir 90}--z8{up}..{dir 0}z9--cycle; 
  


  z10 = (x5, y0 - u);
  z11 = z10 - (1.5u,0);
  z12 = z3 + (u,.2u);
  z13 = z5 + (0,u);
  z14 = z12 reflectedabout((2.5u,0),(2.5u,6u));
  z15 = z11 reflectedabout((2.5u,0),(2.5u,6u));
  
  r3 = z10--z11--z12{dir -90}..{dir -70}z13{dir 70}..
  z14{dir 90}--z15--cycle;

%%%%%%%%%%%%%%%% Hashing %%%%%%%%%%%%%%%%
  path c[], border;
  c0 = (0, -500)--(0,500);

  pickup pencircle scaled .8pt;
  draw c0;
  for i = 1 upto 35:
    draw c0 shifted (2.5*i,0);
    draw c0 shifted (-2.5 * i,0);
  endfor;

  clip currentpicture to r2;
  
  draw r2 withpen pencircle scaled 1.3pt;
  unfill r3; fill r3 withcolor bg_color;
  draw r3 withpen pencircle scaled 1.3pt;


  picture savepic;
  
  border = bound_it(currentpicture, .1);

  % SAVE the currentpicture
  savepic := currentpicture;
  currentpicture := nullpicture;

  fill border withcolor bg_color;
  draw border;
  draw savepic;    
endfig;

def draw_grid =
  begingroup
    save u, i;
    u = 1cm;

    draw (-3u,0)--(3u,0);
    draw (0, -3u)--(0,3u);

    for i = -3u step u until 3u:
      draw (i, 3u)--(i,-3u);
      draw (3u, i)--(-3u, i);
    endfor;
    
    for i = -3u step u/10 until 3u:
      draw (i, 3u)--(i,-3u) withpen pencircle scaled .1bp;
      draw (3u, i)--(-3u, i) withpen pencircle scaled .1bp;
    endfor;
  endgroup
enddef;


%%%%%%%%%%%%%%%%% broad arrow page 618
beginfig(8);
  numeric u; u = 1cm;
  path border;
  path r[];  
  
  z0 = (-u, -.3u); z1 = (0,2u); z2 = z0 xscaled -1;
  z8 = (-.5u, -.1u); z3 = z8 xscaled -1;
  z7 = (-.1u, 1.4u);
  z6 = (-.25u, -.25u);  z5 = z6 xscaled -1;


  r0 = z0{dir 80}..z1;
  r1 = r0 reflectedabout ((0, -1), (0, 1));
  r2 = z0{dir 40}..z8;
  r3 = r2 reflectedabout ((0, -1), (0, 1));
  r4 = z8{up}..z7; r5 = r4 reflectedabout ((0, -1), (0, 1));
  r6 = z7{dir -87}..z6;
  r7 = r6 reflectedabout ((0, -1), (0, 1));
  r8 = z6{dir 20}..z5;
  

  r10 = buildcycle (r0, r1, r3, r5, r7, r8, r6, r4, r2);

  border = bound_it(r10, .1);

  
  fill border withcolor bg_color;
  draw border;
  fill r10 withcolor black;    
  
endfig;



beginfig (9);
  numeric u, r[];
  picture savepic;
  path border;
  color bg_color;

  bg_color = (1, 194/255, 219/255);
  
  u = 1cm;

  r0 = .8u;
  r1 = 1.5u;
  r2 = 2u;


  draw fullcircle scaled r0 withpen pencircle scaled 3.5pt;
  draw fullcircle scaled r1 withpen pencircle scaled 4.2pt;
  draw fullcircle scaled r2 withpen pencircle scaled 1.3pt;


  % DRAW the border
  savepic = currentpicture;
  border = bound_it(currentpicture, .1);
  currentpicture := nullpicture;

  fill border withcolor bg_color;
  draw border;

  draw savepic;
  
endfig;


%%%%%%%%%%%%%%%%%%%%% (1)canton (3) %%%%%%%%%%%%%% page 726
beginfig(10);

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

  a0 = .6[z1,z0];
  a2 = .4[z2,z3];
  a1 = (xpart a0, ypart a2);

  r1 = a2--a1--a0;
  
  r2 = buildcycle(r0,r1);
%%%%%%%%%%%%%%%%%%%% Hashing %%%%%%%%%%%%%%%%%%%
  c0 = (0, -500)--(0,500);

  pickup pencircle scaled .8pt;
  draw c0;
  for i = 1 upto 35:
    draw c0 shifted (3*i,0);
    draw c0 shifted (-3 * i,0);
  endfor;


%%%%%%%%%%%%% End Hashing %%%%%%%%%%%%%%%%%%%%%%
  
  clip currentpicture to r2;
  

   pickup pencircle scaled 3pt yscaled 0.08 rotated 30;
   draw r0;
   pickup pencircle scaled 2pt yscaled 0.08 rotated -60;
   draw r1;  

   color bg_color;
   bg_color = (1, 215/255, 232/255);

  % DRAW the border
  savepic = currentpicture;
  border = bound_it(currentpicture, .1);
  currentpicture := nullpicture;

  fill border withcolor bg_color;
  draw border;

  draw savepic;
   
endfig;

% CARDIOID page 744
beginfig(11);
  u:=1cm;
  numeric a, theta, r;
  pair d[];
  path p, border;
  picture savepic;
  
  
  a = 30;
  r = a * (1 + cosd(0));
  d[0] = r * dir(0);

  for theta := 1 upto 360:
    r := a * (1 + cosd(theta));
    d[theta] := r * dir(theta);
  endfor;

%  draw d[0]
%  for i := 1 upto 360:
%    ..d[i]
%  endfor;

  p = d0
  for i := 1 upto 360:
    ..d[i]
  endfor;

  draw p withpen pencircle scaled 1.6pt;

% DRAW the border
  savepic = currentpicture rotated -90;
  border = bound_it(savepic, .1);
  currentpicture := nullpicture;

  fill border withcolor bg_color;
  draw border;

  draw savepic;
  

endfig;


%%%%%%%%%%%%%% cusp (2) page1260
beginfig(12);
%  draw_grid;
  numeric u, theta, delta; u = 1cm;
  path r[], border;
  z0 = (-1.5u, -.5u);
  z1 = (-.75u, u);
  z2 = (0,2u);

  r0 = z0{dir 100}..z1;
  r1 = z1{up}..z2;

  r3 = r0 xscaled -1;
  r2 = r1 xscaled -1;
 
  delta = .15u;

  numeric theta[];
  pair dm;

  dm = unitvector  direction 1 of r0;

  theta0 = angle(dm); show theta0;
  dm := unitvector direction 0 of r1;
  theta1 = angle(dm); show theta1;

  theta2 = theta1 - theta0;
  theta3 = 90 + theta2;

  
  z3 = (delta * dir (180)) shifted z0;
  z4 = (delta * dir (theta3)) shifted z1;
  z5 = (delta * dir (90)) shifted z2;

  r4 = z3{dir 100}..z4;
  r5 = z4{up}..z5;

  r7 = r4 xscaled -1;
  r6 = r5 xscaled -1;

  pickup pencircle scaled 1.4pt;
  for i := 0 upto 7:
    draw r[i];
  endfor;


  picture lblbox;

  lblbox = thelabel("cusp", (0, .2y2));

  unfill bbox lblbox;
  fill bbox lblbox withcolor bg_color;
  draw lblbox;

  pair a[];

  a0 = z1 + (.05u, -0.05u);
  a1 = a0 xscaled -1;

  a2 = .1[ulcorner (bbox lblbox), urcorner (bbox lblbox)];
  a3 = a2 xscaled -1;

  ahlength := 5bp; ahangle := 30;

  r8 = a2{dir 160}..a0;
  r9 = r8 xscaled -1;
  drawarrow r8 withpen pencircle scaled .4pt;
  drawarrow r9 withpen pencircle scaled .4pt;

  ahlength := 4bp; ahangle := 45;
  
  
  picture savepic;
% DRAW the border
  savepic = currentpicture;
  border = bound_it(savepic, .1);
  currentpicture := nullpicture;

  fill border withcolor bg_color;
  draw border withpen pencircle scaled .4pt;

  draw savepic;

endfig;


%%%%%%%%%%%%%% cycloid %%%%%%%%%%%%%%%
beginfig(13);
  numeric u; u = 2.5cm;
    path p, q, midcircle;
  numeric len, delta, theta, ndivisions, fromwhere;
  pair a, b, c, midpoint;
  pair d[], a[];
  transform T, R;
  picture savepic;
  
  % some initializations
  theta := 1;     % angle or rotation
  ndivisions := 360/theta;

  show ndivisions;
  
  
  %the circle
  p = fullcircle scaled u shifted (0,.5u);
  % perimeter
  len = arclength p;
  % horizontal displacement
  delta = 1/ndivisions * len;

  show delta;
  
  fromwhere := 10/ndivisions;
  a := point 9/12length p of p;

  c := (0,.5u); % center of the circle
%  theta := 30;    % angle of rotation
  %draw (0,5cm)--origin--(len,0);

  % draw a
  %draw a withpen pencircle scaled 1pt;

  d[0]:= a;
  
  q = a..a;
  %draw p;
 
  for i := 1 upto ndivisions:
    % rotate the circle and shift
    p := p rotatedabout(c, -theta) shifted (delta,0);
%    draw p;

    %locate the point 
    a := point 9/12length p of p;
  %  draw a withpen pencircle scaled 3pt;

    d[i] := a;
    %cycloid path

    if (i = 90):
      midcircle = p;
      midpoint = a;
    fi;
    q := q..a;
    
    % shift the center also
    c := c shifted (delta, 0);
  endfor;

  
  path Cycloid;

  Cycloid := d[0]..d[0];

  for i := 1 upto ndivisions:
    Cycloid := Cycloid .. d[i];
  endfor;


  draw Cycloid withpen pencircle scaled 1.7pt withcolor red;

  %draw p;

  pair e[];

  % copy first few pointst to e

  numeric Limit;
  Limit = 90;
  
  for i := 0 upto Limit:
    e[i] = d[i] reflectedabout (d0, (d0 + (0,1)));
  endfor;


  Cycloid := e0..e0;
  for i := 1 upto Limit:
    Cycloid := Cycloid .. e[i];
  endfor;
  draw Cycloid withpen pencircle scaled 1.7pt withcolor red;


  j = ndivisions;
  i = 0;

  for i := 0 upto Limit:
    e[i] := d[j] reflectedabout (d[ndivisions], (d[ndivisions]+(0,1)));
    j := j - 1;
  endfor;

  Cycloid := e0..e0;
  for i := 1 upto Limit:
    Cycloid := Cycloid .. e[i];
  endfor;

  draw midcircle withpen pencircle scaled 1pt withcolor blue;
  draw midpoint withpen pencircle scaled 4pt ;

  draw Cycloid withpen pencircle scaled 1.7pt withcolor red;  

  a0 = llcorner currentpicture - (.2u,0);
  a1 = lrcorner currentpicture + (.2u, 0);


  draw a0 -- a1 withpen pencircle scaled .8pt;

  a5 = midpoint + (.4u,0);

  draw midpoint--a5 withpen pencircle scaled 1pt dashed evenly;
% DRAW the border
  path border;
  savepic = currentpicture;
  border = bound_it(savepic, .1);
  currentpicture := nullpicture;

  fill border withcolor bg_color;
  draw border;

  draw savepic;

  
endfig;

%%%%%%%%%%%%%%% DECAGON page 1321
beginfig(14);
  numeric u, theta, n, radius;
  path p, border;
  picture savepic;  
  u = 1cm;
  n = 10; % No of sides
  theta = 360 / n;   % the angle of rotation

  radius = 2.3u;

  z0 = radius * dir (0);

  for i = 1 upto (n - 1):
    z[i] = z0 rotated (i * theta);
  endfor;


  p = z0 for i = 1 upto (n -1): --z[i] endfor --cycle;


  draw p withpen pencircle scaled .9pt withcolor line_color;

  %z10 = .5[z5,z6];

  %draw origin--z10 withpen pencircle scaled .8pt;

  path q; q = my_arc(z6, z7, z8, 10);

  drawdblarrow q withpen pencircle scaled .8pt;

  label.urt(btex $144^\circ$ etex, point .5length q of q);
%  label.bot(btex $B$ etex, z10);
%  label.top(btex $A$ etex, origin);
  
  border = bound_it(currentpicture, .05);

  % SAVE the currentpicture
  savepic = currentpicture;
  currentpicture := nullpicture;

  fill border withcolor bg_color;
  draw border;
  draw savepic;

endfig;


%%%%%%%%%%%%%% dihedral angle page 1432
beginfig(15);
  numeric u, ht, wid, rad;
  
  u = 1cm;

  wid = 5u; ht = .4wid;

  rad = .2ht;

  z0 = origin; z1 = wid * dir 0;

  z3 = ht * dir (30); z2 = z1 + z3;

  z4 = .5[z0,z1]; z5 = .5[z3, z2];

  z6 = (1.2ht * dir 70) shifted z5;
  z7 = (1.2ht * dir 70) shifted z4;

  z8 = whatever[z4,z7] = whatever[z3,z2];


  pickup pencircle scaled 1.4pt;

  draw z8--z3--z0--z1--z2--z5;
  draw z4--z5--z6--z7--cycle;

  z9 = .5[z4,z5];

  z10 = .3[z9, .5[z6,z7]];
  z11 = (arclength (z9--z10) * dir 0) shifted z9;
  
  draw z10 withpen pencircle scaled 2pt;
  draw z11 withpen pencircle scaled 2pt;


  path q, border;
  picture savepic;
  q = my_arc(z11, z9, z10, arclength (z9--z10));
  draw q withpen pencircle scaled 1pt;

  draw z10--z9--z11 dashed evenly;

  border = bound_it(currentpicture, .1);

  % SAVE the currentpicture
  savepic = currentpicture;
  currentpicture := nullpicture;

  fill border withcolor bg_color;
  draw border withpen pencircle scaled .4pt;
  draw savepic;
  
endfig;



%%%%%%%%%%%%% Cartesian coordinates page 758

beginfig(16);
  numeric u, wid, ht;
  pair X, X', Y, Y';
  u = 1cm;


  wid = 4u;
  X = (wid, 0);
  X' = (-.4wid, 0);
  Y' = .3wid * dir (-110);
  Y = .6wid * dir (70);

  draw X--X' withpen pencircle scaled .8pt;
  draw Y--Y' withpen pencircle scaled .8pt;


  
  % the labels
  label.rt(btex $Y'$ etex, Y');
  label.rt(btex $Y$ etex, Y);
  label.bot(btex $X'$ etex, X');
  label.lrt(btex $X$ etex, X);

  label.llft(btex $O$ etex, origin - (3,0));

  z0 = .45[origin, Y];
  z1 = .5[origin, X];
  z2 = z1 + z0;

  draw z0--z2--z1 withpen pencircle scaled 1pt dashed evenly  withcolor .6white;
  draw z2 withpen pencircle scaled 3pt withcolor blue;

  label.urt(btex $P$ etex, z2);
  label.lft(btex $U$ etex, z0);
  label.bot(btex $S$ etex, z1);


  path  border;
  picture savepic;


  border = bound_it(currentpicture, .1);

  % SAVE the currentpicture
  savepic = currentpicture;
  currentpicture := nullpicture;

  fill border withcolor bg_color;
  draw border withpen pencircle scaled .4pt;
  draw savepic;
  label.bot(btex $UP, SP$ -- Cartesian coordinates etex,
    .5[llcorner currentpicture, lrcorner currentpicture]);
    
endfig;

%%%%%%%%%%%%%%%% Ellipsoid 
beginfig(17);
  
  numeric xrad[], yrad[], u;
  path p[], sub_p[];

  color clr[];

  u = 1cm;
  
  xrad0 = 2.8u;
  yrad0 = 1.5u;

  xrad1 = xrad0;
  yrad1 = .4yrad0;

  xrad2 = yrad1;
  yrad2 = yrad0;
  

  
  p0 = fullcircle xscaled 2xrad0 yscaled 2yrad0;

  p1 = fullcircle xscaled 2xrad1 yscaled 2yrad1;
  p2 = fullcircle xscaled 2xrad2 yscaled 2yrad2;
  
  %draw p0; draw p1; draw p2;

  % Sub paths
  sub_p0 = subpath (0length p1, .5length p1 ) of p1;
  sub_p1 = subpath (.5length p1, 1length p1 ) of p1;




  sub_p2 = subpath (.25length p2, .75length p2) of p2;

  sub_p3 = (subpath(.75length p2, 1length p2) of p2)..
  (subpath(0length p2, .25length p2) of p2);


  pickup pencircle scaled 1.4pt;

  draw p0;

  draw sub_p0;
  draw sub_p1 dashed evenly;

  draw sub_p2 dashed evenly;
  draw sub_p3;
  
  path  border;
  picture savepic;

  color bg_color; bg_color = (1, 215/255, 232/255);
  border = bound_it(currentpicture, .1);

  % SAVE the currentpicture
  savepic = currentpicture;
  currentpicture := nullpicture;

  fill border withcolor bg_color;
  draw border withpen pencircle scaled .4pt;
  draw savepic;
   
endfig;


% DRAWING AN EPI CYCLOID; page 1728
beginfig(18);

numeric u, in_rad, out_rad, in_circum, out_circum, theta, pi, radius;
u = 1cm;
pi = 3.141592654;  % The Constant PI

in_rad = 2.5u; % Radius of the inner circle
out_rad = .25in_rad; % Radius of the outer circle

% calculate the angle of rotation
out_circum := 2*pi*out_rad;
theta := out_circum / in_rad;
show theta;
theta := (180.0 / pi) * theta;
show theta;
delta := theta / 360;
show delta;


path inner, outer, temp;
pair a, c[], d[];


inner = halfcircle scaled 2in_rad;
outer = fullcircle scaled 2out_rad;


radius = in_rad + out_rad;

c0 := radius * dir (0);

temp := outer shifted c0;
%draw temp;
%draw inner;

path inter;


%store the first point
a := point .5length temp of temp;
d[0] := a;

for i := 1 upto 360:
  c1 := radius * dir (i * delta);
  temp := temp rotatedabout (c0, 1);
  temp := temp rotated delta;

  a := point 0.5length temp of temp;
  d[i] := a;
  c0 := c1;
  if (i = 90):
    inter = temp;
  fi;
endfor;
%draw temp;
% DRAW the x and y axis


% DRAW THE INTERMEDIATE CIRCLE
draw inter withpen pencircle scaled .8pt withcolor blue;



path epi;

epi =  d[0]
for i := 1 upto 360:
  ..d[i]
endfor;

draw fullcircle scaled 2in_rad withpen pencircle scaled .8pt;

pickup pencircle scaled 1.8pt;
draw epi withcolor red;
draw epi rotated 90 withcolor red;
draw epi rotated 180 withcolor red;
draw epi rotated 270 withcolor red;




pickup pencircle scaled .4pt;

pair X, X', Y, Y';

X' = (1.15xpart llcorner bbox currentpicture, 0);
X = (1.15xpart lrcorner bbox currentpicture, 0);
Y' = (0, 1.15ypart llcorner bbox currentpicture);
Y = (0, 1.15ypart urcorner bbox currentpicture);

ahlength := 6bp;
ahangle := 30;
drawarrow X'--X;
drawarrow Y'--Y;
pair dm;

dm = epi intersectionpoint inter;

draw dm withpen pencircle scaled 4pt;

label.llft(btex $O$ etex, origin);

label.rt(btex $Y$ etex, Y);
label.bot(btex $X$ etex, X);



z0 = point .5length epi of epi;


label.urt(btex $E$ etex, z0);
label.lrt(btex $P$ etex, dm);
ahlength := 4bp;
ahangle := 45;



  path  border;
  picture savepic;

  color bg_color; bg_color = (1, 215/255, 232/255);
  border = bound_it(currentpicture, .02);

  % SAVE the currentpicture
  savepic = currentpicture;
  currentpicture := nullpicture;

  fill border withcolor bg_color;
  draw border withpen pencircle scaled .4pt;
  draw savepic;
endfig;



%%%%%%%%%%%%%%%%%%%%%%% fesse; page 1914.
beginfig(19);
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

   a0 = 1/3[z3,z2]; a1 = 1/3[z7,z8];
   a2 = 2/3[z7,z8]; a3 = 2/3[z3, z2];

   r1 = a0--a1--a2--a3--cycle;
   
%%%%%%%%%%%%%%%%%%%% Hashing %%%%%%%%%%%%%%%%%%%
  c0 = (0, -500)--(0,500);

  pickup pencircle scaled .8pt;
  draw c0;
  for i = 1 upto 35:
    draw c0 shifted (3*i,0);
    draw c0 shifted (-3 * i,0);
  endfor;
%%%%%%%%%%%%% End Hashing %%%%%%%%%%%%%%%%%%%%%%

  clip currentpicture to r1;
  draw r1;
  
   pickup pencircle scaled 2pt;% yscaled 0.08 rotated -60;
   draw r0;

  color bg_color; bg_color = (1, 215/255, 232/255);
  border = bound_it(currentpicture, .1);

  % SAVE the currentpicture
  savepic = currentpicture;
  currentpicture := nullpicture;

  fill border withcolor bg_color;
  draw border withpen pencircle scaled .4pt;
  draw savepic;

 
endfig;

%%%%%%%%%%% Frustrums; page 2124
beginfig(20);
  numeric u, ht, rad;
  path p[];
  
  u = .6cm;

  ht = 7u;
  rad = 2u;

  z0 = (-rad, 0); z1 = (rad, 0);
  z2 = (0, ht);
  
  
  p0 = z0{dir -35}..z1;

  z3 = .4[z0,z2]; z4 = .4[z1,z2];

  numeric xr, yr;
  path border;

  xr = x4;
  yr = .3xr;

  p1 = fullcircle xscaled 2xr yscaled 2yr shifted .5[z3, z4];


  label("F", .5[z1,z4] - (.6u, 0));

  
  pickup pencircle scaled .9pt;
  draw p0; draw p1;
  draw z3--z0; draw z1--z4;
  draw z3--z2--z4 dashed evenly;
  picture pic[], savepic;

  pic0 = currentpicture;
  currentpicture := nullpicture;

  pair a[];

  a0 = origin;
  a1 = (1.5rad, 0);
  a2 = (u * dir 120);
  a3 = (u * dir 60) shifted a1;

  a4 = (xpart a1 /2, ht);






  a5 = .4[a2, a4];
  a6 = .4[a0, a4];
  a7 = .4[a1, a4];
  a8 = .4[a3, a4];

  a9 = (xpart a4, .55ypart a4);

  
  draw a2--a0--a1--a3;
  draw a5--a6--a7--a8--a9--cycle;
  
  draw a2--a5;
  draw a0--a6; draw a1--a7; draw a3--a8;

  draw a5--a4--a8 dashed evenly;
  draw a6--a4--a7 dashed evenly;
  draw a4--a9 dashed evenly;

  label("F", .5[a1,a7] - (.5u,0) );

  pic1 = currentpicture;

  currentpicture := nullpicture;

  draw pic0;
  draw pic1 shifted (4u, 0);

    color bg_color; bg_color = (1, 215/255, 232/255);
  border = bound_it(currentpicture, .1);

  % SAVE the currentpicture
  savepic = currentpicture;
  currentpicture := nullpicture;

  fill border withcolor bg_color;
  draw border withpen pencircle scaled .4pt;
  draw savepic;
endfig;


%%%%%%%%%%%%%%% gnomon; page 2251
beginfig(21);
  numeric u, wid, ht;

  u = 1cm;

  wid = 5u;
  ht = .6wid;


  z0 = origin;
  z1 = (wid, 0);
  z3 = (ht * dir 120);
  z2 = z1 + z3;



  label.bot(btex $G$ etex, z0);
  label.urt(btex $F$ etex, z3);
  label.rt(btex $E$ etex, z2);
  
  
  draw z0--z1--z2--z3--cycle withpen pencircle scaled 1pt withcolor blue;

  z4 = 4/3[z1,z2];
  z5 = 4/3[z0,z3];
  z7 = 4/3[z1, z0];


  z8 = 4/3[z2,z3];

  z9 = whatever [z7, z8] = whatever[z4, z5];

  draw z0--z7--z9--z4--z2 withpen pencircle scaled 1pt withcolor blue;
  draw z8--z3--z5 withpen pencircle scaled 1pt withcolor blue;
  label.ulft(btex $C$ etex, z9);
  label.urt(btex $D$ etex, z4);
  label.llft(btex $B$ etex, z7);

  label.bot(btex $BCDEFG$ -- gnomon etex, .6[llcorner currentpicture, lrcorner currentpicture] - (0, 7));


  color bg_color; bg_color = (1, 215/255, 232/255);
  path border;
  picture savepic;
  border = bound_it(currentpicture, .1);

  % SAVE the currentpicture
  savepic = currentpicture;
  currentpicture := nullpicture;

  fill border withcolor bg_color;
  draw border withpen pencircle scaled .4pt;
  draw savepic;
  
endfig;



beginfig(22);
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

  

endfig;


beginfig(23)

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
     picture savepic;
  
  border = bound_it(currentpicture, .3);

  % SAVE the currentpicture
  savepic := currentpicture;
  currentpicture := nullpicture;

  fill border withcolor bg_color;

  draw savepic;
  
    drawoptions(withpen pencircle scaled 3pt );
  draw border;
  
    
    endfig;


end;

