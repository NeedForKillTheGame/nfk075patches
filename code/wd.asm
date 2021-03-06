    .686
    .model flat, stdcall
    option casemap :none   ; case sensitive
    ;option LJMP
	assume fs:nothing

;windows.inc goes here
OPEN_ALWAYS                          equ 4
GENERIC_WRITE                        equ 40000000h
FILE_END                             equ 2

;nfk defs
g_players   equ     00757B80h
MMP_CLIENTSHOT              equ     11
MMP_CLIENTRAILSHOT          equ     13
MMP_PING                    equ     26
MMP_INVITE                  equ     78
MMP_LOBBY_ANSWERPING        equ     73
MMP_LOBBY_GAMESTATE_RESULT  equ     85
MMP_SPECTATORDISCONNECT     equ     38
MMP_IAMQUIT                 equ     75
MMP_CTF_EVENT_FLAGDROP      equ     35h
MMP_PLAYERPOSUPDATE_PACKED  equ     88

WEAPON_GAUNTLET         equ     0
WEAPON_MACHINEGUN       equ     1
WEAPON_SHOTGUN          equ     2
WEAPON_GRENADELAUNCHER  equ     3
WEAPON_ROCKETLAUNCHER   equ     4
WEAPON_SHAFT            equ     5
WEAPON_RAILGUN          equ     6
WEAPON_PLASMAGUN        equ     7
WEAPON_BFG              equ     8

Gametype_CTF	equ	3
Gametype_DOM	equ	7

;wd defs
NETDEBUG_VERSION equ 1

exeAddr MACRO va
org va - 401000h
ENDM

    .code
start:
dd      patchCount

exeAddr 4011DCh
CloseHandle:                nop
exeAddr 4011E4h
CreateFileA:                nop
exeAddr	401294h
GetModuleHandleA:			nop
exeAddr	40129Ch
GetProcAddress:				nop
exeAddr 4013A0h
InitializeCriticalSection:  nop
exeAddr 4013A8h
EnterCriticalSection:       nop
exeAddr 4013B0h
LeaveCriticalSection:       nop

exeAddr	4026E0h
GetMem:		nop
exeAddr 4026EAh
l4026EA:    nop
exeAddr 4026EEh
l4026EE:    nop
exeAddr 4026F8h
FreeMem:    nop
exeAddr 402702h
l402702:    nop
exeAddr 402706h
l402706:    nop

exeAddr 402710h
ReallocMem: nop

exeAddr 402716h
l402716:    nop
exeAddr 402748h
l402748:    nop
exeAddr	40284Ch
IOResult:	nop
exeAddr	402864h
Move:		nop			;params
							;eax - source
							;edx - destination
							;ecx - count
exeAddr 402AB4h
Round:      nop

exeAddr	402AC0h
TRUNC:		nop

exeAddr 402AF8h
PStrNCat:	nop
exeAddr 402B28h
PStrCpy:	nop
exeAddr	402B44h
PStrNCpy:	nop			;params:
							;eax - destination:	shortstring
							;edx - source:		shortstring
							;cl - destSize:		byte
exeAddr	402B74h
PStrCmp:	nop

exeAddr	402C88h
RandInt:	nop

exeAddr 403430h
HandleAnyException: nop

exeAddr	4036E4h
HandleFinally:	nop

exeAddr 40378Ch
DoneExcept: nop

exeAddr 403B14h
l403B14h:   nop

exeAddr 403C4Ch
LStrClr:    nop			;params:
							;eax - source: PLStr

exeAddr	403C70h
LStrArrayClr:	nop

exeAddr 403CA0h
LStrAsg:    nop			;params:
							;eax - destination: PLStr
							;edx - source: LStr

exeAddr 403D15h
l403D15:    nop
exeAddr 403D30h
l403D30:    nop
exeAddr 403D39h
l403D39:    nop

exeAddr 403E70h
StringToLStr:	nop		;params:
							;eax - destination: PLStr
							;edx - source:		shortstring

exeAddr	403EA8h
LStrToString:	nop

exeAddr 403ED4h
LStrCat:    nop

exeAddr	403F18h
LStrCat3:	nop

exeAddr 403F8Ch
LStrCatN:	nop

exeAddr	403FDCh
LStrCmp:	nop

exeAddr	404080h
LStrAddRef:	nop

exeAddr	405C8Eh
_ASSIGN:	nop

exeAddr	405D30h
BlockRead:	nop

exeAddr 405DF8h
_CLOSE:		nop

exeAddr	40602Ch
FileSize:	nop			;params:
							;eax - FileRecord

exeAddr	4061BDh
_RESETFILE:	nop

exeAddr	4061F4h
Seek:		nop			;params
							;eax - FileRecord
							;edx - distance (from the beginning)

exeAddr 406D08h
patch128_begin:
GetTickCount:
	jmp	newGetTickCount
patch128_end:

exeAddr 406D70h
LoadLibraryA:       nop
exeAddr 406DC8h
SetFilePointer:     nop
exeAddr 406DE0h
Sleep:              nop
exeAddr 406E00h
WriteFile:          nop

exeAddr 407568h
CopyMemory:			nop

exeAddr	408A88h
IntToStr:	nop			;params:
							;eax - source: integer
							;edx - destination: PLStr

exeAddr	408B2Ch
StrToInt:	nop

exeAddr 408EACh
ExtractFileName:	nop

exeAddr 410A04h
l410A04:    nop

exeAddr	410B14h
TList_Get:	nop

exeAddr 422414h
Math__RadToDeg: nop

exeAddr 422470h
Math__ArcTan2:  nop

exeAddr	424894h
lstrpart_space	db	' ', 0

exeAddr 431344h
TWinControl_GetHandle:  nop

exeAddr 442BE0h
TCustomForm_SetClientWidth: nop

exeAddr 442C10h
TCustomForm_SetClientHeigth:    nop

exeAddr 443400h
TCustomForm_SetBorderStyle: nop

exeAddr 44B884h
MessageDlg: nop

exeAddr	451F80h
TCustomWinSocket_SendText:	nop

exeAddr 45304Fh
patch30_begin:
call    patch29_begin
patch30_end:

exeAddr	46968Ch
patch103_begin:
newTAGFImage_LoadFromFileStrip	proc
	push	16
	pop		edx
	mov		[eax + 4], edx
	mov		[eax + 8], edx
	mov		[eax + 0Ch], edx
	mov		[eax + 10h], edx
	push	1
	pop		edx
	mov		[eax + 14h], edx
	mov		[eax + 18h], edx
	mov		[eax + 1Ch], edx
	mov		[eax + 20h], edx
	xor		eax, eax
	retn	14h
newTAGFImage_LoadFromFileStrip	endp
patch103_end:

exeAddr	469B14h
patch106_begin:
newTAGFImage_LoadFromFileAuto	proc
	push	16
	pop		edx
	mov		[eax + 4], edx
	mov		[eax + 8], edx
	mov		[eax + 0Ch], edx
	mov		[eax + 10h], edx
	push	1
	pop		edx
	mov		[eax + 14h], edx
	mov		[eax + 18h], edx
	mov		[eax + 1Ch], edx
	mov		[eax + 20h], edx
	xor		eax, eax
	retn	4
newTAGFImage_LoadFromFileAuto	endp
patch106_end:

exeAddr	469FC4h
patch104_begin:
newTAGFImage_LoadFromStream_0	proc
	push	16
	pop		edx
	mov		[eax + 4], edx
	mov		[eax + 8], edx
	mov		[eax + 0Ch], edx
	mov		[eax + 10h], edx
	push	1
	pop		edx
	mov		[eax + 14h], edx
	mov		[eax + 18h], edx
	mov		[eax + 1Ch], edx
	mov		[eax + 20h], edx
	xor		eax, eax
	retn	14h
newTAGFImage_LoadFromStream_0	endp
patch104_end:

exeAddr	46A43Ch
patch105_begin:
newTAGFImage_LoadFromVTDb	proc
	push	16
	pop		edx
	mov		[eax + 4], edx
	mov		[eax + 8], edx
	mov		[eax + 0Ch], edx
	mov		[eax + 10h], edx
	push	1
	pop		edx
	mov		[eax + 14h], edx
	mov		[eax + 18h], edx
	mov		[eax + 1Ch], edx
	mov		[eax + 20h], edx
	xor		eax, eax
	retn	8
newTAGFImage_LoadFromVTDb	endp
patch105_end:

exeAddr 46AFC0h
TPowerGraph_SetWidth:   nop

exeAddr 46AFD0h
TPowerGraph_SetHeigth:  nop

exeAddr 46B000h
TPowerGraph_SetFullscreen: nop

exeAddr	46B06Ch
patch107_begin:
TPowerGraph_Initialize:
newTPowerGraph_Initialize	proc
	xor		eax, eax
	retn
newTPowerGraph_Initialize	endp
patch107_end:

exeAddr	46B518h
patch108_begin:
TPowerGraph_Finalize:
newTPowerGraph_Finalize	proc
	xor		eax, eax
	retn
newTPowerGraph_Finalize	endp
patch108_end:

exeAddr	46B594h
patch109_begin:
newTPowerGraph_Reset	proc
	xor		eax, eax
	retn
newTPowerGraph_Reset	endp
patch109_end:

exeAddr 46B5C4h
patch81_begin:
newTPowerGraph_SetAntialias	proc
	mov		eax, 1
	retn
newTPowerGraph_SetAntialias	endp
patch81_end:

exeAddr	46B8F8h
patch98_begin:
newTPowerGraph_SetClipRect	proc
	mov		eax, 1
	retn
newTPowerGraph_SetClipRect	endp
patch98_end:

exeAddr	46B978h
patch97_begin:
TPowerGraph_ResetRect:
newTPowerGraph_ResetRect	proc
	mov		eax, 1
	retn
newTPowerGraph_ResetRect	endp
patch97_end:

exeAddr	46B9A8h
patch102_begin:
newTPowerGraph_BeginScene	proc
	mov		eax, 1
	retn
newTPowerGraph_BeginScene	endp
patch102_end:

exeAddr	46B9DCh
patch99_begin:
newTPowerGraph_EndScene	proc
	mov		eax, 1
	retn
newTPowerGraph_EndScene	endp
patch99_end:

exeAddr	46BA10h
patch100_begin:
newTPowerGraph_Present	proc
	mov		eax, 1
	retn
newTPowerGraph_Present	endp
patch100_end:

exeAddr	46BA70h
patch101_begin:
newTPowerGraph_Clear	proc
	mov		eax, 1
	retn
newTPowerGraph_Clear	endp
patch101_end:

exeAddr	46C080h
patch77_begin:
newTPowerGraph_FillRectMap	proc
	mov		eax, 1
	retn	20h
newTPowerGraph_FillRectMap	endp
patch77_end:

exeAddr	46C17Ch
patch78_begin:
newTPowerGraph_FillRectMap_0	proc
	mov		eax, 1
	retn	2Ch
newTPowerGraph_FillRectMap_0	endp
patch78_end:

exeAddr	46C2D0h
patch76_begin:
newTPowerGraph_FillRect	proc
	mov		eax, 1
	retn	10h
newTPowerGraph_FillRect endp
patch76_end:

exeAddr	46C310h
patch96_begin:
newTPowerGraph_FrameRect	proc
	mov		eax, 1
	retn	4
newTPowerGraph_FrameRect	endp
patch96_end:

exeAddr	46C3E0h
patch79_begin:
TPowerGraph_Rectangle:
newTPowerGraph_Rectangle	proc
	mov		eax, 1
	retn	14h
newTPowerGraph_Rectangle	endp
patch79_end:

exeAddr	46C454h
patch80_begin:
newTPowerGraph_Line	proc
	mov		eax, 1
	retn	10h
newTPowerGraph_Line	endp
patch80_end:

exeAddr	46C648h
patch84_begin:
newTPowerGraph_SmoothLine	proc
	mov		eax, 1
	retn	0Ch
newTPowerGraph_SmoothLine	endp
patch84_end:

exeAddr	46CCE8h
patch94_begin:
newTPowerGraph_TextureMap	proc
	mov		eax, 1
	retn	24h
newTPowerGraph_TextureMap	endp
patch94_end:

exeAddr	46CE24h
patch93_begin:
newTPowerGraph_TextureMapRect_0	proc
	mov		eax, 1
	retn	14h
newTPowerGraph_TextureMapRect_0	endp
patch93_end:

exeAddr	46CF90h
patch92_begin:
newTPowerGraph_TextureMapRect	proc
	mov		eax, 1
	retn	18h
newTPowerGraph_TextureMapRect	endp
patch92_end:

exeAddr	46D0F8h
patch95_begin:
TPowerGraph_TextureCol:
newTPowerGraph_TextureCol	proc
	mov		eax, 1
	retn	28h
newTPowerGraph_TextureCol	endp
patch95_end:

exeAddr	46D370h
patch88_begin:
newTPowerGraph_RenderEffect_0	proc
	mov		eax, 1
	retn 	0Ch
newTPowerGraph_RenderEffect_0	endp
patch88_end:

exeAddr	46D3ACh
patch87_begin:
newTPowerGraph_RenderEffect	proc
	mov		eax, 1
	retn	10h
newTPowerGraph_RenderEffect	endp
patch87_end:

exeAddr	46D410h
patch85_begin:
newTPowerGraph_RenderEffectCol	proc
	mov		eax, 1
	retn	10h
newTPowerGraph_RenderEffectCol	endp
patch85_end:

exeAddr	46D450h
patch91_begin:
newTPowerGraph_RenderEffectCol_0	proc
	mov		eax, 1
	retn	14h
newTPowerGraph_RenderEffectCol_0	endp
patch91_end:

exeAddr	46D4B8h
patch86_begin:
newTPowerGraph_RenderEffectCol2	proc
	mov		eax, 1
	retn	20h
newTPowerGraph_RenderEffectCol2	endp
patch86_end:

exeAddr	46D57Ch
patch90_begin:
newTPowerGraph_RotateEffectFix_0	proc
	mov		eax, 1
	retn	14h
newTPowerGraph_RotateEffectFix_0	endp
patch90_end:

exeAddr	46D790h
patch83_begin:
newTPowerGraph_TexturedLine2	proc
	mov		eax, 1
	retn	2Ch
newTPowerGraph_TexturedLine2	endp
patch83_end:

exeAddr	46D888h
patch82_begin:
newTPowerGraph_RotateEffect	proc
	mov		eax, 1
	retn	18h
newTPowerGraph_RotateEffect	endp
patch82_end:

exeAddr	46DA9Ch
patch89_begin:
newTPowerGraph_RotateEffectFix	proc
	mov		eax, 1
	retn	14h
newTPowerGraph_RotateEffectFix	endp
patch89_end:

exeAddr 46E5ECh
TPowerFont_TextOut: nop

exeAddr	46E860h
TPowerFont_AlignedOut:	nop

exeAddr 46EAD0h
TPowerFont_TextWidth:   nop

exeAddr 47DF2Eh
patch26_begin:
call    patch25_begin
patch26_end:

exeAddr 47E47Fh
patch24_begin:
call    patch23_begin
patch24_end:

exeAddr 47E7CDh
patch20_begin:
call    patch19_begin
nop
nop
nop
nop
patch20_end:

IFDEF _TEST
; Network_AddToQueue hook
exeAddr 47E857h
patch184_begin:
    push    esi
    push    [ebp + 8]   ; flags
    push    [ebp + 0Ch] ; port
    lea     eax, [ebp - 100h]
    push    eax         ; ip_address
    lea     eax, [esp + 0Ch]
    push    eax         ; Psize
    push    edi         ; data
    call    dword ptr [nd_AddToQueue]
    pop     esi
    test    eax, eax
    jz      Network_AddToQueue_exit
    jmp     Network_AddToQueue_tramp
patch184_end:
ENDIF

exeAddr 47E880h
Network_AddToQueue_tramp2:

exeAddr 47E8DFh
Network_AddToQueue_exit:

IFDEF _TEST
; Network_ParsePackets hook 1 (preprocessing)
exeAddr 47E938h
patch186_begin:
    mov     ebp, edx
    push    1           ; proc_state
    push    edx         ; port
    push    eax         ; ip_address
    push    PReadBuf    ; data
    call    dword ptr [nd_ReceiveData]
    jmp     Network_ParsePackets_tramp1
patch186_end:
ENDIF

exeAddr 47E94Fh
Network_ParsePackets_tramp1_2:

IFDEF _TEST
exeAddr 47E9F3h
patch188_begin:
    push    2           ; proc_state
    push    ebp         ; port
    lea     eax, [esp + 0Fh]
    push    eax         ; ip_address
    push    esi         ; data
    call    dword ptr [nd_ReceiveData]
    jmp     Network_ParsePackets_tramp2
patch188_end:
ENDIF

exeAddr 47EA07h
Network_ParsePackets_tramp2_2:

exeAddr 47EA3Fh
Network_ParsePackets_exit:

exeAddr 47EAD4h
patch35_begin:
newTPlayerSize	dd	370h
patch35_end:

exeAddr 47F794h
ismultip:   nop

exeAddr	47FAACh
NFKPlanet_GetTok2:	nop

exeAddr 47FC70h
strpar: nop

exeAddr	47FDFCh
BD_Avail:	nop

exeAddr 483850h
initBotdllAddress:  nop

; BD_Init extensions call
exeAddr 483CC8h
patch214_begin:
    call    BD_Init_ext
patch214_end:

exeAddr 484920h
BNETSendData2All:	nop

exeAddr	484BC4h
BNETSendData2IP_:	nop

exeAddr 484D08h
BNETSendData2HOST:  nop

exeAddr	484EB4h
GetNumberOfPlayers:	nop

exeAddr 484EF4h
getNetPlayersCount: nop

exeAddr 486E74h
SpawnBubble:        nop

exeAddr 488690h
SimpleDeathMessage: nop

exeAddr 488F58h
DeathMessage:       nop

exeAddr 48A138h
GameEnd:		nop

exeAddr 48BCFCh
CalculateFragBar	proc

exeAddr 48BE73h
patch218_begin::
    nop
    nop
    call    CalculateFragBar_ex1
patch218_end::

exeAddr 48BF8Ch
patch219_begin::
    nop
    nop
    call    CalculateFragBar_ex1
patch219_end::

exeAddr 48BF99h
patch220_begin::
    .if OPT_FREEFLY != 0
        call    CalculateFragBar_ex2
        jmp     loc_48C046
    .endif
    mov     al, OPT_1BARTRAX
    cmp     dword ptr g_players[eax * 4], 0
    jz      loc_48BFD4
    jmp     loc_48BFC5
patch220_end::

exeAddr 48BFC5h
loc_48BFC5: nop

exeAddr 48BFD4h
loc_48BFD4: nop

exeAddr 48C046h
loc_48C046: nop

exeAddr 48C181h
patch161_begin::
	jmp		uselessCodeEnd
patch161_end::

exeAddr	48C20Bh
uselessCodeEnd:

CalculateFragBar	endp

exeAddr	48C4E8h
PAINSOUNDZZ:	nop

exeAddr 48C8A0h
ApplyDamage:	nop

exeAddr	48C961h
patch114_begin:
	call	newApplyDamage_selfSplashDamage
patch114_end:

exeAddr 48E764h
; ==================================================================
PlasmaSplash	proc
;------- locals -----------------
plasma		EQU		<[ebp - 4]>		; TMonoSprite, size = 4
dist		EQU		<[ebp - 10h]>	; double, size = 8
;------- code -------------------
exeAddr 48E80Ch
patch162_begin::
	mov		eax, plasma
	mov		edx, [eax + 10h]	; TMonoSprite.player
	fld		qword ptr [edx + 290h]	; TPlayer.x
	fsub	qword ptr [eax + 20h]	; TMonoSprite.x
	fmul	st(0), st(0)
	fld		qword ptr [edx + 298h]	; TPlayers.y
	fsub	qword ptr [eax + 28h]	; TMonoSprite.y
	fmul	st(0), st(0)
	faddp	st(1), st
	fsqrt
	fst		qword ptr dist
	wait
	fcomp	maxDist
	fnstsw	ax
	sahf
	jnb		near ptr exit
	cmp		byte ptr [edx + 277h], 0	; TPlayer.item_battle
	jz		distCalcEnd	; continue with damage calculation and applying
	mov		eax, edx
	call	PlayBattleSuitSound
	jmp		near ptr throwPlayer
exeAddr 48E862h
patch162_end::
distCalcEnd:	nop

exeAddr 48E8D3h
throwPlayer:	nop

exeAddr	48E90Ah
exit:	nop

;------- datas ------------------
exeAddr	48E910h
maxDist		dd	30.0

PlasmaSplash	endp
; ==================================================================


exeAddr 492731h
patch164_begin:
	cmp		byte ptr [eax + 277h], 0	; TPlayer.item_battle
	push	eax
	jz		@F
	call	PlayBattleSuitSound
	jmp		noDamage
@@:
	push	3
	push	6
	pop		eax
	call	RandInt
	mov		edx, eax
	add		edx, 0Ch
	mov		ecx, objects
	mov		eax, [ebp - 4]
	call	ApplyDamage
noDamage:
	pop		eax
	mov		byte ptr [eax + 11h], 8		; TPlayer.inlava
	push	dword ptr [eax + 294h]		; TPlayer.x high dword
	push	dword ptr [eax + 290h]		; TPlayer.x low dword
	push	dword ptr [eax + 29Ch]		; TPlayer.y high dword
	push	dword ptr [eax + 298h]		; TPlayer.y low dword
	mov		ax, 22h
	call	playsound
patch164_end:

exeAddr 492B58h
ItemDisappear:  nop

exeAddr 49CB38h
IsWaterContentHEAD: nop

exeAddr 4A73CCh
aRestart	db	'restart', 0

exeAddr	4AB800h
DOM_Think:	nop

exeAddr 4ABF78h
patch158_begin:
CTF_CLNETWORK_DropFlag	proc
									; al - PacketType: byte
									; edx - Data: Pointer
									; ecx - PacketSize
;------- locals --------------------
PacketType		EQU		<[ebp - 4]>		; byte, size = 1
PacketSize		EQU		<[ebp - 8]>		; Integer, size = 4
i				EQU		<[ebp - 0Ch]>	; Integer, size = 4
flagImageIndex	EQU		<[ebp - 0Dh]>	; byte, size = 1
flagDir			EQU		<[ebp - 0Eh]>	; byte, size = 1
playerFound		EQU		<[ebp - 0Fh]>	; byte, size = 1
objectInserted	EQU		<[ebp - 10h]>	; byte, size = 1
tempInt			EQU		<[ebp - 14h]>	; integer, size = 4
;------- codes ---------------------

	push	ebp
	mov		ebp, esp
	add		esp, -10h
	push	esi
	push	edi

	mov		esi, edx			; esi = Data
	mov		PacketType, al
	mov		PacketSize, ecx

	call	ismultip
	cmp		al, 2
	jnz		exit

	mov		byte ptr flagDir, 0
	mov		byte ptr flagImageIndex, 0

	; if the flag has just been dropped, loop through players to clear 'flagcarrier' flag
	mov		byte ptr playerFound, 0
	cmp		byte ptr PacketType, MMP_CTF_EVENT_FLAGDROP
	jnz		isGamestate

	mov		ax, [esi + 3]	; TMP_CTF_FlagDrop.DropperDXID
	mov		edx, offset aLost
	call	CTF_Event_Message
	xor		eax, eax
	mov		i, eax
playersLoop:
	mov		edi, dword ptr [g_players + eax * 4]
	test	edi, edi
	jz		playersLoop_cont

	mov		ax, [edi + 28Ch]	; TPlayer.DXID
	cmp		ax, [esi + 3]		; TMP_CTF_FlagDrop.DropperDXID
	jnz		playersLoop_cont

	mov		byte ptr playerFound, 1
	mov		byte ptr [edi + 0FCh], 0	; TPlayer.flagcarrier

	; the player who dropped the flag is found, decide what color the flag was of from that player's team color
	mov		al, [edi + 26h]		; TPlayer.team
	xor		al, 1
	mov		flagImageIndex, al
	; remember also the direction of the player
	mov		al, [edi + 0Ch]		; TPlayer.dir
	and		al, 1
	mov		flagDir, al

playersLoop_cont:
	inc		dword ptr i
	mov		eax, i
	cmp		al, 7
	jle		playersLoop

	cmp		byte ptr playerFound, 0
	jnz		notGamestate
	; flag dropper hasn't been found, try to extract info from the packet
	cmp		byte ptr PacketSize, 17h
	jnz		flagError
	mov		al, [esi + 15h]		; TMP_CTF_FlagDrop.imageindex
	mov		dl, [esi + 16h]		; TMP_CTF_FlagDrop.dir
	mov		byte ptr flagImageIndex, al
	mov		byte ptr flagDir, dl
	jmp		notGamestate
flagError:
	; old servers don't give us any data to decide the color of the flag, print error and disconnect
	mov		eax, offset aErrorMsg
	call	AddMessage
	mov		eax, offset lstr_disconnect
	call	ApplyHCommand
	jmp		exit

isGamestate:
	; if the message is a part of gamestate, flag color is stored in DropperDXID value
	mov		al, [esi + 3]		; TMP_CTF_FlagDrop.DropperDXID
	mov		flagImageIndex, al
	mov		byte ptr flagDir, 0	; TODO: random(1)

notGamestate:
	mov		byte ptr objectInserted, 0
	; loop through all objects, delete old flags of the same color and insert the new one
	xor		eax, eax
	mov		i, eax
