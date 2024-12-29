	format	MS COFF
	extrn	___bb_appstub_appstub
	extrn	___bb_audio_audio
	extrn	___bb_bank_bank
	extrn	___bb_bankstream_bankstream
	extrn	___bb_basic_basic
	extrn	___bb_blitz_blitz
	extrn	___bb_bmploader_bmploader
	extrn	___bb_d3d7max2d_d3d7max2d
	extrn	___bb_d3d9max2d_d3d9max2d
	extrn	___bb_data_data
	extrn	___bb_directsoundaudio_directsoundaudio
	extrn	___bb_eventqueue_eventqueue
	extrn	___bb_freeaudioaudio_freeaudioaudio
	extrn	___bb_freejoy_freejoy
	extrn	___bb_freeprocess_freeprocess
	extrn	___bb_freetypefont_freetypefont
	extrn	___bb_glew_glew
	extrn	___bb_gnet_gnet
	extrn	___bb_jpgloader_jpgloader
	extrn	___bb_macos_macos
	extrn	___bb_map_map
	extrn	___bb_maxlua_maxlua
	extrn	___bb_maxutil_maxutil
	extrn	___bb_oggloader_oggloader
	extrn	___bb_openalaudio_openalaudio
	extrn	___bb_pngloader_pngloader
	extrn	___bb_retro_retro
	extrn	___bb_tgaloader_tgaloader
	extrn	___bb_threads_threads
	extrn	___bb_timer_timer
	extrn	___bb_wavloader_wavloader
	extrn	_bbAppTitle
	extrn	_bbArrayNew
	extrn	_bbArrayNew1D
	extrn	_bbEmptyArray
	extrn	_bbEnd
	extrn	_bbFloatMod
	extrn	_bbFloatToInt
	extrn	_bbFloor
	extrn	_bbGCFree
	extrn	_bbNullObject
	extrn	_bbStringClass
	extrn	_bbStringConcat
	extrn	_bbStringFromInt
	extrn	_bbSystemDesktopDepth
	extrn	_bbSystemDesktopHeight
	extrn	_bbSystemDesktopHertz
	extrn	_bbSystemDesktopWidth
	extrn	_brl_graphics_Flip
	extrn	_brl_graphics_Graphics
	extrn	_brl_max2d_AutoImageFlags
	extrn	_brl_max2d_Cls
	extrn	_brl_max2d_DrawImage
	extrn	_brl_max2d_DrawRect
	extrn	_brl_max2d_DrawSubImageRect
	extrn	_brl_max2d_DrawText
	extrn	_brl_max2d_LoadImage
	extrn	_brl_max2d_SetAlpha
	extrn	_brl_max2d_SetBlend
	extrn	_brl_max2d_SetColor
	extrn	_brl_max2d_SetScale
	extrn	_brl_polledinput_KeyDown
	extrn	_brl_polledinput_KeyHit
	extrn	_brl_polledinput_MouseDown
	extrn	_brl_polledinput_MouseHit
	extrn	_brl_polledinput_MouseX
	extrn	_brl_polledinput_MouseY
	extrn	_brl_standardio_Print
	public	__bb_main
	public	_bb_CalcSelectedTileId
	public	_bb_CalcTileMousePos
	public	_bb_CalcTilePosTab
	public	_bb_CalcTilePosition
	public	_bb_ClearAmigaScreen
	public	_bb_ClearLevelData
	public	_bb_DrawCurrentTileAtMousePosition
	public	_bb_DrawLevelEditorInformationText
	public	_bb_DrawTileCursorAtMousePos
	public	_bb_DrawTilemap
	public	_bb_Init
	public	_bb_LoadLevelData
	public	_bb_MainLoop
	public	_bb_SaveLevelData
	public	_bb_SetTile_Foreground
	public	_bb_TilesetSelection
	public	_bb_gfx
	public	_bb_level_pos_x
	public	_bb_level_pos_y
	public	_bb_scale
	public	_bb_selectedTileId
	public	_bb_tileGridDisplay
	public	_bb_tileMapData_foreground
	public	_bb_tileMouseX
	public	_bb_tileMouseY
	public	_bb_tilePosTab
	public	_bb_tileX
	public	_bb_tileY
	public	_bb_tileset
	section	"code" code
__bb_main:
	push	ebp
	mov	ebp,esp
	cmp	dword [_106],0
	je	_107
	mov	eax,0
	mov	esp,ebp
	pop	ebp
	ret
_107:
	mov	dword [_106],1
	call	___bb_blitz_blitz
	call	___bb_appstub_appstub
	call	___bb_audio_audio
	call	___bb_bank_bank
	call	___bb_bankstream_bankstream
	call	___bb_basic_basic
	call	___bb_bmploader_bmploader
	call	___bb_d3d7max2d_d3d7max2d
	call	___bb_d3d9max2d_d3d9max2d
	call	___bb_data_data
	call	___bb_directsoundaudio_directsoundaudio
	call	___bb_eventqueue_eventqueue
	call	___bb_freeaudioaudio_freeaudioaudio
	call	___bb_freetypefont_freetypefont
	call	___bb_gnet_gnet
	call	___bb_jpgloader_jpgloader
	call	___bb_map_map
	call	___bb_maxlua_maxlua
	call	___bb_maxutil_maxutil
	call	___bb_oggloader_oggloader
	call	___bb_openalaudio_openalaudio
	call	___bb_pngloader_pngloader
	call	___bb_retro_retro
	call	___bb_tgaloader_tgaloader
	call	___bb_threads_threads
	call	___bb_timer_timer
	call	___bb_wavloader_wavloader
	call	___bb_freejoy_freejoy
	call	___bb_freeprocess_freeprocess
	call	___bb_glew_glew
	call	___bb_macos_macos
	mov	eax,dword [_101]
	and	eax,1
	cmp	eax,0
	jne	_102
	push	640
	push	_99
	call	_bbArrayNew1D
	add	esp,8
	inc	dword [eax+4]
	mov	dword [_bb_tilePosTab],eax
	or	dword [_101],1
