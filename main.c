#include <gb/gb.h>
#include <gb/font.h>
#include <stdio.h>
#include "background.c"
#include "arrowsprite.c"
#include "BackgroundTiles.c"
#include "titlemap.c"
#include "newbackground.c"
#include "playpause.c"
#include "cursor.c"
//#include "musicnote.c"

struct Cursor arrowsprite;

const UINT8 mincursorx = 40;
const UINT8 mincursory = 56;
const UINT8 maxcursorx = 136;
const UINT8 maxcursory = 112;

UBYTE keydown;
UBYTE withinBounds(UINT8 x, UINT8 y){
    if(x == 40 && y == 56 || x == 40 && y == 112 || x == 88 && y == 56 || x == 88 && y == 112 || x == 136 && y == 56 || x == 136 && y == 112){
        return 1;
        }
        return x >= mincursorx && x <= maxcursorx && y >= mincursory && y <= maxcursory;
}

void setPP(){
    set_sprite_data(0,1, PP);
    set_sprite_tile(30,56);
}

void performantdelay(UINT8 numloops){
    UINT8 ii;
    for(ii = 0; ii < numloops; ii++){
        wait_vbl_done();
    }
}


void main()
{
    setPP();
    
    NR52_REG = 0x80; /*turns on the sound*/
    NR50_REG = 0x77; /*sets volume for both channels to max, when using headphones (stereo)*/
    NR51_REG = 0xFF; /*selects which channels are being used*/
    
    font_t min_font;
    font_init();
    min_font = font_load(font_min);
    font_set(min_font);

    set_bkg_data(37,16, NB);
    set_bkg_tiles(0,0, ActualBackgroundWidth, ActualBackgroundHeight, ActualBackground);


    set_sprite_data(0, 2, TileLabel);
    set_sprite_tile(0,0);

    arrowsprite.x = 40;
    arrowsprite.y = 56;
    arrowsprite.col = 0;
    arrowsprite.row = 0;
    move_sprite(0, arrowsprite.x, arrowsprite.y);


    SHOW_BKG;
    DISPLAY_ON;
    SHOW_SPRITES;
    

    
    while(1){

        UBYTE joypad_state = joypad();
        if(joypad_state)
        delay(100);
        if(keydown){
            waitpadup();
            keydown = 0;
        }
        switch (joypad()){
            case J_UP:
            if(withinBounds(arrowsprite.x, arrowsprite.y -48)){
                    arrowsprite.y -=48;
                    arrowsprite.row--; 
                    scroll_sprite(0, 0, -48);
                    keydown = 1;
                    break;
            }
            case J_DOWN:
                if(withinBounds(arrowsprite.x, arrowsprite.y +48)){
                    arrowsprite.y +=48;
                    arrowsprite.row++; 
                    scroll_sprite(0, 0, 48);
                    keydown = 1;
                    break;
                }
            case J_RIGHT:
                if(withinBounds(arrowsprite.x +40, arrowsprite.y )){
                    arrowsprite.y +=40;
                    arrowsprite.col++; 
                    scroll_sprite(0, 40, 0);
                    keydown = 1;
                    break;
                }
            case J_LEFT:
                if(withinBounds(arrowsprite.x -40, arrowsprite.y )){
                    arrowsprite.y -=40;
                    arrowsprite.col--; 
                    scroll_sprite(0, -40, 0);
                    keydown = 1;
                    break;
                }
            case J_A:
                keydown = 1;
        }
        performantdelay(2);
        }
    }