objectsLoop:
	mov		edi, [objects + eax * 4]
	; check if the object is a flag of the same color
	cmp		byte ptr [edi + 4], 0	; TMonoSprite.dead
	jnz		notAFlag
	mov		al, flagImageIndex
	cmp		byte ptr [edi + 0Dh], al	; TMonoSprite.imageindex
	jnz		notAFlag
	lea		eax, [edi + 50h]	; TMonoSprite.name
	mov		edx, offset aFlag
	call	PStrCmp
	jnz		notAFlag
	; flag of the same color has been found, mark it as dead
	mov		byte ptr [edi + 4], 2

notAFlag:
	; if the object is dead, and we haven't yet inserted the new flag, insert.
	cmp		byte ptr objectInserted, 0
	jnz		objectsLoop_cont
	cmp		byte ptr [edi + 4], 2	; TMonoSprite.dead
	jnz		objectsLoop_cont
	; fill the object fields
	; TMonoSprite.name
	lea		eax, [edi + 50h]
	mov		byte ptr [eax], 4
	mov		dword ptr [eax + 1], 'galf'
	; TMonoSprite.X
	fld		dword ptr [esi + 5]		; TMP_CTF_FlagDrop.X
	fstp	qword ptr [edi + 20h]	; TMonoSprite.X
	; TMonoSprite.Y
	fld		dword ptr [esi + 9]		; TMP_CTF_FlagDrop.Y
	fstp	qword ptr [edi + 28h]	; TMonoSprite.Y
	wait
	; TMonoSprite.DXID
	mov		ax, [esi + 1]			; TMP_CTF_FlagDrop.DXID
	mov		[edi + 70h], ax			; TMonoSprite.DXID
	; TMonoSprite.dead
	mov		byte ptr [edi + 4], 0	; TMonoSprite.dead
	; TMonoSprite.dude
	mov		byte ptr [edi + 72h], 1	; TMonoSprite.dude
	; TMonoSprite.topdraw
	mov		byte ptr [edi + 73h], 0	; TMonoSprite.topdraw
	; TMonoSprite.frame
	mov		byte ptr [edi + 14h], 0 ; TMonoSprite.frame
	; TMonoSprite.mass
	xor		edx, edx
	mov		[edi + 78h], edx		; TMonoSprite.mass low dword
	mov		dword ptr [edi + 7Ch], 40140000h	; TMonoSprite.mass high dword. 0x4014000000000000 is double 5.0
	; TMonoSprite.weapon
	mov		byte ptr [edi + 0Ah], 0			; TMonoSprite.weapon
	; TMonoSprite.health
	mov		word ptr [edi + 16h], 3500

	; TMonoSprite.imageindex
	mov		al, flagImageIndex
	mov		[edi + 0Dh], al		; TMonoSprite.imageindex
	; TMonoSprite.dir
	mov		dl, flagDir
	mov		[edi + 0Eh], dl		; TMonoSprite.dir

	; if the flag was dropped (message is not gamestate), put DropperDXID into fangle field
	cmp		byte ptr PacketType, MMP_CTF_EVENT_FLAGDROP
	jnz		@F
	movzx	eax, word ptr [esi + 3]	; TMP_CTF_FlagDrop.DropperDXID
	mov		tempInt, eax
	fild	dword ptr tempInt
	fstp	qword ptr [edi + 40h]	; TMonoSprite.fangle
	wait
@@:
	; TMonoSprite.InertiaX
	fld		dword ptr [esi + 0Dh]	; TMP_CTF_FlagDrop.InertiaX
	fstp	qword ptr [edi + 80h]	; TMonoSprite.InertiaX
	; TMonoSprite.InertiaY
	fld		dword ptr [esi + 11h]	; TMP_CTF_FlagDrop.InertiaY
	fstp	qword ptr [edi + 88h]	; TMonoSprite.InertiaY
	wait
	; TMonoSprite.clippixel
	mov		word ptr [edi + 6], 4	; TMonoSprite.clippixel

	cmp		byte ptr MATCH_DRECORD, 0
	jnz		exit
	mov		eax, edi
	call	CTF_SAVEDEMO_FlagDrop
	jmp		exit
objectsLoop_cont:
	inc		dword ptr i
	mov		eax, i
	cmp		eax, 1000
	jle		objectsLoop
exit:
	pop		edi
	pop		esi
	mov		esp, ebp
	pop		ebp
	retn
;---------- data -------------
align 4
	dd	0FFFFFFFFh
	dd	30
aErrorMsg	db	'ERROR: Can''t find flag dropper', 0
align 4
aLost	db	4, 'lost', 0
align 4
aFlag	db	4, 'flag', 0
CTF_CLNETWORK_DropFlag	endp
patch158_end:

exeAddr	4AC4ACh
CTF_SAVEDEMO_FlagDrop:	nop

exeAddr 4AC5A4h
patch157_begin:
; slightly modified function CTF_SVNETWORK_FlagDrop. Size of the packet is increased
; and now packet contains information about dropped flag color and direction
CTF_SVNETWORK_FlagDrop	proc
									; eax - sender: TMonoSprite
;------- locals --------------------
sender			EQU		<[ebp - 4]>		; TMonoSprite, size = 4
MsgSize			EQU		<[ebp - 8]>		; Integer, size = 4
Flag_dir		EQU		<[ebp - 9]>		; byte, size = 1
Flag_imageindex	EQU		<[ebp - 0Ah]>	; byte, size = 1
Flag_InertiaY	EQU		<[ebp - 0Eh]>	; Single, size = 4
Flag_InertiaX	EQU		<[ebp - 12h]>	; Single, size = 4
Flag_Y			EQU		<[ebp - 16h]>	; Single, size = 4
Flag_X			EQU		<[ebp - 1Ah]>	; Single, size = 4
Flag_DropperDXID EQU	<[ebp - 1Ch]>	; word, size = 2
Flag_DXID		EQU		<[ebp - 1Eh]>	; word, size = 2
Data			EQU		<[ebp - 1Fh]>	; byte, size = 1
;------- const ---------------------
FlagDropMsgSize	EQU		17h
;------- codes ---------------------

	push	ebp
	mov		ebp, esp
	add		esp, -20h
	mov		sender, eax
	call	ismultip
	cmp		al, 1
	jnz		exit
	push	FlagDropMsgSize
	pop		dword ptr MsgSize
	mov		byte ptr Data, MMP_CTF_EVENT_FLAGDROP
	mov		eax, sender
	fld		qword ptr [eax + 40h]	; TMonoSprite.fangle
	call	TRUNC
	cmp		edx, 0
	jnz		@F
	cmp		eax, 0FFFFh
	jbe		no_overflow
@@:
	xor		eax, eax
no_overflow:
	mov		Flag_DropperDXID, ax
	mov		eax, sender
	mov		dx, [eax + 70h]			; TMonoSprite.DXID
	mov		Flag_DXID, dx
	fld		qword ptr [eax + 20h]	; TMonoSprite.X
	fstp	dword ptr Flag_X
	fld		qword ptr [eax + 28h]	; TMonoSprite.Y
	fstp	dword ptr Flag_Y
	fld		qword ptr [eax + 80h]	; TMonoSprite.InertiaX
	fstp	dword ptr Flag_InertiaX
	fld		qword ptr [eax + 88h]	; TMonoSprite.InertiaY
	fstp	dword ptr Flag_InertiaY
	mov		dl, [eax + 0Dh]			; TMonoSprite.imageindex
	mov		Flag_imageindex, dl
	mov		dl, [eax + 0Eh]			; TMonoSprite.dir
	mov		Flag_dir, dl
	push	1
	lea		edx, Data
	mov		cx, MsgSize
	mov		eax, mainform
	call	BNETSendData2All
exit:
	mov		esp, ebp
	pop		ebp
	retn
CTF_SVNETWORK_FlagDrop	endp
exeAddr 4AC630h
patch157_end:

exeAddr 4AD594h
CTF_Event_Message:	nop

exeAddr 4B2014h
playsound:  nop

exeAddr 4B31FCh
isGameTeamplay:	nop

exeAddr 4B4B9Ch
lstr_disconnect	db 'disconnect', 0

exeAddr 4B507Ah
patch175_begin:
	xor		eax, eax
	mov		gametic, eax
	mov		gametime, eax
	mov		inmenu, al
	mov		gx, eax
	mov		gy, eax
	mov		byte ptr map_info, 8
	mov		SYS_TEAMSELECT, al
	cmp		OPT_NETSPECTATOR, al
	jnz		@F
	call	isGameTeamplay
	test	al, al
	jz		@F
	mov		SYS_TEAMSELECT, 30
	nop
	nop
	nop
	nop
@@:
patch175_end:

exeAddr	4B516Ah
patch43_begin:
	jmp		SpawnServer_PostInit_NFKPlanetPortOk
patch43_end:

exeAddr	4B51F6h
SpawnServer_PostInit_NFKPlanetPortOk:	nop

exeAddr	4B52ACh
SpawnServer:	nop

exeAddr	4B74E8h
patch115_begin:
	mov		edx, offset LFULL_NFK_VERSION
patch115_end:

NFKPlanet_PingLastServer	proc
; part of PingLastServer that sends ping
exeAddr	4B9C12h
patch49_begin::
	lea		ecx, [ebp - 2ch]
	movzx	edx, byte ptr [ebp - 2]		; i
	mov		eax, NFKPlanet_ServersList
	mov		ebx, [eax]
	call	dword ptr [ebx + 0Ch]		; TStringList.Get
	mov		eax, [ebp - 2ch]
	lea		ecx, [ebp - 28h]
	mov		dx, 7
	call	NFKPlanet_GetTok2
	cmp		dword ptr [ebp - 28h], 0	; If theres no 7th token
	jnz		exit
	mov		byte ptr [ebp - 3], 72		; put MMP_LOBBY_PING in message.data
	lea		eax, [ebp - 3]
	push	eax
	push	1
	push	0
	mov		eax, [ebp - 2ch]
	lea		ecx, [ebp - 130h]
	mov		dx, 5
	call	NFKPlanet_GetTok2			; get IP from 5th token
	mov		edx, [ebp - 130h]
	lea		eax, [ebp - 12Ch]
	mov		ecx, 0FFh
	call	LStrToString				; convert it into ShortString
	mov		eax, [ebp - 2ch]
	lea		ecx, [ebp - 130h]
	mov		dx, 6
	call	NFKPlanet_GetTok2			; get Port from 6th token
	mov		eax, [ebp - 130h]
	call	StrToInt
	mov		cx, ax
	lea		edx, [ebp - 12Ch]
	mov		eax, mainform
	call	BNETSendData2IP_
	jmp		afterPing
patch49_end::

exeAddr	4B9D0Bh
afterPing:	nop

exeAddr	4B9D68h
exit:	nop
NFKPlanet_PingLastServer	endp

exeAddr	4B9DC4h
patch50_begin:
NFKPlanet_UpdateServerPing	proc
									; eax - IP: ShortString
									; edx - Port: integer
;------- locals --------------------
IP				EQU		<[ebp - 4]>		; PShortString, size = 4
Port			EQU		<[ebp - 8]>		; Integer, size = 4
i				EQU		<[ebp - 0Ch]>	; Integer, size = 4
serversCount	EQU		<[ebp - 10h]>	; Integer, size = 4
ping			EQU		<[ebp - 14h]>	; Integer, size = 4
serverIP		EQU		<[ebp - 18h]>	; LStr, size = 4
serverData		EQU		<[ebp - 1Ch]>	; LStr, size = 4
tempStr			EQU		<[ebp - 20h]>	; LStr, size = 4
;------- codes ---------------------
	push	ebp
	mov		ebp, esp
	push	eax						; initialize IP
	push	edx						; initialize Port
	mov		ecx, 3
@@:	push	0						; allocate 24 more bytes for the rest of locals
	push	0
	dec		ecx
	jnz		@B
	push	ebx						; we will use ebx to access TStringList vtable
; enter try-finally block
	xor		eax, eax
	push	ebp
	push	offset exceptionHandler
	push	dword ptr fs:[eax]
	mov		fs:[eax], esp

	mov		eax, NFKPlanet_ServersList
	mov		ebx, [eax]
	call	dword ptr [ebx + 14h]	; TStringList.GetCount
	test	eax, eax
	jz		exit
	mov		serversCount, eax
	mov		eax, mainform
	mov		eax, [eax + 304h]		; eax = MainForm.Lobby
	cmp		byte ptr [eax + 24h], 0	; cmp MainForm.Lobby.Active, 0
	jne		nextServer
	cmp		MP_STEP, 4
	jne		exit
nextServer:
	lea		ecx, serverData
	mov		eax, NFKPlanet_ServersList
	mov		edx, i
	call	dword ptr [ebx + 0Ch]	; NFKPlanet_ServersList.Get(i);
	lea		ecx, serverIP
	mov		eax, serverData
	mov		dx, 5
	call	NFKPlanet_GetTok2		; extract IP address of the server
	lea		eax, tempStr
	mov		edx, IP
	call	StringToLStr			; convert IP from parameters to LStr
	mov		eax, tempStr
	mov		edx, serverIP
	call	LStrCmp					; compare both
	jnz		continue
	lea		ecx, tempStr
	mov		eax, serverData
	mov		dx, 6
	call	NFKPlanet_GetTok2		; extract port number of the server
	mov		eax, tempStr
	call	StrToInt
	cmp		eax, Port				; compare with Port number from parameters
	jnz		continue
	lea		ecx, tempStr
	mov		eax, serverData
	mov		dx, 7
	call	NFKPlanet_GetTok2		; extract timestamp
	mov		eax, tempStr
	test	eax, eax
	jz		exit					; exit if there were no timestamp - this may happen and ruin all the shit
	call	StrToInt
	push	eax
	call	GetTickCount
	pop		edx
	sub		eax, edx
	js		exit					; exit if timestamp is bigger than GetTickCount - this must [almost] never happen
	sar		eax, 1
	cmp		eax, 999
	jbe		@F
	mov		eax, 999
@@:
	mov		ping, eax
	lea		ecx, tempStr
	mov		eax, serverData
	mov		dx, 8
	call	NFKPlanet_GetTok2
	mov		eax, tempStr
	test	eax, eax
	jnz		exit					; exit if there already is a computed ping. This is plain wrong but meh...
	push	serverData				; prepare to LStrCatN
	push	offset nullStr
	lea		edx, tempStr
	mov		eax, ping
	call	IntToStr
	push	tempStr
	lea		eax, tempStr
	mov		edx, 3
	call	LStrCatN
	mov		eax, NFKPlanet_ServersList
	mov		edx, i
	mov		ecx, tempStr
	call	dword ptr [ebx + 20h]	; TStringList.Put
	jmp		exit
continue:
	inc		dword ptr i
	dec		dword ptr serversCount
	jnz		nextServer
exit:
	; exit try-finally block
	xor		eax, eax
	pop		edx
	pop		ecx
	pop		ecx
	mov		fs:[eax], edx
	push	offset realExit
cleanup:
	lea		eax, tempStr
	mov		edx, 3
	call	LStrArrayClr
	retn

exceptionHandler:
	jmp		HandleFinally
	jmp		cleanup

realExit:
	pop		ebx
	mov		esp, ebp
	pop		ebp
	retn

;------- datas ---------------------
align 4
			dd		0FFFFFFFFh
			dd		1
nullStr		db		0
NFKPlanet_UpdateServerPing	endp
patch50_end:

exeAddr	4BA60Eh
patch56_begin:
	cmp		byte ptr [ebp - 1], 8
patch56_end:

exeAddr	4BA828h
patch58_begin:
	jmp		NFKPlanet_SortServerList_appendPort
patch58_end:
exeAddr	4BA82Dh
NFKPlanet_SortServerList_afterAppendPort:	nop

exeAddr	4BA844h
patch59_begin:
	mov		dx, 7
patch59_end:

exeAddr	4BA86Dh
patch60_begin:
	mov		dx, 7
patch60_end:

exeAddr	4BA8A2h
patch61_begin:
	mov		dx, 8
patch61_end:

exeAddr	4BA8CBh
patch62_begin:
	mov		dx, 8
patch62_end:

exeAddr	4BA98Ch
NFKPlanet_SortServerList_nullStr	dd	0

exeAddr	4BAA84h
BNET_DirectConnect	proc

exeAddr 4BAB8Fh
patch165_begin::
	jmp		localIPCheckEnd
patch165_end::

exeAddr 4BABCAh
localIPCheckEnd:	nop

BNET_DirectConnect	endp

exeAddr	4BB720h
DrawWindow:	nop

exeAddr 4BC575h
patch207_begin:
    mov     eax, mainform
    mov     eax, [eax + 2D4h]   ;TMainForm.PowerGraph
    call    TPowerGraph_ResetRect
    mov     eax, mainform
    mov     eax, [eax + 2D4h]   ;TMainForm.PowerGraph
    mov     edx, [eax + 21D8h]  ;TPowerDraw.Width
    sub     edx, 640
    sar     edx, 1
    jns     @F
    adc     edx, 0
@@: mov     [eax + 3ED8h], edx  ;TPowerDraw.offsetx
    mov     edx, [eax + 21DCh]  ;TPowerDraw.Height
    sub     edx, 480
    sar     edx, 1
    jns     @F
    adc     edx, 0
@@: mov     [eax + 3EDCh], edx  ;TPowerDraw.offsety
    jmp     loc_4BC5F1
patch207_end:

exeAddr 4BC5F1h
loc_4BC5F1: nop

exeAddr 4C05D6h
patch3_begin:
IFDEF _DEDIC
jmp     l4C05E1
nop
nop
nop
nop
nop
nop
nop
nop
nop
ENDIF
patch3_end:
l4C05E1:    nop

exeAddr	4C2AA3h
patch55_begin:
	mov		al, 8
patch55_end:

exeAddr	4C3140h
patch63_begin:
	mov		dx, 8
patch63_end:

exeAddr 4C3360h
patch4_begin:
IFDEF _DEDIC
jmp     l4C336B
nop
nop
nop
nop
nop
nop
nop
nop
nop
ENDIF
patch4_end:
l4C336B:    nop

exeAddr	4C34D8h
patch66_begin:
	jmp		DrawMenu_newOnConnect
patch66_end:

exeAddr	4C34F3h
DrawMenu_onConnect_afterConcat:	nop

exeAddr	4C3533h
patch64_begin:
	mov		dx, 8
patch64_end:

exeAddr	4C3578h
patch72_begin:
	call 	DrawMenu_newAskForInvite
patch72_end:

; stop using BNET_REALSERVERPORT, use BNET_SERVERPORT instead
exeAddr 4CA2EAh
patch194_begin:
    cmp     BNET_SERVERPORT, 29991
patch194_end:

; stop using BNET_REALSERVERPORT, use BNET_SERVERPORT instead
exeAddr 4CA326h
patch195_begin:
    movzx   eax, BNET_SERVERPORT
patch195_end:

exeAddr	4CA52Dh
patch152_begin:
	call	DrawMenu_ex
patch152_end:

exeAddr	4CA638h
patch123_begin:
	dd	0FFFFFFFFh
	dd	48h
	db	'Need For Kill (c) 2001-2012. Created by 3d[Power]. All rights preserved.', 0, 0, 0, 0
	dd	0FFFFFFFFh
	dd	40h
	db	'http://needforkill.ru                e-mail: the.boobl@gmail.com', 0
patch123_end:

exeAddr	4CA878h
sstrpart_empty	db	0

exeAddr	4CAD84h
patch124_begin:
	dd	0FFFFFFFFh
	dd	49
	db	' visit the official NFK web site (needforkill.ru)', 0
patch124_end:

exeAddr	4CB534h
DrawMenu_onConnect_connectStr	dd	0

exeAddr 4D21ACh
ResetMap:	nop

exeAddr 4D5C1Bh
patch221_begin:
    jmp     loc_4D5C28
patch221_end:

exeAddr 4D5C28h
loc_4D5C28: nop

exeAddr 4D5C48h
patch217_begin:
    call    new_FragBar
    jmp     loc_4D61BF
patch217_end:

exeAddr 4D61BFh
loc_4D61BF:     nop

exeAddr 4DA449h
patch181_begin:
	call	MapRestart_resetSpectators
patch181_end:

exeAddr 4DD579h
patch223_begin:
    push    eax
    mov     eax, g_players[eax * 4]
    lea     edx, [eax + 7Bh]    ;TPlayer.netname
    xor     eax, eax
    mov     al, [ebp - 7]
    push    eax
    mov     eax, g_players[eax * 4]
    call    FollowKillerSimpleDeathMessageHook
    jmp     loc_4DD5B9
patch223_end:

exeAddr 4DD5B9h
loc_4DD5B9:

exeAddr 4DE6F3h
patch226_begin:
    call    followPowerup
patch226_end:

exeAddr	4E39CCh
BNETWORK_TMP_PlayerPosUpdate_copy_fill: nop

exeAddr	4E4064h
BNETWORK_TMP_PlayerPosUpdate_fill:	nop

IFDEF _TEST
exeAddr	4E4804h
patch183_begin:
BNETWORK_Sv_PlayerPosUpdate_packed	proc
;------- locals --------------------
allPlayersData		EQU		<[ebp - 4]>		; PByte, size = 4
otherPlayersData	EQU		<[ebp - 8]>		; PByte, size = 4
i					EQU		<[ebp - 0Ch]>	; Integer, size = 4
leftPartSize		EQU		<[ebp - 10h]>	; Integer, size = 4
rightPartSize		EQU		<[ebp - 14h]>	; Integer, size = 4
allDataSize			EQU		<[ebp - 18h]>	; Integer, size = 4
otherDataSize		EQU		<[ebp - 1Ch]>	; Integer, size = 4
eachMsgSize			EQU		<[ebp - 20h]>	; byte[8], size = 8
eachPlayerIndex		EQU		<[ebp - 28h]>	; byte[8], size = 8
msgCount			EQU		<[ebp - 30h]>	; Integer, size = 4
;------- codes ---------------------
	push	ebp
	mov		ebp, esp
	sub		esp, 34h
	push	esi
	push	edi
	push	ebx
	; calculate max needed buffer size
	call	GetNumberOfPlayers
	test	eax, eax
	jz		noPlayers
	mov		i, eax
	imul	eax, 19		; 19 - sizeof(TMP_PlayerPosUpdate)
	add		eax, 2		; 2 - sizeof(TPlayerPosUpdate_Packed)
	push	eax
	; allocate two buffers: one for all players data (count = <players count>) which is sent to spectators
	;  and also holds position information of every player
	; and one buffer for all players data except one (count = <players count> - 1) to be sent to each player
	; also initialize TPlayerPosUpdate_Packed header
	call	GetMem
	mov		allPlayersData, eax
	mov		byte ptr [eax], MMP_PLAYERPOSUPDATE_PACKED
	lea		eax, [eax + 1]
	mov		ecx, i
	mov		byte ptr [eax], cl	; put players count into TPlayerPosUpdate_Packed.Count
	pop		eax
	call	GetMem
	mov		otherPlayersData, eax
	mov		byte ptr [eax], MMP_PLAYERPOSUPDATE_PACKED
	lea		eax, [eax + 1]
	mov		ecx, i
	dec		ecx
	mov		byte ptr [eax], cl	; put players count - 1 into TPlayerPosUpdate_Packed.Count
	; loop through all the players and add msg to allPlayersData.
	; Store the size of each msg in eachMsgSize array and the index of each player in eachPlayerIndex array
	mov		ebx, allPlayersData	; ebx - current msg pointer (inside buffer)
	lea		edi, eachMsgSize	; edi - current msg size offset
	lea		esi, eachPlayerIndex	; esi - current player index offset
	add		ebx, 2				; skip TPlayerPosUpdate_Packed buffer
	xor		eax, eax
	mov		i, eax
playersLoop:
	mov		edx, g_players[eax * 4]
	test	edx, edx
	jz		playersLoopContinue
	; store current player index and advance current player index pointer
	mov		[esi], al
	inc		esi
	; if player's InertiaY and Y didn't change, use PlayerPosUpdate_copy message
	fld		qword ptr [edx + 2c0h]	; 2c0h - TPlayer.InertiaY
	fcomp	qword ptr [edx + 338h]	; 338h - TPlayer.NET_LastInertiaY
	fnstsw	ax
	sahf
	jnz		@F
	fld		qword ptr [edx + 298h]	; 298h - TPlayer.Y
	fcomp	qword ptr [edx + 340h]	; 340h - TPlayer.NET_LastPosY low dword
	fnstsw	ax
	sahf
	jnz		@F
	; using TMP_PlayerPosUpdate_copy message
	mov		edx, ebx
	mov		eax, i
	call	BNETWORK_TMP_PlayerPosUpdate_copy_fill
	mov		eax, 13		; 13 - sizeof(TMP_PlayerPosUpdate_copy)
	mov		[edi], al	; store current message size (and advance current msg size pointer)
	inc		edi
	add		ebx, eax	; advance current msg pointer
	jmp		playersLoopContinue