_102:
	mov	eax,dword [_101]
	and	eax,2
	cmp	eax,0
	jne	_105
	push	13
	push	200
	push	2
	push	_103
	call	_bbArrayNew
	add	esp,16
	inc	dword [eax+4]
	mov	dword [_bb_tileMapData_foreground],eax
	or	dword [_101],2
_105:
	call	_bb_Init
	call	_bb_MainLoop
	call	_bbEnd
	mov	eax,0
	jmp	_59
_59:
	mov	esp,ebp
	pop	ebp
	ret
_bb_MainLoop:
	push	ebp
	mov	ebp,esp
_25:
	push	208
	push	320
	push	0
	push	10
	push	50
	call	_bb_ClearAmigaScreen
	add	esp,20
	call	_bb_CalcTileMousePos
	call	_bb_DrawTilemap
	mov	eax,dword [_bb_scale]
	imul	eax,208
	cmp	dword [_bb_tileMouseY],eax
	jge	_108
	call	_bb_DrawCurrentTileAtMousePosition
	call	_bb_DrawTileCursorAtMousePos
_108:
	push	1
	call	_brl_polledinput_MouseDown
	add	esp,4
	cmp	eax,0
	je	_109
	push	dword [_bb_selectedTileId]
	call	_bb_SetTile_Foreground
	add	esp,4
_109:
	push	2
	call	_brl_polledinput_MouseDown
	add	esp,4
	cmp	eax,0
	je	_110
	push	0
	call	_bb_SetTile_Foreground
	add	esp,4
_110:
	push	3
	call	_brl_polledinput_MouseHit
	add	esp,4
	cmp	eax,0
	je	_111
	call	_bb_TilesetSelection
_111:
	push	76
	call	_brl_polledinput_KeyHit
	add	esp,4
	cmp	eax,0
	je	_112
	call	_bb_LoadLevelData
_112:
	push	83
	call	_brl_polledinput_KeyHit
	add	esp,4
	cmp	eax,0
	je	_113
	call	_bb_SaveLevelData
_113:
	push	67
	call	_brl_polledinput_KeyHit
	add	esp,4
	cmp	eax,0
	je	_114
	call	_bb_ClearLevelData
_114:
	push	71
	call	_brl_polledinput_KeyHit
	add	esp,4
	cmp	eax,0
	je	_115
	mov	eax,dword [_bb_tileGridDisplay]
	cmp	eax,0
	sete	al
	movzx	eax,al
	mov	dword [_bb_tileGridDisplay],eax
_115:
	push	37
	call	_brl_polledinput_KeyDown
	add	esp,4
	cmp	eax,0
	je	_116
	fld	dword [_bb_level_pos_x]
	fsub	dword [_165]
	fstp	dword [_bb_level_pos_x]
	fld	dword [_bb_level_pos_x]
	fldz
	fxch	st1
	fucompp
	fnstsw	ax
	sahf
	setae	al
	movzx	eax,al
	cmp	eax,0
	jne	_117
	fldz
	fstp	dword [_bb_level_pos_x]
_117:
_116:
	push	39
	call	_brl_polledinput_KeyDown
	add	esp,4
	cmp	eax,0
	je	_118
	fld	dword [_bb_level_pos_x]
	fadd	dword [_166]
	fstp	dword [_bb_level_pos_x]
	fld	dword [_bb_level_pos_x]
	fld	dword [_167]
	fxch	st1
	fucompp
	fnstsw	ax
	sahf
	setbe	al
	movzx	eax,al
	cmp	eax,0
	jne	_119
	fld	dword [_168]
	fstp	dword [_bb_level_pos_x]
_119:
_118:
	call	_bb_DrawLevelEditorInformationText
	push	-1
	call	_brl_graphics_Flip
	add	esp,4
_23:
	push	27
	call	_brl_polledinput_KeyDown
	add	esp,4
	cmp	eax,0
	je	_25
_24:
	mov	eax,0
	jmp	_61
_61:
	mov	esp,ebp
	pop	ebp
	ret
_bb_Init:
	push	ebp
	mov	ebp,esp
	sub	esp,4
	push	ebx
	mov	ebx,_26
	inc	dword [ebx+4]
	mov	eax,dword [_bbAppTitle]
	dec	dword [eax+4]
	jnz	_123
	push	eax
	call	_bbGCFree
	add	esp,4
