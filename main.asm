;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 4.1.6 #12439 (MINGW32)
;--------------------------------------------------------
	.module main
	.optsdcc -mgbz80
	
;--------------------------------------------------------
; Public variables in this module
;--------------------------------------------------------
	.globl _main
	.globl _performantdelay
	.globl _setPP
	.globl _font_set
	.globl _font_load
	.globl _font_init
	.globl _set_sprite_data
	.globl _set_win_tiles
	.globl _set_bkg_tiles
	.globl _set_bkg_data
	.globl _wait_vbl_done
	.globl _waitpadup
	.globl _joypad
	.globl _delay
	.globl _PP
	.globl _NB
	.globl _titlemap
	.globl _BackgroundTiles
	.globl _TileLabel
	.globl _ActualBackground
	.globl _keydown
	.globl _playerlocation
	.globl _arrowsprite
	.globl _blankmap
;--------------------------------------------------------
; special function registers
;--------------------------------------------------------
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _DATA
_arrowsprite::
	.ds 4
_playerlocation::
	.ds 2
_keydown::
	.ds 1
;--------------------------------------------------------
; ram data
;--------------------------------------------------------
	.area _INITIALIZED
_ActualBackground::
	.ds 360
_TileLabel::
	.ds 48
_BackgroundTiles::
	.ds 240
_titlemap::
	.ds 13
_NB::
	.ds 240
_PP::
	.ds 32
;--------------------------------------------------------
; absolute external ram data
;--------------------------------------------------------
	.area _DABS (ABS)
;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
	.area _HOME
	.area _GSINIT
	.area _GSFINAL
	.area _GSINIT
;--------------------------------------------------------
; Home
;--------------------------------------------------------
	.area _HOME
	.area _HOME
;--------------------------------------------------------
; code
;--------------------------------------------------------
	.area _CODE
;main.c:20: void setPP(){
;	---------------------------------
; Function setPP
; ---------------------------------
_setPP::
;main.c:21: set_sprite_data(0,1, PP);
	ld	de, #_PP
	push	de
	xor	a, a
	inc	a
	push	af
	call	_set_sprite_data
	add	sp, #4
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 122)
	ld	(hl), #0x38
;main.c:22: set_sprite_tile(30,56);
;main.c:23: }
	ret
_blankmap:
	.db #0x2a	;  42
	.db #0x00	;  0
	.db #0x27	;  39
	.db #0x28	;  40
	.db #0x2b	;  43
	.db #0x2c	;  44