@@:	; using TMP_PlayerPosUpdate message
	mov		edx, ebx
	mov		eax, i
	call	BNETWORK_TMP_PlayerPosUpdate_fill
	mov		eax, 19		; 19 - sizeof(TMP_PlayerPosUpdate)
	mov		[edi], al	; store current message size (and advance current msg size pointer)
	inc		edi
	add		ebx, eax	; advance current msg pointer
	; copy InertiaY into NET_LastInertiaY and Y into NET_LastPosY
	mov		eax, i
	mov		edx, g_players[eax * 4]
	mov		ecx, [edx + 2c0h]	; 2c0h - TPlayer.InertiaY lo dword
	mov		eax, [edx + 2c4h]	; 2c4h - TPlayer.InertiaY hi dword
	mov		[edx + 338h], ecx	; 338h - TPlayer.NET_LastInertiaY lo dword
	mov		[edx + 33ch], eax	; 33ch - TPlayer.NET_LastInertiaY hi dword
	mov		ecx, [edx + 298h]	; 298h - TPlayer.Y lo dword
	mov		eax, [edx + 29Ch]	; 29ch - TPlayer.Y hi dword
	mov		[edx + 340h], ecx	; 340h - TPlayer.NET_LastY lo dword
	mov		[edx + 344h], eax	; 344h - TPlayer.NET_LastY hi dword
playersLoopContinue:
	inc		dword ptr i
	mov		eax, i
	cmp		eax, 8
	jl		playersLoop
	; calculate allDataSize and msgCount
	mov		eax, allPlayersData
	lea		ecx, eachMsgSize
	sub		ebx, eax
	sub		edi, ecx
	mov		allDataSize, ebx
	mov		msgCount, edi
	dec		edi
	jz		onlyOnePlayer	; no need to send player pos updates to players, if there is only one player
	; send each player positions of other players. Use single buffer otherPlayersData for sending,
	;  copy appropriate messages with info on other players positions from allPlayersData:
	;  first player will get 2nd, 3rd, 4th ... messages
	;  second player will get 1st, 3rd, 4th ... messages
	;  third player will get 1st, 2nd, 4th and so on
	; the algorithm is really hard to explain, try to figure the rest from the code
	; otherPlayersData buffer is made of 2 parts - left one and right one. In the left part there are messages about players
	;  whose indexes are lesser than index of current player (to whom the message will be sent). In the right part there are
	;  messages about players with indexes that are greater than that of the current player. For the first player, left part is
	;  empty, and the right part contains info about all players but the first one.

	; initially rightPartSize will be equal to the size of all messages, it will be reduced right before the data is sent
	mov		rightPartSize, ebx
	; esi points to the message with current player's position. It will be ignored, and the rest will be copied to the right part
	mov		esi, allPlayersData
	; edi points to the place in otherPlayersData where the right part will be copied
	mov		edi, otherPlayersData
	; ebx points to the size of current player's message
	lea		ebx, eachMsgSize
	add		esi, 2			; 2 - sizeof(TPlayerPosUpdate_Packed)
	add		edi, 2
	xor		eax, eax
	; initially, left part is empty
	mov		leftPartSize, eax
	mov		i, eax
playersLoop2:
	xor		eax, eax
	mov		al, [ebx]	; read msg size
	mov		edx, edi	; dest = right part
	mov		ecx, rightPartSize
	sub		ecx, eax	; count = right part size (previous size - size of current player's message)
	mov		rightPartSize, ecx
	jz		@F
	add		eax, esi	; src = positions of next player's message
	call	Move		; copy right part
@@:
	mov		eax, i
	lea		edx, eachPlayerIndex
	mov		al, [edx + eax]		; get current player's index
	mov		eax, g_players[eax * 4]
	cmp		byte ptr [eax + 274h], 1	; 274 - TPlayer.netobject
	jnz		dontSend					; don't send anything to local players
	; size of packet = right part size + left part size + 2
	mov		ecx, rightPartSize
	add		ecx, leftPartSize
	add		ecx, 2					; 2 - sizeof(TPlayerPosUpdate_Packed)
	push	dword ptr otherPlayersData	; data to send
	push	ecx						; size
	xor		ecx, ecx
	push	ecx						; importance flag (not important)
	mov		cx, [eax + 242h]		; 242 - TPlayer.Port
	lea		edx, [eax + 141h]		; 141 - TPlayer.ip_addr
	mov		eax, mainform
	call	BNETSendData2IP_		; send to current player
dontSend:
	; copy current player's position info to the left part
	xor		ecx, ecx
	mov		cl, [ebx]			; count = current message's size
	mov		eax, esi			; src = current player's message
	add		leftPartSize, ecx	; increase leftPartSize
	mov		edx, edi			; dest = right part buffer (it's ok, last message of the left part lies exactly
								;  where first message of right part was located)
	add		esi, ecx			; move esi to next player's message
	add		edi, ecx			; update right part pointer
	call	Move				; move current player's message to the left part
	inc		dword ptr i
	inc		ebx					; advance messageSize pointer
	mov		al, i
	cmp		al, msgCount
	jb		playersLoop2
onlyOnePlayer:

	; send all players info to spectators
	mov		eax, SpectatorList
	cmp		dword ptr [eax + 8], 0	; 8 - TList.Count
	jle		noSpectators
	mov		ebx, [eax + 8]
	mov		edi, allDataSize
	mov		esi, allPlayersData
	xor		edx, edx
	mov		i, edx
spectatorsLoop:
	; spectator index should be in edx at this point
	push	esi		; data to send
	push	edi		; length of data to send
	push	0		; urgency flag
	mov		eax, SpectatorList
	call	TList_Get
	xor		ecx, ecx
	mov		edx, [eax + 1Fh]		; 1Fh - TSpectator.address
	mov		cx, [eax + 30h]			; 30h - TSpectator.port
	mov		eax, mainform
	call	BNETSendData2IP_
	inc		dword ptr i
	mov		edx, i
	cmp		edx, ebx
	jnz		spectatorsLoop
noSpectators:
	mov		eax, allPlayersData
	call	FreeMem
	mov		eax, otherPlayersData
	call	FreeMem
noPlayers:
	pop		ebx
	pop		edi
	pop		esi
	mov		esp, ebp
	pop		ebp
	retn
BNETWORK_Sv_PlayerPosUpdate_packed	endp
patch183_end:
ENDIF

IFNDEF _TEST
exeAddr 4E5735h	;removed in 077 rev3
patch5_begin:
jmp     l4E5751	;removed in 077 rev3
patch5_end:
ELSE
exeAddr 4E573Eh		; added in 077 rev3
patch5_begin:
jmp		l4E5747		; added in 077 rev3
patch5_end:
ENDIF

exeAddr 4E5747h
l4E5747:	nop

exeAddr 4E5751h
l4E5751:    nop

exeAddr 4E59CCh
CanSpectate:    nop

exeAddr 4E8BC9h
patch225_begin:
    call    nextplayer_ex
patch225_end:

exeAddr 4E9098h
patch205_begin:
resolutionCheck proc
    jmp     newResolutionCheck
resolutionCheck endp
patch205_end:

exeAddr 4E9120h
    dd  0FFFFFFFFh
    dd  45
str_r_mode_is_not_allowed    db '^5r_mode ^7is ^1NOT ALLOWED ^7on this server.',0

exeAddr	4E9164h
patch132_begin:
	nop
	nop
	nop
	nop
	nop
	nop
patch132_end:


exeAddr 4E9390h
l4E9390:    nop

exeAddr	4E9725h
patch126_begin:
	jmp	DXTimerTimer_isInConsole
patch126_end:

exeAddr	4E9787h
DXTimerTimer_isInConsole:	nop

exeAddr 4EEB65h
patch224_begin:
    call    onFrame
patch224_end:

exeAddr 4EEFB3h
patch18_begin:
cmp     gametic, 31h
patch18_end:

;new realization of part of DXTimerTimer code
exeAddr 4EF281h
patch31_begin:
secondTick	proc
	call	ismultip
	cmp		al, 2
	jnz		new_notClient
	mov		eax, STIME
	mov		starttime, eax
l4EF298:
    push    esi
    push    edi
    xor     eax, eax
    mov     [ebp-0Ch], eax
powerupsLoop:                   ;old address = 4ef29d
    mov     edi, g_players
    mov     eax, [ebp-0Ch]
    cmp     dword ptr [edi+eax*4], 0
    jz      powerupsLoopCont
    mov     edi, [edi+eax*4]
    cmp     byte ptr [edi+4], 0
    jnz     powerupsLoopCont
    ;4ef2e3
    lea     esi, [edi+270h]
    cmp     byte ptr [esi+6], 0
    jz      @F
    cmp     dword ptr [edi+50h], 200
    jae     @F
    push    dword ptr [esi+24h]
    push    dword ptr [esi+20h]
    push    dword ptr [esi+2Ch]
    push    dword ptr [esi+28h]
    mov     eax, 30h
    call    playsound
    mov     byte ptr [esi+0Dh], 0Fh
@@:
    ;4ef378
    xor     ecx, ecx
    cmp     [esi+5], ch
    setnz   cl
    sub     [esi+5], cl
    ;4ef3cb
    cmp     byte ptr [esi+5], 3
    jnz     @F
    push    dword ptr [esi+24h]
    push    dword ptr [esi+20h]
    push    dword ptr [esi+2Ch]
    push    dword ptr [esi+28h]
    mov     ax, 8
    call    playsound
@@:
    ;4ef41d
    movzx   eax, byte ptr [esi+8]
    cmp     al, 4
    ja      @F
    cmp     al, 1
    jbe     @F
    push    dword ptr [esi+24h]
    push    dword ptr [esi+20h]
    push    dword ptr [esi+2Ch]
    push    dword ptr [esi+28h]
    mov     ax, 3Ah
    call    playsound
@@:
    ;4ef4a0
    movzx   eax, byte ptr [esi+7]
    cmp     al, 4
    ja      @F
    cmp     al, 1
    jbe     @F
    push    dword ptr [esi+24h]
    push    dword ptr [esi+20h]
    push    dword ptr [esi+2Ch]
    push    dword ptr [esi+28h]
    mov     ax, 3Ah
    call    playsound
@@:
    ;4ef530
    movzx   eax, byte ptr [esi+9]
    cmp     al, 4
    ja      @F
    cmp     al, 1
    jbe     @F
    push    dword ptr [esi+24h]
    push    dword ptr [esi+20h]
    push    dword ptr [esi+2Ch]
    push    dword ptr [esi+28h]
    mov     ax, 3Ah
    call    playsound
@@:
    ;4ef5b3
    xor     ecx, ecx
    cmp     [esi+6], ch
    setnz   cl
    sub     [esi+6], cl
    ;4ef5f2
    cmp     [esi+8], ch
    setnz   cl
    sub     [esi+8], cl
    ;4ef631
    cmp     [esi+0Ah], ch
    setnz   cl
    sub     [esi+0Ah], cl
    ;4ef670
    cmp     [esi+7], ch
    setnz   cl
    sub     [esi+7], cl
    ;4ef6af
    cmp     [esi+9], ch
    setnz   cl
    sub     [esi+9], cl
    ;4ef6ee
    mov     eax, edi
    call    IsWaterContentHEAD
    test    al, al
    jz      powerupsLoopCont
    cmp     byte ptr [edi+12h], 0
    jnz     powerupsLoopCont
    mov     eax, edi
    call    SpawnBubble
powerupsLoopCont:
    add     byte ptr [ebp-0Ch], 1
    cmp     byte ptr [ebp-0Ch], 8
    jnz     powerupsLoop
;---------------- Pingers ---------------------
	xor		eax, eax
	mov		al, OPT_NETSPECTATOR
	test	eax, eax
	jnz		isSpectator
    mov     [ebp-0Ch], eax
pingLoop:
    mov     edi, g_players
    mov     eax, [ebp-0Ch]
    cmp     dword ptr [edi+eax*4], 0
    je      pingLoopCont
    mov     edi, [edi+eax*4]
    cmp     byte ptr [edi+274h], 0		;TPlayer.netobject
    jnz     pingLoopCont
    ;sending ping
    ;ping packet:
    ;
    ;0      1      3      5          9          0Bh
    ;--------------------------------------------
    ;| data | ping | dxid | checksum | gametime |  Size == 11
    ;--------------------------------------------
    ;
    sub     esp, 0Ch
    mov     byte ptr [esp], MMP_PING    ;data
    movzx   eax, word ptr [edi+356h]
    mov     [esp+1], ax                 ;ping
    movzx   eax, word ptr [edi+28Ch]
    mov     [esp+3], ax                 ;dxid
    movzx   eax, byte ptr checksumDelay
    test    eax, eax
    jnz     @F
    mov     eax, 401000h
    mov     edx, 147200h
    call    getChecksum
    mov     checksum, eax
    mov     checksumDelay, 5
@@:
    dec     checksumDelay
    mov     eax, checksum
    mov     [esp+5], eax
    mov     eax, gametime
    mov     [esp+9], ax
    mov     eax, STIME
    mov     pingsend_tick, eax
    mov     edx, esp
    xor     ecx, ecx
    mov     cl, 0Bh
    mov     eax, mainform
    push    0
    call    BNETSendData2HOST
    add     esp, 0Ch
    jmp     afterPing
pingLoopCont:
    add     byte ptr [ebp-0Ch], 1
    cmp     byte ptr [ebp-0Ch], 8
    jnz     pingLoop
	jmp		afterPing
isSpectator:
	sub		esp, 0Ch		; getting space for MMP_PING message buffer
	mov		byte ptr [esp], MMP_PING
	xor		eax, eax
	dec		eax
	mov		[esp + 1], eax	; set ping and dxid to 0FFFFh
	mov		[esp + 5], eax	; set checksum to 0FFFFFFFFh
	mov		[esp + 9], ax	; set gametime to 0FFFFh
	mov		edx, esp		; set pointer to message buffer
	xor		ecx, ecx
	mov		cl, 0Bh			; size of message
	mov		eax, mainform
	push	0				; not guaranteed (?)
	call	BNETSendData2HOST
	add		esp, 0Ch		; free message buffer
afterPing:
    pop     edi
    pop     esi
    jmp     endOfSecondEvent
new_notClient:
	jmp		secondTickNotClient
secondTick	endp

align 8
getChecksum proc
    push    ebx
    push    esi
    push    edi
    mov     esi, 0FFFFh
    mov     edi, esi
bigloop:
    mov     ecx, 168h
    cmp     edx, ecx
    cmovb   ecx, edx
    sub     edx, ecx
@@:
    movzx   ebx, byte ptr [eax]
    add     esi, ebx
    inc     eax
    add     edi, esi
    dec     ecx
    jne     @B
    movzx   ecx, si
    movzx   ebx, di
    shr     esi, 10h
    shr     edi, 10h
    add     esi, ecx
    add     edi, ebx
    test    edx, edx
    jne     bigloop
    mov     eax, edi
    movzx   edx, si
    shr     edi, 10h
    shr     esi, 10h
    add     eax, edi
    add     edx, esi
    pop     edi
    shl     eax, 10h
    pop     esi
    add     eax, edx
    pop     ebx
    retn
getChecksum endp
patch31_end:

exeAddr	4EF7F7h
secondTickNotClient:
patch144_begin:
	call	ismultip
	cmp		al, 1
	jnz		secondTickNotServer
	jmp		new_secondTickServer
patch144_end:

exeAddr	4EF812h
secondTickTimeoutPlayers:	nop

exeAddr	4F094Bh
secondTickNotServer:	nop

exeAddr 4F0FD9h
endOfSecondEvent:   nop

exeAddr 4F1210h
patch177_begin:
	call	checkHardTimelimit
patch177_end:

exeAddr	4F3080h
patch125_begin:
	dd	0FFFFFFFFh
	dd	23
	db	'messages at pff.clan.su', 0
patch125_end:

exeAddr	4F38E4h
AddMessage:		nop

IFDEF _DISABLED
exeAddr	4F7835h
patch149_begin:
	jmp		LOADMAP_ex
patch149_end:
ENDIF

exeAddr	4F7840h
LOADMAP_not_a_map:	nop

exeAddr	4F78D7h
LOADMAP_after_ex:	nop

exeAddr 4F8908h
patch32_begin:
	retn
patch32_end:

exeAddr 4FB45Ch
TMainForm_LoadGrafix:   nop

exeAddr	4FEFB3h
patch117_begin:
	call	newPrintNFKEngineVersion
patch117_end:

exeAddr	4FEFD4h
patch130_begin:
	nop
	nop
	nop
	nop
	nop
	nop
	nop
patch130_end:

exeAddr 4FF4BAh
FormCreate_fail:    nop

; FormCreate hook
exeAddr 50026Eh
patch135_begin:
	jmp		FormCreate_extensions
patch135_end:

exeAddr 500275h
FormCreate_after_extensions:    nop

exeAddr	500697h
patch131_begin:
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
patch131_end:

FireRocket proc
;----------- local variables -------
f       EQU     <[ebp - 4]>
;----------- codes -----------------
;... this is not an entire function code

; add fireID at the end of the MMP_CLIENTSHOT message and make it important
exeAddr 50166Ah
patch197_begin::
    mov     esi, f
    mov     al, [esi + 1Fh]     ;TPlayer.ammo_rl
    mov     ah, WEAPON_ROCKETLAUNCHER
    call    sendClientShotMsg
    jmp     exit

align 16
; this will be a common code for message sending. It has 7 copies in NFK code, all differs with just 2 variables: ammo left and weapon index
;   before jumping here, put ammo left to al and weapon index to ah. Also put player address in esi
sendClientShotMsg::
    ; better use our own stack frame here
    push    ebp
    mov     ebp, esp
    sub     esp, 20h
;----------- local variables -------
msgSize     EQU     <[ebp - 4]>
weapony     EQU     <[ebp - 8]>
;-----------------------------------
    mov     edi, esp                    ; address for message struct will be in edi
    mov     word ptr msgSize, 15h       ; new TMP_ClientShot size
    ; rail shot messages are a bit different from other weapon's shot messages
    .if ah == WEAPON_RAILGUN
        mov     byte ptr [edi], MMP_CLIENTRAILSHOT
        ; there's no index field, but a railcolor field, and it's stored in cl at this point
        mov     [edi + 1], cl       ;TMP_RailShot.Color
    .else
        mov     byte ptr [edi], MMP_CLIENTSHOT  ;TMP_ClientShot.Data
        mov     [edi + 1], ah       ;TMP_ClientShot.Index
    .endif
    inc     al
    mov     [edi + 2], al           ;TMP_ClientShot.Ammo
    mov     ax, [esi + 28Ch]        ;TPlayer.DXID
    mov     [edi + 3], ax           ;TMP_ClientShot.DXID

    fld     qword ptr [esi + 48h]   ;TPlayer.clippixel
    call    Round
    mov     [edi + 5], ax           ;TMP_ClientShot.clippixel

    fld     qword ptr [esi + 290h]  ;TPlayer.x
    fstp    dword ptr [edi + 7]     ;TMP_ClientShot.x

    .if byte ptr [esi + 0FAh] != 0  ;TPlayer.crouch
        mov     dword ptr weapony, 3
    .else
        mov     dword ptr weapony, -5
    .endif
    fild    dword ptr weapony
    fadd    qword ptr [esi + 298h]  ;TPlayer.y
    fstp    dword ptr [edi + 0Bh]   ;TMP_ClientShot.y

    .if byte ptr [esi + 0Ch] == 1 || byte ptr [esi + 0Ch] == 3  ;TPlayer.dir
        fld     qword ptr [esi + 298h]  ;TPlayer.y
        fsub    qword ptr [esi + 2A8h]  ;TPlayer.cy
        fild    dword ptr weapony
        faddp   st(1), st
        add     esp, -0Ch
        fstp    tbyte ptr [esp]
        fld     qword ptr [esi + 290h]  ;TPlayer.x
        fsub    qword ptr [esi + 2A0h]  ;TPlayer.cx
        add     esp, -0Ch
        fstp    tbyte ptr [esp]
        call    Math__ArcTan2
        add     esp, -0Ch
        fstp    tbyte ptr [esp]
        call    Math__RadToDeg
        fsub    single90
        fstp    dword ptr [edi + 0Fh]   ;TMP_ClientShot.fangle
    .else
        fld     qword ptr [esi + 298h]  ;TPlayer.y
        fsub    qword ptr [esi + 2A8h]  ;TPlayer.cy
        fild    dword ptr weapony
        faddp   st(1), st
        add     esp, -0Ch
        fstp    tbyte ptr [esp]
        fld     qword ptr [esi + 290h]  ;TPlayer.x
        fsub    qword ptr [esi + 2A0h]  ;TPlayer.cx
        fsub    single1
        add     esp, -0Ch
        fstp    tbyte ptr [esp]
        call    Math__ArcTan2
        add     esp, -0Ch
        fstp    tbyte ptr [esp]
        call    Math__RadToDeg
        fsub    single90
        fstp    dword ptr [edi + 0Fh]   ;TMP_ClientShot.fangle
    .endif
    mov     ax, word ptr shotCounter
    mov     [edi + 13h], ax
    inc     shotCounter
    push    1   ; important message
    mov     edx, edi
    mov     cx, msgSize
    mov     eax, mainform
    call    BNETSendData2HOST
    mov     esp, ebp
    pop     ebp
    retn
patch197_end::

;...

exeAddr 50203Fh
exit:   nop

;----------- datas -----------------
exeAddr 502048h
single90    dd  90.0
single1     dd  1.0
FireRocket endp

FireBFG proc
;----------- local variables -------
f       EQU     <[ebp - 4]>
;----------- codes -----------------
;... this is not an entire function code

; add fireID at the end of the MMP_CLIENTSHOT message and make it important
exeAddr 50211Eh
patch198_begin::
    mov     esi, f
    mov     al, [esi + 23h]     ;TPlayer.ammo_bfg
    mov     ah, WEAPON_BFG
    call    sendClientShotMsg
    jmp     exit
patch198_end::
;...
exeAddr 502AABh
exit:   nop
;...
FireBFG endp

FirePlasma proc
;----------- local variables -------
f       EQU     <[ebp - 4]>
;----------- codes -----------------
;... this is not an entire function code

; add fireID at the end of the MMP_CLIENTSHOT message and make it important
exeAddr 502B8Ah
patch199_begin::
    mov     esi, f
    mov     al, [esi + 22h]     ;TPlayer.ammo_pl
    mov     ah, WEAPON_PLASMAGUN
    call    sendClientShotMsg
    jmp     exit
patch199_end::
;...
exeAddr 50361Bh
exit:   nop
;...
FirePlasma endp

FireRail proc
;----------- local variables -------
f       EQU     <[ebp - 4]>
;----------- codes -----------------
;... this is not an entire function code

; add fireID at the end of the MMP_CLIENTSHOT message and make it important
exeAddr 503715h
patch204_begin::
    mov     esi, f
    mov     al, [esi + 21h]     ;TPlayer.ammo_rg
    mov     ah, WEAPON_RAILGUN
    ; rail shot message is very much like other weapons shot messages, it just doesn't specify the weaponID (b/c it's useless)
    ;  and instead of weaponID it sends the color of the rail. Put the color in cl, and sendClientShotMsg will figure everything out
    .if byte ptr [esi + 0Dh] == 0
        mov     cl, OPT_RAILCOLOR1
    .else
        mov     cl, OPT_RAILCOLOR2
    .endif
    call    sendClientShotMsg
    jmp     exit
patch204_end::
;...
exeAddr 50401Fh
exit:   nop
;...
FireRail endp

FireShotGun proc
;----------- local variables -------
f       EQU     <[ebp - 4]>
;----------- codes -----------------
;... this is not an entire function code

; add fireID at the end of the MMP_CLIENTSHOT message and make it important
exeAddr 5040FDh
patch200_begin::
    mov     esi, f
    mov     al, [esi + 1Dh]     ;TPlayer.ammo_sg
    mov     ah, WEAPON_SHOTGUN
    call    sendClientShotMsg
    jmp     exit
patch200_end::
;...
exeAddr 50484Ah
exit:   nop
;...
FireShotGun endp

FireShaft proc
;----------- local variables -------
f       EQU     <[ebp - 4]>
;----------- codes -----------------
;... this is not an entire function code

; add fireID at the end of the MMP_CLIENTSHOT message and make it important
exeAddr 50512Bh
patch201_begin::
    mov     esi, f
    mov     al, [esi + 20h]     ;TPlayer.ammo_sh
    mov     ah, WEAPON_SHAFT
    call    sendClientShotMsg
    jmp     exit
patch201_end::
;...
exeAddr 50597Ch
exit:   nop
;...
FireShaft endp

FireMachine proc
;----------- local variables -------
f       EQU     <[ebp - 4]>
;----------- codes -----------------
;... this is not an entire function code

; add fireID at the end of the MMP_CLIENTSHOT message and make it important
exeAddr 505F71h
patch202_begin::
    mov     esi, f
    mov     al, [esi + 1Ch]     ;TPlayer.ammo_mg
    mov     ah, WEAPON_MACHINEGUN
    call    sendClientShotMsg
    jmp     exit
patch202_end::
;...
exeAddr 506619h
exit:   nop
;...
FireMachine endp

FireGren proc
;----------- local variables -------
f       EQU     <[ebp - 4]>
;----------- codes -----------------
;... this is not an entire function code

; add fireID at the end of the MMP_CLIENTSHOT message and make it important
exeAddr 5066FAh
patch203_begin::
    mov     esi, f
    mov     al, [esi + 1Eh]     ;TPlayer.ammo_gl
    mov     ah, WEAPON_GRENADELAUNCHER
    call    sendClientShotMsg
    jmp     exit
patch203_end::
;...
exeAddr 507695h
exit:   nop
;...
FireGren endp

TMainForm_FormKeyUp proc
PKey    EQU     <[ebp - 8]>
res     EQU     <[ebp - 0Ch]>
;...