_123:
	mov	dword [_bbAppTitle],ebx
	push	0
	call	_bbSystemDesktopHertz
	push	eax
	call	_bbSystemDesktopDepth
	push	eax
	call	_bbSystemDesktopHeight
	push	eax
	call	_bbSystemDesktopWidth
	push	eax
	call	_brl_graphics_Graphics
	add	esp,20
	push	1
	call	_brl_max2d_AutoImageFlags
	add	esp,4
	call	_bbSystemDesktopHeight
	cdq
	and	edx,255
	add	eax,edx
	sar	eax,8
	mov	dword [ebp+-4],eax
	fild	dword [ebp+-4]
	sub	esp,8
	fstp	qword [esp]
	call	_bbFloor
	add	esp,8
	sub	esp,8
	fstp	qword [esp]
	call	_bbFloatToInt
	add	esp,8
	mov	dword [_bb_scale],eax
	push	dword [_bb_scale]
	call	_bbStringFromInt
	add	esp,4
	push	eax
	call	_brl_standardio_Print
	add	esp,4
	push	-1
	push	_27
	call	_brl_max2d_LoadImage
	add	esp,8
	inc	dword [eax+4]
	mov	ebx,eax
	mov	eax,dword [_bb_gfx]
	dec	dword [eax+4]
	jnz	_127
	push	eax
	call	_bbGCFree
	add	esp,4
_127:
	mov	dword [_bb_gfx],ebx
	push	-1
	push	_28
	call	_brl_max2d_LoadImage
	add	esp,8
	inc	dword [eax+4]
	mov	ebx,eax
	mov	eax,dword [_bb_tileset]
	dec	dword [eax+4]
	jnz	_131
	push	eax
	call	_bbGCFree
	add	esp,4
_131:
	mov	dword [_bb_tileset],ebx
	call	_bb_CalcTilePosTab
	call	_bb_ClearLevelData
	fldz
	fstp	dword [_bb_level_pos_x]
	mov	dword [_bb_level_pos_y],0
	mov	eax,0
	jmp	_63
_63:
	pop	ebx
	mov	esp,ebp
	pop	ebp
	ret
_bb_TilesetSelection:
	push	ebp
	mov	ebp,esp
	sub	esp,4
_31:
	push	256
	push	320
	push	0
	push	70
	push	0
	call	_bb_ClearAmigaScreen
	add	esp,20
	call	_bb_CalcTileMousePos
	call	_bb_CalcSelectedTileId
	mov	eax,dword [_bb_scale]
	mov	dword [ebp+-4],eax
	fild	dword [ebp+-4]
	sub	esp,4
	fstp	dword [esp]
	mov	eax,dword [_bb_scale]
	mov	dword [ebp+-4],eax
	fild	dword [ebp+-4]
	sub	esp,4
	fstp	dword [esp]
	call	_brl_max2d_SetScale
	add	esp,8
	push	0
	push	0
	push	0
	push	dword [_bb_tileset]
	call	_brl_max2d_DrawImage
	add	esp,16
	call	_bb_DrawTileCursorAtMousePos
	push	1073741824
	push	1073741824
	call	_brl_max2d_SetScale
	add	esp,8
	push	1084227584
	mov	eax,dword [_bb_scale]
	imul	eax,320
	add	eax,5
	mov	dword [ebp+-4],eax
	fild	dword [ebp+-4]
	sub	esp,4
	fstp	dword [esp]
	push	dword [_bb_selectedTileId]
	call	_bbStringFromInt
	add	esp,4
	push	eax
	push	_32
	call	_bbStringConcat
	add	esp,8
	push	eax
	call	_brl_max2d_DrawText
	add	esp,12
	mov	eax,dword [_bb_scale]
	shl	eax,8
	add	eax,5
	mov	dword [ebp+-4],eax
	fild	dword [ebp+-4]
	sub	esp,4
	fstp	dword [esp]
	push	1084227584
	push	_33
	call	_brl_max2d_DrawText
	add	esp,12
	push	1065353216
	push	1065353216
	call	_brl_max2d_SetScale
	add	esp,8
	push	-1
	call	_brl_graphics_Flip
	add	esp,4
_29:
	push	1
	call	_brl_polledinput_MouseHit
	add	esp,4
	cmp	eax,0
	je	_31
_30:
	jmp	_34
_36:
_34:
	push	1
	call	_brl_polledinput_MouseDown
	add	esp,4
	cmp	eax,0
	jne	_36
_35:
	mov	eax,0
	jmp	_65
_65:
	mov	esp,ebp
	pop	ebp
	ret
_bb_DrawTileCursorAtMousePos:
	push	ebp
	mov	ebp,esp
	sub	esp,4
	mov	eax,dword [_bb_scale]
	mov	dword [ebp+-4],eax
	fild	dword [ebp+-4]
	sub	esp,4
	fstp	dword [esp]
	mov	eax,dword [_bb_scale]
	mov	dword [ebp+-4],eax
	fild	dword [ebp+-4]
	sub	esp,4
	fstp	dword [esp]
	call	_brl_max2d_SetScale
	add	esp,8
	push	220
	push	0
	push	0
	call	_brl_max2d_SetColor
	add	esp,12
	push	0
	push	0
	push	0
	push	1098907648
	push	1098907648
	push	0
	push	1098907648
	push	1098907648
	push	1098907648
	mov	eax,dword [_bb_tileMouseY]
	mov	dword [ebp+-4],eax
	fild	dword [ebp+-4]
	sub	esp,4
	fstp	dword [esp]
	mov	eax,dword [_bb_tileMouseX]
	mov	dword [ebp+-4],eax
	fild	dword [ebp+-4]
	sub	esp,4
	fstp	dword [esp]
	push	dword [_bb_gfx]
	call	_brl_max2d_DrawSubImageRect
	add	esp,48
	push	1065353216
	push	1065353216
	call	_brl_max2d_SetScale
	add	esp,8
	push	255
	push	255
	push	255
	call	_brl_max2d_SetColor
	add	esp,12
	mov	eax,0
	jmp	_67