;main.c:25: void performantdelay(UINT8 numloops){
;	---------------------------------
; Function performantdelay
; ---------------------------------
_performantdelay::
;main.c:27: for(ii = 0; ii < numloops; ii++){
	ld	c, #0x00
00103$:
	ld	a, c
	ldhl	sp,	#2
	sub	a, (hl)
	ret	NC
;main.c:28: wait_vbl_done();
	call	_wait_vbl_done
;main.c:27: for(ii = 0; ii < numloops; ii++){
	inc	c
;main.c:30: }
	jr	00103$
;main.c:33: void main()
;	---------------------------------
; Function main
; ---------------------------------
_main::
;main.c:35: setPP();
	call	_setPP
;main.c:37: NR52_REG = 0x80; /*turns on the sound*/
	ld	a, #0x80
	ldh	(_NR52_REG + 0), a
;main.c:38: NR50_REG = 0x77; /*sets volume for both channels to max, when using headphones (stereo)*/
	ld	a, #0x77
	ldh	(_NR50_REG + 0), a
;main.c:39: NR51_REG = 0xFF; /*selects which channels are being used*/
	ld	a, #0xff
	ldh	(_NR51_REG + 0), a
;main.c:42: font_init();
	call	_font_init
;main.c:43: min_font = font_load(font_min);
	ld	de, #_font_min
	push	de
	call	_font_load
	pop	hl
;main.c:44: font_set(min_font);
	push	de
	call	_font_set
	pop	hl
;main.c:46: set_win_tiles(0, 0, 12, 1, titlemap);
	ld	de, #_titlemap
	push	de
	ld	hl, #0x10c
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_win_tiles
	add	sp, #6
;c:/gbdk/include/gb/gb.h:1044: WX_REG=x, WY_REG=y;
	ld	a, #0x06
	ldh	(_WX_REG + 0), a
	ld	a, #0x0a
	ldh	(_WY_REG + 0), a
;main.c:49: set_bkg_data(37,16, NB);
	ld	de, #_NB
	push	de
	ld	hl, #0x1025
	push	hl
	call	_set_bkg_data
	add	sp, #4
;main.c:50: set_bkg_tiles(0,0, ActualBackgroundWidth, ActualBackgroundHeight, ActualBackground);
	ld	de, #_ActualBackground
	push	de
	ld	hl, #0x1214
	push	hl
	xor	a, a
	rrca
	push	af
	call	_set_bkg_tiles
	add	sp, #6
;main.c:51: set_sprite_data(0, 2, TileLabel); /*Try to change the variable name of this. This is the arrow sprite*/
	ld	de, #_TileLabel
	push	de
	ld	hl, #0x200
	push	hl
	call	_set_sprite_data
	add	sp, #4
;c:/gbdk/include/gb/gb.h:1174: shadow_OAM[nb].tile=tile;
	ld	hl, #(_shadow_OAM + 2)
	ld	(hl), #0x00
;main.c:56: playerlocation[0] = 40;//x and y coords for player
	ld	de, #_playerlocation+0
	ld	a, #0x28
	ld	(de), a
;main.c:57: playerlocation[1] = 56;
	ld	l, e
;	spillPairReg hl
;	spillPairReg hl
	ld	h, d
;	spillPairReg hl
;	spillPairReg hl
	inc	hl
	ld	(hl), #0x38
;main.c:59: move_sprite(0,playerlocation[0], playerlocation[1]);
	ld	b, (hl)
	ld	a, (de)
	ld	c, a
;c:/gbdk/include/gb/gb.h:1247: OAM_item_t * itm = &shadow_OAM[nb];
	ld	hl, #_shadow_OAM
;c:/gbdk/include/gb/gb.h:1248: itm->y=y, itm->x=x;
	ld	a, b
	ld	(hl+), a
	ld	(hl), c
;main.c:62: SHOW_BKG;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x01
	ldh	(_LCDC_REG + 0), a
;main.c:64: DISPLAY_ON;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x80
	ldh	(_LCDC_REG + 0), a
;main.c:65: SHOW_SPRITES;
	ldh	a, (_LCDC_REG + 0)
	or	a, #0x02
	ldh	(_LCDC_REG + 0), a
;main.c:69: while(1){
00112$:
;main.c:71: UBYTE joypad_state = joypad();
	call	_joypad
	ld	a, e
;main.c:72: if(joypad_state) /*{
	or	a, a
	jr	Z, 00102$
;main.c:80: delay(100);
	ld	de, #0x0064
	push	de
	call	_delay
	pop	hl
00102$:
;main.c:81: if(keydown){
;setupPair	HL
	ld	a, (#_keydown)
	or	a, a
	jr	Z, 00104$
;main.c:82: waitpadup();
	call	_waitpadup
;main.c:83: keydown = 0;
;setupPair	HL
	ld	hl, #_keydown
	ld	(hl), #0x00
00104$:
;main.c:85: switch (joypad()){
	call	_joypad
	ld	a, e
	dec	a
	jr	Z, 00107$
	ld	a,e
	cp	a,#0x02
	jr	Z, 00108$
	cp	a,#0x04
	jr	Z, 00105$
	cp	a,#0x08
	jr	Z, 00106$
	sub	a, #0x10
	jr	Z, 00109$
	jp	00110$
;main.c:86: case J_UP:
00105$:
;main.c:87: arrowsprite.y -=48;
	ld	bc, #_arrowsprite + 1
	ld	a, (bc)
	add	a, #0xd0
	ld	(bc), a
;main.c:88: arrowsprite.row--; 
	ld	bc, #_arrowsprite + 3
	ld	a, (bc)
	dec	a
	ld	(bc), a
;c:/gbdk/include/gb/gb.h:1263: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+0
;c:/gbdk/include/gb/gb.h:1264: itm->y+=y, itm->x+=x;
	ld	a, (bc)
	add	a, #0xd0
	ld	(bc), a
	inc	bc
	ld	a, (bc)
	ld	(bc), a
;main.c:90: keydown = 1;
;setupPair	HL
	ld	hl, #_keydown
	ld	(hl), #0x01
;main.c:91: break;
	jr	00110$
;main.c:93: case J_DOWN:
00106$:
;main.c:94: arrowsprite.y +=48;
	ld	bc, #_arrowsprite + 1
	ld	a, (bc)
	add	a, #0x30
	ld	(bc), a
;main.c:95: arrowsprite.row++; 
	ld	bc, #_arrowsprite + 3
	ld	a, (bc)
	inc	a
	ld	(bc), a
;c:/gbdk/include/gb/gb.h:1263: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM+0
;c:/gbdk/include/gb/gb.h:1264: itm->y+=y, itm->x+=x;
	ld	a, (bc)
	add	a, #0x30
	ld	(bc), a
	inc	bc
	ld	a, (bc)
	ld	(bc), a
;main.c:97: keydown = 1;
;setupPair	HL
	ld	hl, #_keydown
	ld	(hl), #0x01
;main.c:98: break;
	jr	00110$
;main.c:100: case J_RIGHT:
00107$:
;main.c:101: arrowsprite.y +=40;
	ld	bc, #_arrowsprite + 1
	ld	a, (bc)
	add	a, #0x28
	ld	(bc), a
;main.c:102: arrowsprite.col++; 
	ld	bc, #_arrowsprite + 2
	ld	a, (bc)
	inc	a
	ld	(bc), a
;c:/gbdk/include/gb/gb.h:1263: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM
;c:/gbdk/include/gb/gb.h:1264: itm->y+=y, itm->x+=x;
	ld	a, (bc)
	ld	(bc), a
	inc	bc
	ld	a, (bc)
	add	a, #0x28
	ld	(bc), a
;main.c:104: keydown = 1;
;setupPair	HL
	ld	hl, #_keydown
	ld	(hl), #0x01
;main.c:105: break;
	jr	00110$
;main.c:107: case J_LEFT:
00108$:
;main.c:108: arrowsprite.y -=40;
	ld	bc, #_arrowsprite + 1
	ld	a, (bc)
	add	a, #0xd8
	ld	(bc), a
;main.c:109: arrowsprite.col--; 
	ld	bc, #_arrowsprite + 2
	ld	a, (bc)
	dec	a
	ld	(bc), a
;c:/gbdk/include/gb/gb.h:1263: OAM_item_t * itm = &shadow_OAM[nb];
	ld	bc, #_shadow_OAM
;c:/gbdk/include/gb/gb.h:1264: itm->y+=y, itm->x+=x;
	ld	a, (bc)
	ld	(bc), a
	inc	bc
	ld	a, (bc)
	add	a, #0xd8
	ld	(bc), a
;main.c:111: keydown = 1;
;setupPair	HL
	ld	hl, #_keydown
	ld	(hl), #0x01
;main.c:112: break;
	jr	00110$
;main.c:113: case J_A:
00109$:
;main.c:114: keydown = 1;
;setupPair	HL
	ld	hl, #_keydown
	ld	(hl), #0x01
;main.c:115: }
00110$:
;main.c:116: performantdelay(2);
	ld	a, #0x02
	push	af
	inc	sp
	call	_performantdelay
	inc	sp
;main.c:118: }
	jp	00112$
	.area _CODE
	.area _INITIALIZER
__xinit__ActualBackground:
	.db #0x25	; 37
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x2b	; 43
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2c	; 44
	.db #0x26	; 38
	.db #0x30	; 48	'0'
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x2b	; 43
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x2b	; 43
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x2b	; 43
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2c	; 44
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2c	; 44
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2c	; 44
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2c	; 44
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2c	; 44
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2c	; 44
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2c	; 44
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2c	; 44
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2c	; 44
	.db #0x26	; 38
	.db #0x27	; 39
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x2a	; 42
	.db #0x00	; 0
	.db #0x27	; 39
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x2a	; 42
	.db #0x00	; 0
	.db #0x27	; 39
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x2a	; 42
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2c	; 44
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2c	; 44
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2c	; 44
	.db #0x26	; 38
	.db #0x30	; 48	'0'
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x2b	; 43
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x2b	; 43
	.db #0x00	; 0
	.db #0x30	; 48	'0'
	.db #0x29	; 41
	.db #0x29	; 41
	.db #0x2b	; 43
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2c	; 44
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2c	; 44
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2c	; 44
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2c	; 44
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2c	; 44
	.db #0x26	; 38
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2c	; 44
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2c	; 44
	.db #0x00	; 0
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2c	; 44
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2c	; 44
	.db #0x26	; 38
	.db #0x27	; 39
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x2a	; 42
	.db #0x00	; 0
	.db #0x27	; 39
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x2a	; 42
	.db #0x00	; 0
	.db #0x27	; 39
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x2a	; 42
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2c	; 44
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2c	; 44
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2c	; 44
	.db #0x26	; 38
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2c	; 44
	.db #0x2e	; 46
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x33	; 51	'3'
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x2d	; 45
	.db #0x26	; 38
	.db #0x1e	; 30
	.db #0x13	; 19
	.db #0x1e	; 30
	.db #0x16	; 22
	.db #0x0f	; 15
	.db #0x31	; 49	'1'
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x2c	; 44
	.db #0x27	; 39
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x32	; 50	'2'
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x28	; 40
	.db #0x2a	; 42
__xinit__TileLabel:
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf0	; 240
	.db #0xf8	; 248
	.db #0xf8	; 248
	.db #0xfc	; 252
	.db #0x9c	; 156
	.db #0xbe	; 190
	.db #0x0e	; 14
	.db #0x1e	; 30
	.db #0x06	; 6
	.db #0x0e	; 14
	.db #0x00	; 0
	.db #0xe7	; 231
	.db #0xe7	; 231
	.db #0xc3	; 195
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x81	; 129
	.db #0x81	; 129
	.db #0xc3	; 195
	.db #0x81	; 129
	.db #0xe7	; 231
	.db #0xe7	; 231
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x66	; 102	'f'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x42	; 66	'B'
	.db #0x66	; 102	'f'
	.db #0x42	; 66	'B'
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x00	; 0
	.db #0x00	; 0
__xinit__BackgroundTiles:
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x18	; 24
	.db #0x38	; 56	'8'
	.db #0x18	; 24
	.db #0x38	; 56	'8'
	.db #0x18	; 24
	.db #0x38	; 56	'8'
	.db #0x18	; 24
	.db #0x38	; 56	'8'
	.db #0x18	; 24
	.db #0x38	; 56	'8'
	.db #0x18	; 24
	.db #0x38	; 56	'8'
	.db #0x18	; 24
	.db #0xfe	; 254
	.db #0x7e	; 126
	.db #0xfe	; 254
	.db #0x18	; 24
	.db #0x38	; 56	'8'
	.db #0x18	; 24
	.db #0x38	; 56	'8'
	.db #0x18	; 24
	.db #0x38	; 56	'8'
	.db #0x18	; 24
	.db #0x38	; 56	'8'
	.db #0x18	; 24
	.db #0x38	; 56	'8'
	.db #0x18	; 24
	.db #0xfe	; 254
	.db #0x7e	; 126
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x18	; 24
	.db #0x38	; 56	'8'
	.db #0x18	; 24
	.db #0x38	; 56	'8'
	.db #0x18	; 24
	.db #0x38	; 56	'8'
	.db #0x18	; 24
	.db #0x38	; 56	'8'
	.db #0x18	; 24
	.db #0x38	; 56	'8'
	.db #0x18	; 24
	.db #0x38	; 56	'8'
	.db #0x18	; 24
	.db #0x70	; 112	'p'
	.db #0x30	; 48	'0'
	.db #0x70	; 112	'p'
	.db #0x30	; 48	'0'
	.db #0x70	; 112	'p'
	.db #0x30	; 48	'0'
	.db #0x70	; 112	'p'
	.db #0x30	; 48	'0'
	.db #0x70	; 112	'p'
	.db #0x30	; 48	'0'
	.db #0x70	; 112	'p'
	.db #0x30	; 48	'0'
	.db #0x70	; 112	'p'
	.db #0x30	; 48	'0'
	.db #0x7e	; 126
	.db #0x3e	; 62
	.db #0x7e	; 126
	.db #0x3e	; 62
	.db #0x7e	; 126
	.db #0x30	; 48	'0'
	.db #0x70	; 112	'p'
	.db #0x30	; 48	'0'
	.db #0x7c	; 124
	.db #0x3c	; 60
	.db #0x7c	; 124
	.db #0x30	; 48	'0'
	.db #0x70	; 112	'p'
	.db #0x30	; 48	'0'
	.db #0x70	; 112	'p'
	.db #0x30	; 48	'0'
	.db #0x7e	; 126
	.db #0x3e	; 62
__xinit__titlemap:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
__xinit__NB:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0xfe	; 254
	.db #0x06	; 6
	.db #0x06	; 6
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x1f	; 31
	.db #0x1f	; 31
	.db #0x3f	; 63
	.db #0x3f	; 63
	.db #0x78	; 120	'x'
	.db #0x78	; 120	'x'
	.db #0x70	; 112	'p'
	.db #0x70	; 112	'p'
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0xff	; 255
	.db #0x30	; 48	'0'
	.db #0x30	; 48	'0'
__xinit__PP:
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x78	; 120	'x'
	.db #0x78	; 120	'x'
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x7f	; 127
	.db #0x7f	; 127
	.db #0x7e	; 126
	.db #0x7e	; 126
	.db #0x78	; 120	'x'
	.db #0x78	; 120	'x'
	.db #0x60	; 96
	.db #0x60	; 96
	.db #0x00	; 0
	.db #0x00	; 0
	.db #0x6c	; 108	'l'
	.db #0x6c	; 108	'l'
	.db #0x6c	; 108	'l'
	.db #0x6c	; 108	'l'
	.db #0x6c	; 108	'l'
	.db #0x6c	; 108	'l'
	.db #0x6c	; 108	'l'
	.db #0x6c	; 108	'l'
	.db #0x6c	; 108	'l'
	.db #0x6c	; 108	'l'
	.db #0x6c	; 108	'l'
	.db #0x6c	; 108	'l'
	.db #0x00	; 0
	.db #0x00	; 0
	.area _CABS (ABS)