; here goes processing of key aliases
exeAddr 5084E8h
patch192_begin::
    cmp     inmenu, 0
    jnz     aliasProcessing_end
    cmp     INCONSOLE, 0
    jnz     aliasProcessing_end
    mov     eax, PKey
    movzx   eax, byte ptr [eax]
    .if MESSAGEMODE != 0
        cmp     ax, 13
        jnz     aliasProcessing_end
    .endif
    mov     eax, KEYALIASES[eax * 4]
    test    eax, eax
    jz      aliasProcessing_end
    mov     dx, [eax]
    cmp     dx, '1'
    jz      aliasProcessing_end
    mov     HIST_DISABLE, 1
    .if MSG_DISABLE != 0
        mov     dword ptr res, 1
    .else
        mov     dword ptr res, 0
    .endif
    .if MATCH_DDEMOPLAY != 0
        mov     MSG_DISABLE, 1
    .else
        mov     MSG_DISABLE, 0
    .endif
    mov     ALIASCOMMAND, 1
    call    ApplyCommand
    mov     ALIASCOMMAND, 0
    mov     HIST_DISABLE, 0
    .if dword ptr res == 1
        mov     MSG_DISABLE, 1
    .else
        mov     MSG_DISABLE, 0
    .endif
aliasProcessing_end:
    jmp     aliasProcessing_realend
patch192_end::
exeAddr 5085C3h
aliasProcessing_realend:
;...
TMainForm_FormKeyUp endp

exeAddr	508B54h
patch140_begin:	; ending of TestIP function
	jmp		add_TestIP
patch140_end:

exeAddr	509174h
BNET_NFK_ReceiveData:	nop		; eax - mainform	TMainForm
								; edx - data		Pointer
								; ecx - address		ShortString
								; push- port		Integer
								; push- dataSize	Integer

exeAddr 5091ADh
patch166_begin:
	jmp		BNET_NFK_ReceiveData_localIPCheckEnd
patch166_end:

exeAddr 5091DBh
BNET_NFK_ReceiveData_localIPCheckEnd:	nop

exeAddr	50926Bh
patch134_begin:
	jmp		BNET_NFK_ReceiveData_PacketFilter
patch134_end:

exeAddr	509272h
BNET_NFK_ReceiveData_afterPacketFilter:	nop

exeAddr 5094ACh
patch159_begin:
	dd		offset BNET_NFK_ReceiveData_on_MMP_CTF_EVENT_FLAGDROP
patch159_end:

exeAddr	509612h
patch75_begin:
	call	BNET_NFK_ReceiveData_on_MMP_INVITE_connectEx
patch75_end:

exeAddr	50984Ah
patch54_begin:
	jmp		BNET_NFK_ReceiveData_new_on_MMP_LOBBY_GAMESTATE_RESULT_beforeConcat
patch54_end:

exeAddr	509860h
BNET_NFK_ReceiveData_on_MMP_LOBBY_GAMESTATE_RESULT_afterConcat:	nop

exeAddr 509927h
patch52_begin:
BNET_NFK_ReceiveData_on_MMP_LOBBY_ANSWERPING:
	jmp		BNET_NFK_ReceiveData_new_on_MMP_LOBBY_ANSWERPING
patch52_end:

exeAddr 509B49h
patch39_begin:
IFDEF _TEST
PROTO_VERSION db 03,'t77'
ELSE
PROTO_VERSION db 03,'077'
ENDIF
patch39_end:

exeAddr	509FF2h
patch41_begin:
	mov		edx, offset PROTO_VERSION
patch41_end:

IFDEF _DISABLED
exeAddr	50A15Ah
patch154_begin:
	call	BNET_NFK_ReceiveData_on_MMP_GAMESTATEANSWER_mapNotFound_ex
patch154_end:
ENDIF

exeAddr	50A3E4h
patch70_begin:
	mov		eax, offset BNET_OLDGAMEIP
	mov		edx, offset BNET_GAMEIP
	call	PStrCpy
	mov		eax, [ebp + 0Ch]		; Port
	mov		BNET_SERVERPORT, ax
	call	SpawnServer
	jmp		BNET_ReceiveData_on_MMP_GAMESTATEANSWER_afterSpawnServer
patch70_end:

exeAddr	50A40Dh
BNET_ReceiveData_on_MMP_GAMESTATEANSWER_afterSpawnServer: nop

exeAddr 50AC12h
patch216_begin:
    call    BNET_NFK_ReceiveData_on_MMP_SPECTATORDISCONNECT_ext
patch216_end:

exeAddr 50AE31h
patch215_begin:
    call    BNET_NFK_ReceiveData_on_MMP_SPECTATORCONNECT_ext
patch215_end:

exeAddr	50B3A4h
patch129_begin:
	jmp		BNET_NFK_ReceiveData_on_MMP_REGISTERPLAYER_dontShowWindow
patch129_end:

exeAddr	50B3BDh
BNET_NFK_ReceiveData_on_MMP_REGISTERPLAYER_dontShowWindow: nop

exeAddr 50CA9Eh
patch14_begin:
IFNDEF _TEST
jmp     l50CAA7	;removed in 077 rev3
ELSE
jmp		l50CAE5		; added in 077 rev3
ENDIF
patch14_end:

exeAddr 50CAA7h
l50CAA7:    nop

exeAddr 50CAE5h
l50CAE5:	nop

exeAddr 50CAFDh
patch15_begin:
IFNDEF _TEST
jmp     l50CB06	;removed in 077 rev3
ELSE
jmp		l50CB44		; added in 077 rev3
ENDIF
patch15_end:

exeAddr 50CB06h
l50CB06:    nop

exeAddr 50CB44h
l50CB44:	nop

IFDEF _DISABLED
exeAddr	50EB58h
patch155_begin:
	call	BNET_NFK_ReceiveData_on_MMP_DAMAGEPLAYER_ex
patch155_end:
ENDIF

exeAddr	50EB64h
BNET_NFK_ReceiveData_on_MMP_DAMAGEPLAYER_after_ex:	nop

exeAddr 50ECC0h
patch182_begin:
	mov		edx, g_players[edx * 4]
	test	edx, edx
	jz		BNET_NFK_ReceiveData_on_MMP_DAMAGEPLAYER_no_hitsnd
	jmp		@F
patch182_end:
exeAddr 50ECD1h
@@:	nop

exeAddr 50ED69h
BNET_NFK_ReceiveData_on_MMP_DAMAGEPLAYER_no_hitsnd: nop

exeAddr 50F49Fh
patch222_begin:
    push    eax
    mov     eax, g_players[eax * 4]
    lea     edx, [eax + 7Bh]    ;TPlayer.netname
    mov     eax, [ebp - 34h]
    push    eax
    mov     eax, g_players[eax * 4]
    call    FollowKillerSimpleDeathMessageHook
    jmp     BNET_NFK_ReceiveData_default
patch222_end:

exeAddr 512CBAh
patch168_begin:
	jmp		BNET_NFK_ReceiveData_on_MMP_CL_OBJDESTROY_isPlasma
patch168_end:

exeAddr 512CE4h
BNET_NFK_ReceiveData_on_MMP_CL_OBJDESTROY_isPlasma:	nop

exeAddr 513B8Bh
patch142_begin:
    jmp		on_MMP_PING_distribute
patch142_end:

exeAddr	513B99h
patch33_begin:
on_MMP_PING_do_distribute:
	lea		eax, [ebp - 2FFh]	;buf
	mov		ecx, [ebp + 8]		;DataSize
	mov		edx, [ebp - 8]
	call	CopyMemory
	lea		eax, [ebp - 2FFh]	;buf
	push	eax
	push	[ebp + 8]           ;DataSize
	push	0
	mov		ecx, [ebp + 0Ch]	;Port
patch33_end:

exeAddr	513BC9h
patch196_begin:
on_MMP_PING_no_distribute   proc
    xor     ecx, ecx
    mov     edi, [ebp - 8]  ;data
    mov     dx, [edi + 3]   ;TMP_Ping.DXID
playersLoop:
    mov     eax, g_players[ecx * 4]
    test    eax, eax
    jz      playersLoopContinue
    cmp     dx, [eax + 28Ch]    ;TPlayer.DXID
    jnz     playersLoopContinue
    mov     dx, [edi + 1]
    mov     [eax + 356h], dx
    mov     edx, [edi + 5]
    mov     [eax + 368h], edx
    movzx   edx, word ptr [edi + 9]
    mov     ecx, gametime
    sub     edx, ecx
    mov     [eax + 36Ch], edx
    jmp     playersLoopBreak
playersLoopContinue:
    inc     ecx
    cmp     cl, 8
    jnz     playersLoop
playersLoopBreak:
    jmp     on_MMP_PING_answer
on_MMP_PING_no_distribute   endp
patch196_end:

IFDEF _PINGER
exeAddr 513BCEh
onMMP_PING2	proc
patch34_begin::
	mov		edi, [ebp - 8]
	xor		ecx, ecx
playerloop:
	mov		esi, [g_players + ecx * 4]
	test	esi, esi
	jz		playerloop_cont
	mov		ax, [esi + 28Ch]	;TPlayer.dxid
	cmp		ax, [edi + 3]		;TPingPacket.dxid
	jnz		playerloop_cont
	add		esi, 356h
	mov		ax, [edi + 1]		;TPingPacket.ping
	mov		[esi], ax			;TPlayer.ping
	cmp		byte ptr [ebp + 8], 0Bh
	jnz		playerloop_break
	mov		eax, [edi + 5]		;TPingPacket.crc
	cmp		eax, [esi + 12h]
	je		@F
	mov		[esi + 12h], eax	;TPlayer.crc
	call	crcChanged
@@:
	xor		eax, eax
	mov		ax, [edi + 9]		;TPingPacker.gametime
	sub		eax, gametime
	cmp		eax, [esi + 16h]	;TPlayer.time_delta
	je		playerloop_break
	mov		[esi + 16h], eax
	call	deltaChanged
	jmp		playerloop_break

exeAddr	513C30h
playerloop_cont:
	inc		ecx
	cmp		cl, 8
	jnz		playerloop
patch34_end::
playerloop_break:
onMMP_PING2	endp
ENDIF

exeAddr 513C36h
on_MMP_PING_answer: nop

exeAddr 513D75h
patch167_begin:
on_MMP_THROWPLAYER:
	jmp 	on_MMP_THROWPLAYER_afterIPCheck
patch167_end:

exeAddr 513DAFh
on_MMP_THROWPLAYER_afterIPCheck:

exeAddr 515A83h
patch160_begin:
BNET_NFK_ReceiveData_on_MMP_CTF_EVENT_FLAGDROP:
	mov		edx, [ebp - 8]		; data
	mov		ecx, [ebp + 8]		; DataSize
	call	CTF_CLNETWORK_DropFlag
	jmp		BNET_NFK_ReceiveData_default
patch160_end:

exeAddr	516895h
BNET_NFK_ReceiveData_default:	nop

exeAddr	516B48h
BNET_NFK_ReceiveData_nullStr	dd	0

exeAddr	516D50h
sstrpart_opening_parentheses	db	1,'(',0

exeAddr	516DECh
str_droppedByTimeout	db	0	; shortstring ' ^7^ndropped by timeout.'

exeAddr	516E54h
str_Spectator	db	0	; shortstring 'Spectator '

; stop using BNET_REALSERVERPORT, use BNET_SERVERPORT instead
exeAddr 5175F3h
patch193_begin:
    mov     BNET_SERVERPORT, ax
patch193_end:

exeAddr	517609h
patch67_begin:
	jmp		SPAWNCLIENT_portsEqual
patch67_end:

exeAddr	517625h
SPAWNCLIENT_portsEqual:		nop

exeAddr	517647h
patch68_begin:
	jmp		SPAWNCLIENT_portsEqual2
patch68_end:

exeAddr	51766Ah
SPAWNCLIENT_portsEqual2:	nop

exeAddr	517688h
patch69_begin:
	jmp		SPAWNCLIENT_portsEqual3
patch69_end:

exeAddr	5176A7h
SPAWNCLIENT_portsEqual3:	nop

exeAddr	51A773h
patch147_begin:
	call	SaveCFG_ext
patch147_end:

exeAddr	51C320h
GammaAnimation:	nop

exeAddr 51CD74h
reloadPlayerModels: nop

exeAddr	51D46Ch
ALIAS_SaveAlias:	nop

exeAddr 51D7F4h
changeResolution:   nop

exeAddr 51DA5Ch
ApplyCommand:   nop

exeAddr	51E8A0h
patch112_begin:
	call	newApplyCommand_on_reconnect
patch112_end:

exeAddr	51EC19h
patch110_begin:
	jmp		applyCommand_notWireframe
patch110_end:

exeAddr	51EC76h
applyCommand_notWireframe:	nop

exeAddr	51ED33h
patch118_begin:
	call	newPrintNFKEngineVersion
patch118_end:

exeAddr 5203F3h
patch210_begin:
    jmp     newRModeHandler
patch210_end:

exeAddr 5206CDh
patch211_begin:
    call    newGofullscreen
    jmp     applyCommand_exit
patch211_end:

exeAddr 524B55h
patch178_begin:
	jmp		ApplyCommand_onRestart_playersOk
patch178_end:

exeAddr 524B6Dh
ApplyCommand_onRestart_playersOk:

exeAddr 533D8Bh
patch212_begin:
    jmp     loc_533D9B
patch212_end:

exeAddr 533D9Bh
loc_533D9B:

exeAddr	536BF9h
patch173_begin:
	jmp		ApplyCommand_onMap_ex
patch173_end:

exeAddr 536BFEh
	ApplyCommand_beginChangeMap:	nop

exeAddr	53A359h
patch145_begin:
	jmp		applyCommand_ext
patch145_end:
applyCommand_after_ext:	nop

exeAddr	53A41Ch
applyCommand_exit:	nop

exeAddr 53BB54h
lstrpart_x      db      'x', 0

exeAddr	53CC9Ch
lstrpart_doublequote	db '"', 0

exeAddr	53D4ACh
lstrpart_invalid_value_dq	db 'invalid value "', 0

exeAddr	53D6C4h
lstrpart_dq_is_dq		db '" is "', 0

exeAddr	53E1B8h
lstrpart_dq_is_set_to_dq	db '" is set to "', 0

exeAddr 53FCE0h
patch213_begin:
    dd      0FFFFFFFFh
    dd      41
    db      '". Default is "10". Possible value 1-255.', 0
patch213_end:

exeAddr 542134h
ApplyHCommand:	nop

exeAddr 542700h
TMainForm_FinalizeAll:  nop

exeAddr 5428E8h
patch174_begin:
	jmp		MainForm_FormKeyDown_ignoreAlt
patch174_end:

exeAddr	5428F1h
MainForm_FormKeyDown_ignoreAlt:	nop

exeAddr	543F30h
patch120_begin:
	call	newGetSystemVariable_getNfkversion
	nop
patch120_end:

exeAddr	5446C4h
NFKPlanet_GetTok:	nop

;------- NFKPlanet_ParseServerData fixes ---
exeAddr	5447EFh
; allocating buffer for server port
patch47_begin:
	mov		ecx, 5
patch47_end:

; jump to procedure of extracting port from planet data (ext)
exeAddr	5448B2h
patch45_begin:
	jmp		NFKPlanet_ParseServerData_ext
patch45_end:

; return address from ext procedure
exeAddr	5448BAh
NFKPlanet_ParseServerData_StartStrcat:	nop

; concatenating 13 strings instead of 11
exeAddr	5448BDh
patch46_begin:
	mov		edx, 0Dh
patch46_end:

; clean up buffer for server port
exeAddr	5448E8h
patch48_begin:
	lea		eax, [ebp - 28h]
	mov		edx, 0Ah
patch48_end:

exeAddr	544918h
NFKPlanet_ParseServerData_emptyStr	dd	0
;-------------------------------------------

exeAddr	5449C7h
patch40_begin:
	jmp		NFKPlanet_ParseResponse_versionNotOK
patch40_end:

exeAddr	544A10h
patch122_begin:
NFKPlanet_ParseResponse_versionNotOK:
	mov		ecx, offset aNFKPlanetTooOld
	nop
	nop
	nop
	nop
patch122_end:

exeAddr	544C04h
patch73_begin:
	dd		0FFFFFFFFh
	dd		3
LPLANET_VERSION	db	'077',0
patch73_end:

exeAddr	544C10h
patch121_begin:
aNFKPlanetTooOld	db		42, 'visit official website for new NFK update.', 0
exeAddr 544C50h
	db		42, 'This NFK Planet version is too old. Please', 0
exeAddr	544C7Ch
	db		22, 'NFK Planet is too old.', 0
patch121_end:

exeAddr	544E74h
patch38_begin:
oldNFKPlanet_SendHello:
	jmp		newNFKPlanet_SendHello
patch38_end:

exeAddr	544F80h
patch42_begin:
NFKPlanet_RegisterServer	proc	; eax = hostname: LStr
                                    ; edx = mapname: LStr
                                    ; ecx = current players: Byte
                                    ; arg_4 = max players: Byte = [ebp + 0Ch]
                                    ; arg_0 = game type: Byte = [ebp + 8]