_67:
	mov	esp,ebp
	pop	ebp
	ret
_bb_DrawCurrentTileAtMousePosition:
	push	ebp
	mov	ebp,esp
	sub	esp,4
	push	ebx
	push	esi
	mov	edx,dword [_bb_tilePosTab]
	mov	eax,dword [_bb_selectedTileId]
	shl	eax,1
	mov	ebx,dword [edx+eax*4+24]
	mov	edx,dword [_bb_tilePosTab]
	mov	eax,dword [_bb_selectedTileId]
	shl	eax,1
	add	eax,1
	mov	esi,dword [edx+eax*4+24]
	mov	eax,dword [_bb_scale]
	mov	dword [ebp+-4],eax
	fild	dword [ebp+-4]
	sub	esp,4
	fstp	dword [esp]
	mov	eax,dword [_bb_scale]
	mov	dword [ebp+-4],eax
	fild	dword [ebp+-4]
	sub	esp,4
	fstp	dword [esp]
	call	_brl_max2d_SetScale
	add	esp,8
	push	0
	push	0
	push	0
	push	1098907648
	push	1098907648
	mov	dword [ebp+-4],esi
	fild	dword [ebp+-4]
	sub	esp,4
	fstp	dword [esp]
	mov	dword [ebp+-4],ebx
	fild	dword [ebp+-4]
	sub	esp,4
	fstp	dword [esp]
	push	1098907648
	push	1098907648
	mov	eax,dword [_bb_tileMouseY]
	mov	dword [ebp+-4],eax
	fild	dword [ebp+-4]
	sub	esp,4
	fstp	dword [esp]
	mov	eax,dword [_bb_tileMouseX]
	mov	dword [ebp+-4],eax
	fild	dword [ebp+-4]
	sub	esp,4
	fstp	dword [esp]
	push	dword [_bb_tileset]
	call	_brl_max2d_DrawSubImageRect
	add	esp,48
	push	1065353216
	push	1065353216
	call	_brl_max2d_SetScale
	add	esp,8
	mov	eax,0
	jmp	_69
_69:
	pop	esi
	pop	ebx
	mov	esp,ebp
	pop	ebp
	ret
_bb_CalcTileMousePos:
	push	ebp
	mov	ebp,esp
	push	ebx
	mov	ebx,dword [_bb_scale]
	shl	ebx,4
	call	_brl_polledinput_MouseX
	cdq
	idiv	ebx
	mov	edx,dword [_bb_scale]
	shl	edx,4
	imul	eax,edx
	mov	dword [_bb_tileMouseX],eax
	mov	ebx,dword [_bb_scale]
	shl	ebx,4
	call	_brl_polledinput_MouseY
	cdq
	idiv	ebx
	mov	edx,dword [_bb_scale]
	shl	edx,4
	imul	eax,edx
	mov	dword [_bb_tileMouseY],eax
	mov	eax,dword [_bb_scale]
	imul	eax,304
	cmp	dword [_bb_tileMouseX],eax
	jle	_134
	mov	eax,dword [_bb_scale]
	imul	eax,304
	mov	dword [_bb_tileMouseX],eax
_134:
	mov	eax,dword [_bb_scale]
	imul	eax,240
	cmp	dword [_bb_tileMouseY],eax
	jle	_135
	mov	eax,dword [_bb_scale]
	imul	eax,240
	mov	dword [_bb_tileMouseY],eax
_135:
	mov	eax,0
	jmp	_71
_71:
	pop	ebx
	mov	esp,ebp
	pop	ebp
	ret
_bb_CalcSelectedTileId:
	push	ebp
	mov	ebp,esp
	sub	esp,12
	mov	eax,dword [_bb_tileMouseX]
	cdq
	idiv	dword [_bb_scale]
	cdq
	and	edx,15
	add	eax,edx
	sar	eax,4
	mov	dword [ebp+-12],eax
	fild	dword [ebp+-12]
	sub	esp,8
	fstp	qword [esp]
	call	_bbFloor
	add	esp,8
	fstp	qword [ebp-8]
	mov	eax,dword [_bb_tileMouseY]
	cdq
	idiv	dword [_bb_scale]
	cdq
	and	edx,15
	add	eax,edx
	sar	eax,4
	imul	eax,20
	mov	dword [ebp+-12],eax
	fild	dword [ebp+-12]
	sub	esp,8
	fstp	qword [esp]
	call	_bbFloor
	add	esp,8
	fld	qword [ebp-8]
	faddp	st1,st0
	fstp	qword [ebp-8]
	fld	qword [ebp-8]
	sub	esp,8
	fstp	qword [esp]
	call	_bbFloatToInt
	add	esp,8
	mov	dword [_bb_selectedTileId],eax
	mov	eax,0
	jmp	_73
_73:
	mov	esp,ebp
	pop	ebp
	ret
