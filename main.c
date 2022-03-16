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

const UINT8 mincursorx = "";
const UINT8 mincursory = "";
const UINT8 maxcursorx = "";
const UINT8 maxcursory = "";

const char blankmap[6] = {0x2A, 0x00, 0x27, 0x28, 0x2B, 0x2C}; //these coords need to be set to the coords that the arrow will be landing on
UINT8 playerlocation[2];
UBYTE keydown;
UBYTE outofbounds(UINT8 x, UINT8 y){
    if(x == 40 && y == 56 || x == 40 && y == -8 || x == 80 && y == 56 || x == 80 && y == -8 || x == 120 && y == 56 || x == 120 && y == -8){
        return 1;
        }
    
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

    set_win_tiles(0, 0, 12, 1, titlemap);
    move_win(06, 10);

    set_bkg_data(37,16, NB);
    set_bkg_tiles(0,0, ActualBackgroundWidth, ActualBackgroundHeight, ActualBackground);
    set_sprite_data(0, 2, TileLabel); /*Try to change the variable name of this. This is the arrow sprite*/
    set_sprite_tile(0, 0);


    
    playerlocation[0] = 40;//x and y coords for player
    playerlocation[1] = 56;
    
    move_sprite(0,playerlocation[0], playerlocation[1]);


    SHOW_BKG;
    /*SHOW_WIN;*/
    DISPLAY_ON;
    SHOW_SPRITES;
    

    
    while(1){

        UBYTE joypad_state = joypad();
        if(joypad_state) /*{
            NR10_REG = 0x16;
            NR11_REG = 0x40;
            NR12_REG = 0x73;
            NR13_REG = 0x00;
            NR14_REG = 0xC3;       
            
        }*/
        delay(100);
        if(keydown){
            waitpadup();
            keydown = 0;
        }
        switch (joypad()){
            case J_UP:
                arrowsprite.y -=48;
                arrowsprite.row--; 
                scroll_sprite(0, 0, -48);
                keydown = 1;
                break;

        case J_DOWN:
            arrowsprite.y +=48;
            arrowsprite.row++; 
            scroll_sprite(0, 0, 48);
            keydown = 1;
            break;

        case J_RIGHT:
            arrowsprite.y +=40;
            arrowsprite.col++; 
            scroll_sprite(0, 40, 0);
            keydown = 1;
            break;

        case J_LEFT:
            arrowsprite.y -=40;
            arrowsprite.col--; 
            scroll_sprite(0, -40, 0);
            keydown = 1;
            break;
        case J_A:
            keydown = 1;
        }
        performantdelay(2);
        }
    }



