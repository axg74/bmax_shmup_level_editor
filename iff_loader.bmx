' Amiga IFF-File loader (original Amiga DPAINT4 IFF-Format)
' code by AXG74 written in BlitzMAX (Windows)
' IFF-Format details
' https://wiki.multimedia.cx/index.php/IFF#ATAK_and_RLSE
' https://www.fileformat.info/format/iff/egff.htm

SuperStrict

Type TDPaint4
	' picture width in pixel
	Global picWidth:Int
	
	' picture height in pixel
	Global picHeight:Int
	
	' amount of colors (2, 4, 8, 16, 32)
	Global picColorCount:Int
	
	' amount of bitplanes (1 - 5)
	Global picBitplanes:Int
	
	' Amiga color palette 32 colors in Amiga-format
	Global amigaColorPalette:Int[32]
	
	' PC color palette (red, green, blue)
	Global pcColorPalette:Int[32 * 3]
	
	' Amiga bitplane data
	Global amigaBitplaneData:Byte[40 * 256 * 5]

	' loads an Amiga IFF-File (tested with DPaint4) with max. 5 bitplanes (32 colors) and returns the rendered image, IFF-data must be compressed
	Function Load:TImage(filename:String)
		Local pos:Int = 0
		Local compression:Int = 0
		Local iffData:TBank = LoadBank(filename)
		
		If Not iffData Then 
			Notify("could not load file: " + filename)
			Return Null
		EndIf
		
		Local byt1:Byte = PeekByte(iffData, 0)
		Local byt2:Byte = PeekByte(iffData, 1)
		Local byt3:Byte = PeekByte(iffData, 2)
		Local byt4:Byte = PeekByte(iffData, 3)
		Local chunk:String = Chr(byt1) + Chr(byt2) + Chr(byt3) + Chr(byt4)
					
		If chunk = "FORM" Then
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
					Notify("could not found BMHD-chunk!")
					Return Null
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
					Notify("IFF-file has no color-map!")
					Return Null
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
					
					amigaBitplaneData = New Byte[(picWidth / 8) * picHeight * picBitplanes]
					Print(Len(amigaBitplaneData))

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
					Notify("can not load uncompressed IFF-Files!")
					Return Null
				EndIf
			Else
				Notify("could not found ILBM-chunk!")
				Return Null
			EndIf
		Else 
			Notify("could not found FORM-chunk!")
			Return Null
		EndIf	
		
		Return CreatePixmapFromIffData()
	EndFunction
	
	Function CreatePixmapFromIffData:TImage()
		Local pixMap:TPixmap
		Local imgPic:TImage 
		Local bytesPerRow:Int = picWidth / 8

		imgPic = CreateImage(picWidth, picHeight)
		pixMap = LockImage(imgPic)
		ClearPixels(pixMap)
						
		For Local y:Int = 0 To picHeight - 1
			For Local x:Int = 0 To bytesPerRow - 1			
				Local offset:Int = 0
				Local amigaByteBitplane1:Byte = 0
				Local amigaByteBitplane2:Byte = 0
				Local amigaByteBitplane3:Byte = 0
				Local amigaByteBitplane4:Byte = 0
				Local amigaByteBitplane5:Byte = 0
				
				Select picColorCount
					Case 2
						offset = (picWidth / 8)
						amigaByteBitplane1 = amigaBitplaneData[x + (y * offset)]	
					Case 4
						offset = (picWidth / 8) * 2	
						amigaByteBitplane1 = amigaBitplaneData[x + (y * offset)]	
						amigaByteBitplane2 = amigaBitplaneData[x + bytesPerRow + (y * offset)]
					Case 8
						offset = (picWidth / 8) * 3
						amigaByteBitplane1 = amigaBitplaneData[(y * offset) + x]	
						amigaByteBitplane2 = amigaBitplaneData[x +  bytesPerRow + (y * offset)]
						amigaByteBitplane3 = amigaBitplaneData[x + (bytesPerRow * 2) + (y * offset)]		
					Case 16
						offset = (picWidth / 8) * 4
						amigaByteBitplane1 = amigaBitplaneData[(y * offset) + x]	
						amigaByteBitplane2 = amigaBitplaneData[x +  bytesPerRow + (y * offset)]
						amigaByteBitplane3 = amigaBitplaneData[x + (bytesPerRow * 2) + (y * offset)]		
						amigaByteBitplane4 = amigaBitplaneData[x + (bytesPerRow * 3) + (y * offset)]	
					Case 32
						offset = (picWidth / 8) * 5
						amigaByteBitplane1 = amigaBitplaneData[(y * offset) + x]	
						amigaByteBitplane2 = amigaBitplaneData[x +  bytesPerRow + (y * offset)]
						amigaByteBitplane3 = amigaBitplaneData[x + (bytesPerRow * 2) + (y * offset)]		
						amigaByteBitplane4 = amigaBitplaneData[x + (bytesPerRow * 3) + (y * offset)]	
						amigaByteBitplane5 = amigaBitplaneData[x + (bytesPerRow * 4) + (y * offset)]	
				EndSelect
									
				' draw one byte (8 pixel)
				Local bitPos:Byte = %10000000
	
				For Local pixelX:Byte = 0 To 7			
					Local shift:Int  = 7 - pixelX
	
					Local color:Int =  ((amigaByteBitplane1 & bitPos) Shr shift) 		| ..
					  				  (((amigaByteBitplane2 & bitPos) Shr shift) Shl 1) | ..
					  				  (((amigaByteBitplane3 & bitPos) Shr shift) Shl 2) | ..
					  				  (((amigaByteBitplane4 & bitPos) Shr shift) Shl 3) | ..
									  (((amigaByteBitplane5 & bitPos) Shr shift) Shl 4)

					Local red:Int 	= pcColorPalette[color * 3 + 0]
					Local green:Int = pcColorPalette[color * 3 + 1]
					Local blue:Int 	= pcColorPalette[color * 3 + 2]
	
					WritePixel(pixMap, (x * 8) + pixelX, y, %11111111000000000000000000000000 | red Shl 16 | green Shl 8 | blue)
					
					bitPos = bitPos Shr 1
				Next
			Next
		Next
		
		UnlockImage(imgPic)
		Return imgPic
	EndFunction
EndType

Global winScale:Int = 3
AppTitle = "AMIGA DPAINT4-IFF loader"
Graphics 320 * winScale, 256 * winScale
AutoImageFlags MASKEDIMAGE

Global img:TImage = TDPaint4.Load("data/test_32colors.iff")
If img = Null Then
	Notify("error while loading IFF-Picture!")
	End
EndIf

Repeat
	Cls
	SetScale winScale, winScale
	DrawImage img, 0, 0
	SetScale 1,1
	Flip
Until KeyDown(KEY_ESCAPE)
End