_bb_ClearAmigaScreen:
	push	ebp
	mov	ebp,esp
	sub	esp,4
	push	ebx
	push	esi
	push	edi
	mov	esi,dword [ebp+8]
	mov	ebx,dword [ebp+12]
	mov	edi,dword [ebp+16]
	call	_brl_max2d_Cls
	mov	eax,dword [_bb_scale]
	mov	dword [ebp+-4],eax
	fild	dword [ebp+-4]
	sub	esp,4
	fstp	dword [esp]
	mov	eax,dword [_bb_scale]
	mov	dword [ebp+-4],eax
	fild	dword [ebp+-4]
	sub	esp,4
	fstp	dword [esp]
	call	_brl_max2d_SetScale
	add	esp,8
	push	edi
	push	ebx
	push	esi
	call	_brl_max2d_SetColor
	add	esp,12
	mov	eax,dword [ebp+24]
	mov	dword [ebp+-4],eax
	fild	dword [ebp+-4]
	sub	esp,4
	fstp	dword [esp]
	mov	eax,dword [ebp+20]
	mov	dword [ebp+-4],eax
	fild	dword [ebp+-4]
	sub	esp,4
	fstp	dword [esp]
	push	0
	push	0
	call	_brl_max2d_DrawRect
	add	esp,16
	push	255
	push	255
	push	255
	call	_brl_max2d_SetColor
	add	esp,12
	push	1065353216
	push	1065353216
	call	_brl_max2d_SetScale
	add	esp,8
	mov	eax,0
	jmp	_80
_80:
	pop	edi
	pop	esi
	pop	ebx
	mov	esp,ebp
	pop	ebp
	ret
_bb_ClearLevelData:
	push	ebp
	mov	ebp,esp
	push	ebx
	push	esi
	mov	ebx,0
	jmp	_137
_39:
	mov	ecx,0
	jmp	_139
_42:
	mov	edx,dword [_bb_tileMapData_foreground]
	mov	eax,ecx
	mov	esi,dword [_bb_tileMapData_foreground]
	imul	eax,dword [esi+24]
	add	eax,ebx
	mov	dword [edx+eax*4+28],0
_40:
	add	ecx,1
_139:
	cmp	ecx,199
	jle	_42
_41:
_37:
	add	ebx,1
_137:
	cmp	ebx,12
	jle	_39
_38:
	mov	eax,0
	jmp	_82
_82:
	pop	esi
	pop	ebx
	mov	esp,ebp
	pop	ebp
	ret
_bb_CalcTilePosTab:
	push	ebp
	mov	ebp,esp
	push	ebx
	push	esi
	push	edi
	mov	esi,0
	mov	edi,0
	jmp	_142
_45:
	mov	ebx,0
	jmp	_144
_48:
	mov	edx,dword [_bb_tilePosTab]
	mov	eax,ebx
	shl	eax,4
	mov	dword [edx+esi*4+24],eax
	mov	ecx,dword [_bb_tilePosTab]
	mov	edx,esi
	add	edx,1
	mov	eax,edi
	shl	eax,4
	mov	dword [ecx+edx*4+24],eax
	add	esi,2
_46:
	add	ebx,1
_144:
	cmp	ebx,19
	jle	_48
_47:
_43:
	add	edi,1
_142:
	cmp	edi,15
	jle	_45
_44:
	mov	eax,0
	jmp	_84
_84:
	pop	edi
	pop	esi
	pop	ebx
	mov	esp,ebp
	pop	ebp
	ret
_bb_SetTile_Foreground:
	push	ebp
	mov	ebp,esp
	push	ebx
	mov	ebx,dword [ebp+8]
	call	_bb_CalcTilePosition
	cmp	dword [_bb_tileY],12
	jle	_145
	mov	eax,0
	jmp	_87
_145:
	mov	ecx,dword [_bb_tileMapData_foreground]
	mov	eax,dword [_bb_tileX]
	mov	edx,dword [_bb_tileMapData_foreground]
	imul	eax,dword [edx+24]
	add	eax,dword [_bb_tileY]
	mov	dword [ecx+eax*4+28],ebx
	mov	eax,0
	jmp	_87
_87:
	pop	ebx
	mov	esp,ebp
	pop	ebp
	ret
_bb_CalcTilePosition:
	push	ebp
	mov	ebp,esp
	push	ebx
	mov	eax,dword [_bb_tileMouseX]
	cdq
	idiv	dword [_bb_scale]
	cdq
	and	edx,15
	add	eax,edx
	sar	eax,4
	mov	ebx,eax
	fld	dword [_bb_level_pos_x]
	sub	esp,8
	fstp	qword [esp]
	call	_bbFloatToInt
	add	esp,8
	add	ebx,eax
	mov	dword [_bb_tileX],ebx
	mov	eax,dword [_bb_tileMouseY]
	cdq
	idiv	dword [_bb_scale]
	cdq
	and	edx,15
	add	eax,edx
	sar	eax,4
	mov	dword [_bb_tileY],eax
	mov	eax,0
	jmp	_89
_89:
	pop	ebx
	mov	esp,ebp
	pop	ebp
	ret
_bb_DrawTilemap:
	push	ebp
	mov	ebp,esp
	sub	esp,12
	push	ebx
	push	esi
	push	edi
	mov	eax,dword [_bb_scale]
	mov	dword [ebp+-12],eax
	fild	dword [ebp+-12]
	sub	esp,4
	fstp	dword [esp]
	mov	eax,dword [_bb_scale]
	mov	dword [ebp+-12],eax
	fild	dword [ebp+-12]
	sub	esp,4
	fstp	dword [esp]
	call	_brl_max2d_SetScale
	add	esp,8
	mov	edi,0
	jmp	_148
_51:
	mov	esi,0
	jmp	_150
