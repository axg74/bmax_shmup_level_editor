' #############################################################################
' level-editor for 2d horizontal scrolling shoot-em-up-game (amiga version)
' code by AXG74
' in BlitzMAX for Windows
'
' keyboard-shortcuts for the level-editor:
' cursor-keys left/right = scroll levelmap
' key-c					 = clear level data
' key-s					 = save level data
' key-l					 = load level data
' key-g					 = toggle tile-grid
' key-escape			 = exit level-editor
' left-mouse button		 = set tile (selection from the tile-selection screen)
' right-mouse button	 = clear tile with id #0
' middle-mouse button	 = open tile-selection screen (left-mouse-button for selecting a tile for editing)
' #############################################################################

SuperStrict

Const VERSION:String = "0.00"

' amiga game size
Const GAME_WIDTH:Int = 320
Const GAME_HEIGHT:Int = 256

' size of a level in tiles
Const LEVELMAP_WIDTH:Int = 20 * 10
Const LEVELMAP_HEIGHT:Int = 13

' tile-size in pixel (width, height)
Const TILE_SIZE:Int = 16

' size of a tilemap for one screen
Const TILE_COLS:Int = GAME_WIDTH / TILE_SIZE
Const TILE_ROWS:Int = GAME_HEIGHT / TILE_SIZE

' scale factor
Global scale:Int

' current tileset graphics
Global tileset:TImage

' some editor-UI gfx
Global gfx:TImage

' current mouse-position aligned to the tile-size
Global tileMouseX:Int
Global tileMouseY:Int

' current position of tile in tilemap coordinates
Global tileX:Int
Global tileY:Int

' current level-position in tiles
Global level_pos_x:Float
Global level_pos_y:Int

' current selected tile-id
Global selectedTileId:Int

' display tilegrid in level-editor mode
Global tileGridDisplay:Int = True

' x/y position for each tile in the tileset
Global tilePosTab:Int[TILE_COLS * TILE_ROWS * 2]

' data for the tilemap foreground layer
Global tileMapData_foreground:Int[LEVELMAP_WIDTH, LEVELMAP_HEIGHT]

Init()
MainLoop()
End

' #############################################################################
' # level-editor´s main loop												  #
' #############################################################################
Function MainLoop()
	Repeat
		ClearAmigaScreen(50, 10, 0, GAME_WIDTH, LEVELMAP_HEIGHT * TILE_SIZE)
		CalcTileMousePos()

		DrawTilemap()

		If tileMouseY < LEVELMAP_HEIGHT * TILE_SIZE * scale Then
			DrawCurrentTileAtMousePosition()
			DrawTileCursorAtMousePos()
		EndIf
		
		' left-mouse-button: set tile
		If MouseDown(1) Then
			SetTile_Foreground(selectedTileId)
		EndIf
		
		' right-mouse-button: clear tile with tile-id #0
		If MouseDown(2) Then
			SetTile_Foreground(0)
		EndIf
		
		' middle-mouse-button: tile-selection
		If MouseHit(3) Then
			TilesetSelection()
		EndIf
		
		' KEY-L: load level data
		If KeyHit(KEY_L) Then
			LoadLevelData()
		EndIf
		
		' KEY-S: save level data
		If KeyHit(KEY_S) Then
			SaveLevelData()
		EndIf

		' KEY-C: clear all current level data
		If KeyHit(KEY_C) Then
			ClearLevelData()
		EndIf
		
		' KEY-G: toogle tile grid display
		If KeyHit(KEY_G) Then
			tileGridDisplay = Not tileGridDisplay
		EndIf
		
		' scroll the level-map with cursor keys
		If KeyDown(KEY_LEFT) Then
			level_pos_x:-0.25
			If level_pos_x < 0 Then level_pos_x = 0
		EndIf

		If KeyDown(KEY_RIGHT) Then
			level_pos_x:+0.25
			If level_pos_x > LEVELMAP_WIDTH - TILE_COLS Then level_pos_x = LEVELMAP_WIDTH - TILE_COLS
		EndIf
		
		DrawLevelEditorInformationText()
				
		Flip
	Until KeyDown(KEY_ESCAPE)
EndFunction

' #############################################################################
' # init level-editor														  #
' #############################################################################
Function Init()
	AppTitle = "AXG74 * Level-Editor"
	Graphics DesktopWidth(), DesktopHeight(), DesktopDepth(), DesktopHertz()
	AutoImageFlags MASKEDIMAGE
	scale = Floor(DesktopHeight() / GAME_HEIGHT)
	
	gfx = LoadImage("data/gfx.png")
	tileset = LoadImage("data/tileset1.png")
	
	CalcTilePosTab()
	ClearLevelData()
	
	level_pos_x = 0
	level_pos_y = 0
