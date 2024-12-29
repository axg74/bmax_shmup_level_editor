# bmax_shmup_level_editor

A simple level-editor for my shoot'em'up game project on the amiga. I don't want edit the level-maps within the amiga
emulator environment and I don't want use Tiled, so I started my own level-editor.

It's still in development. You can compile the code with the BlitzMAX version 1.5x or you can also use the newer version of BlitzMAX NG.

Level data will be loaded/saved in the folder "data/lvl" as binary data.

Keyboard / Mouse shortcuts:

 * cursor-keys left/right 	 = scroll levelmap
 * key-c					 = clear level data
 * key-s					 = save level data
 * key-l					 = load level data
 * key-g					 = toggle tile-grid
 * key-escape			 	 = exit level-editor
 * left-mouse button		 = set tile (selection from the tile-selection screen)
 * right-mouse button	 	 = clear tile with id #0
 * middle-mouse button	  	 = open tile-selection screen (left-mouse-button for selecting a tile for editing)
 
 amiga graphics mode for the game:
 =================================
 * game-resolution: 320 x 208 pixel
 * tile-size: 		16  x 16 pixel
 * 4 bitplanes for the game-graphics (16 colors)
   * for the tile-graphics
   * for the enemies
   
 * player sprite and player-shot's as amiga-hardware sprites (another 16 color palette)

 
 todo's:
 =======
  * set player-ship start-position
  * set enemy objects
  * export option for the tileset-graphics as a native amiga rawblit binary
  * export option for all sprites and bobs as a native amiga rawblit binary
  
 
 