_54:
	mov	ebx,dword [_bb_tileMapData_foreground]
	mov	dword [ebp+-12],esi
	fild	dword [ebp+-12]
	fstp	qword [ebp-8]
	fld	dword [_bb_level_pos_x]
	sub	esp,8
	fstp	qword [esp]
	call	_bbFloor
	add	esp,8
	fld	qword [ebp-8]
	faddp	st1,st0
	fstp	qword [ebp-8]
	fld	qword [ebp-8]
	sub	esp,8
	fstp	qword [esp]
	call	_bbFloatToInt
	add	esp,8
	mov	edx,dword [_bb_tileMapData_foreground]
	imul	eax,dword [edx+24]
	add	eax,edi
	mov	eax,dword [ebx+eax*4+28]
	cmp	eax,0
	jle	_151
	mov	ecx,dword [_bb_tilePosTab]
	mov	edx,eax
	shl	edx,1
	mov	ecx,dword [ecx+edx*4+24]
	mov	edx,dword [_bb_tilePosTab]
	shl	eax,1
	add	eax,1
	mov	eax,dword [edx+eax*4+24]
	push	0
	push	0
	push	0
	push	1098907648
	push	1098907648
	mov	dword [ebp+-12],eax
	fild	dword [ebp+-12]
	sub	esp,4
	fstp	dword [esp]
	mov	dword [ebp+-12],ecx
	fild	dword [ebp+-12]
	sub	esp,4
	fstp	dword [esp]
	push	1098907648
	push	1098907648
	mov	eax,edi
	shl	eax,4
	imul	eax,dword [_bb_scale]
	mov	dword [ebp+-12],eax
	fild	dword [ebp+-12]
	sub	esp,4
	fstp	dword [esp]
	mov	eax,esi
	shl	eax,4
	imul	eax,dword [_bb_scale]
	mov	dword [ebp+-12],eax
	fild	dword [ebp+-12]
	sub	esp,4
	fstp	dword [esp]
	push	dword [_bb_tileset]
	call	_brl_max2d_DrawSubImageRect
	add	esp,48
_151:
	cmp	dword [_bb_tileGridDisplay],0
	je	_154
	push	30
	push	40
	push	80
	call	_brl_max2d_SetColor
	add	esp,12
	push	3
	call	_brl_max2d_SetBlend
	add	esp,4
	push	1056964608
	call	_brl_max2d_SetAlpha
	add	esp,4
	push	0
	push	0
	push	0
	push	1098907648
	push	1098907648
	push	0
	push	1107296256
	push	1098907648
	push	1098907648
	mov	eax,edi
	shl	eax,4
	imul	eax,dword [_bb_scale]
	mov	dword [ebp+-12],eax
	fild	dword [ebp+-12]
	sub	esp,4
	fstp	dword [esp]
	mov	eax,esi
	shl	eax,4
	imul	eax,dword [_bb_scale]
	mov	dword [ebp+-12],eax
	fild	dword [ebp+-12]
	sub	esp,4
	fstp	dword [esp]
	push	dword [_bb_gfx]
	call	_brl_max2d_DrawSubImageRect
	add	esp,48
	push	1
	call	_brl_max2d_SetBlend
	add	esp,4
	push	255
	push	255
	push	255
	call	_brl_max2d_SetColor
	add	esp,12
	push	1065353216
	call	_brl_max2d_SetAlpha
	add	esp,4
_154:
_52:
	add	esi,1
_150:
	cmp	esi,19
	jle	_54
_53:
_49:
	add	edi,1
_148:
	cmp	edi,12
	jle	_51
_50:
	push	1065353216
	push	1065353216
	call	_brl_max2d_SetScale
	add	esp,8
	mov	eax,0
	jmp	_91
_91:
	pop	edi
	pop	esi
	pop	ebx
	mov	esp,ebp
	pop	ebp
	ret
_bb_LoadLevelData:
	push	ebp
	mov	ebp,esp
	mov	eax,0
	jmp	_93
_93:
	mov	esp,ebp
	pop	ebp
	ret
_bb_SaveLevelData:
	push	ebp
	mov	ebp,esp
	mov	eax,0
	jmp	_95
_95:
	mov	esp,ebp
	pop	ebp
	ret