EndFunction

' #############################################################################
' # tile selection screen * user can select a tile for level-editing		  #
' #############################################################################
Function TilesetSelection()
	Repeat
		ClearAmigaScreen(0, 70, 0, GAME_WIDTH, GAME_HEIGHT)
		CalcTileMousePos()
		CalcSelectedTileId()
		
		SetScale scale, scale
		DrawImage tileset, 0, 0
		DrawTileCursorAtMousePos()
		
		SetScale 2, 2
		DrawText "tile-Nr: " + selectedTileId, GAME_WIDTH * scale + 5, 5
		DrawText "pick a tile", 5, GAME_HEIGHT * scale + 5
		SetScale 1, 1
		Flip
	Until MouseHit(1)

	While MouseDown(1)
	Wend
EndFunction

' #############################################################################
' # draw a tile-cursor at the current mouse-position						  #
' #############################################################################
Function DrawTileCursorAtMousePos()	
	SetScale scale, scale
	SetColor 0, 0, 220
	DrawSubImageRect gfx,tileMouseX , tileMouseY, TILE_SIZE, TILE_SIZE, 16, 0, TILE_SIZE, TILE_SIZE
	SetScale 1, 1
	SetColor 255, 255, 255
EndFunction


' #############################################################################
' # draws the current tile at the current mouse-position					  #
' #############################################################################
Function DrawCurrentTileAtMousePosition()
	Local xs:Int = tilePosTab[selectedTileId * 2 + 0]
	Local ys:Int = tilePosTab[selectedTileId * 2 + 1]
	SetScale scale, scale
	DrawSubImageRect(tileset, tileMouseX, tileMouseY, TILE_SIZE, TILE_SIZE, xs, ys, TILE_SIZE, TILE_SIZE)
	SetScale 1, 1
EndFunction

' #############################################################################
' # calculate the current mouse-position for the tile-editing				  #
' #############################################################################
Function CalcTileMousePos()
	tileMouseX = (MouseX() / (TILE_SIZE * scale)) * (TILE_SIZE * scale)
	tileMouseY = (MouseY() / (TILE_SIZE * scale)) * (TILE_SIZE * scale)	
	If tileMouseX > ((GAME_WIDTH - TILE_SIZE) * scale) Then tileMouseX = ((GAME_WIDTH - TILE_SIZE) * scale)
	If tileMouseY > ((GAME_HEIGHT - TILE_SIZE) * scale) Then tileMouseY = ((GAME_HEIGHT - TILE_SIZE) * scale)
EndFunction

' #############################################################################
' calculate current tile-id													  #
' #############################################################################
Function CalcSelectedTileId()
	selectedTileId = Floor((tileMouseX / scale) / TILE_SIZE) + Floor(((tileMouseY / scale) / TILE_SIZE) * TILE_COLS)
EndFunction

' #############################################################################
' fill rectangle area with color											  #
' #############################################################################
Function ClearAmigaScreen(r:Int, g:Int, b:Int, width:Int, height:Int)
	Cls
	SetScale scale, scale
	SetColor r, g, b
	DrawRect 0, 0, width, height
	SetColor 255, 255, 255
	SetScale 1, 1
EndFunction

' #############################################################################
' # delete all tilemap level data											  #
' #############################################################################
Function ClearLevelData()
	For Local y:Int = 0 To LEVELMAP_HEIGHT- 1
		For Local x:Int = 0 To LEVELMAP_WIDTH - 1
			tileMapData_foreground[x, y] = 0
		Next
	Next	
EndFunction

' #############################################################################
' # calculate for each tile the x/y-position within the tileset				  #
' #############################################################################
Function CalcTilePosTab()
	Local pos:Int = 0
	
	For Local y:Int = 0 To TILE_ROWS - 1
		For Local x:Int = 0 To TILE_COLS - 1
			tilePosTab[pos + 0] = x * TILE_SIZE
			tilePosTab[pos + 1] = y * TILE_SIZE
			pos:+2
		Next
	Next
EndFunction

' #############################################################################
' # set a tile at the current mouse-position								  #
' #############################################################################
Function SetTile_Foreground(tileId:Int)
	CalcTilePosition()
	If tileY > LEVELMAP_HEIGHT - 1 Then Return	
	tileMapData_foreground[tileX, tileY] = tileId
EndFunction

' #############################################################################
' # calculate the tile-position within the level-map						  #
' #############################################################################
Function CalcTilePosition()
	tileX = ((tileMouseX / scale) / TILE_SIZE) + Int(level_pos_x)
	tileY = (tileMouseY / scale) / TILE_SIZE
