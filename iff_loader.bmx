' Amiga IFF-File loader (original Amiga DPAINT4 IFF-Format)
' code by AXG74 written in BlitzMAX (Windows)
' IFF-Format details
' https://wiki.multimedia.cx/index.php/IFF#ATAK_and_RLSE
' https://www.fileformat.info/format/iff/egff.htm

SuperStrict
AppTitle = "AMIGA DPAINT4-IFF loader"

Graphics 1024, 800
AutoImageFlags MASKEDIMAGE

Global picWidth:Int
Global picHeight:Int
Global picColorCount:Int
Global picBitplanes:Int

' Amiga color palette 32 colors
Global amigaColorPalette:Int[32]

' PC color palette
Global pcColorPalette:Int[32 * 3]

' Amiga bitplane data
Global amigaBitplaneData:Byte[40 * 256 * 5]

Global imgPic:TImage 
Global pixMap:TPixmap

LoadAmigaDpaint4IffFile("data/test_16colors.iff")

Repeat
	Cls
	SetScale 3,3
	DrawImage imgpic, 0, 0
	SetScale 1,1
	Flip
Until KeyDown(KEY_ESCAPE)
End

' create a pixmap from the loaded DPAINT4-Iff-Data
Function CreatePixmapFromIffData()
	Local offset:Int = 0	

	imgPic = CreateImage(picWidth, picHeight)
	pixMap = LockImage(imgPic)
	ClearPixels(pixMap)
		
	Local amigaByteBitplane1:Byte = 0
	Local amigaByteBitplane2:Byte = 0
	Local amigaByteBitplane3:Byte = 0
	Local amigaByteBitplane4:Byte = 0
	
	For Local y:Int = 0 To picHeight - 1
		For Local x:Int = 0 To picWidth / 8 - 1
			amigaByteBitplane1 = 0
			amigaByteBitplane2 = 0
			amigaByteBitplane3 = 0
			amigaByteBitplane4 = 0
			
			Select picColorCount
				Case 2
					offset = (picWidth / 8)
					amigaByteBitplane1 = amigaBitplaneData[ 0  + ((y * offset) + x)]	
				Case 4
					offset = (picWidth / 8) * 2	
					amigaByteBitplane1 = amigaBitplaneData[ 0  + ((y * offset) + x)]	
					amigaByteBitplane2 = amigaBitplaneData[40  + ((y * offset) + x)]
				Case 8
					offset = (picWidth / 8) * 3
					amigaByteBitplane1 = amigaBitplaneData[ 0  + ((y * offset) + x)]	
					amigaByteBitplane2 = amigaBitplaneData[40  + ((y * offset) + x)]
					amigaByteBitplane3 = amigaBitplaneData[80  + ((y * offset) + x)]		
				Case 16
					offset = (picWidth / 8) * 4
					amigaByteBitplane1 = amigaBitplaneData[ 0  + ((y * offset) + x)]	
					amigaByteBitplane2 = amigaBitplaneData[40  + ((y * offset) + x)]
					amigaByteBitplane3 = amigaBitplaneData[80  + ((y * offset) + x)]		
					amigaByteBitplane4 = amigaBitplaneData[120 + ((y * offset) + x)]	
			EndSelect
								
			' draw one byte (8 pixel)
			Local bitPos:Byte = %10000000

			For Local pixelX:Byte = 0 To 7			
				Local shift:Int  = 7 - pixelX

				Local color:Int =  ((amigaByteBitplane1 & bitPos) Shr shift) 		| ..
				  				  (((amigaByteBitplane2 & bitPos) Shr shift) Shl 1) | ..
				  				  (((amigaByteBitplane3 & bitPos) Shr shift) Shl 2) | ..
				  				  (((amigaByteBitplane4 & bitPos) Shr shift) Shl 3)

				Local red:Int = pcColorPalette[color * 3 + 0]
				Local green:Int = pcColorPalette[color * 3 + 1]
				Local blue:Int = pcColorPalette[color * 3 + 2]

				WritePixel(pixMap, (x * 8) + pixelX, y, %11111111000000000000000000000000 | red Shl 16 | green Shl 8 | blue)
				
				bitPos = bitPos Shr 1
			Next
		Next
	Next
	
	UnlockImage(imgPic)
EndFunction

' loads an AMIGA IFF-File (from DPAINT4)
Function LoadAmigaDpaint4IffFile(filename:String)
	Local pos:Int = 0
	Local compression:Int = 0
	Local iffData:TBank = LoadBank(filename)

	Local byt1:Byte = PeekByte(iffData, 0)
	Local byt2:Byte = PeekByte(iffData, 1)
	Local byt3:Byte = PeekByte(iffData, 2)
	Local byt4:Byte = PeekByte(iffData, 3)
	Local chunk:String = Chr(byt1) + Chr(byt2) + Chr(byt3) + Chr(byt4)
		
	For Local i:Int = 0 To Len(amigaBitplaneData) - 1
		amigaBitplaneData[i] = 0
	Next
	
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
			
			' search BODY-chunk for the picture data
			Repeat
				byt1 = PeekByte(iffData, pos + 0)
				byt2 = PeekByte(iffData, pos + 1)
				byt3 = PeekByte(iffData, pos + 2)
				byt4 = PeekByte(iffData, pos + 3)
				chunk = Chr(byt1) + Chr(byt2) + Chr(byt3) + Chr(byt4)
				pos:+1
			Until chunk = "BODY"
						
			If chunk = "BODY" Then
				pos:+5
				Local chunkLength:Int = (PeekByte(iffData, pos) Shl 8) + PeekByte(iffData, pos+1)
				pos:+2
				
				' decompress data "ByteRun1 Encoding"
				If compression Then
					Local destPos:Int = 0
					Local bodyPos:Int = pos
				
					For Local i:Int = 0 To chunkLength - 1
						Local byt:Byte = PeekByte(iffData, bodyPos)
						bodyPos:+1												
																														
						' compressed byte							
						If byt & %10000000 <> 0 Then				
							Local count:Byte = ~byt+1
	
							For Local k:Int = 0 To count
								amigaBitplaneData[destPos] = PeekByte(iffData, bodyPos)
								destPos:+1
							Next
							
							bodyPos:+1	
							i:+1
						Else
							' uncompressed byte
							For Local k:Int = 0 To byt
								amigaBitplaneData[destPos] = PeekByte(iffData, bodyPos)
								destPos:+1
								bodyPos:+1
								i:+1
							Next							
						EndIf
					Next
				EndIf
			Else
				Return
			EndIf
		Else
			Return
		EndIf
	Else 
		Return
	EndIf	
	
	CreatePixmapFromIffData()
EndFunction