_bb_DrawLevelEditorInformationText:
	push	ebp
	mov	ebp,esp
	sub	esp,4
	push	ebx
	push	1073741824
	push	1073741824
	call	_brl_max2d_SetScale
	add	esp,8
	push	1084227584
	mov	eax,dword [_bb_scale]
	imul	eax,320
	add	eax,5
	mov	dword [ebp+-4],eax
	fild	dword [ebp+-4]
	sub	esp,4
	fstp	dword [esp]
	fld	dword [_bb_level_pos_x]
	fmul	dword [_214]
	sub	esp,8
	fstp	qword [esp]
	call	_bbFloatToInt
	add	esp,8
	push	eax
	call	_bbStringFromInt
	add	esp,4
	push	eax
	push	_55
	call	_bbStringConcat
	add	esp,8
	push	eax
	call	_brl_max2d_DrawText
	add	esp,12
	mov	eax,dword [_bb_tileMouseX]
	cdq
	idiv	dword [_bb_scale]
	mov	ebx,eax
	fld	dword [_bb_level_pos_x]
	fmul	dword [_215]
	sub	esp,8
	fstp	qword [esp]
	call	_bbFloatToInt
	add	esp,8
	add	ebx,eax
	push	1106247680
	mov	eax,dword [_bb_scale]
	imul	eax,320
	add	eax,5
	mov	dword [ebp+-4],eax
	fild	dword [ebp+-4]
	sub	esp,4
	fstp	dword [esp]
	push	ebx
	call	_bbStringFromInt
	add	esp,4
	push	eax
	push	_56
	call	_bbStringConcat
	add	esp,8
	push	eax
	call	_brl_max2d_DrawText
	add	esp,12
	push	1112539136
	mov	eax,dword [_bb_scale]
	imul	eax,320
	add	eax,5
	mov	dword [ebp+-4],eax
	fild	dword [ebp+-4]
	sub	esp,4
	fstp	dword [esp]
	mov	eax,dword [_bb_tileMouseY]
	cdq
	idiv	dword [_bb_scale]
	push	eax
	call	_bbStringFromInt
	add	esp,4
	push	eax
	push	_57
	call	_bbStringConcat
	add	esp,8
	push	eax
	call	_brl_max2d_DrawText
	add	esp,12
	push	160
	push	50
	push	0
	call	_brl_max2d_SetColor
	add	esp,12
	mov	eax,dword [_bb_scale]
	shl	eax,8
	mov	dword [ebp+-4],eax
	fild	dword [ebp+-4]
	sub	esp,4
	fstp	dword [esp]
	push	1073741824
	push	_156
	call	_brl_max2d_DrawText
	add	esp,12
	push	255
	push	255
	push	255
	call	_brl_max2d_SetColor
	add	esp,12
	fld	dword [_216]
	sub	esp,8
	fstp	qword [esp]
	fld	dword [_bb_level_pos_x]
	sub	esp,8
	fstp	qword [esp]
	call	_bbFloatMod
	add	esp,16
	sub	esp,8
	fstp	qword [esp]
	call	_bbFloatToInt
	add	esp,8
	mov	ebx,eax
	mov	eax,dword [_bb_scale]
	mov	dword [ebp+-4],eax
	fild	dword [ebp+-4]
	sub	esp,4
	fstp	dword [esp]
	mov	eax,dword [_bb_scale]
	mov	dword [ebp+-4],eax
	fild	dword [ebp+-4]
	sub	esp,4
	fstp	dword [esp]
	call	_brl_max2d_SetScale
	add	esp,8
	push	0
	push	255
	push	0
	call	_brl_max2d_SetColor
	add	esp,12
	push	1077936128
	push	1097859072
	fld	dword [_bb_level_pos_x]
	fdiv	dword [_217]
	sub	esp,8
	fstp	qword [esp]
	call	_bbFloatToInt
	add	esp,8
	add	eax,1
	push	eax
	call	_bbStringFromInt
	add	esp,4
	push	eax
	call	_brl_max2d_DrawText
	add	esp,12
	push	0
	push	100
	push	0
	call	_brl_max2d_SetColor
	add	esp,12
	push	3
	call	_brl_max2d_SetBlend
	add	esp,4
	push	1061158912
	call	_brl_max2d_SetAlpha
	add	esp,4
	cmp	ebx,1
	jge	_158
	push	0
	push	0
	push	0
	push	1098907648
	push	1098907648
	push	0
	push	1111490560
	push	1098907648
	push	1098907648
	push	0
	push	0
	push	dword [_bb_gfx]
	call	_brl_max2d_DrawSubImageRect
	add	esp,48
	push	0
	push	0
	push	0
	push	1098907648
	push	1098907648
	push	1098907648
	push	1111490560
	push	1098907648
	push	1098907648
	mov	eax,dword [_bb_scale]
	imul	eax,192
	mov	dword [ebp+-4],eax
	fild	dword [ebp+-4]
	sub	esp,4
	fstp	dword [esp]
	push	0
	push	dword [_bb_gfx]
	call	_brl_max2d_DrawSubImageRect
	add	esp,48
	jmp	_159
_158:
	push	0
	push	255
	push	0
	call	_brl_max2d_SetColor
	add	esp,12
	push	1065353216
	call	_brl_max2d_SetAlpha
	add	esp,4
	push	1077936128
	mov	eax,320
	mov	edx,ebx
	shl	edx,4
	sub	eax,edx
	imul	eax,dword [_bb_scale]
	add	eax,8
	mov	dword [ebp+-4],eax
	fild	dword [ebp+-4]
	sub	esp,4
	fstp	dword [esp]
	fld	dword [_bb_level_pos_x]
	fdiv	dword [_218]
	sub	esp,8
	fstp	qword [esp]
	call	_bbFloatToInt
	add	esp,8
	add	eax,2
	push	eax
	call	_bbStringFromInt
	add	esp,4
	push	eax
	call	_brl_max2d_DrawText
	add	esp,12
	push	3
	call	_brl_max2d_SetBlend
	add	esp,4
	push	1061158912
	call	_brl_max2d_SetAlpha
	add	esp,4
	push	0
	push	100
	push	0
	call	_brl_max2d_SetColor
	add	esp,12
	push	0
	push	0
	push	0
	push	1098907648
	push	1098907648
	push	0
	push	1111490560
	push	1098907648
	push	1098907648
	push	0
	mov	eax,320
	mov	edx,ebx
	shl	edx,4
	sub	eax,edx
	imul	eax,dword [_bb_scale]
	mov	dword [ebp+-4],eax
	fild	dword [ebp+-4]
	sub	esp,4
	fstp	dword [esp]
	push	dword [_bb_gfx]
	call	_brl_max2d_DrawSubImageRect
	add	esp,48
	push	0
	push	0
	push	0
	push	1098907648
	push	1098907648
	push	1098907648
	push	1111490560
	push	1098907648
	push	1098907648
	mov	eax,dword [_bb_scale]
	imul	eax,192
	mov	dword [ebp+-4],eax
	fild	dword [ebp+-4]
	sub	esp,4
	fstp	dword [esp]
	mov	eax,320
	mov	edx,ebx
	shl	edx,4
	sub	eax,edx
	imul	eax,dword [_bb_scale]
	mov	dword [ebp+-4],eax
	fild	dword [ebp+-4]
	sub	esp,4
	fstp	dword [esp]
	push	dword [_bb_gfx]
	call	_brl_max2d_DrawSubImageRect
	add	esp,48
