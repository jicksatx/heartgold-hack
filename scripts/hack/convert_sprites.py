# convert pokeemerald-expansion (GBA, 64x64) battle sprites into hg-engine's DS layout (two 80x80 frames side by side)
import sys
from PIL import Image
PEE='/home/claude/hgss/pee/graphics/pokemon/'
HG='/home/claude/hgss/hg-engine/data/graphics/sprites/'
def readpal(p):
    L=open(p).read().split()
    n=int(L[2]); cols=[int(x) for x in L[3:3+3*n]]
    return (cols+[0]*(48-len(cols)))[:48]
def build(src_png, pal):
    s=Image.open(src_png)
    assert s.mode=='P' and s.size==(64,64), (src_png, s.mode, s.size)
    out=Image.new('P',(160,80),0)
    for f in range(2): out.paste(s,(f*80+8,16))
    out.putpalette(pal)
    return out
for name in sys.argv[1:]:
    normal=readpal(PEE+name+'/normal.pal'); shiny=readpal(PEE+name+'/shiny.pal')
    build(PEE+name+'/front.png', normal).save(HG+name+"/male/front.png", transparency=0)
    build(PEE+name+'/back.png', shiny).save(HG+name+"/male/back.png", transparency=0)
    print('ok',name)