EndFunction

' #############################################################################
' # draw the tilemap to the screen											  #
' #############################################################################
Function DrawTilemap()
	Local tileId:Int = 0

	SetScale scale, scale
	
	For Local y:Int = 0 To LEVELMAP_HEIGHT - 1
		For Local x:Int = 0 To TILE_COLS - 1			
			tileId = tileMapData_foreground[x + Floor(level_pos_x), y]
			If tileId > 0 Then
				Local tileX:Int = tilePosTab[tileId * 2 + 0]
				Local tileY:Int = tilePosTab[tileId * 2 + 1]
				
				DrawSubImageRect (tileset, x * TILE_SIZE * scale, y * TILE_SIZE * scale, TILE_SIZE, TILE_SIZE, tileX, tileY, TILE_SIZE, TILE_SIZE)
			EndIf
			
			If tileGridDisplay Then
				SetColor 80, 40, 30
				SetBlend ALPHABLEND
				SetAlpha 0.5
				DrawSubImageRect (gfx, x * TILE_SIZE * scale, y * TILE_SIZE * scale, TILE_SIZE, TILE_SIZE, 32, 0, TILE_SIZE, TILE_SIZE)
				SetBlend MASKBLEND
				SetColor 255, 255, 255
				SetAlpha 1.0
			EndIf
		Next
	Next
	
	SetScale 1, 1
EndFunction

' #############################################################################
' # load level-data from file												  #
' #############################################################################
Function LoadLevelData()
EndFunction

' #############################################################################
' # save level-data to file													  #
' #############################################################################
Function SaveLevelData()
EndFunction

' #############################################################################
' # draw information text for the level-editor   							  #
' #############################################################################
Function DrawLevelEditorInformationText()
	SetScale 2,2
	DrawText("level-x: " + Int(level_pos_x * TILE_SIZE), GAME_WIDTH * scale + 5, 5)
	Local lvlX:Int = Int(tileMouseX / scale) + Int(level_pos_x * TILE_SIZE)
	DrawText(" tile-x: " + lvlX, GAME_WIDTH * scale + 5, 30)
	DrawText(" tile-y: " + Int(tileMouseY / scale), GAME_WIDTH * scale + 5, 52)
	
	SetColor 0,50,160
	DrawText("AXG74 Level-Editor v" + VERSION, 2, GAME_HEIGHT * scale)
	SetColor 255,255,255

	
	' draw the current screen-number at left top corner
	Local x:Int = Int(level_pos_x Mod TILE_COLS)

	SetScale scale, scale
	SetColor 0,255,0
	DrawText(Int(level_pos_x / TILE_COLS) + 1, 15, 3)

	SetColor 0,100,0
	SetBlend ALPHABLEND
	SetAlpha 0.75
	
	' display marker for the screen marking and screen numbers
	If x < 1 Then
		' top left marker
		DrawSubImageRect gfx, 0, 0, 16, 16, 48,0, 16, 16

		' bottom Left marker
		DrawSubImageRect gfx, 0, (LEVELMAP_HEIGHT - 1) * TILE_SIZE * scale, 16, 16, 48,16, 16, 16
	Else
	
		SetColor 0,255,0
		SetAlpha 1.0
		DrawText(Int(level_pos_x / TILE_COLS) + 2, 8 + (GAME_WIDTH - x * TILE_SIZE) * scale, 3)
		SetBlend ALPHABLEND
		SetAlpha 0.75
		SetColor 0,100,0

		' top left marker
		DrawSubImageRect gfx, (GAME_WIDTH - x * TILE_SIZE) * scale, 0, 16, 16, 48,0, 16, 16		

		' bottom Left marker
		DrawSubImageRect gfx, (GAME_WIDTH - x * TILE_SIZE) * scale, (LEVELMAP_HEIGHT - 1) * TILE_SIZE * scale, 16, 16, 48,16, 16, 16
	EndIf
	
	' top right marker
	DrawSubImageRect gfx, (GAME_WIDTH - (x + 1) * TILE_SIZE) * scale, 0, 16, 16, 64,0, 16, 16 
	
	' bottom right marker
	DrawSubImageRect gfx, (GAME_WIDTH - (x + 1) * TILE_SIZE) * scale, (LEVELMAP_HEIGHT - 1) * TILE_SIZE * scale, 16, 16, 64,16, 16, 16 
	
	SetAlpha 1.0
	SetBlend MASKBLEND
	SetScale 1,1
	SetColor 255,255,255
EndFunction