_159:
	push	0
	push	0
	push	0
	push	1098907648
	push	1098907648
	push	0
	push	1115684864
	push	1098907648
	push	1098907648
	push	0
	mov	edx,320
	mov	eax,ebx
	add	eax,1
	shl	eax,4
	sub	edx,eax
	imul	edx,dword [_bb_scale]
	mov	dword [ebp+-4],edx
	fild	dword [ebp+-4]
	sub	esp,4
	fstp	dword [esp]
	push	dword [_bb_gfx]
	call	_brl_max2d_DrawSubImageRect
	add	esp,48
	push	0
	push	0
	push	0
	push	1098907648
	push	1098907648
	push	1098907648
	push	1115684864
	push	1098907648
	push	1098907648
	mov	eax,dword [_bb_scale]
	imul	eax,192
	mov	dword [ebp+-4],eax
	fild	dword [ebp+-4]
	sub	esp,4
	fstp	dword [esp]
	mov	eax,320
	add	ebx,1
	shl	ebx,4
	sub	eax,ebx
	imul	eax,dword [_bb_scale]
	mov	dword [ebp+-4],eax
	fild	dword [ebp+-4]
	sub	esp,4
	fstp	dword [esp]
	push	dword [_bb_gfx]
	call	_brl_max2d_DrawSubImageRect
	add	esp,48
	push	1065353216
	call	_brl_max2d_SetAlpha
	add	esp,4
	push	1
	call	_brl_max2d_SetBlend
	add	esp,4
	push	1065353216
	push	1065353216
	call	_brl_max2d_SetScale
	add	esp,8
	push	255
	push	255
	push	255
	call	_brl_max2d_SetColor
	add	esp,12
	mov	eax,0
	jmp	_97
_97:
	pop	ebx
	mov	esp,ebp
	pop	ebp
	ret
	section	"data" data writeable align 8
	align	4
_106:
	dd	0
	align	4
_bb_scale:
	dd	0
	align	4
_bb_tileset:
	dd	_bbNullObject
	align	4
_bb_gfx:
	dd	_bbNullObject
	align	4
_bb_tileMouseX:
	dd	0
	align	4
_bb_tileMouseY:
	dd	0
	align	4
_bb_tileX:
	dd	0
	align	4
_bb_tileY:
	dd	0
	align	4
_bb_level_pos_x:
	dd	0x0
	align	4
_bb_level_pos_y:
	dd	0
	align	4
_bb_selectedTileId:
	dd	0
	align	4
_bb_tileGridDisplay:
	dd	1
	align	4
_101:
	dd	0
_99:
	db	"i",0
	align	4
_bb_tilePosTab:
	dd	_bbEmptyArray
_103:
	db	"i",0
	align	4
_bb_tileMapData_foreground:
	dd	_bbEmptyArray
	align	4
_165:
	dd	0x3e800000
	align	4
_166:
	dd	0x3e800000
	align	4
_167:
	dd	0x43340000
	align	4
_168:
	dd	0x43340000
	align	4
_26:
	dd	_bbStringClass
	dd	2147483647
	dd	20
	dw	65,88,71,55,52,32,42,32,76,101,118,101,108,45,69,100
	dw	105,116,111,114
	align	4
_27:
	dd	_bbStringClass
	dd	2147483647
	dd	12
	dw	100,97,116,97,47,103,102,120,46,112,110,103
	align	4
_28:
	dd	_bbStringClass
	dd	2147483647
	dd	17
	dw	100,97,116,97,47,116,105,108,101,115,101,116,49,46,112,110
	dw	103
	align	4
_32:
	dd	_bbStringClass
	dd	2147483647
	dd	9
	dw	116,105,108,101,45,78,114,58,32
	align	4
_33:
	dd	_bbStringClass
	dd	2147483647
	dd	11
	dw	112,105,99,107,32,97,32,116,105,108,101
	align	4
_214:
	dd	0x41800000
	align	4
_55:
	dd	_bbStringClass
	dd	2147483647
	dd	9
	dw	108,101,118,101,108,45,120,58,32
	align	4
_215:
	dd	0x41800000
	align	4
_56:
	dd	_bbStringClass
	dd	2147483647
	dd	9
	dw	32,116,105,108,101,45,120,58,32
	align	4
_57:
	dd	_bbStringClass
	dd	2147483647
	dd	9
	dw	32,116,105,108,101,45,121,58,32
	align	4
_156:
	dd	_bbStringClass
	dd	2147483647
	dd	24
	dw	65,88,71,55,52,32,76,101,118,101,108,45,69,100,105,116
	dw	111,114,32,118,48,46,48,48
	align	4
_216:
	dd	0x41a00000
	align	4
_217:
	dd	0x41a00000
	align	4
_218:
	dd	0x41a00000
