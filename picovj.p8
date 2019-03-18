pico-8 cartridge // http://www.pico-8.com
version 16
__lua__
-- picovj
-- @jordi_ros
vj_loops={}
vj_scene=0
vj_bpm=120
vj_bpmstart=0
vj_beatsync=0
vj_beatinfo=0
vj_fxrage=0
vj_fxflash=0

function vj_load()
 vj_loops[0]=vj_menu
 vj_loops[1]=twistdither
 vj_loops[2]=plasma
 vj_loops[3]=octopus
 vj_loops[4]=scroller
 vj_loops[5]=twistwire
 vj_loops[6]=rings
 vj_loops[7]=cube3d
 vj_loops[8]=cubeinside
end

function _update60()
 vj_load()
 vj_time=t()/2 -- because 60fps
 vj_flash=0
 if btn(4) and vj_scene>0 then
  -- scene manager
  if (btnp(⬆️)) vj_scene=flr(rnd(#vj_loops))+1
  if (btnp(⬅️)) vj_scene-=1
  if (btnp(➡️)) vj_scene+=1
  if (btnp(⬇️)) vj_scene=1 
  if (vj_scene<1) vj_scene=#vj_loops
  if (vj_scene>#vj_loops) vj_scene=1
 elseif btn(5) then
  -- bpm manager
	 if (btnp(⬆️)) vj_bpm+=0.05
  if (btnp(⬇️)) vj_bpm-=0.05
  if (btnp(⬅️)) vj_bpmstart-=0.02
  if (btnp(➡️)) vj_bpmstart+=0.02
  vj_beatinfo=vj_time
 else
  -- fx manager
  if (btnp(⬆️)) vj_fxrage=mid(0,1,vj_fxrage+0.1)
  if (btnp(⬇️)) vj_fxrage=mid(0,1,vj_fxrage-0.1)
  if (btnp(➡️)) vj_fxflash+=1
  if (vj_fxflash>5) vj_fxflash=0
  -- beat sync
  if btnp(⬅️) then
   if (vj_time-vj_beatsync)>4 then
    vj_beatsync=vj_time
    vj_bpmstart=vj_time
   else
    vj_bpm=240/(vj_time-vj_beatsync)
    vj_bpmstart=vj_time
    vj_beatsync=0
   end
   vj_beatinfo=vj_time
  end
 end
 -- vj vars
 vj_beatlen=60/vj_bpm
 vj_beatlen2=vj_beatlen*2
 vj_beatlen4=vj_beatlen*4
 vj_beattime=(vj_time-vj_bpmstart)/vj_beatlen
 vj_beattime2=vj_beattime/2
 vj_beattime4=vj_beattime/4
 vj_beatnum=flr(vj_beattime)%4
 vj_beatnum2=flr(vj_beatnum/2)
 vj_beat=1-mid(0,((vj_time-vj_bpmstart)%vj_beatlen)*5,1)
 vj_beat2=(vj_beatnum==0 or vj_beatnum==2) and vj_beat or 0
 vj_beatflash=0
 if vj_fxflash==1 then
  vj_beatflash=(vj_beatnum==0) and vj_beat or 0
 elseif vj_fxflash==2 then
  vj_beatflash=(vj_beatnum==1 or vj_beatnum==3) and vj_beat or 0
 elseif vj_fxflash==3 then
  vj_beatflash=(vj_beatnum==0 or vj_beatnum==2) and vj_beat or 0  
 elseif vj_fxflash==4 then
  vj_beatflash=vj_beat
 elseif vj_fxflash==5 then
  vj_beatflash=1-mid(0,((vj_time-vj_bpmstart)%(vj_beatlen*.5))*5,1)
 end
end

function _draw()
 vj_loops[vj_scene]()
 vj_overlay()
end

-- utils
function lerp(a,b,l)
 return mid(a,b,(b-a)*l+a)
end

function info()
 print("beat: " .. vj_beatnum .. " " .. vj_beattime4, 1, 97, 6)
 print("bpm: " .. vj_bpm, 1, 103, 6)
 print("fxrage: " .. vj_fxrage, 1, 109, 6)
 print("fxflash: " .. vj_fxflash, 1, 115, 6)
end

cpal={
 {0,1,13,12,7},
 {0,1,3,11,7},
 {0,4,9,10,7},
 {0,2,8,14,7},
 {1,2,8,9,10},
 {1,12,13,14,15},
 {1,5,6,7,7},
}
-->8
-- main menu
function vj_menu()
 if (btn(4) and btn(5)) vj_scene=1
 cls()
 sspr(0,0,94,20,17,40-vj_beat*10)
 if(sin(vj_time*vj_beatlen*2)>0)print("press a + b to start",24,60,7)
 vj_flash=vj_beatflash
 info() 
end

-- overlay
ol_editing=false
ol_time=0
function vj_overlay()
 -- text overlay
 fillp()
 if stat(30) then
 end
 v=vj_time-ol_time
 if(ol_time>0 and v<2) then
  y=105
  rectfill(0,y-1,101,y+8,0)
  rectfill(0,y,100,y+6,8)
  print("picovj",2,y+1,7)
 end
 -- flash
 if (vj_flash>0.8) rectfill(0,0,128,128,7)
 -- beat info
 if (vj_time - vj_beatinfo < 8) then
  for i=0,vj_beatnum do
   line(0,127-i,1,127-i,flr(5+vj_beat*2))
   line(126,127-i,127,127-i,flr(5+vj_beat*2))
  end
 end
end

-->8
-- dithered twist
-- @jordi_ros
function td_segment(x,y)
d=64
a=d/-(y+2)
b=d/(x-2)
vx=x*a+d
vy=y*b+d
if(vx>vy)return
fillp(23130)
r=0.8+vj_beatflash*2+sin(i*.2+v*3)/8
x=x*a*r+d+sin(i/3+v*2)*vj_fxrage*10
y=y*b*r+d+sin(i/3+v*2)*vj_fxrage*10
c=vy/vx
s=1+vj_beatflash*2
col=vj_fxrage<.5 and flr(c+11)+16*flr(c+11.5) or cpal[vj_beatnum2+1][flr(c+1)]+16*cpal[vj_beatnum2+4][flr(c+1.5)]
for k=0,3 do
line(x,i*a+d+k*s,y,i*b+d+k*s,col)
end end

function twistdither()
cls()
v=vj_fxrage<.5 and vj_beattime4/2 or vj_beattime4
for j=-.1,.1,.01 do
a=sin(v*.5+.5+j/2)/2
x=-sin(a)
y=cos(a)
i=j*17
td_segment(x,-y)
td_segment(-x,y)
td_segment(-y,-x)
td_segment(y,x)
end end

-- plasma effect
-- @jordi_ros
function plasma()
cls()
for y=0,23 do
for x=0,23 do
v=vj_beattime2+(vj_fxrage<.5 and 0 or vj_beatnum2/2)
r=vj_fxrage/2
l=sqrt(x^2+y^2)/50
vx=x-11+(x*sin(l/8+v/2)+y*cos(l/6+v/3))*r
vy=y-11+(x*cos(l/7+v/3)-y*cos(l/9+v/2))*r
--vx,vy=vx+(vx*sin(v)-vy*cos(v))+.5,vy+(vx*cos(v)+vy*sin(v))+.5
a=sin(vx*.09-v*.8)+sin(vy*.14+v)
b=sin(vx*.11+v)+sin(vy*.05-v*0.6)
z=4
r=a*z+b*(z+1)
p={8,13,8,13}
c=vj_fxrage<.5 and 1 or vj_beatnum2*2
if(r>8)r=16-r
circfill(x*6,y*6,r*0.7+vj_beatflash*10,cpal[c+2][flr((r*.3)+2)])
end end
info()
end

-- octopus
-- @jordi_ros
function octopus()
cls()
r=180
k=flr(lerp(2,0,vj_fxrage))
for j=k,5 do
v=vj_beattime4+j/lerp(200,100,vj_fxrage)+(vj_beatflash-j/4)*.05
for i=0,r+1 do
p=sin(v)*10+20+(sin(i/60)^4)*40+vj_beatflash*10+j*(vj_fxrage*10+1)-30*(vj_fxrage)
a=i/r-.3*sin(p/r-v)
x=sin(a)*p*(vj_beatflash*4+1)+64
y=-cos(a)*p+64
c=vj_fxrage<.5 and 0 or vj_beatnum
if(i>0)line(n,m,x,y,cpal[c+1][j])
n,m=x,y
end end end

-- text scroller
-- @jordi_ros
function scroller()
cls()
text="picovj scroller"
v=128*(vj_time%(#text/2.5))
?text,0,0,1
for k=0,#text*24 do
i=k%5
j=flr(k/5)
p=vj_beatflash*5
x=j*9+128-v
y=i*9+25+9*sin(x/128)
c=vj_beatflash>0 and 8 or 13
if(pget(j,i)>0) then
 r=3+2*sin((x*1.3-50+y*1.4)/128)+p
 circfill(x,y,r+1,c+2)
 circfill(x,y,r,c+1)
 ?"☉",x-3,y-2,c
end
x=-(vj_time%10)*64+k*9
y=82+i*(5+i)
line(0,y,128,y,c)
line(x,82,(x-64)*4+64,128,1)
end end

-- wireframe twist
-- @jordi_ros
function tw_segment(u,j)
u+=.2+v+j*.1
f=.7+sin(v+j*.1)*.8*((sin(j/4+v)*vj_fxrage))
x=f*cos(u)*(vj_beatflash/2+1)
y=-f*sin(u)*(vj_beatflash/2+1)
a=64/-(y+2)+sin(vj_fxbeatflash)*30
b=64/(x-2)
return x*a+64,j*a+64,y*b+64,j*b+64 end

function twistwire()
cls()
v=vj_beattime4
for j=-3,1.5,lerp(.2,.05,vj_beatflash) do
for k=0,1,lerp(.25,.1,vj_fxrage) do
c=sin(v+j/10)*4+9
g,h,n,m=tw_segment(k,j)
line(g,h,n,m,c)
e,r=tw_segment(k,j-.2)
line(g,h,e,r,c)
end end end

-- rings
-- @jordi_ros
function rings()
for i=0,700 do
v=i*0+vj_time*.5*(vj_fxrage+1)
a=rnd(360)
r=rnd(64)
x=sin(a)*r
y=-cos(a)*r
r=sqrt(x^2+y^2)/lerp(lerp(16,32,vj_beat2),2,vj_beatflash)
k=r*2+vj_beatflash^2*2
c=vj_fxrage<.5 and cpal[4] or cpal[vj_beatnum2+5]
circfill(
(x+sin(v*.6)*20)*1.5+64,
(y+sin(v*.5)*20)*1.5+64,r/4+1,c[flr(k+1)])
end end

-- cube 3d
function c3d_point(x,y,z)
n,m=cos(v/6),sin(v/6)
x,z=x*n-z*m,x*m+z*n
n,m=cos(x/50+v/6),sin(y/50+v/8+vj_fxrage*x/30)
y,z=y*n-z*m,y*m+z*n
r=vj_beatflash
w=(70-r*80)/(z-13)
x=x*w+64
y=y*w+64
q=z*.4+(vj_fxrage<.5 and 8 or 8+vj_beatnum2*4)
if (pget(x,y)<q) circfill(x,y,z*.5,q)
end

function cube3d()
cls()
v=vj_beattime2*(vj_fxrage+1)+(vj_fxrage<.25 and 0 or vj_beatnum2)
for j=-5,5 do
for i=-5,5 do
for k=-5,5 do
c3d_point(i,j,k)end end end
end

-- cube inside
-- @jordi_ros
function ci_point(x,y,z)
a=v/7
x,z=x*cos(a)-z*sin(a),x*sin(a)+z*cos(a)
a=v/5
z,y=z*cos(a)-y*sin(a),z*sin(a)+y*cos(a)
r=vj_beatflash
w=(110-r*20)/(z-9-r*8)
x=x*w+64
y=y*w+64
q=z*.4+(vj_fxrage<.5 and 8 or 5+vj_beatnum*2.5)
if (pget(x,y)<q) circfill(x,y,z*.8,q)
end

function cubeinside()
cls()
v=vj_beattime4*(vj_fxrage/2+1)+(vj_fxrage<.25 and 0 or vj_beatnum2)
for j=-5,5 do
for i=-5,5 do
for k=-5,5 do
 ci_point(i,j+cos(v+k/20),k)
end end end
end


__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
07777777710000000077600777777777777776007777777777777760088200000000000882000000000000008820000000000000000000000000000000000000
07777777771000000077600777777777777776007777777777777760088200000000000882000000000000008820000000000000000000000000000000000000
07777777777100000077600777777777777776007777777777777760088820000000000882000000000000008820000000000000000000000000000000000000
07770000677710000077600777000000000000007770000000007760018882000000000882000000000000008820000000000000000000000000000000000000
07770000067771000077600777000000000000007770000000007760001888200000000882000000000000008820000000000000000000000000000000000000
07770000006777100077600777000000000000007770000000007760000188820000000882000000000000008820000000000000000000000000000000000000
07770000000677710077600777000000000000007770000000007760000018882000000882000000000000008820000000000000000000000000000000000000
07770000000067760077600777000000000000007770000000007760000001888200000882000000000000018820000000000000000000000000000000000000
07770077777777760077600777000000000000007770000000007760000000188820000882000000000000188820000000000000000000000000000000000000
07770077777777760077600777000000000000007770000000007760000000018882000882000000000001888200000000000000000000000000000000000000
07770000000000000077600777777777777776007777777777777760000000001888888882008888888888882000000000000000000000000000000000000000
07770000000000000077600777777777777776007777777777777760000000000188888882008888888888820000000000000000000000000000000000000000
07770000000000000077600777777777777776007777777777777760000000000018888882008888888888100000000000000000000000000000000000000000