;----------- local variables -------
hostname	EQU	<[ebp - 4]>
mapname		EQU	<[ebp - 8]>
curPlayers	EQU	<[ebp - 0Ch]>
maxPlayers	EQU	<[ebp + 0Ch]>
gameType	EQU	<[ebp + 8]>
tempStr		EQU	<[ebp - 10h]>
;----------- codes -----------------
	push	ebp
	mov		ebp, esp
	push	eax						; init hostname
	push	edx						; init mapname
	push	ecx						; init curPlayers
	push	0						; init tempStr
	call	LStrAddRef				; add ref to hostname
	mov		eax, mapname
	call	LStrAddRef				; add ref to mapname
	push	esi						; esi will be an alias for MainForm.lobby.Socket so preserve it in teh stack
	; enter try
	xor		eax, eax
	push	ebp
	push	offset exceptHandler
	push	dword ptr fs:[eax]
	mov		fs:[eax], esp
	mov		esi, dword ptr mainform
	mov		esi, [esi + 304h]		; 304h - offset to `lobby' object in TMainForm
	cmp		byte ptr [esi + 24h], 0	; dunno what is `+ 24h', might be something like 'isConnected'
	je		notConnected
	mov		esi, [esi + 80h]		; 80h - offset to Socket object in `lobby'

	; sending greetings
	push	offset aGreeting		; put '?R' in the stack
	mov		eax, UDPDemon
	mov		eax, [eax + 834h]		; get UDPDemon.port value
	lea		edx, tempStr
	call	IntToStr
	push	tempStr					; put port number in the stack
	push	offset aCrLf			; put '\r\n' in the stack
	lea		eax, tempStr
	mov		edx, 3
	call	LStrCatN				; contatenate 3 strings from the stack and put it in tempStr
	mov		edx, tempStr
	mov		eax, esi
	call	TCustomWinSocket_SendText

	; sending hostname
	push	offset aHostname
	push	hostname
	push	offset aCrLf
	lea		eax, tempStr
	mov		edx, 3
	call	LStrCatN
	mov		edx, tempStr
	mov		eax, esi
	call	TCustomWinSocket_SendText

	; sending mapname
	push	offset aMapname
	push	mapname
	push	offset aCrLf
	lea		eax, tempStr
	mov		edx, 3
	call	LStrCatN
	mov		edx, tempStr
	mov		eax, esi
	call	TCustomWinSocket_SendText

	; sending current players
	push	offset aCurPlayers
	xor		eax, eax
	mov		al, curPlayers
	lea		edx, tempStr
	call	IntToStr
	push	tempStr
	push	offset aCrLf
	lea		eax, tempStr
	mov		edx, 3
	call	LStrCatN
	mov		edx, tempStr
	mov		eax, esi
	call	TCustomWinSocket_SendText

	; sending max players
	push	offset aMaxPlayers
	xor		eax, eax
	mov		al, maxPlayers
	lea		edx, tempStr
	call	IntToStr
	push	tempStr
	push	offset aCrLf
	lea		eax, tempStr
	mov		edx, 3
	call	LStrCatN
	mov		edx, tempStr
	mov		eax, esi
	call	TCustomWinSocket_SendText

	; sending game type
	push	offset aGameType
	xor		eax, eax
	mov		al, gameType
	lea		edx, tempStr
	call	IntToStr
	push	tempStr
	push	offset aCrLf
	lea		eax, tempStr
	mov		edx, 3
	call	LStrCatN
	mov		edx, tempStr
	mov		eax, esi
	call	TCustomWinSocket_SendText

notConnected:
	; leave try block
	xor		eax, eax
	pop		edx
	pop		ecx
	pop		ecx
	mov		fs:[eax], edx
	push	offset gracefulExit		; dirty Delphian hacks
cleanup:
	lea		eax, tempStr
	call	LStrClr					; delete tempStr
	lea		eax, mapname
	call	LStrClr					; remove ref from mapname
	lea		eax, hostname
	call	LStrClr					; remove ref from hostname
	retn

exceptHandler:
	jmp		HandleFinally
	jmp		cleanup

gracefulExit:
	pop		esi						; restore esi
	mov		esp, ebp				; cleanup locals
	pop		ebp
	retn	8
;----------- datas -----------------
			dd		0FFFFFFFFh
			dd		02
aGreeting	db		'?R', 0
align 4
			dd		0FFFFFFFFh
			dd		02
aHostname	db		'?N', 0
align 4
			dd		0FFFFFFFFh
			dd		02
aMapname	db		'?m', 0
align 4
			dd		0FFFFFFFFh
			dd		02
aCurPlayers	db		'?C', 0
align 4
			dd		0FFFFFFFFh
			dd		02
aMaxPlayers	db		'?M', 0
align 4
			dd		0FFFFFFFFh
			dd		02
aGameType	db		'?P', 0
align 4
			dd		0FFFFFFFFh
			dd		02
aCrLf		db		0Dh, 0Ah, 0
NFKPlanet_RegisterServer	endp
patch42_end:

exeAddr	545594h
NFKPlanet_AskForInvite:		nop

exeAddr 5459E4h
patch28_begin:
call    patch27_begin
patch28_end:

exeAddr 54631Ah
patch170_begin:
	nop
	nop
	nop
	nop
	nop
	nop
patch170_end:

exeAddr 546800h
patch22_begin:
call    patch21_begin
patch22_end:

exeAddr	546EAAh
; setting new BNET_OnDataReceived
patch138_begin:
dd		new_BNET_OnDataReceived
patch138_end:

IFDEF _TEST
; TUDPDemon_SendData hook
exeAddr 54701Bh
patch190_begin:
    push    eax
    push    ecx
    push    dword ptr [ebp + 8]     ; port
    push    dword ptr [ebp + 0Ch]   ; ip_address
    push    dword ptr [ebp + 10h]   ; size
    push    ecx                     ; data
    push    dword ptr [ebp + 4]     ; return address
    call    [nd_SendData]
    pop     ecx
    pop     eax
    jmp     TUDPDemon_SendData_tramp
patch190_end:
ENDIF

exeAddr 547037h
TUDPDemon_SendData_tramp2:

exeAddr 54704Ch
TUDPDemon_SendData_exit:

exeAddr	547054h
old_BNET_OnDataReceived:	nop

;========================================
TParticle_Move	proc

exeAddr 547954h
patch169_begin::
	cmp		OPT_R_MASSACRE, 0
	jz		noBlood
	fld		qword ptr [esi + 8]
	add		esp, -4
	fstp	dword ptr [esp]
	wait
	jmp		@F
patch169_end::

exeAddr 54796Fh
@@:

exeAddr 5479AAh
noBlood:

TParticle_Move	endp
;========================================


exeAddr 54901Ch
l54901C     dd  0
l549020     dd  0

exeAddr	54BCDCh
BNET_SERVERPORT	dw	0
exeAddr	54BCE0h
BNET_REALSERVERPORT	dw	0
exeAddr	54BCE4h
BNET_GAMEIP		dd	0	;ShortString
exeAddr	54BDE4h
BNET_OLDGAMEIP	dd	0

exeAddr	54BEF0h
BNET_CONNECTING	db	0

exeAddr	54BEF8h
ENABLE_PROTECT	db	0

exeAddr	54BF3Ch
SPECTATOR_TIMEOUT	dw	7000

exeAddr 54BF64h
MSG_DISABLE     db  0
align 4
HIST_DISABLE    db  0
align 4
ALIASCOMMAND    db  0

exeAddr	54C178h
SYS_TEAMSELECT	db	0

exeAddr 54C1E4h
OPT_R_MASSACRE	db	0

exeAddr 54C274h
pingsend_tick   dd  0

exeAddr 54C2B8h
MATCH_DRECORD	db	0
align 4
MATCH_DDEMOPLAY db  0

exeAddr 54C2DCh
CTF_BLUEFLAGSTATUS   db  0
align 4
CTF_REDFLAGSTATUS  db  0

exeAddr 54C634h
OPT_RAILCOLOR1  db  0
align 4
OPT_RAILCOLOR2  db  0
align 4
OPT_SYNC        db  0

exeAddr 54C6B0h
OPT_1BARTRAX    db  0

exeAddr 54C7A0h
OPT_SV_ALLOW_R_MODE db  0

exeAddr 54C7C4h
SYS_MAXAIR  db  0

exeAddr 54C80Ch
OPT_DRAWFRAGBAR     db  0
align 4
OPT_DRAWFRAGBARX    dw  0
align 4
OPT_DRAWFRAGBARY    dw  0
align 4
OPT_DRAWFRAGBARMYFRAG   dw  0
align 4
OPT_DRAWFRAGBAROTHERFRAG   dw  0

exeAddr	54CB68h
OPT_NETSPECTATOR	db	0
align 4
OPT_FREEFLY         db  0

exeAddr	54CCB0h
MATCH_GAMETYPE		db	0

exeAddr 54CDA0h
STIME   dd  0

exeAddr 54D1A4h
KEYALIASES  dd  256 dup(0)

exeAddr 54D5F4h
MESSAGEMODE db  0

exeAddr 54D748h
PReadBuf    dd  0

exeAddr 54DA48h
DEarnPowerup    dd  0

exeAddr 54E046h
byte_54E046		db	0

exeAddr 54E7C8h
Application		dd	0

exeAddr	552B60h
UDPDemon	dd	0

exeAddr	552B6Ch
NFKPlanet_state	db	0

exeAddr	552B80h
NFKPlanet_ServersList	dd	0

exeAddr	552B8Dh
MP_STEP	db	0

exeAddr 5547CAh
INCONSOLE   db  0

exeAddr 5547CCh
inmenu	db	0

exeAddr 554CD4h
mainform    dd  0

exeAddr	554CE4h
mapcancel	dd	0
gx			dd	0
gy			dd	0

exeAddr	555B00h
starttime	dd	0

exeAddr 555B30h
nextResolutionCheckTime dd  0
RMODE_ALLOWED   db  0

exeAddr 555B48h
objects	dd	0

exeAddr	757BB4h
loadmapsearch_lastfile	dd	0

exeAddr 757BC8h
gametime    dd  0
gametic     dd  0

exeAddr 757D4Ch
map_info	db	0

exeAddr	75CC98h
SpectatorList	dd	0

exeAddr	75CCF8h
DLL_DMGReceived dd 	0		;params
								;ax - target DXID
								;dx - attacker DXID
								;ecx - damage

exeAddr 75D380h
checksum    dd  0
checksumDelay   db  0
OPT_CL_ALLOWDOWNLOAD	db	0
OPT_SV_ALLOWDOWNLOAD	db	0
downloadingMap	db	0
OPT_FOLLOWKILLER    db  0
KillerFollowDelay   db  0
KillerID            db  0
OPT_FOLLOWPOWERUP   db  0
align 4
sleepDelay	db	0
align 4
mapBuffer	dd	0
mapRequestTimeout	dd	0
mapRequestTimeoutCount	db	0
mapRequestState	db	0	; 1 - ask
						; 2 - download
mapRequestNeededPart	db	0
mapRequestErrorCount	db	0
align 4
mapRequestSize	dd	0
mapRequestDownloaded	dd	0
shotCounter     dd  0

resolutionsCount    dd  0
resolutionsCapacity dd  0
resolutionsArray    dd  0
maxWidth            dd  0
maxHeight           dd  0

; addresses of netdebug.dll exports
nd_AddToQueue   dd  0
nd_SendData     dd  0
nd_ReceiveData  dd  0

; new botdll functions
DLL_SYSTEM_SpectatorConnect dd  0
DLL_SYSTEM_SpectatorDisconnect  dd  0

exeAddr	75E2F0h
imp_GetTickCount	dd	0

exeAddr 784000h
patch19_begin:
call    FreeMem
mov     edx, ebp
mov     eax, [edi]
call    l410A04
retn
patch19_end:

exeAddr 784010h
patch21_begin:
call    FreeMem
mov     edx, ebp
mov     eax, [esi + 4]
retn
patch21_end:

exeAddr 784020h
patch23_begin:
push    eax
lea     eax, [eax + 0Ch]
call    LStrClr
pop     eax
call    FreeMem
movzx   edx, bx
mov     eax, [edi]
retn
patch23_end:

exeAddr 784038h
patch25_begin:
call    FreeMem
mov     edx, edi
mov     eax, [ebp + 0]
retn
patch25_end:

exeAddr 784048h
patch27_begin:
call    FreeMem
mov     edx, ebp
mov     eax, [esi + 8]
retn
patch27_end:

align 16
patch29_begin:
    mov     al, OPT_NETSPECTATOR
    test    al, al
    jz      @F
    mov		al, sleepDelay
    inc		al
    and		al, 07Fh
    mov		sleepDelay, al
    jnz		@F
    push    1
    call    Sleep
    @@:
    call	TRUNC
    retn
patch29_end:

IFDEF _PINGER
align 16
patch36_begin:
dwordToHex  proc    ;eax - pointer to buffer, edx - dword
    push    edi
    mov     edi, eax
    mov     ecx, 8
hexloop:
    rol     edx, 4
    mov     al, dl
    and     al,0Fh
    cmp     al, 9
    jbe     digit
    add     al, 7
digit:
    add     al, '0'
    stosb
    dec     ecx
    jnz     hexloop
    pop     edi
    retn
dwordToHex  endp

align 16
;eax = new CRC, ecx = player index
;must preserve ecx
crcChanged	proc
	push	ebp
	mov		ebp, esp
	push	eax		;[ebp - 4] = new CRC
	push	ecx		;[ebp - 8] = player index
	sub		esp, 50h
	mov		eax, esp
	mov		edx, offset crcWarning
	call	PStrCpy
	mov		eax, [ebp - 8]
	mov		eax, [g_players + eax * 4]
	lea		edx, [eax + 7Bh]
	mov		eax, esp
	mov		cl, 50h
	call	PStrNCat
	mov		eax, esp
	mov		edx, offset crcWarningCont
	mov		cl, 50h
	call	PStrNCat
	mov		eax, esp
	movzx	ecx, byte ptr [eax]
	add		eax, ecx
	inc		eax
	lea		ecx, [eax + 8]
	mov		byte ptr [ecx], 0
	mov		edx, [ebp - 4]
	call	dwordToHex
	mov		edx, esp
	add		byte ptr [edx], 10
	push	0
	mov		eax, esp
	call	StringToLStr
	mov		eax, [esp]
	call	AddMessage
	mov		eax, esp
	call	LStrClr
	mov		ecx, [ebp - 8]		;restore ecx
	mov		esp, ebp
	pop		ebp
	retn
crcChanged	endp
align 16
crcWarning	db	31,'^1Checksum was changed for ^7^n',0
crcWarningCont	db	6,'^7^n: ',0

dwordToDec	proc	;eax - pointer to buffer, edx - dword
	push	edi
	mov		edi, eax
	test	edx, edx
	jns		nosign
	mov		al, '-'
	stosb
	neg		edx
nosign:
	push	edi
	sub		esp, 10h
	mov		edi, esp
	push	0Ah
	pop		ecx
	mov		eax, edx
@@:
	xor		edx, edx
	div		ecx
	add		dl, '0'
	mov		[edi], dl
	inc		edi
	test	eax, eax
	jnz		@B
	mov		ecx, edi
	mov		edx, edi
	sub		ecx, esp
	add		esp, 10h
	dec		edx
	pop		edi
@@:	mov		al, [edx]
	stosb
	dec		edx
	loopd	@B
	mov		eax, edi
	pop		edi
	retn
dwordToDec	endp

align 16
;eax = new Time-Delta, ecx = player index
deltaChanged	proc
	push	ebp
	mov		ebp, esp
	push	eax		;[ebp - 4] = new Time-Delta
	push	ecx		;[ebp - 8] = player index
	sub		esp, 50h
	mov		eax, esp
	mov		edx, offset timedeltaWarning
	call	PStrCpy
	mov		eax, [ebp - 8]
	mov		eax, [g_players + eax * 4]
	lea		edx, [eax + 7Bh]
	mov		eax, esp
	mov		cl, 50h
	call	PStrNCat
	mov		eax, esp
	mov		edx, offset crcWarningCont
	mov		cl, 50h
	call	PStrNCat
	mov		eax, esp
	movzx	ecx, byte ptr [eax]
	add		eax, ecx
	inc		eax
	mov		edx, [ebp - 4]
	call	dwordToDec
	mov		byte ptr [eax], 0
	mov		edx, esp
	sub		eax, esp
	dec		eax
	mov		byte ptr [edx], al
	push	0
	mov		eax, esp
	call	StringToLStr
	mov		eax, [esp]
	call	AddMessage
	mov		eax, esp
	call	LStrClr
	mov		esp, ebp
	pop		ebp
	retn
deltaChanged	endp
align 4
timedeltaWarning	db	33,'^1Time-Delta was changed for ^7^n',0
patch36_end:
ENDIF

align 16
patch37_begin:
newNFKPlanet_SendHello	proc
	mov		eax, mainform
	mov		eax, [eax + 304h]
	cmp		byte ptr [eax + 24h], 0
	je		finish
	mov		NFKPlanet_state, 0
	mov		ebx, [eax + 80h]
	sub		esp, 12
	mov		eax, esp
	mov		edx, offset aV
	call	PStrCpy
	mov		eax, esp
	mov		edx, offset PLANET_VERSION
	mov		cl, 12
	call	PStrNCat
	mov		eax, esp
	mov		edx, offset endl
	mov		cl, 12
	call	PStrNCat
	mov		edx, esp
	push	0
	mov		eax, esp
	call	StringToLStr
	mov		edx, [esp]
	mov		eax, ebx
	call	TCustomWinSocket_SendText
	add		esp, 16
finish:
	retn

align 4
aV		db		2,'?V',0
endl	db		2,13,10,0
newNFKPlanet_SendHello	endp
patch37_end:

align 16
patch44_begin:
NFKPlanet_ParseServerData_ext:
	call	NFKPlanet_GetTok
	push	[ebp - 24h]
	push	offset NFKPlanet_ParseServerData_emptyStr
	lea		ecx, [ebp - 28h]
	mov		dx, 6
	mov		eax, [ebp - 4]
	call	NFKPlanet_GetTok
	push	[ebp - 28h]
	jmp		NFKPlanet_ParseServerData_StartStrcat
patch44_end:

align 16
patch51_begin:
BNET_NFK_ReceiveData_new_on_MMP_LOBBY_ANSWERPING:
	lea		eax, [ebp - 14Ah]	; FromIP
	mov		edx, [ebp + 0Ch]	; FromPort
	call	NFKPlanet_UpdateServerPing
	jmp		BNET_NFK_ReceiveData_default
patch51_end:

align 16
patch53_begin:
BNET_NFK_ReceiveData_new_on_MMP_LOBBY_GAMESTATE_RESULT_beforeConcat:
	push	[ebp - 3F8h]
	push	offset BNET_NFK_ReceiveData_nullStr
	lea		edx, [ebp - 344h]
	mov		eax, [ebp + 0Ch]	; FromPort
	call	IntToStr
	push	[ebp - 344h]
	lea		eax, [ebp - 344h]
	mov		edx, 0Ah
	call	LStrCatN
	jmp		BNET_NFK_ReceiveData_on_MMP_LOBBY_GAMESTATE_RESULT_afterConcat
patch53_end:

align 16
patch57_begin:
NFKPlanet_SortServerList_appendPort:
	call	LStrCatN
	push	[ebp - 14h]
	mov		eax, [ebp - 5Ch]
	lea		ecx, [ebp - 58h]
	mov		dx, 6
	call	NFKPlanet_GetTok2
	push	[ebp - 58h]
	push	offset NFKPlanet_SortServerList_nullStr
	lea		eax, [ebp - 14h]
	mov		edx, 3
	call	LStrCatN
	jmp		NFKPlanet_SortServerList_afterAppendPort
patch57_end:

align 16
patch65_begin:
DrawMenu_newOnConnect	proc
	call	NFKPlanet_GetTok2
	push	0
	mov		ecx, esp
	mov		eax, [ebp - 310h]
	mov		dx, 6
	call	NFKPlanet_GetTok2
	mov		eax, [esp]
	push	offset DrawMenu_onConnect_connectStr
	push	[ebp - 30Ch]
	push	offset addrSep
	push	eax
	lea		eax, [ebp - 308h]
	mov		edx, 4
	call	LStrCatN
	mov		eax, esp
	call	LStrClr
	pop		eax
	jmp		DrawMenu_onConnect_afterConcat

align 4
			dd	0FFFFFFFFh
			dd	1
addrSep		db	':', 0
DrawMenu_newOnConnect	endp
patch65_end:

align 16
patch71_begin:
DrawMenu_newAskForInvite	proc
	push	0
	mov		ecx, esp
	mov		eax, [ebp - 320h]
	mov		dx, 6
	call	NFKPlanet_GetTok2
	mov		eax, [ebp - 31Ch]
	mov		edx, [esp]
	push	eax
	push	offset addrSep2
	push	edx
	lea		eax, [ebp - 31Ch]
	mov		edx, 3
	call	LStrCatN
	mov		eax, esp
	call	LStrClr
	pop		eax
	mov		eax, [ebp - 31Ch]
	call	NFKPlanet_AskForInvite
	retn
align 4
			dd	0FFFFFFFFh
			dd	1
addrSep2	db	':', 0
DrawMenu_newAskForInvite	endp
patch71_end:

align 16
patch74_begin:
BNET_NFK_ReceiveData_on_MMP_INVITE_connectEx	proc
	push	0
	mov		edx, esp
	mov		eax, [ebp + 0Ch]
	call	IntToStr
	mov		eax, [ebp - 32Ch]
	mov		edx, [esp]
	push	eax
	push	offset addrSep3
	push	edx
	lea		eax, [ebp - 32Ch]
	mov		edx, 3
	call	LStrCatN
	mov		eax, esp
	call	LStrClr
	pop		eax
	mov		eax, [ebp - 32Ch]
	call	BNET_DirectConnect
	retn
align 4
			dd	0FFFFFFFFh
			dd	1
addrSep3	db	':', 0
BNET_NFK_ReceiveData_on_MMP_INVITE_connectEx	endp
patch74_end:

align 16
patch111_begin:
newApplyCommand_on_reconnect	proc
	push	0
	mov		edx, esp
	movzx	eax, BNET_SERVERPORT
	call	IntToStr
	mov		eax, [ebp - 8ECh]
	mov		edx, [esp]
	push	eax
	push	offset addrSep4
	push	edx
	lea		eax, [ebp - 8ECh]
	mov		edx, 3
	call	LStrCatN
	mov		eax, esp
	call	LStrClr
	pop		eax
	mov		eax, [ebp - 8ECh]
	call	BNET_DirectConnect
	retn

align 4
			dd	0FFFFFFFFh
			dd	1
addrSep4	db	':', 0
newApplyCommand_on_reconnect	endp
patch111_end:

align 16
patch113_begin:
; returns 0 in eax if player has battlesuit
newApplyDamage_selfSplashDamage	proc
	jns		@F
	adc		eax, 0
@@:
	push	eax
	mov		eax, [ebp - 4]		; player
	cmp		byte ptr [eax + 277h], 0
	pop		eax
	jbe		noBattle
	xor		eax, eax			; dmg
noBattle:
	retn
newApplyDamage_selfSplashDamage	endp
patch113_end:

align 16
patch116_begin:
newPrintNFKEngineVersion	proc
; make string 'NFK Engine ver <version>.       <url>'
	push	0
	mov		eax, esp
	push	offset aNFKEngineVer1
	push	offset LNFK_VERSION
	push	offset aNFKEngineVer2
	push	offset NFK_URL
	mov		edx, 4
	call	LStrCatN
	mov		eax, [esp]
	call	AddMessage
	pop		eax
	retn

align 4
				dd		0FFFFFFFFh
				dd		15
aNFKEngineVer1	db		'NFK Engine ver ', 0, 0, 0
				dd		0FFFFFFFFh
				dd		9
aNFKEngineVer2	db		'.        ', 0
newPrintNFKEngineVersion	endp

align 4
			dd	0FFFFFFFFh
			dd	21
NFK_URL		db	'http://needforkill.ru', 0
patch116_end:

align 16
patch119_begin:
newGetSystemVariable_getNfkversion	proc
	mov		ecx, dword ptr PROTO_VERSION
	mov		[eax], ecx
	retn
newGetSystemVariable_getNfkversion	endp
patch119_end:

align 16
patch127_begin:
newGetTickCount	proc
	call	[imp_GetTickCount]
	and		eax, 7FFFFFFFh
	retn
newGetTickCount	endp
patch127_end:

align 16
patch133_begin:
BNET_NFK_ReceiveData_PacketFilter	proc
;----------- local variables -------
	FromIP		EQU	<[ebp - 14Ah]>	; ShortString
	data		EQU	<[ebp - 8]>		; PPChar
	Port		EQU	<[ebp + 0Ch]>	; Dword
;-----------------------------------
	call	ismultip
	cmp		eax, 2
	jnz		exit_ok
	mov		eax, data
	mov		al, [eax]
	; checking allowed set of packets
	cmp		al, MMP_INVITE
	jz		exit_ok
	cmp		al, MMP_LOBBY_ANSWERPING
	jz		exit_ok
	cmp		al, MMP_LOBBY_GAMESTATE_RESULT
	jz		exit_ok
	; now checking IP and Port of the sender
	lea		eax, dword ptr FromIP
	lea		edx, BNET_GAMEIP
	call	PStrCmp
	jnz		exit_notOk
	movzx	eax, word ptr BNET_SERVERPORT
	cmp		eax, Port
	jnz		exit_notOk
exit_ok:
	cmp		ENABLE_PROTECT, 0		; overwritten code
	jmp		BNET_NFK_ReceiveData_afterPacketFilter
exit_notOk:
	jmp		BNET_NFK_ReceiveData_default
BNET_NFK_ReceiveData_PacketFilter	endp
patch133_end:

align 16
patch136_begin:
FormCreate_extensions proc
    ;--- save registers
    push    esi
    push    edi
    ;--- an attempt to fix multiprocessor bug, only for clients
IFNDEF _DEDIC
	push	offset new_entryPointLibName
	call	GetModuleHandleA
	test	eax, eax
	jz		@F
	push	offset new_entryPointProcName1
	mov		edi, eax
	push	eax
	call	GetProcAddress
	test	eax, eax
	jz		@F
	mov		esi, eax
	push	offset new_entryPointProcName2
	push	edi
	call	GetProcAddress
	test	eax, eax
	jz		@F
	call	eax
	push	1
	push	eax
	call	esi
@@:
ENDIF
	;--- init new console variables
	; cl_allowdownload and sv_allowdownload are 1 by default
	mov		OPT_CL_ALLOWDOWNLOAD, 1
	mov		OPT_SV_ALLOWDOWNLOAD, 1
IFDEF _TEST
    ;--- load netdebug.dll
    push    offset a_netdebugdll
    call    LoadLibraryA
    test    eax, eax
    jnz     @F
    push    0
    mov     cx, 4
    mov     dl, 1
    mov     eax, offset a_cantLoadNetdebug
    call    MessageDlg
    mov     eax, offset a_cantLoadNetdebug
    call    AddMessage
    jmp     FormCreate_fail
@@:
    mov     esi, eax
    push    offset a_getVersion
    push    eax
    call    GetProcAddress
    test    eax, eax
    jnz     @F
    push    0
    mov     cx, 4
    mov     dl, 1
    mov     eax, offset a_noNetdebugNoExports
    call    MessageDlg
    mov     eax, offset a_noNetdebugNoExports
    call    AddMessage
    jmp     FormCreate_fail
@@:
    call    eax
    cmp     eax, NETDEBUG_VERSION
    jz      @F
    push    0
    mov     cx, 4
    mov     dl, 1
    mov     eax, offset a_wrongNetdebugVersion
    call    MessageDlg
    mov     eax, offset a_wrongNetdebugVersion
    call    AddMessage
    jmp     FormCreate_fail
@@:
    push    offset a_getExports
    push    esi
    call    GetProcAddress
    test    eax, eax
    jnz     @F
    push    0
    mov     cx, 4
    mov     dl, 1
    mov     eax, offset a_noNetdebugNoExports
    call    MessageDlg
    mov     eax, offset a_noNetdebugNoExports
    call    AddMessage
    jmp     FormCreate_fail
@@:
    push    offset nd_AddToQueue
    call    eax
ENDIF
    ;--- enumerate all possible display resolutions
    call    getValidResolutions
    ;--- restore registers
    pop     edi
    pop     esi
	;--- old formCreate code
	mov		eax, Application
    jmp     FormCreate_after_extensions
;----------- datas ------------
;--- multiprocessor fix datas, for clients only
IFNDEF _DEDIC
align 4
new_entryPointLibName	db	'kernel32.dll', 0
align 4
new_entryPointProcName1	db	'SetProcessAffinityMask', 0
align 4
new_entryPointProcName2	db	'GetCurrentProcess', 0
ENDIF

align 4
a_netdebugdll           db  'netdebug.dll', 0
align 4
a_getVersion            db  'getVersion', 0
align 4
a_getExports            db  'getExports', 0
align 4
                        dd  0FFFFFFFFh
                        dd  23
a_cantLoadNetdebug      db  'Can''t load netdebug.dll', 0
align 4
                        dd  0FFFFFFFFh
                        dd  41
a_wrongNetdebugVersion  db  'netdebug.dll has wrong version, monsieur.', 0
align 4
                        dd  0FFFFFFFFh
                        dd  48
a_noNetdebugNoExports   db  'netdebug.dll looks rather odd. This will not do.', 0
FormCreate_extensions endp
patch136_end:

align 16
patch137_begin:
new_BNET_OnDataReceived	proc
;----------- params ----------------
	port	EQU	<[ebp + 8]>	; integer
	address	EQU	<[ebp + 0Ch]>	; LStr
	; eax = edx = this (TNMUDP)
	; ecx = result of recvfrom
;----------- local variables -------
	i		EQU	<[ebp - 4]>	; integer
	data	EQU	<[ebp - 24h]>	; char[32]
	count	EQU	<[ebp - 28h]>	; integer
	shortAddress	EQU	<[ebp - 38h]>	; shortstring[15]
;-----------------------------------
	cmp		ecx, 0FFFFFFFFh
	je		isError
	jmp		old_BNET_OnDataReceived
isError:
	push	ebp
	mov		ebp, esp
	sub		esp, 38h
	; preserve esi
	push	esi
	; apply fix only to servers
	call	ismultip
	cmp		eax, 1
	jnz		exit
	; make a short version of address
	lea		eax, shortAddress
	mov		edx, address
	mov		ecx, 0Fh
	call	LStrToString

	; check spectators
	mov		eax, SpectatorList
	mov		eax, [eax + 8]	; TList.Count
	cmp		eax, 0
	jle		noSpectators
	mov		count, eax
	xor		edx, edx
	mov		i, edx
spectatorsLoop:
	mov		eax, SpectatorList
	call	TList_Get
	mov		esi, eax
	lea		eax, shortAddress
	lea		edx, [esi + 01Fh]	;TSpectator.address
	call	PStrCmp
	jnz		nextSpectator
	mov		ax, [esi + 30h]
	cmp		ax, port
	jnz		nextSpectator
	; spectator is found
	mov		byte ptr data, MMP_SPECTATORDISCONNECT
	lea		eax, data + 1		;TMMP_SpectatorDisconnect.netname
	mov		edx, esi
	mov		ecx, 1Eh
	call	PStrNCpy
	mov		eax, port
	push	eax
	push	20h					; sizeof TMMP_SpectatorDisconnect
	mov		eax, mainform
	lea		edx, data
	lea		ecx, shortAddress
	call	BNET_NFK_ReceiveData
	jmp		exit
nextSpectator:
	mov		edx, i
	inc		edx
	mov		i, edx
	cmp		edx, count
	jl		spectatorsLoop
noSpectators:

exit:
	pop		esi
	mov		esp, ebp
	pop		ebp
	retn	8
new_BNET_OnDataReceived	endp
patch137_end:

align 16
patch139_begin:
add_TestIP	proc	; function continuation (no prolog)
					; must restore edi, esi (in that order), does not purge stack params
;----------- local variables -------
	Result	EQU		<[ebp - 1]>		; byte
	i		EQU		<[ebp - 2]>		; byte
	address	EQU		<[ebp - 102h]>	; shortstring
					;[ebp - 104h] - unallocated word
					;[ebp - 108h] - old esi
					;[ebp - 10Ch] - old edi
	count	EQU		<[ebp - 110h]>	; integer
;-----------------------------------
	movzx	eax, byte ptr Result
	test	eax, eax
	jz		checkSpectators
	pop		edi
	pop		esi
	mov		esp, ebp
	pop		ebp
	retn
checkSpectators:
	push	ecx				; allocate count
	mov		edi, SpectatorList
	mov		edx, [edi + 8]	; TList.Count
	cmp		edx, 0
	jle		exit
	mov		count, edx
	mov		i, al
	mov		edx, eax
spectatorsLoop:	; here, edx must contain i
	mov		eax, edi
	call	TList_Get
	lea		edx, [eax + 01Fh]	;TSpectator.address
	lea		eax, address
	call	PStrCmp
	jnz		nextSpectator
	; found spectator
	push	1
	pop		eax
	jmp		exit
nextSpectator:
	movzx	edx, byte ptr i
	inc		edx
	mov		i, dl
	cmp		edx, count
	jl		spectatorsLoop
exit:
	pop		ecx				; free count
	pop		edi
	pop		esi
	mov		esp, ebp
	pop		ebp
	retn
add_TestIP	endp
patch139_end:

align 16
patch141_begin:
on_MMP_PING_distribute	proc	; jump on on_MMP_PING_do_distribute if ping distribution is needed (not spectators)
								; jump on on_MMP_PING_no_distribute otherwise
								; can use edi
;----------- local variables -------
	data	EQU		<[ebp - 8]>		; PChar
	i		EQU		<[ebp - 34h]>	; integer
	FromIP	EQU		<[ebp - 14Ah]>	; shortstring
	Port	EQU		<[ebp + 0Ch]>	; integer
;-----------------------------------
	mov		edi, data
	mov		eax, [edi + 1]      ; read TMP_Ping.Ping and TMP_Ping.DXID into one dword
	cmp		eax, 0FFFFFFFFh
	jnz		on_MMP_PING_do_distribute
	; if spectator, find out which one was that
	mov		eax, SpectatorList
	mov		eax, [eax + 8]		;TList.Count
	cmp		eax, 0
	jle		exit
	push	eax					; [esp] now contains the length of spectators array
								; do not forget to pop it out!
	xor		edx, edx
	mov		i, edx
spectatorsLoop:	; edx has to have index at this point
	mov		eax, SpectatorList
	call	TList_Get
	mov		edi, eax
	lea		eax, [eax + 1Fh]		;TSpectator.address
	lea		edx, FromIP
	call	PStrCmp
	jnz		nextSpectator
	movzx	edx, word ptr [edi + 30h]	;TSpectator.port
	cmp		edx, Port
	jnz		nextSpectator
	call	GetTickCount
	mov		[edi + 34h], eax		;TSpectator.lastPingTime
	jmp		exit
nextSpectator:
	inc		dword ptr i
	mov		edx, i
	cmp		edx, [esp]
	jl		spectatorsLoop
exit:
	pop		eax					; remove spectators count
	jmp		on_MMP_PING_no_distribute
on_MMP_PING_distribute	endp
patch141_end:

align 16
patch143_begin:
new_secondTickServer	proc	; function insertion, no prolog or epilog
								; can use ebx
;----------- local variables -------
	i	EQU		<[ebp - 0Ch]>	; integer
;-----------------------------------
	; old code
	cmp		MATCH_GAMETYPE, Gametype_DOM
	jnz		@F
	call	DOM_Think
@@:
	; timeout spectators
	mov		ebx, SpectatorList
	mov		eax, [ebx + 8]		;TList.Count
	cmp		eax, 0
	jle		noSpectators
	push	eax					; [esp] is now Count
	xor		edx, edx
	mov		i, edx
spectatorsLoop:					; edx must contain index at this point
	mov		eax, SpectatorList
	call	TList_Get
	mov		ebx, eax
	mov		edx, STIME
	sub		edx, [eax + 34h]	;TSpectator.lastPingTime
	cmp		dx, SPECTATOR_TIMEOUT
	jl		nextSpectator
	; spectator timeouted

	; say it
	; reserve buffer for shortstring[64] (68 bytes aligned) and LStr conversion buffer (4 bytes)
	; so we will have shortstring at [esp] and LString at [esp + 44h]
	push	0					; init LString with 0
	sub		esp, 44h
	; build string
	mov		eax, esp
	lea		edx, str_Spectator
	mov		cl, 44h
	call	PStrNCpy
	mov		eax, esp
	mov		edx, ebx			;TSpectator.netname
	mov		cl, 44h
	call	PStrNCat
	mov		eax, esp
	lea		edx, str_droppedByTimeout
	mov		cl, 44h
	call	PStrNCat
	lea		eax, [esp + 44h]
	mov		edx, esp
	call	StringToLStr
	mov		eax, [esp + 44h]
	call	AddMessage
	; cleanup
	lea		eax, [esp + 44h]
	call	LStrClr

	; Send MMP_SPECTATORDISCONNECT
	; we will reuse allocated 48h bytes for MMP_SPECTATORDISCONNECT message
	mov		byte ptr [esp], MMP_SPECTATORDISCONNECT
	lea		eax, [esp + 1]		;TMMP_SpectatorDisconnect.netname
	mov		edx, ebx			;TSpectator.netname
	mov		ecx, 1Eh
	call	PStrNCpy
	movzx	eax, word ptr [ebx + 30h]	;TSpectator.port
	mov		edx, esp
	push	eax
	push	20h					; sizeof TMMP_SpectatorDisconnect
	mov		eax, mainform
	lea		ecx, [ebx + 1Fh]	;TSpectator.address
	call	BNET_NFK_ReceiveData
	; free allocated buffer
	add		esp, 48h
	; decrease i and Count
	dec		dword ptr i
	dec		dword ptr [esp]
nextSpectator:
	mov		edx, i
	inc		edx
	mov		i, edx
	cmp		edx, [esp]
	jnz		spectatorsLoop
	pop		ecx					; remove Count from stack
noSpectators:
	jmp		secondTickTimeoutPlayers
new_secondTickServer	endp
patch143_end:

align 16
patch146_begin:
; process input of boolean-type (0 or 1) parameter
; eax - LStr: name of parameter
; edx - PChar: pointer to the parameter value
; ecx - LStr: input value
; stack parameter 1 - Char: default value
applyCommand_process_boolean	proc
;----------- local variables -------
	defaultValue	EQU		<[ebp + 8]>		; Char
	_name			EQU		<[ebp - 4]>		; LStr
	paramValue		EQU		<[ebp - 8]>		; PChar
	temp1			EQU		<[ebp - 0Ch]>	; LStr
;-----------------------------------
	push	ebp
	mov		ebp, esp
	; init stack variables
	push	eax
	push	edx
	push	0
	; check the presense of actual input
	test	ecx, ecx
	jnz		handle_input

	; there were none, show current value then
	lea		eax, temp1
	mov		edx, offset applyCommand_boolean_show
	call	LStrAsg
	; put current value to "show" string
	mov		eax, temp1
	mov		edx, paramValue
	mov		dl, [edx]
	add		[eax + 6], dl
	; put default value to "show" string
	mov		dl, defaultValue
	add		[eax + 22], dl

	; build a string '"<name>" is "<current value>". Default is "<default value>". Possible range 0-1.'
	push	offset lstrpart_doublequote
	mov		edx, _name
	push	edx
	lea		eax, temp1
	push	dword ptr [eax]
	mov		edx, 3
	call	LStrCatN
	; add message to the console
	mov		eax, temp1
	call	AddMessage
	jmp		exit

handle_input:
	; check input length - must be 1
	mov		eax, [ecx - 4]
	dec		eax
	jnz		bad_input
	; check input value - must be "0" or "1"
	mov		al, [ecx]
	sub		al, '0'
	cmp		al, 1
	ja		bad_input
	; set the value
	mov		[edx], al
	; announce changes
	; build a string '"<name>" is set to "<input value>"'
	push	offset lstrpart_doublequote
	mov		eax, _name
	push	eax
	push	offset lstrpart_dq_is_set_to_dq
	push	ecx
	push	offset lstrpart_doublequote
	lea		eax, temp1
	mov		edx, 5
	call	LStrCatN
	; add message to the console
	mov		eax, temp1
	call	AddMessage
	jmp		exit
    
bad_input:
	; build a string 'invalid value "<input value>"'
	lea		eax, temp1
	push	offset lstrpart_invalid_value_dq
	push	ecx
	push	offset lstrpart_doublequote
	mov		edx, 3
	call	LStrCatN
	mov		eax, temp1
	call	AddMessage
exit:
	lea		eax, temp1
	call	LStrClr
	mov		esp, ebp
	pop		ebp
	retn	4
;----------- datas -----------------
dd	0FFFFFFFFh
dd	45
; current and default values here are to be fixed in runtime
; current value offset = 6, default value offset = 22
applyCommand_boolean_show		db	'" is "0". Default is "0". Possible range 0-1.', 0

applyCommand_process_boolean	endp

align 4
applyCommand_followid   proc
    push    0
    test    eax, eax
    jz      invalidInput
    cmp     byte ptr [eax + 1], 0
    jnz     invalidInput
    xor     ecx, ecx
    mov     cl, [eax]
    .if cl < '0' || cl > '9'
        jmp     invalidInput
    .endif
    sub     cl, '0'
    mov     eax, g_players[ecx * 4]
    test    eax, eax
    jz      exit
    mov     OPT_1BARTRAX, cl
    jmp     exit
invalidInput:
    mov     ecx, eax
    mov     eax, esp
	push	offset lstrpart_invalid_value_dq
	push	ecx
	push	offset followid_valid_str
	mov		edx, 3
	call	LStrCatN
	mov		eax, [esp]
	call	AddMessage
exit:
    mov     eax, esp
    call    LStrClr
    pop     eax
    retn
    
;----------- datas -----------------
    dd  0FFFFFFFFh
    dd  23
followid_valid_str      db  '". Possible range: 0-7.', 0
applyCommand_followid   endp

align 16
applyCommand_ext	proc
;----------- local variables -------
	s			EQU		<[ebp - 4]>
	par0		EQU		<[ebp - 4Ch]>
	par1		EQU		<[ebp - 50h]>
;-----------------------------------
	; check cl_allowdownload
	mov		eax, par0
	mov		edx, offset lstr_cl_allowdownload
	call	LStrCmp
	jnz		check_sv_allowdownload
	push	1
	mov		eax, offset lstr_cl_allowdownload
	mov		edx, offset OPT_CL_ALLOWDOWNLOAD
	mov		ecx, par1
	call	applyCommand_process_boolean
	jmp		applyCommand_exit

check_sv_allowdownload:
	; check sv_allowdownload
	mov		eax, par0
	mov		edx, offset lstr_sv_allowdownload
	call	LStrCmp
	jnz		check_followkiller
	push	1
	mov		eax, offset lstr_sv_allowdownload
	mov		edx, offset OPT_SV_ALLOWDOWNLOAD
	mov		ecx, par1
	call	applyCommand_process_boolean
	jmp		applyCommand_exit

check_followkiller:    
    ; check followkiller
    mov		eax, par0
	mov		edx, offset lstr_followkiller
	call	LStrCmp
	jnz		check_followpowerup
	push	0
	mov		eax, offset lstr_followkiller
	mov		edx, offset OPT_FOLLOWKILLER
	mov		ecx, par1
	call	applyCommand_process_boolean
	jmp		applyCommand_exit
    
check_followpowerup:
    ; check followpowerup
    mov		eax, par0
	mov		edx, offset lstr_followpowerup
	call	LStrCmp
	jnz		check_followid
	push	0
	mov		eax, offset lstr_followpowerup
	mov		edx, offset OPT_FOLLOWPOWERUP
	mov		ecx, par1
	call	applyCommand_process_boolean
	jmp		applyCommand_exit
    
check_followid:
    ; check followid
    mov		eax, par0
	mov		edx, offset lstr_followid
	call	LStrCmp
    jnz     exit
    mov     eax, par1
    call    applyCommand_followid
    jmp     applyCommand_exit
    
exit:
	call	ismultip
	jmp		applyCommand_after_ext
;----------- datas -----------------
align 4
dd	0FFFFFFFFh
dd  16
lstr_cl_allowdownload	db 'cl_allowdownload', 0

align 4
dd	0FFFFFFFFh
dd  16
lstr_sv_allowdownload	db 'sv_allowdownload', 0

align 4
dd  0FFFFFFFFh
dd  12
lstr_followkiller   db  'followkiller', 0

align 4
dd  0FFFFFFFFh
dd  13
lstr_followpowerup  db  'followpowerup', 0

align 4
dd  0FFFFFFFFh
dd  8
lstr_followid       db  'followid', 0

applyCommand_ext	endp
patch146_end:

align 16
patch148_begin:
; save a numeric parameter in cfg
; eax - integer: number
; edx - LStr: name of parameter
; ecx - TStringList: cfg String List
SaveCFG_save_number	proc
	; reserve space for temporary LStr
	push	0
	; save ecx and edx
	push	ecx
	push	edx
	lea		edx, [esp + 8]
	call	IntToStr
	push	offset lstrpart_space
	lea		eax, [esp + 0Ch]
	push	dword ptr [eax]
	mov		edx, 3
	call	LStrCatN
	pop		eax
	mov		ecx, [eax]
	mov		edx, [esp]
	call	dword ptr [ecx + 34h]	;TStringList.Add
	mov		eax, esp
	call	LStrClr
	pop		ecx
	retn
SaveCFG_save_number	endp

align 16
SaveCFG_ext	proc
;----------- local variables -------
	ts			EQU		<[ebp - 8]>
;-----------------------------------
	call	ALIAS_SaveAlias
	movzx	eax, byte ptr OPT_CL_ALLOWDOWNLOAD
	mov		edx, offset lstr_cl_allowdownload
	mov		ecx, ts
	call	SaveCFG_save_number
	movzx	eax, byte ptr OPT_SV_ALLOWDOWNLOAD
	mov		edx, offset lstr_sv_allowdownload
	mov		ecx, ts
	call	SaveCFG_save_number
    movzx   eax, OPT_FOLLOWKILLER
    mov     edx, offset lstr_followkiller
    mov     ecx, ts
    call    SaveCFG_save_number
    movzx   eax, OPT_FOLLOWPOWERUP
    mov     edx, offset lstr_followpowerup
    mov     ecx, ts
    call    SaveCFG_save_number
	retn
;----------- datas -----------------
align 4
dd	0FFFFFFFFh
dd	18
;lstr_cl_allowdownload	db	'cl_allowdownload 0', 0
SaveCFG_ext	endp
patch148_end:

IFDEF _DISABLED
align 16
patch150_begin:
LOADMAP_ex	proc		; can use ebx
;----------- local variables -------
	f		EQU		<[ebp - 17Ch]>
	Buffer	EQU		<[ebp - 216h]>
;-----------------------------------
	call	LStrCmp
	jnz		LOADMAP_not_a_map
	; store the entire map somewhere. First 154 bytes are already loaded into [ebp-216]
	; if Map Buffer is not empty - free it
	mov		eax, mapBuffer
	test	eax, eax
	jz		@F
	call	FreeMem
	xor		eax, eax
	mov		mapBuffer, eax
@@:
	lea		eax, f
	call	FileSize
	cmp		eax, 1000000
	jge		exit
	push	eax
	call	GetMem
	test	eax, eax
	jz		exit
	; move first 154 bytes stored in a buffer
	mov		mapBuffer, eax
	mov		edx, eax
	lea		eax, Buffer
	mov		ecx, 154
	call	Move
	; read the rest from the file
	mov		eax, mapBuffer
	lea		edx, [eax + 154]
	lea		eax, f
	pop		ecx
	sub		ecx, 154
	push	0
	call	BlockRead
	; move file pointer back in the place
	lea		eax, f
	mov		edx, 154
	call	Seek
exit:
	jmp		LOADMAP_after_ex
LOADMAP_ex	endp
patch150_end:
ENDIF

align 16
patch151_begin:
DrawMenu_ex	proc
	; draw Map Downloading window if needed
	cmp		mapRequestState, 0
	jz		notDownloading
	push	190
	push	300
	push	100
	push	1
	mov		cx, 170
	mov		edx, offset sstrpart_empty
	mov		eax, offset sstr_downloading_a_map
	call	DrawWindow
	mov		mapcancel, 4
	cmp		mapRequestState, 1
	jnz		notRequesting
	push	0
	push	3
	push	3
	push	0FFFFFFh
	mov		edx, offset lstr_sending_a_request
	mov		eax, mainform
	mov		eax, [eax + 2FCh]				; TMainForm.font2b
	xor		ecx, ecx
	call	TPowerFont_AlignedOut
	jmp		notDownloading
notRequesting:
	cmp		mapRequestState, 2
	jnz		notDownloading
	push	0
	push	3
	push	3
	push	0FFFFFFh
	push	offset lstrpart_downloading_a_map_colon
	lea		edx, [ebp - 578h]
	mov		eax, mapRequestDownloaded
	call	IntToStr
	push	[ebp - 578h]
	push	offset lstrpart_out_of
	lea		edx, [ebp - 57Ch]
	mov		eax, mapRequestSize
	call	IntToStr
	push	[ebp - 57Ch]
	lea		eax, [ebp - 574h]
	mov		edx, 4
	call	LStrCatN
	mov		edx, [ebp - 574h]
	mov		eax, mainform
	mov		eax, [eax + 2FCh]				; TMainForm.font2b
	xor		ecx, ecx
	call	TPowerFont_AlignedOut
notDownloading:
	call	GammaAnimation
	retn
;----------- datas -----------------
align 4
sstr_downloading_a_map	db	20, 'Downloading a map...', 0
align 4
dd	0FFFFFFFFh
dd	20
lstr_sending_a_request	db	'Sending a request...', 0
align 4
dd	0FFFFFFFFh
dd	19
lstrpart_downloading_a_map_colon	db	'Downloading a map: ', 0
align 4
dd	0FFFFFFFFh
dd	8
lstrpart_out_of		db	' out of ', 0
DrawMenu_ex	endp
patch151_end:

IFDEF _DISABLED
align 16
patch153_begin:
BNET_NFK_ReceiveData_on_MMP_GAMESTATEANSWER_mapNotFound_ex	proc
	cmp		OPT_CL_ALLOWDOWNLOAD, 1
	jnz		exit
	; set request state
	mov		mapRequestState, 1
	mov		BNET_CONNECTING, 0
	; send a packet
	;,----------1---------32
	; MMP_GETMAP|
exit:
	mov		edx, offset sstrpart_opening_parentheses
	retn
BNET_NFK_ReceiveData_on_MMP_GAMESTATEANSWER_mapNotFound_ex	endp
patch153_end:
ENDIF

IFDEF _DISABLED
align 16
patch156_begin:
BNET_NFK_ReceiveData_on_MMP_DAMAGEPLAYER_ex	proc
;----------- local variables -------
	data	EQU		<[ebp - 8h]>
;-----------------------------------
	push	eax
	call	BD_Avail
	test	al, al
	jz		@F
	mov		ecx, data
	mov		ax, [ecx + 4]		; TMP_DamagePlayer.DXID
	mov		dx, [ecx + 6]
	xor		ecx, ecx
	call	DLL_DMGReceived
@@:
	pop		eax
	mov		eax, g_players[eax * 4]
	call	PAINSOUNDZZ
	jmp		BNET_NFK_ReceiveData_on_MMP_DAMAGEPLAYER_after_ex
BNET_NFK_ReceiveData_on_MMP_DAMAGEPLAYER_ex	endp
patch156_end:
ENDIF

align 16
patch163_begin:
; plays battlesuit sound if needed (not more than once per second)
; eax: TPlayer - player with a battlesuit
PlayBattleSuitSound	proc
	push	ebp
	mov		ebp, esp
	push	eax
	cmp		byte ptr [eax + 27Eh], 0	; TPlayer.item_battle_time
	jnz		exit
	push	dword ptr [eax + 294h]		; TPlayer.x high dword
	push	dword ptr [eax + 290h]		; TPlayer.x low dword
	push	dword ptr [eax + 29Ch]		; TPlayer.y	high dword
	push	dword ptr [eax + 298h]		; TPlayer.y low dword
	mov		ax, 45
	call	playsound
	pop		eax
	mov		byte ptr [eax + 27Eh], 50	; TPlayer.item_battle_time
exit:
	mov		esp, ebp
	pop		ebp
	retn
PlayBattleSuitSound	endp
patch163_end:

align 16
patch171_begin:
CHECKMAP_SUCCESS	EQU		<1>
CHECKMAP_DOMREADY	EQU		<2>
CHECKMAP_CTFREADY	EQU		<4>

CheckMap	proc	; eax: LStr - filename
					; returns a bitfield of CHECKMAP_* flags
;----------- local variables -------
	filename	EQU		<[ebp - 4]>		; LStr
	file		EQU		<[ebp - 150h]>	; File, size = 0x14C
	header		EQU		<[ebp - 1ECh]>	; byte[0x9C]
	buf			EQU		<[ebp - 2ECh]>	; byte[0x100]
	mapStats	EQU		<[ebp - 2FCh]>	; word[8] - count of blocks with indexes (i - 35)
										; 0 - red respawn points; 1 - blue respawn points; 5 - red flags; 6 - blue flags
										; 7 - dom points
	temp		EQU		<[ebp - 300h]>	; integer, used to store amount of bytes read
	result		EQU		<[ebp - 304h]>
;----------- consts ----------------
	MAPSTATS_REDRESP	EQU	<0>
	MAPSTATS_BLUERESP	EQU	<1>
	MAPSTATS_REDFLAG	EQU	<5>
	MAPSTATS_BLUEFLAG	EQU	<6>
	MAPSTATS_DOMPOINT	EQU	<7>
;-----------------------------------
	push	ebp
	mov		ebp, esp
	push	eax			; init filename
	sub		esp, 2FCh	; allocate the rest of local variables
	push	0			; init result value. 0 is an error
	push	esi
	push	edi
	call	LStrAddRef
	; init file with zeroes
	xor		eax, eax
	push	14Ch/4
	pop		ecx
	lea		edi, file
	rep		stosd
	; open file
	mov		edx, filename
	lea		eax, file
	call	_ASSIGN
	mov		byte_54E046, 0
	xor		edx, edx
	mov		dl, 1
	lea		eax, file
	call	_RESETFILE
	call	IOResult
	test	eax, eax
	jz		openSuccess
	lea		eax, file
	call	_CLOSE
	jmp		exit
openSuccess:
	lea		eax, temp
	push	eax
	lea		edx, header
	mov		ecx, 9Ah
	lea		eax, file
	call	BlockRead
	cmp		byte ptr temp, 9Ah
	jz		@F
	; if number of bytes read is not 9Ah, return 0, since it indicates that the file is less than 9Ah bytes long, and could not possibly be a map
	lea		eax, file
	call	_CLOSE
	jmp		exit
@@:
	; esi - Y dimension, edi - X dimension
	movzx	esi, byte ptr [header + 94h]	; Header.MapSizeX
	movzx	edi, byte ptr [header + 93h]	; Header.MapSizeY
	; reset stats
	mov		ecx, 08h
	xor		eax, eax
@@:	dec		ecx
	mov		[mapStats + ecx * 2], ax
	jnz		@B

	; reading a row of bricks
readLoop:
	lea		eax, temp
	push	eax
	lea		edx, buf
	mov		ecx, esi
	lea		eax, file
	call	BlockRead
	mov		ecx, temp
	cmp		esi, ecx
	jz		@F
	; couldn't read a row of bricks, return 0
	lea		eax, file
	call	_CLOSE
	jmp		exit
@@:
	; scanning a row of bricks
	xor		eax, eax
scanLoop:
	mov		al, byte ptr [buf + ecx]
	sub		al, 35
	jb		continueScan
	cmp		al, 0Eh
	ja		continueScan
	inc		word ptr [mapStats + eax * 2]
continueScan:
	dec		ecx
	jnz		scanLoop
	; read next row
	dec		edi
	jnz		readLoop

	; everything is read, close the file, check map stats and return flags
	lea		eax, file
	call	_CLOSE
	xor		eax, eax
	; map was read successfully, set success flag
	or		eax, CHECKMAP_SUCCESS
	; dom maps need exactly 3 dom points
	cmp		word ptr [mapStats + MAPSTATS_DOMPOINT*2], 3
	jnz		@F
	or		eax, CHECKMAP_DOMREADY
@@:
	; ctf maps need 1 red flag, 1 blue flag and at least one red and blue respawn point
	cmp		word ptr [mapStats + MAPSTATS_REDFLAG*2], 1
	jnz		@F
	cmp		word ptr [mapStats + MAPSTATS_BLUEFLAG*2], 1
	jnz		@F
	cmp		word ptr [mapStats + MAPSTATS_REDRESP*2], 0
	jz		@F
	cmp		word ptr [mapStats + MAPSTATS_BLUERESP*2], 0
	jz		@F
	or		eax, CHECKMAP_CTFREADY
@@:
	mov		result, eax
exit:
	lea		eax, filename
	call	LStrClr
	pop		edi
	pop		esi
	pop		eax		; pop result into eax
	mov		esp, ebp
	pop		ebp
	retn
CheckMap	endp
patch171_end:

align 16
patch172_begin:
ApplyCommand_onMap_ex	proc
	mov		eax, loadmapsearch_lastfile
	call	CheckMap
	test	eax, eax
	jnz		@F
	; print 'invalid map'
	mov		eax, offset lstrInvalidMap
printInvalidMap:	; printInvalidMap subprocedure. eax: LStr - message
					;  prints a "<map name><message>", restores MATCH_GAMETYPE
					;  to its previous value and exits the ApplyCommand function

	push	eax		; save message
	push	0		; init temporary LStr variable
	mov		eax, loadmapsearch_lastfile
	mov		edx, esp
	call	ExtractFileName
	mov		eax, esp
	mov		edx, [esp + 4]	; message
	call	LStrCat
	mov		eax, [esp]
	call	AddMessage
	mov		eax, esp
	call	LStrClr
	pop		eax
	pop		eax
	mov		al, [ebp - 31]	; old MATCH_GAMETYPE value
	mov		MATCH_GAMETYPE, al
	jmp		applyCommand_exit
@@:
	cmp		byte ptr MATCH_GAMETYPE, Gametype_CTF
	jnz		@F
	test	eax, CHECKMAP_CTFREADY
	jnz		mapOk
	; print 'invalid CTF map'
	mov		eax, offset lstrInvalidCTFMap
	jmp		printInvalidMap
@@:
	cmp		byte ptr MATCH_GAMETYPE, Gametype_DOM
	jnz		mapOk
	test	eax, CHECKMAP_DOMREADY
	jnz		mapOk
	; print 'invalid DOM map'
	mov		eax, offset lstrInvalidDOMMap
	jmp		printInvalidMap
mapOk:
	call	ismultip
	jmp		ApplyCommand_beginChangeMap

align 4
	dd		0FFFFFFFFh
	dd		012h
	lstrInvalidMap	db		' is not a map file', 00
align 4
	dd		0FFFFFFFFh
	dd		11h
	lstrInvalidCTFMap	db		' is not a CTF map', 0
align 4
	dd		0FFFFFFFFh
	dd		11h
	lstrInvalidDOMMap	db		' is not a DOM map', 0
ApplyCommand_onMap_ex	endp
patch172_end:

align 16
patch176_begin:
checkHardTimelimit	proc	; this function is called instead of ismultip in DXTimerTimer before MATCH_TIMELIMIT checks
	mov		eax, gametime
	cmp		eax, 5 * 60 * 60
	jb		@F
	mov		eax, offset aHardTimelimitHit
	call	AddMessage
	mov		eax, offset aRestart
	call	ApplyHCommand
@@:
	call	ismultip		; this call is necessary
	retn
align 4
	dd		0FFFFFFFFh
	dd		12h
aHardTimelimitHit	db		'hard timelimit hit', 0
checkHardTimelimit	endp
patch176_end:

align 16
patch180_begin:
MapRestart_resetSpectators	proc	; Map_Restart functiion code insertion.
									; A call to this funtion replaces a call to ResetMap
									; receive nothing, return nothing, no stack frame
;----------- local variables -------
	i		EQU		<[esp]>		; dword
;----------- code ------------------
	call	ResetMap
	; we will need edi, save it
	push	edi
	; loop through spectators
	push	ecx				; allocate i
	mov		edi, SpectatorList
	mov		edx, [edi + 8]	; TList.Count
	cmp		edx, 0
	jle		exit
	dec		edx
spectatorsLoop:
	mov		i, edx
	mov		eax, edi
	call	TList_Get
	lea		edx, [eax + 034h]	; TSpectator.lastPingTime
	mov		eax, STIME
	mov		[edx], eax			; set spectator's last ping time to current time
nextSpectator:
	mov		edx, i
	dec		edx
	jnc		spectatorsLoop
exit:
	pop		eax			; free i
	pop		edi			; restore edi
	retn
MapRestart_resetSpectators	endp
patch180_end:

IFDEF _TEST
align 4
; trampoline from the hook in Network_AddToQueue
patch185_begin:
Network_AddToQueue_tramp    proc
    test    si, si
    jnz     @F
    mov     eax, 0047E8F0h  ; '^1warning: zero sized data added to buffer.',0
    call    AddMessage
    jmp     Network_AddToQueue_exit
@@: mov     eax, 124h
    call    GetMem
    mov     ebx, eax
    mov     byte ptr [ebx], 1
    lea     eax, [ebx + 1]
    lea     edx, [ebp - 100h]
    jmp     Network_AddToQueue_tramp2
Network_AddToQueue_tramp    endp
patch185_end:

align 4
patch187_begin:
Network_ParsePackets_tramp1:
    lea     edi, [esp + 7]
    xor     ecx, ecx
    mov     cl, [esi]
    inc     ecx
    rep movsb
    mov     esi, PReadBuf
    mov     al, [esi]
    cmp     al, 4
    jmp     Network_ParsePackets_tramp1_2
patch187_end:

align 4
patch189_begin:
Network_ParsePackets_tramp2 proc
    inc     esi
    mov     al, [esi]
    test    al, al
    jbe     @F
    add     esi, 2
    mov     [esp + 6], al
    jmp     Network_ParsePackets_tramp2_2
@@: jmp     Network_ParsePackets_exit
Network_ParsePackets_tramp2 endp
patch189_end:

align 4
patch191_begin:
TUDPDemon_SendData_tramp    proc
    xor     edx, edx
    mov     esi, [ebp + 0Ch]
    lea     edi, [ebp - 100h]
    push    ecx
    xor     ecx, ecx
    mov     cl, [esi]
    inc     ecx
    rep movsb
    pop     ecx
    cmp     byte ptr [eax + 54B6Ch], 0
    jz      @F
    push    edx
    jmp     TUDPDemon_SendData_tramp2
@@: jmp     TUDPDemon_SendData_exit
TUDPDemon_SendData_tramp    endp
patch191_end:
ENDIF

align 4
patch206_begin:
newResolutionCheck proc
    mov     eax, STIME
    cmp     eax, nextResolutionCheckTime
    ja      @F
    retn
@@: add     eax, 5000
    mov     nextResolutionCheckTime, eax
    cmp     MATCH_DDEMOPLAY, 0
    jnz     exit
    call    ismultip
    .if (al == 0) || (al == 1 && OPT_SV_ALLOW_R_MODE != 0) || (al == 2 && RMODE_ALLOWED != 0)
        jmp     exit
    .endif
    .if (OPT_NETSPECTATOR != 0)
        jmp     exit
    .endif
    call    getNetPlayersCount
    cmp     al, 1
    jb      exit
    mov     eax, mainform
    mov     ecx, [eax + 2D4h]
    mov     edx, 480
    mov     eax, 640
    .if dword ptr [ecx + 21D8h] == eax && dword ptr [ecx + 21DCh] == edx
        jmp     exit
    .endif
    call    changeResolution
    mov     eax, offset str_r_mode_is_not_allowed
    call    AddMessage
exit:
    retn
newResolutionCheck endp
patch206_end:

align 4
patch208_begin:
getValidResolutions proc
;----------- locals -------
mode        equ     <[ebp - 9Ch]>
;----------- codes --------
    push    ebp
    mov     ebp, esp
    push    19
    pop     ecx
@@: push    0
    push    0
    dec     ecx
    jnz     @B
    push    0               ; alloc and zero space for DEVMODE struct (0x9C or 19*8 + 4 bytes) delphi style
    push    esi             ; save edi and esi cause we'll use them
    push    edi

    push    offset libName
    call    GetModuleHandleA
    push    offset funcName
    push    eax
    call    GetProcAddress
    mov     esi, eax
    mov     word ptr [mode + 24h], 9Ch     ;DEVMODEA.dmSize
    xor     edi, edi
enumLoop:
    lea     eax, mode
    push    eax
    push    edi
    push    0
    call    esi
    test    eax, eax
    jz      exit
@@: mov     ecx, resolutionsCount
    shl     ecx, 3
    mov     edx, resolutionsCapacity
    lea     eax, resolutionsArray
    sub     edx, 8
    cmp     ecx, edx
    jle     @F
    add     edx, 108h
    mov     resolutionsCapacity, edx
    call    ReallocMem
    jmp     @B
@@: mov     eax, [eax]
    add     eax ,ecx
    test    ecx, ecx
    mov     edx, [mode + 6Ch]
    mov     ecx, [mode + 70h]
    jz      @F
    .if (edx == [eax - 8]) && (ecx == [eax - 4])
        jmp     enumLoopContinue
    .endif
@@: mov     [eax], edx
    mov     [eax + 4], ecx
    .if maxWidth < edx
        mov     maxWidth, edx
    .endif
    .if maxHeight < ecx
        mov     maxHeight, ecx
    .endif
    inc     resolutionsCount
enumLoopContinue:
    inc     edi
    jmp     enumLoop
exit:
    pop     edi
    pop     esi
    mov     esp, ebp
    pop     ebp
    retn

;------ datas -----------
align 4
libName     db  'user32.dll', 0
align 4
funcName    db  'EnumDisplaySettingsA', 0
getValidResolutions endp

align   4
isResolutionValid   proc
    push    esi
    mov     esi, edx
    mov     edx, eax
    mov     ecx, resolutionsCount
    mov     eax, resolutionsArray
    test    ecx, ecx
    jz      exit
resLoop:
    .if [eax] == edx && [eax + 4] == esi
        jmp     exit
    .endif
    add     eax, 8
    dec     ecx
    jnz     resLoop
exit:
    mov     eax, ecx
    pop     esi
    retn
isResolutionValid   endp
patch208_end:

align 4
patch209_begin:
newRModeHandler proc
;------ locals ----------
s           equ     <[ebp - 4]>
par1        equ     <[ebp - 50h]>
par2        equ     <[ebp-2B14h]>
lstr_temp   equ     <[ebp-2B18h]>
lstr_temp2  equ     <[ebp-2B1Ch]>
lstr_rmode  equ     <[ebp-2B20h]>
;------ codes -----------
    ; allocate additional strings
    push    0   ; par2      ebp-2B14h
    push    0   ; tempStr   ebp-2B18h
    push    0   ; tempStr2  ebp-2B1Ch
    push    0   ; rmode     ebp-2B20h
    mov     eax, par1
    test    eax, eax
    jz      printUsage
    lea     ecx, par2
    mov     edx, 2
    mov     eax, s
    call    strpar
    mov     eax, par2
    test    eax, eax
    jz      oneParam
    ; set up SEH

    xor     eax, eax
    push    ebp
    push    offset exceptHandler
    push    dword ptr fs:[eax]
    mov     fs:[eax], esp
    mov     eax, par2
    call    StrToInt
    mov     edi, eax
    mov     eax, par1
    call    StrToInt
    mov     esi, eax
    mov     eax, mainform
    mov     eax, [eax + 2D4h]
    cmp     byte ptr [eax + 21C4h], 1
    mov     ecx, eax
    mov     eax, esi
    mov     edx, edi
    jnz     notFullscreen
    call    isResolutionValid
    test    eax, eax
    jz      resolutionError
resolutionOk:
    mov     eax, esi
    mov     edx, edi
    call    changeResolution
    jmp     exitTry
notFullscreen:
    .if (eax <= maxWidth) && (edx <= maxHeight) && (eax >= 320) && (edx >= 240)
        jmp     resolutionOk
    .endif
resolutionError:
    lea     eax, unsupportedResolution
    call    AddMessage
exitTry:
    xor     eax, eax
    pop     edx
    pop     ecx
    pop     ecx
    mov     fs:[0], edx
    jmp     exit

exceptHandler:
    jmp     HandleAnyException
    call    DoneExcept
    jmp     invalidInput

oneParam:
    mov     eax, par1
    mov     ax, [eax]
    test    ah, ah
    jnz     invalidInput
    .if al == '1'
        mov     eax, 640
        mov     edx, 480
        call    changeResolution
        jmp     exit
    .elseif al == '2'
        mov     eax, 800
        mov     edx, 600
        call    changeResolution
        jmp     exit
    .elseif al == '3'
        mov     eax, 1024
        mov     edx, 768
        call    changeResolution
        jmp     exit
    .endif

invalidInput:
    mov     eax, offset badInputStr
    call    AddMessage
printUsage:
    mov     eax, offset usageStr1
    call    AddMessage
    mov     eax, offset usageStr2
    call    AddMessage
    ; determine current rmode
    push    1
    pop     eax
    lea     edx, lstr_rmode
    call    IntToStr
    mov     eax, mainform
    mov     eax, [eax + 2D4h]
    mov     edx, [eax + 21D8h]
    mov     ecx, [eax + 21DCh]
    mov     eax, lstr_rmode
    .if (edx == 640) && (ecx == 480)
        jmp     @F
    .elseif (edx == 800) && (ecx == 600)
        mov     byte ptr [eax], '2'
        jmp     @F
    .elseif (edx == 1024) && (ecx == 768)
        mov     byte ptr [eax], '3'
        jmp     @F
    .else
        mov     eax, edx
        lea     edx, lstr_temp
        push    ecx
        call    IntToStr
        pop     eax
        lea     edx, lstr_temp2
        call    IntToStr
        push    lstr_temp
        push    offset lstrpart_x
        push    lstr_temp2
        lea     eax, lstr_rmode
        mov     edx, 3
        call    LStrCatN
    .endif
@@:
    push    offset currentStr
    push    lstr_rmode
    push    offset lstrpart_doublequote
    lea     eax, lstr_temp
    mov     edx, 3
    call    LStrCatN
    mov     eax, lstr_temp
    call    AddMessage

exit:
    ; free and cleanup additional strings
    lea     eax, lstr_rmode
    mov     edx, 4
    call    LStrArrayClr
    add     esp, 10h
    jmp     applyCommand_exit

;------ datas -----------
align 4
    dd  0FFFFFFFFh
    dd  13
badInputStr db  'Invalid input', 0
align 4
    dd  0FFFFFFFFh
    dd  51
usageStr1   db  'Usage: "r_mode <mode>" or "r_mode <width> <height>"', 0
align 4
    dd  0FFFFFFFFh
    dd  56
usageStr2   db  'mode is a number: 1 - 640x480; 2 - 800x600; 3 - 1024x768', 0
align 4
    dd  0FFFFFFFFh
    dd  19
currentStr  db  'Current r_mode is "', 0
align   4
    dd  0FFFFFFFFh
    dd  32
unsupportedResolution   db  'This resolution is not supported', 0
newRModeHandler endp

align 4
newGofullscreen proc
    push    esi
    push    edi
    mov     esi, mainform
    mov     eax, esi
    call    TMainForm_FinalizeAll
    mov     edi, [esi + 2D4h]
    mov     eax, edi
    call    TPowerGraph_Finalize
    ; now check the resolution
    mov     eax, [edi + 21D8h]
    mov     edx, [edi + 21DCh]
    call    isResolutionValid
    test    eax, eax
    jnz     resolutionIsOK
    mov     eax, edi
    mov     edx, 640
    call    TPowerGraph_SetWidth
    mov     eax, edi
    mov     edx, 480
    call    TPowerGraph_SetHeigth
    mov     eax, esi
    mov     edx, 640
    call    TCustomForm_SetClientWidth
    mov     eax, esi
    mov     edx, 480
    call    TCustomForm_SetClientHeigth
    mov     eax, offset resolutionWasReset
    call    AddMessage
resolutionIsOK:
    mov     eax, edi
    mov     dl, 1
    call    TPowerGraph_SetFullscreen
    xor     edx, edx
    mov     eax, esi
    call    TCustomForm_SetBorderStyle
    mov     eax, esi
    call    TWinControl_GetHandle
    mov     edx, eax
    mov     eax, edi
    call    TPowerGraph_Initialize
    mov     eax, esi
    call    TMainForm_LoadGrafix
    call    reloadPlayerModels
    pop     edi
    pop     esi
    retn

align 4
    dd  0FFFFFFFFh
    dd  37
resolutionWasReset  db  'The resolution was changed to 640x480', 0

newGofullscreen endp

align 4
BD_Init_ext proc
    call    initBotdllAddress   ; execute the destroyed call
    mov     edx, offset aNewDllProc1
    mov     eax, offset DLL_SYSTEM_SpectatorConnect
    call    initBotdllAddress
    mov     edx, offset aNewDllProc2
    mov     eax, offset DLL_SYSTEM_SpectatorDisconnect
    call    initBotdllAddress
    retn
align 4
aNewDllProc1    db  'DLL_SYSTEM_SpectatorConnect', 0
align 4
aNewDllProc2    db  'DLL_SYSTEM_SpectatorDisconnect', 0
BD_Init_ext endp

align 4
BNET_NFK_ReceiveData_on_MMP_SPECTATORCONNECT_ext    proc
;---------- local vars -----------
Port        equ     <[ebp+0Ch]>
data        equ     <[ebp-8]>
FromIP      equ     <[ebp-14Ah]>
;---------- code -----------------
    call    AddMessage      ; execute the destroyed call
    mov     eax, DLL_SYSTEM_SpectatorConnect
    test    eax, eax
    jz      exit
    ; alloc 2 strings
    push    0           ; ip
    push    0           ; name
    mov     edx, data
    lea     edx, [edx + 1]  ;TMP_SpectatorJoin.netname
    mov     eax, esp
    call    StringToLStr    ; init name
    lea     edx, FromIP
    lea     eax, [esp + 4]
    call    StringToLStr
    mov     eax, [esp]
    mov     edx, [esp + 4]
    mov     ecx, Port
    call    DLL_SYSTEM_SpectatorConnect
    mov     eax, esp
    mov     edx, 2
    call    LStrArrayClr
    pop     ecx
    pop     ecx
exit:
    retn
BNET_NFK_ReceiveData_on_MMP_SPECTATORCONNECT_ext    endp

align 4
BNET_NFK_ReceiveData_on_MMP_SPECTATORDISCONNECT_ext proc
;---------- local vars -----------
Port        equ     <[ebp+0Ch]>
data        equ     <[ebp-8]>
FromIP      equ     <[ebp-14Ah]>
;---------- code -----------------
    call    AddMessage      ; execute the destroyed call
    mov     eax, DLL_SYSTEM_SpectatorDisconnect
    test    eax, eax
    jz      exit
    ; alloc 2 strings
    push    0           ; ip
    push    0           ; name
    mov     edx, data
    lea     edx, [edx + 1]  ;TMP_SpectatorJoin.netname
    mov     eax, esp
    call    StringToLStr    ; init name
    lea     edx, FromIP
    lea     eax, [esp + 4]
    call    StringToLStr
    mov     eax, [esp]
    mov     edx, [esp + 4]
    mov     ecx, Port
    call    DLL_SYSTEM_SpectatorDisconnect
    mov     eax, esp
    mov     edx, 2
    call    LStrArrayClr
    pop     ecx
    pop     ecx
exit:
    retn
BNET_NFK_ReceiveData_on_MMP_SPECTATORDISCONNECT_ext endp

align 4
new_FragBar  proc
;---------- local vars -----------
RealFragBarX        equ     <[ebp-4]>
RealFragBarY        equ     <[ebp-8]>
MinFragBarY         equ     <[ebp-0Ch]>
LeftFragsCount      equ     <[ebp-10h]>
RightFragsCount     equ     <[ebp-14h]>
LeftFragsStr        equ     <[ebp-18h]>
RightFragsStr       equ     <[ebp-1Ch]>
LeftFragsWidth      equ     <[ebp-20h]>
RightFragsWidth     equ     <[ebp-24h]>
LeftBarColor        equ     <[ebp-28h]>
RightBarColor       equ     <[ebp-2Ch]>
LeftBarTextColor    equ     <[ebp-30h]>
RightBarTextColor   equ     <[ebp-34h]>
;---------- code -----------------
    push    ebp
    mov     ebp, esp
    sub     esp, 34h
    push    esi
    push    edi
    
    ; init vars
    xor     eax, eax
    mov     MinFragBarY, eax
    mov     LeftFragsStr, eax
    mov     RightFragsStr, eax
    
    ;mov     eax, mainform
    ;mov     eax, [eax + 2D4h]           ; TMainForm.PowerDraw
    ;fild    dword ptr [eax + 21D8h]     ; TPowerDraw.Width
    ;fild    OPT_DRAWFRAGBARX
    ;fild    c100
    ;fdivp   st(1), st(0)
    ;fmulp   st(1), st(0)
    ;fistp   dword ptr RealFragBarX
    ;fild    dword ptr [eax + 21DCh]     ; TPowerDraw.Height
    ;fild    OPT_DRAWFRAGBARY
    ;fild    c100
    ;fdivp   st(1), st(0)
    ;fmulp   st(1), st(0)
    ;fistp   dword ptr RealFragBarY
    movzx   eax, OPT_DRAWFRAGBARX
    mov     RealFragBarX, eax
    movzx   edx, OPT_DRAWFRAGBARY
    mov     RealFragBarY, edx
    
    ; calc frag counts
    call    isGameTeamplay
    test    al, al
    .if ZERO?
        ; for DM games, left is blue, right is red
        mov     dword ptr LeftBarColor, 88FF0000h
        mov     dword ptr LeftBarTextColor, 88EEEEEEh
        mov     dword ptr RightBarColor, 880000CCh
        mov     dword ptr RightBarTextColor, 88DDDDDDh
        movsx   eax, OPT_DRAWFRAGBARMYFRAG
        mov     LeftFragsCount, eax
        movsx   edx, OPT_DRAWFRAGBAROTHERFRAG
        mov     RightFragsCount, edx
    .else
        ; for TeamPlay games, left is red, right is blue
        mov     dword ptr LeftBarColor, 880000CCh 
        mov     dword ptr LeftBarTextColor, 88DDDDDDh
        mov     dword ptr RightBarColor, 88FF0000h
        mov     dword ptr RightBarTextColor, 88EEEEEEh
        movsx   eax, OPT_DRAWFRAGBAROTHERFRAG
        mov     LeftFragsCount, eax
        movsx   edx, OPT_DRAWFRAGBARMYFRAG
        mov     RightFragsCount, edx
    .endif
    ; prepare frag strings
    lea     edx, LeftFragsStr
    mov     eax, LeftFragsCount
    call    IntToStr
    lea     edx, RightFragsStr
    mov     eax, RightFragsCount
    call    IntToStr
    
    ; calc fragbar widths, because min and max coordinates of fragbar mostly depend on them
    mov     eax, mainform
    mov     eax, [eax + 2ECh]   ;TMainForm.font4
    mov     edx, LeftFragsStr
    call    TPowerFont_TextWidth
    add     eax, 7
    mov     LeftFragsWidth, eax
    
    mov     eax, mainform
    mov     eax, [eax + 2ECh]   ;TMainForm.font4
    mov     edx, RightFragsStr
    call    TPowerFont_TextWidth
    add     eax, 7
    mov     RightFragsWidth, eax
    
    ; draw flags if needed
    .if MATCH_GAMETYPE == Gametype_CTF
        ; offset frag bar (always under the flags)
        add     byte ptr MinFragBarY, 32
        
        ; draw red flag
        ; calc X
        mov     esi, RealFragBarX
        sub     esi, 32
        ; min left flag X is 0
        .if CARRY?
            xor     esi, esi
        .endif
        ; max left flag X is ScreenWidth - 64
        mov     eax, mainform
        mov     eax, [eax + 2D4h]       ; TMainForm.PowerDraw
        mov     edx, [eax + 21D8h]      ; TPowerDraw.Width
        sub     edx, 64
        .if esi > edx
            mov     esi, edx
        .endif
        ; calc Y
        mov     edi, RealFragBarY
        sub     edi, 32
        ; min flags Y is 0
        .if CARRY?
            xor     edi, edi
        .endif
        ; max flags Y is ScreenHeight - (16 + 32)
        mov     edx, [eax + 21DCh]      ; TPowerDraw.Height
        sub     edx, (16 + 32)
        .if edi > edx
            mov     edi, edx
        .endif
        ; calc X+32 and Y+32
        mov     eax, esi
        add     eax, 32
        mov     edx, edi
        add     edx, 32
        
        push    edi
        push    eax
        push    edi
        push    eax
        push    edx
        push    esi
        push    edx
        push    0EE0303A1h  ; that's red
        xor     eax, eax
        mov     al, CTF_REDFLAGSTATUS
        push    eax
        push    102h
        mov     ecx, esi
        mov     eax, mainform
        mov     edx, [eax + 3ECh]   ;TMainForm.Images[51]
        mov     eax, [eax + 2D4h]   ;TMainForm.PowerDraw
        call    TPowerGraph_TextureCol
        
        ; draw blue flag
        ; calc X
        mov     esi, RealFragBarX
        ; min right flag X is 32
        .if esi < 32
            mov     esi, 32
        .endif
        ; max right flag X is ScreenWidth - 32
        mov     eax, mainform
        mov     eax, [eax + 2D4h]     ; TMainForm.PowerDraw
        mov     edx, [eax + 21D8h]    ; TPowerDraw.Width
        sub     edx, 32
        .if esi > edx
            mov     esi, edx
        .endif
        ; Y is already calculated
        ; calc X+32 and Y+32
        mov     eax, esi
        add     eax, 32
        mov     edx, edi
        add     edx, 32
        
        push    edi
        push    eax
        push    edi
        push    eax 
        push    edx
        push    esi
        push    edx
        push    0EEAB3604h  ; that's blue
        xor     eax, eax
        mov     al, CTF_BLUEFLAGSTATUS
        push    eax
        push    102h
        mov     ecx, esi
        mov     eax, mainform
        mov     edx, [eax + 3ECh]   ;TMainForm.Images[51]
        mov     eax, [eax + 2D4h]   ;TMainForm.PowerDraw
        call    TPowerGraph_TextureCol
    .endif
    
    ; draw fragbar
    .if OPT_DRAWFRAGBAR != 0
        ; draw left frag
        ; calc left part X and Y
        mov     esi, RealFragBarX
        sub     esi, LeftFragsWidth
        ; min left fragbar X is 0
        .if CARRY?
            xor     esi, esi
        .endif
        ; max left fragbar X is ScreenWidth - LeftFragsWidth - RightFragsWidth
        mov     eax, mainform
        mov     eax, [eax + 2D4h]       ; TMainForm.PowerDraw
        mov     edx, [eax + 21D8h]      ; TPowerDraw.Width
        sub     edx, LeftFragsWidth
        sub     edx, RightFragsWidth
        .if esi > edx
            mov     esi, edx
        .endif
        ; min fragbars Y depends on whether there were flags or not. Min coordinate is already calculated in MinFragBarY
        mov     edi, RealFragBarY
        .if edi < MinFragBarY
            mov     edi, MinFragBarY
        .endif
        ; max fragbars Y is ScreenHeight - 16
        mov     edx, [eax + 21DCh]      ; TPowerDraw.Height
        sub     edx, 16
        .if edi > edx
            mov     edi, edx
        .endif
        ; draw rectangle
        push    dword ptr LeftFragsWidth
        push    10h
        push    88DDDDDDh
        push    dword ptr LeftBarColor
        push    102h
        mov     ecx, edi
        mov     edx, esi
        call    TPowerGraph_Rectangle
        ; draw text
        mov     eax, edi
        sub     eax, 2
        push    eax
        push    dword ptr LeftBarTextColor
        mov     edx, LeftFragsStr
        mov     ecx, esi
        add     ecx, 3
        mov     eax, mainform
        mov     eax, [eax + 2ECh]   ;TMainForm.font4
        call    TPowerFont_TextOut
        
        ; draw right frag
        mov     esi, RealFragBarX
        ; min right fragbar X is left frag bar width
        .if esi < LeftFragsWidth
            mov     esi, LeftFragsWidth
        .endif
        ; max right fragbar X is ScreenWidth - RightFragsWidth
        mov     eax, mainform
        mov     eax, [eax + 2D4h]       ; TMainForm.PowerDraw
        mov     edx, [eax + 21D8h]      ; TPowerDraw.Width
        sub     edx, RightFragsWidth
        .if esi > edx
            mov     esi, edx
        .endif
        ; Y is already calculated
        ; draw rectangle
        push    dword ptr RightFragsWidth
        push    10h
        push    88DDDDDDh
        push    dword ptr RightBarColor
        push    102h
        mov     ecx, edi
        mov     edx, esi
        call    TPowerGraph_Rectangle
        ; draw text
        mov     eax, edi
        sub     eax, 2
        push    eax
        push    dword ptr RightBarTextColor
        mov     edx, RightFragsStr
        mov     ecx, esi
        add     ecx, 3
        mov     eax, mainform
        mov     eax, [eax + 2ECh]   ;TMainForm.font4
        call    TPowerFont_TextOut
    .endif
    ; free strings
    lea     eax, LeftFragsStr
    call    LStrClr
    lea     eax, RightFragsStr
    call    LStrClr
    
    pop     edi
    pop     esi
    mov     esp, ebp
    pop     ebp
    retn
;-------- datas -------
c100    dd      100
new_FragBar  endp

align 4
CalculateFragBar_ex1    proc
    xor     eax, eax
    or      al, MATCH_DDEMOPLAY
    or      al, OPT_NETSPECTATOR
    test    al, al
    retn
CalculateFragBar_ex1    endp

align 4
CalculateFragBar_ex2    proc
;------- locals -------
i               equ     <[ebp-1]>
mybestscore     equ     <[ebp-0Ch]>
biggestscore    equ     <[ebp-8]>
;------- codes --------
    xor     ecx, ecx
playersloop:
    mov     eax, g_players[ecx * 4]
    test    eax, eax
    jz      continue
    mov     edx, [eax + 58h]    ;TPlayer.frags
    mov     eax, mybestscore
    cmp     edx, eax
    jle     @F
    mov     mybestscore, edx
    mov     biggestscore, eax
    jmp     continue
@@:
    cmp     edx, biggestscore
    jle     continue
    mov     biggestscore, edx
continue:
    inc     ecx
    cmp     cl, 8
    jnz     playersloop
    retn
CalculateFragBar_ex2    endp

align 4
FollowKillerSimpleDeathMessageHook  proc
    push    [esp + 0Ch]
    call    SimpleDeathMessage
    mov     eax, [esp + 4]
    .if OPT_FOLLOWKILLER != 0 && al == OPT_1BARTRAX
        mov     ecx, [esp + 8]
        mov     KillerFollowDelay, 75
        mov     KillerID, cl
    .endif
    retn 0Ch
FollowKillerSimpleDeathMessageHook  endp

align 4
onFrame proc
    .if KillerFollowDelay != 0
        dec     KillerFollowDelay
        .if ZERO?
            xor     ecx, ecx
            mov     cl, KillerID
            mov     eax, g_players[ecx * 4]
            test    eax, eax
            .if !ZERO?
                mov     OPT_1BARTRAX, cl
            .endif
        .endif
    .endif
    ; original proc
    call    CanSpectate
    retn
onFrame endp

align 4
nextplayer_ex   proc
    mov     KillerFollowDelay, 0
    call    GetNumberOfPlayers
    retn
nextplayer_ex   endp

align 4
followPowerup   proc
    .if OPT_FOLLOWPOWERUP == 1
        mov     cl, [ebp - 7]
        mov     OPT_1BARTRAX, cl
    .endif
    mov     eax, DEarnPowerup
    retn
followPowerup   endp
patch209_end:


align 16			; all additional data you could possibly need
patch179_begin:
	dd	0FFFFFFFFh
	dd	8
IFDEF _TEST
LFULL_NFK_VERSION	db	't77 rev2', 0
ELSE
LFULL_NFK_VERSION	db	'077 rev2', 0
ENDIF
align 4
PLANET_VERSION  db  03,'077',0
align 4
    dd  0FFFFFFFFh
    dd  3
LNFK_VERSION    db  '077', 0
patch179_end:


align   4
patchCount      dd      (patchSize_end - patchSize_begin) / 8
patchSize_begin dd      patch5_begin				; 6 players fix
                dd      patch5_end - patch5_begin
IFDEF _DEDIC
				dd      patch3_begin				; dedik server autocreate
                dd      patch3_end - patch3_begin
                dd      patch4_begin				; dedik server autocreate
                dd      patch4_end - patch4_begin
ENDIF
                dd      patch14_begin				; 6 players fix
                dd      patch14_end - patch14_begin
                dd      patch15_begin				; 6 players fix
                dd      patch15_end - patch15_begin
                dd      patch18_begin				; timer fix
                dd      patch18_end - patch18_begin
                dd      patch19_begin				; memory leak fix
                dd      patch19_end - patch19_begin
                dd      patch20_begin				; memory leak fix
                dd      patch20_end - patch20_begin
                dd      patch21_begin				; memory leak fix
                dd      patch21_end - patch21_begin
                dd      patch22_begin				; memory leak fix
                dd      patch22_end - patch22_begin
                dd      patch23_begin				; memory leak fix
                dd      patch23_end - patch23_begin
                dd      patch24_begin				; memory leak fix
                dd      patch24_end - patch24_begin
                dd      patch25_begin				; memory leak fix
                dd      patch25_end - patch25_begin
                dd      patch26_begin				; memory leak fix
                dd      patch26_end - patch26_begin
                dd      patch27_begin				; memory leak fix
                dd      patch27_end - patch27_begin
                dd      patch28_begin				; memory leak fix
                dd      patch28_end - patch28_begin
                dd      patch29_begin				; sleeping pill
                dd      patch29_end - patch29_begin
                dd      patch30_begin				; sleeping pill
                dd      patch30_end - patch30_begin
				dd		patch31_begin				; new pinger
				dd		patch31_end - patch31_begin
				dd		patch32_begin				; alt-tab fix
				dd		patch32_end - patch32_begin
				dd		patch33_begin				; new pinger
				dd		patch33_end - patch33_begin
IFDEF	_PINGER
				dd		patch34_begin				; new pinger
				dd		patch34_end - patch34_begin
ENDIF
				dd		patch35_begin				; new pinger
				dd		patch35_end - patch35_begin
IFDEF	_PINGER
				dd		patch36_begin				; new pinger
				dd		patch36_end - patch36_begin
ENDIF
				dd		patch37_begin				; new planet adaptation
				dd		patch37_end - patch37_begin
				dd		patch38_begin				; new planer adaptation
				dd		patch38_end - patch38_begin
				dd		patch39_begin				; new Short Version
				dd		patch39_end - patch39_begin
				dd		patch40_begin				; new planet adaptation
				dd		patch40_end - patch40_begin
				dd		patch41_begin				; new planet adaptation
				dd		patch41_end - patch41_begin
				dd		patch42_begin				; new planet adaptation
				dd		patch42_end - patch42_begin
				dd		patch43_begin				; new planet adaptation
				dd		patch43_end - patch43_begin
				dd		patch44_begin				; new planet adaptation
				dd		patch44_end - patch44_begin
				dd		patch45_begin				; new planet adaptation
				dd		patch45_end - patch45_begin
				dd		patch46_begin				; new planet adaptation
				dd		patch46_end - patch46_begin
				dd		patch47_begin				; new planet adaptation
				dd		patch47_end - patch47_begin
				dd		patch48_begin				; new planet adaptation
				dd		patch48_end - patch48_begin
				dd		patch49_begin				; new planet adaptation
				dd		patch49_end - patch49_begin
				dd		patch50_begin				; new planet adaptation
				dd		patch50_end - patch50_begin
				dd		patch51_begin				; new planet adaptation
				dd		patch51_end - patch51_begin
				dd		patch52_begin				; new planet adaptation
				dd		patch52_end - patch52_begin
				dd		patch53_begin				; new planet adaptation
				dd		patch53_end - patch53_begin
				dd		patch54_begin				; new planet adaptation
				dd		patch54_end - patch54_begin
				dd		patch55_begin				; new planet adaptation
				dd		patch55_end - patch55_begin
				dd		patch56_begin				; new planet adaptation
				dd		patch56_end - patch56_begin
				dd		patch57_begin				; new planet adaptation
				dd		patch57_end - patch57_begin
				dd		patch58_begin				; new planet adaptation
				dd		patch58_end - patch58_begin
				dd		patch59_begin				; new planet adaptation
				dd		patch59_end - patch59_begin
				dd		patch60_begin				; new planet adaptation
				dd		patch60_end - patch60_begin
				dd		patch61_begin				; new planet adaptation
				dd		patch61_end - patch61_begin
				dd		patch62_begin				; new planet adaptation
				dd		patch62_end - patch62_begin
				dd		patch63_begin				; new planet adaptation
				dd		patch63_end - patch63_begin
				dd		patch64_begin				; new planet adaptation
				dd		patch64_end - patch64_begin
				dd		patch65_begin				; new planet adaptation
				dd		patch65_end - patch65_begin
				dd		patch66_begin				; new planet adaptation
				dd		patch66_end - patch66_begin
				dd		patch67_begin				; new planet adaptation
				dd		patch67_end - patch67_begin
				dd		patch68_begin				; new planet adaptation
				dd		patch68_end - patch68_begin
				dd		patch69_begin				; new planet adaptation
				dd		patch69_end - patch69_begin
				dd		patch70_begin				; new planet adaptation
				dd		patch70_end - patch70_begin
				dd		patch71_begin				; new planet adaptation
				dd		patch71_end - patch71_begin
				dd		patch72_begin				; new planet adaptation
				dd		patch72_end - patch72_begin
				dd		patch73_begin				; new Long Version
				dd		patch73_end - patch73_begin
				dd		patch74_begin				; new planet adaptation
				dd		patch74_end - patch74_begin
				dd		patch75_begin				; new planet adaptation
				dd		patch75_end - patch75_begin
IFDEF _DEDIC
				dd		patch76_begin				; disable graphic for dedik
				dd		patch76_end - patch76_begin
				dd		patch77_begin				; disable graphic for dedik
				dd		patch77_end - patch77_begin
				dd		patch78_begin				; disable graphic for dedik
				dd		patch78_end - patch78_begin
				dd		patch79_begin				; disable graphic for dedik
				dd		patch79_end - patch79_begin
				dd		patch80_begin				; disable graphic for dedik
				dd		patch80_end - patch80_begin
				dd		patch81_begin				; disable graphic for dedik
				dd		patch81_end - patch81_begin
				dd		patch82_begin				; disable graphic for dedik
				dd		patch82_end - patch82_begin
				dd		patch83_begin				; disable graphic for dedik
				dd		patch83_end - patch83_begin
				dd		patch84_begin				; disable graphic for dedik
				dd		patch84_end - patch84_begin
				dd		patch85_begin				; disable graphic for dedik
				dd		patch85_end - patch85_begin
				dd		patch86_begin				; disable graphic for dedik
				dd		patch86_end - patch86_begin
				dd		patch87_begin				; disable graphic for dedik
				dd		patch87_end - patch87_begin
				dd		patch88_begin				; disable graphic for dedik
				dd		patch88_end - patch88_begin
				dd		patch89_begin				; disable graphic for dedik
				dd		patch89_end - patch89_begin
				dd		patch90_begin				; disable graphic for dedik
				dd		patch90_end - patch90_begin
				dd		patch91_begin				; disable graphic for dedik
				dd		patch91_end - patch91_begin
				dd		patch92_begin				; disable graphic for dedik
				dd		patch92_end - patch92_begin
				dd		patch93_begin				; disable graphic for dedik
				dd		patch93_end - patch93_begin
				dd		patch94_begin				; disable graphic for dedik
				dd		patch94_end - patch94_begin
				dd		patch95_begin				; disable graphic for dedik
				dd		patch95_end - patch95_begin
				dd		patch96_begin				; disable graphic for dedik
				dd		patch96_end - patch96_begin
				dd		patch97_begin				; disable graphic for dedik
				dd		patch97_end - patch97_begin
				dd		patch98_begin				; disable graphic for dedik
				dd		patch98_end - patch98_begin
				dd		patch99_begin				; disable graphic for dedik
				dd		patch99_end - patch99_begin
				dd		patch100_begin				; disable graphic for dedik
				dd		patch100_end - patch100_begin
				dd		patch101_begin				; disable graphic for dedik
				dd		patch101_end - patch101_begin
				dd		patch102_begin				; disable graphic for dedik
				dd		patch102_end - patch102_begin
				dd		patch103_begin				; disable graphic for dedik
				dd		patch103_end - patch103_begin
				dd		patch104_begin				; disable graphic for dedik
				dd		patch104_end - patch104_begin
				dd		patch105_begin				; disable graphic for dedik
				dd		patch105_end - patch105_begin
				dd		patch106_begin				; disable graphic for dedik
				dd		patch106_end - patch106_begin
				dd		patch107_begin				; disable graphic for dedik
				dd		patch107_end - patch107_begin
				dd		patch108_begin				; disable graphic for dedik
				dd		patch108_end - patch108_begin
				dd		patch109_begin				; disable graphic for dedik
				dd		patch109_end - patch109_begin
				dd		patch110_begin				; disable graphic for dedik
				dd		patch110_end - patch110_begin
ENDIF
				dd		patch111_begin				; new planet adaptation
				dd		patch111_end - patch111_begin
				dd		patch112_begin				; new planet adaptation
				dd		patch112_end - patch112_begin
				dd		patch113_begin				; no splash damage in BattleSuit
				dd		patch113_end - patch113_begin
				dd		patch114_begin				; no splash damage in BattleSuit
				dd		patch114_end - patch114_begin
				dd		patch115_begin				; new version in console
				dd		patch115_end - patch115_begin
				dd		patch116_begin				; new engine version in console
				dd		patch116_end - patch116_begin
				dd		patch117_begin				; new engine version in console
				dd		patch117_end - patch117_begin
				dd		patch118_begin				; new engine version in console
				dd		patch118_end - patch118_begin
				dd		patch119_begin				; new version in GetSystemVariable
				dd		patch119_end - patch119_begin
				dd		patch120_begin				; new version in GetSystemVariable
				dd		patch120_end - patch120_begin
				dd		patch121_begin				; new planet adaptation
				dd		patch121_end - patch121_begin
				dd		patch122_begin				; new planet adaptation
				dd		patch122_end - patch122_begin
				dd		patch123_begin				; new version at the bottom of main screen
				dd		patch123_end - patch123_begin
				dd		patch124_begin				; new official website
				dd		patch124_end - patch124_begin
				dd		patch125_begin				; new birthday website
				dd		patch125_end - patch125_begin
IFDEF _DEDIC
				dd		patch126_begin				; dedik cursor centering fix
				dd		patch126_end - patch126_begin
ENDIF
				dd		patch127_begin				; GetTickCount fix
				dd		patch127_end - patch127_begin
				dd		patch128_begin				; GetTickCount fix
				dd		patch128_end - patch128_begin
IFDEF _DEDIC
				dd		patch129_begin				; no dedik window popup on player join
				dd		patch129_end - patch129_begin
				dd		patch130_begin				; dedik cursor visibility fix
				dd		patch130_end - patch130_begin
				dd		patch131_begin				; dedik cursor visibility fix
				dd		patch131_end - patch131_begin
				dd		patch132_begin				; dedik cursor visibility fix
				dd		patch132_end - patch132_begin
ENDIF
				dd		patch133_begin				; new packet filter
				dd		patch133_end - patch133_begin
				dd		patch134_begin				; new packet filter
				dd		patch134_end - patch134_begin
				dd		patch135_begin				; FormCreate hook
				dd		patch135_end - patch135_begin
				dd		patch136_begin				; FormCreate extensions
				dd		patch136_end - patch136_begin
				dd		patch137_begin				; network error handler
				dd		patch137_end - patch137_begin
				dd		patch138_begin				; network error handler
				dd		patch138_end - patch138_begin
				dd		patch139_begin				; added Spectators checking loop to TestIP function
				dd		patch139_end - patch139_begin
				dd		patch140_begin				; added Spectators checking loop to TestIP function
				dd		patch140_end - patch140_begin
				dd		patch141_begin				; update Spectator last ping time
				dd		patch141_end - patch141_begin
				dd		patch142_begin				; update Spectator last ping time
				dd		patch142_end - patch142_begin
				dd		patch143_begin				; ping timeout Spectators
				dd		patch143_end - patch143_begin
				dd		patch144_begin				; ping timeout Spectators
				dd		patch144_end - patch144_begin
				dd		patch145_begin				; applyCommand extension
				dd		patch145_end - patch145_begin
				dd		patch146_begin				; applyCommand extension
				dd		patch146_end - patch146_begin
				dd		patch147_begin				; SaveCFG extension
				dd		patch147_end - patch147_begin
				dd		patch148_begin				; SaveCFG extension
				dd		patch148_end - patch148_begin
				;dd		patch149_begin				; LOADMAP extension
				;dd		patch149_end - patch149_begin
				;dd		patch150_begin				; LOADMAP extension
				;dd		patch150_end - patch150_begin
				dd		patch151_begin				; DrawMenu extension
				dd		patch151_end - patch151_begin
				dd		patch152_begin				; DrawMenu extension
				dd		patch152_end - patch152_begin
				;dd		patch153_begin				; BNET_NFK_ReceiveData on_MMP_GAMESTATEANSWER mapNotfound extension
				;dd		patch153_end - patch153_begin
				;dd		patch154_begin
				;dd		patch154_end - patch154_begin
				;dd		patch155_begin				; jump to new MMP_DAMAGEPLAYER handler
				;dd		patch155_end - patch155_begin
				;dd		patch156_begin				; new MMP_DAMAGEPLAYER handler
				;dd		patch156_end - patch156_begin
				dd		patch157_begin				; new CTF_SVNETWORK_FlagDrop function
				dd		patch157_end - patch157_begin
				dd		patch158_begin				; new CTF_CLNETWORK_DropFlag function
				dd		patch158_end - patch158_begin
				dd		patch159_begin				; made MMP_CTF_EVENT_FLAGDROP_GAMESTATE switch case point to the MMP_CTF_EVENT_FLAGDROP handler
				dd		patch159_end - patch159_begin
				dd		patch160_begin				; modified MMP_CTF_EVENT_FLAGDROP handler
				dd		patch160_end - patch160_begin
				dd		patch161_begin				; removed useless code causing spectators follow bug
				dd		patch161_end - patch161_begin
				dd		patch162_begin				; check for battle suit in plasma splash damage calculation code (no damage with BS)
				dd		patch162_end - patch162_begin
				dd		patch163_begin				; PlayBattleSuitSound function
				dd		patch163_end - patch163_begin
				dd		patch164_begin				; check for battle suit before applying damage while in lava (no damage with BS)
				dd		patch164_end - patch164_begin
IFDEF _TEST
				dd		patch165_begin				; allow connect to local IPs
				dd		patch165_end - patch165_begin
				dd		patch166_begin				; don't filter packets from local IPs
				dd		patch166_end - patch166_begin
				dd		patch167_begin				; don't filter packets from local IPs
				dd		patch167_end - patch167_begin
ENDIF
				dd		patch168_begin				; remove weapon if asked by server
				dd		patch168_end - patch168_begin
				dd		patch169_begin				; don't add blood splashes if r_massacre == 0
				dd		patch169_end - patch169_begin
				dd		patch170_begin				; don't turn off blood splashes if r_massacre == 0
				dd		patch170_end - patch170_begin
				dd		patch171_begin				; CheckMap function
				dd		patch171_end - patch171_begin
				dd		patch172_begin				; ApplyCommand_onMap extension
				dd		patch172_end - patch172_begin
				dd		patch173_begin				; jump to an ApplyCommand_onMap extension
				dd		patch173_end - patch173_begin
				dd		patch174_begin				; ignore alt key in MainForm_FormKeyDown
				dd		patch174_end - patch174_begin
				dd		patch175_begin				; init SYS_TEAMSELECT with zero in SpawnServer_PostInit
				dd		patch175_end - patch175_begin
				dd		patch176_begin				; checkHardTimelimit function
				dd		patch176_end - patch176_begin
				dd		patch177_begin				; checkHardTimelimit call
				dd		patch177_end - patch177_begin
				dd		patch178_begin				; let empty dedicated servers restart
				dd		patch178_end - patch178_begin
; here be 077
				dd		patch179_begin				; introduction of a revision number in console
				dd		patch179_end - patch179_begin
				dd		patch180_begin				; MapRestart_resetSpectators - an addition to Map_Restart that resets spectators' last ping time
				dd		patch180_end - patch180_begin
				dd		patch181_begin				; jump to MapRestart_resetSpectators
				dd		patch181_end - patch181_begin
; here be 077 rev2
				dd		patch182_begin				; OPT_BARTRAX1 check
				dd		patch182_end - patch182_begin
IFDEF _TEST
				dd		patch183_begin				; new BNETWORK_Sv_PlayerPosUpdate_packed function
				dd		patch183_end - patch183_begin
                dd      patch184_begin              ; Network_AddToQueue hook
                dd      patch184_end - patch184_begin
                dd      patch185_begin              ; Network_AddToQueue trampoline
                dd      patch185_end - patch185_begin
                dd      patch186_begin              ; Network_ParsePackets hook 1 (preprocessing)
                dd      patch186_end - patch186_begin
                dd      patch187_begin              ; Network_ParsePackets hook 1 trampoline
                dd      patch187_end - patch187_begin
                dd      patch188_begin              ; Network_ParsePackets hook 2 (postprocessing)
                dd      patch188_end - patch188_begin
                dd      patch189_begin              ; Network_ParsePackets hook 2 trampoline
                dd      patch189_end - patch189_begin
                dd      patch190_begin              ; TUDPDemon_SendData hook
                dd      patch190_end - patch190_begin
                dd      patch191_begin              ; TUDPDemon_SendData trampoline
                dd      patch191_end - patch191_begin
ENDIF
                dd      patch192_begin              ; don't display binded commands while playing demo
                dd      patch192_end - patch192_begin
                dd      patch193_begin              ; stop using BNET_REALSERVERPORT, use BNET_SERVERPORT instead
                dd      patch193_end - patch193_begin
                dd      patch194_begin              ; same as above
                dd      patch194_end - patch194_begin
                dd      patch195_begin              ; same as above
                dd      patch195_end - patch195_begin
                dd      patch196_begin              ; new ping handler
                dd      patch196_end - patch196_begin
                dd      patch197_begin              ; make a rocket shot an important message, add shotID to the message
                dd      patch197_end - patch197_begin
                dd      patch198_begin              ; make a BFG shot an important message, add shotID to the message
                dd      patch198_end - patch198_begin
                dd      patch199_begin              ; make a plasma shot an important message, add shotID to the message
                dd      patch199_end - patch199_begin
                dd      patch200_begin              ; make a shotgun shot an important message, add shotID to the message
                dd      patch200_end - patch200_begin
                dd      patch201_begin              ; make a shaft shot an important message, add shotID to the message
                dd      patch201_end - patch201_begin
                dd      patch202_begin              ; make a machinegun shot an important message, add shotID to the message
                dd      patch202_end - patch202_begin
                dd      patch203_begin              ; make a grenade launcher shot an important message, add shotID to the message
                dd      patch203_end - patch203_begin
                dd      patch204_begin              ; make a railgun shot an important message, add shotID to the message
                dd      patch204_end - patch204_begin
                dd      patch205_begin              ; jump to new resolution check procedure
                dd      patch205_end - patch205_begin
                dd      patch206_begin              ; new resolution check procedure
                dd      patch206_end - patch206_begin
                dd      patch207_begin              ; r_mode >= 2 D3D8 exception fix
                dd      patch207_end - patch207_begin
                dd      patch208_begin              ; getValidResolutions procedure
                dd      patch208_end - patch208_begin
                dd      patch209_begin
                dd      patch209_end - patch209_begin
                dd      patch210_begin
                dd      patch210_end - patch210_begin
                dd      patch211_begin
                dd      patch211_end - patch211_begin
                dd      patch212_begin
                dd      patch212_end - patch212_begin
                dd      patch213_begin
                dd      patch213_end - patch213_begin
                dd      patch214_begin              ; BD_Init extensions call
                dd      patch214_end - patch214_begin
                dd      patch215_begin              ; BNET_NFK_ReceiveData on_MMP_SPECTATORCONNECT extension call
                dd      patch215_end - patch215_begin
                dd      patch216_begin              ; BNET_NFK_ReceiveData on_MMP_SPECTATORDISCONNECT extension call
                dd      patch216_end - patch216_begin
                dd      patch217_begin
                dd      patch217_end - patch217_begin
                dd      patch218_begin
                dd      patch218_end - patch218_begin
                dd      patch219_begin
                dd      patch219_end - patch219_begin
                dd      patch220_begin
                dd      patch220_end - patch220_begin
                dd      patch221_begin
                dd      patch221_end - patch221_begin
                dd      patch222_begin
                dd      patch222_end - patch222_begin
                dd      patch223_begin
                dd      patch223_end - patch223_begin
                dd      patch224_begin
                dd      patch224_end - patch224_begin
                dd      patch225_begin
                dd      patch225_end - patch225_begin
                dd      patch226_begin
                dd      patch226_end - patch226_begin
patchSize_end:

end start
