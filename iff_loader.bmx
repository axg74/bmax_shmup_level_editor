' #############################################################################
' # Amiga IFF-File loader (original Amiga DPAINT4 IFF-Format)				  #
' # code by AXG74 written in BlitzMAX (Windows)								  #
' # ==========================================================================#
' # IFF-Format details														  #
' # https://wiki.multimedia.cx/index.php/IFF#ATAK_and_RLSE					  #
' #############################################################################

SuperStrict
AppTitle="AMIGA DPAINT4-IFF loader"
Graphics 1024, 800

Global picWidth:Int
Global picHeight:Int
Global picColorCount:Int
Global picBitplanes:Int

' Amiga color palette 32 colors
Global amigaColorPalette:Int[32]

' PC color palette
Global pcColorPalette:Int[32 * 3]

Global imgPic:TImage 
Global pixMap:TPixmap

LoadAmigaDpaint4IffFile("data/tiles1.iff")
imgPic = CreateImage(picWidth, picHeight)
pixMap = LockImage(imgPic)
ClearPixels(pixMap)
For Local y:Int = 0 To picHeight - 1
	For Local x:Int = 0 To picWidth - 1
		WritePixel(pixMap, x, y, %11111111000000000000000000000000 | 255 Shl 16 | 0 Shl 8 | 0)
	Next
Next
UnlockImage(imgPic)

Repeat
	Cls
	SetScale 3,3
	DrawImage imgpic, 0, 0
	SetScale 1,1
	Flip
Until KeyDown(KEY_ESCAPE)
End

' #############################################################################
' # loads an AMIGA IFF-File (from DPAINT4)									  #
' #############################################################################
Function LoadAmigaDpaint4IffFile(filename:String)
	Local pos:Int = 0
	Local compression:Int = 0
	Local iffData:TBank = LoadBank(filename)

	Local byt1:Byte = PeekByte(iffData, 0)
	Local byt2:Byte = PeekByte(iffData, 1)
	Local byt3:Byte = PeekByte(iffData, 2)
	Local byt4:Byte = PeekByte(iffData, 3)
	Local chunk:String = Chr(byt1) + Chr(byt2) + Chr(byt3) + Chr(byt4)
	
	If chunk = "FORM" Then
		pos = 0
		
		Repeat
			byt1 = PeekByte(iffData, pos + 0)
			byt2 = PeekByte(iffData, pos + 1)
			byt3 = PeekByte(iffData, pos + 2)
			byt4 = PeekByte(iffData, pos + 3)
			chunk = Chr(byt1) + Chr(byt2) + Chr(byt3) + Chr(byt4)
			pos:+1
		Until chunk = "ILBM" Or pos > 15
		
		' ILBM-Chunk found
		If chunk = "ILBM" Then
			' search BMHD-Chunk for the picture information
			Repeat
				byt1 = PeekByte(iffData, pos + 0)
				byt2 = PeekByte(iffData, pos + 1)
				byt3 = PeekByte(iffData, pos + 2)
				byt4 = PeekByte(iffData, pos + 3)
				chunk = Chr(byt1) + Chr(byt2) + Chr(byt3) + Chr(byt4)
				pos:+1
			Until chunk = "BMHD" Or pos > 17
			
			If chunk = "BMHD" Then
				pos:+8
				picWidth  = PeekShort(iffData, pos)
				picHeight = PeekShort(iffData, pos + 1)	Shl 8
				picBitplanes = PeekByte(iffData, pos + 7)
				compression = PeekByte(iffData, pos + 9)
			Else
				Return
			EndIf
			
			' search CMAP-Chunk for the color-palette
			Repeat
				byt1 = PeekByte(iffData, pos + 0)
				byt2 = PeekByte(iffData, pos + 1)
				byt3 = PeekByte(iffData, pos + 2)
				byt4 = PeekByte(iffData, pos + 3)
				chunk = Chr(byt1) + Chr(byt2) + Chr(byt3) + Chr(byt4)
				pos:+1
			Until chunk = "CMAP" Or pos > 60
			
			If chunk = "CMAP" Then
				pos:+6
				picColorCount = PeekShort(iffData, pos) / 3
				pos:+1
		
				For Local i:Int = 0 To picColorCount - 1
				
					' generate AMIGA color palette
					Local red:Int = PeekByte(iffData, pos + 0) Shr 4
					Local green:Int = PeekByte(iffData, pos + 1) Shr 4
					Local blue:Int = PeekByte(iffData, pos + 2) Shr 4
									
					Local rgbValue:Short = red Shl 8 + green Shl 4 + blue 
					amigaColorPalette[i] = rgbValue
					
					' generate PC color palette
					pcColorPalette[i * 3 + 0] = red Shl 4
					pcColorPalette[i * 3 + 1] = green Shl 4
					pcColorPalette[i * 3 + 2] = blue Shl 4
					
					If pcColorPalette[i * 3 + 0] > 0 Then pcColorPalette[i * 3 + 0]:+16
					If pcColorPalette[i * 3 + 1] > 0 Then pcColorPalette[i * 3 + 1]:+16
					If pcColorPalette[i * 3 + 2] > 0 Then pcColorPalette[i * 3 + 2]:+16
					
					If pcColorPalette[i * 3 + 0] > 255 Then pcColorPalette[i * 3 + 0] = 255
					If pcColorPalette[i * 3 + 1] > 255 Then pcColorPalette[i * 3 + 1] = 255
					If pcColorPalette[i * 3 + 2] > 255 Then pcColorPalette[i * 3 + 2] = 255

					pos:+3
				Next
			Else
				Return
			EndIf
		Else
			Return
		EndIf
	Else 
		Return
	EndIf	
EndFunction
