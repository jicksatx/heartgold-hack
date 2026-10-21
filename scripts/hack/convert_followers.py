# convert pokeemerald-expansion follower sheets (6 frames in a row: down,down,up,up,left,left)
# into hg-engine's HGSS layout (8 frames stacked: up,up,down,down,left,left,right,right)
import sys, shutil
from PIL import Image
PEE='/home/claude/hgss/pee/graphics/pokemon/'
HG='/home/claude/hgss/hg-engine/data/graphics/sprites/'
def readpal(p):
    L=open(p).read().split(); n=int(L[2]); return [int(x) for x in L[3:3+3*n]][:48]
def writepal(p, cols):
    with open(p,'w',newline='') as f:
        f.write('JASC-PAL\r\n0100\r\n16\r\n'+''.join(f'{cols[i]} {cols[i+1]} {cols[i+2]}\r\n' for i in range(0,48,3)))
for name in sys.argv[1:]:
    s=Image.open(PEE+name+'/overworld.png'); assert s.mode=='P'
    w=s.size[0]//6; assert s.size==(w*6,w) and w in (32,64), (name,s.size)
    fr=[s.crop((i*w,0,i*w+w,w)) for i in range(6)]
    order=[fr[2],fr[3],fr[0],fr[1],fr[4],fr[5],fr[4].transpose(Image.FLIP_LEFT_RIGHT),fr[5].transpose(Image.FLIP_LEFT_RIGHT)]
    out=Image.new('P',(w,w*8),0)
    for i,f in enumerate(order): out.paste(f,(0,i*w))
    normal=readpal(PEE+name+'/overworld_normal.pal'); shiny=readpal(PEE+name+'/overworld_shiny.pal')
    out.putpalette(normal); out.save(HG+name+'/overworld.png', transparency=0)
    writepal(HG+name+'/overworld-tsure_poke0.pal', normal)
    writepal(HG+name+'/overworld-tsure_poke1.pal', shiny)
    shutil.copy(HG+('lugia' if w==64 else 'sprigatito')+'/overworld.json', HG+name+'/overworld.json')
    print(name, w)
