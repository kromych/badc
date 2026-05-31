
struct_layout.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4003cc <.text+0x14c>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xe8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sxtw	x20, w0
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	cbz	x13, 0x40030c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x21, #0x0               // =0
               	adrp	x19, 0x410000
               	add	x19, x19, #0x110
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x116
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11d
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400ce8 <dlsym>
               	cbz	x0, 0x400394 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	0x400394 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x21, x19
               	lsl	x20, x20, #3
               	add	x21, x21, x20
               	ldr	x20, [x21]
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x4003dc <.text+0x15c>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	0x4003f4 <.text+0x174>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x4
               	sxtw	x15, w15
               	cmp	x15, #0x4
               	b.eq	0x400410 <.text+0x190>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x8
               	sxtw	x15, w15
               	cmp	x15, #0x8
               	b.eq	0x40042c <.text+0x1ac>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x10
               	sxtw	x15, w15
               	cmp	x15, #0x10
               	b.eq	0x400448 <.text+0x1c8>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x18
               	sxtw	x15, w15
               	cmp	x15, #0x18
               	b.eq	0x400464 <.text+0x1e4>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x1a
               	sxtw	x15, w15
               	cmp	x15, #0x1a
               	b.eq	0x400480 <.text+0x200>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x20
               	sxtw	x15, w15
               	cmp	x15, #0x20
               	b.eq	0x40049c <.text+0x21c>
               	mov	x0, #0x8                // =8
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x4004ac <.text+0x22c>
               	mov	x0, #0xa                // =10
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	0x4004c4 <.text+0x244>
               	mov	x0, #0xb                // =11
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x1
               	sxtw	x15, w15
               	cmp	x15, #0x1
               	b.eq	0x4004e0 <.text+0x260>
               	mov	x0, #0xc                // =12
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x2
               	sxtw	x15, w15
               	cmp	x15, #0x2
               	b.eq	0x4004fc <.text+0x27c>
               	mov	x0, #0xd                // =13
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x3
               	sxtw	x15, w15
               	cmp	x15, #0x3
               	b.eq	0x400518 <.text+0x298>
               	mov	x0, #0xe                // =14
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400528 <.text+0x2a8>
               	mov	x0, #0x14               // =20
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	0x400540 <.text+0x2c0>
               	mov	x0, #0x15               // =21
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x4
               	sxtw	x15, w15
               	cmp	x15, #0x4
               	b.eq	0x40055c <.text+0x2dc>
               	mov	x0, #0x16               // =22
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x8
               	sxtw	x15, w15
               	cmp	x15, #0x8
               	b.eq	0x400578 <.text+0x2f8>
               	mov	x0, #0x17               // =23
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400588 <.text+0x308>
               	mov	x0, #0x1e               // =30
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	0x4005a0 <.text+0x320>
               	mov	x0, #0x1f               // =31
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x4
               	sxtw	x15, w15
               	cmp	x15, #0x4
               	b.eq	0x4005bc <.text+0x33c>
               	mov	x0, #0x20               // =32
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x10
               	sxtw	x15, w15
               	cmp	x15, #0x10
               	b.eq	0x4005d8 <.text+0x358>
               	mov	x0, #0x21               // =33
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x4005e8 <.text+0x368>
               	mov	x0, #0x28               // =40
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	0x400600 <.text+0x380>
               	mov	x0, #0x29               // =41
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x8
               	sxtw	x15, w15
               	cmp	x15, #0x8
               	b.eq	0x40061c <.text+0x39c>
               	mov	x0, #0x2a               // =42
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x20
               	sxtw	x15, w15
               	cmp	x15, #0x20
               	b.eq	0x400638 <.text+0x3b8>
               	mov	x0, #0x2b               // =43
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400648 <.text+0x3c8>
               	mov	x0, #0x32               // =50
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400658 <.text+0x3d8>
               	mov	x0, #0x33               // =51
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	0x400670 <.text+0x3f0>
               	mov	x0, #0x34               // =52
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x24
               	sxtw	x15, w15
               	cmp	x15, #0x24
               	b.eq	0x40068c <.text+0x40c>
               	mov	x0, #0x35               // =53
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x40069c <.text+0x41c>
               	mov	x0, #0x3c               // =60
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x4006ac <.text+0x42c>
               	mov	x0, #0x3d               // =61
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	0x4006c4 <.text+0x444>
               	mov	x0, #0x3e               // =62
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x8
               	sxtw	x15, w15
               	cmp	x15, #0x8
               	b.eq	0x4006e0 <.text+0x460>
               	mov	x0, #0x3f               // =63
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x18
               	sxtw	x15, w15
               	cmp	x15, #0x18
               	b.eq	0x4006fc <.text+0x47c>
               	mov	x0, #0x40               // =64
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x40070c <.text+0x48c>
               	mov	x0, #0x46               // =70
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	0x400724 <.text+0x4a4>
               	mov	x0, #0x47               // =71
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x1
               	sxtw	x15, w15
               	cmp	x15, #0x1
               	b.eq	0x400740 <.text+0x4c0>
               	mov	x0, #0x48               // =72
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x5
               	sxtw	x15, w15
               	cmp	x15, #0x5
               	b.eq	0x40075c <.text+0x4dc>
               	mov	x0, #0x49               // =73
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x6
               	sxtw	x15, w15
               	cmp	x15, #0x6
               	b.eq	0x400778 <.text+0x4f8>
               	mov	x0, #0x4a               // =74
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0xe
               	sxtw	x15, w15
               	cmp	x15, #0xe
               	b.eq	0x400794 <.text+0x514>
               	mov	x0, #0x4b               // =75
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x10
               	sxtw	x15, w15
               	cmp	x15, #0x10
               	b.eq	0x4007b0 <.text+0x530>
               	mov	x0, #0x4c               // =76
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x11
               	sxtw	x15, w15
               	cmp	x15, #0x11
               	b.eq	0x4007cc <.text+0x54c>
               	mov	x0, #0x4d               // =77
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x4007dc <.text+0x55c>
               	mov	x0, #0x50               // =80
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	0x4007f4 <.text+0x574>
               	mov	x0, #0x51               // =81
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x1
               	sxtw	x15, w15
               	cmp	x15, #0x1
               	b.eq	0x400810 <.text+0x590>
               	mov	x0, #0x52               // =82
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x1a
               	sxtw	x15, w15
               	cmp	x15, #0x1a
               	b.eq	0x40082c <.text+0x5ac>
               	mov	x0, #0x53               // =83
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x40083c <.text+0x5bc>
               	mov	x0, #0x5a               // =90
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	0x400854 <.text+0x5d4>
               	mov	x0, #0x5b               // =91
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x2
               	sxtw	x15, w15
               	cmp	x15, #0x2
               	b.eq	0x400870 <.text+0x5f0>
               	mov	x0, #0x5c               // =92
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x6
               	sxtw	x15, w15
               	cmp	x15, #0x6
               	b.eq	0x40088c <.text+0x60c>
               	mov	x0, #0x5d               // =93
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x8
               	sxtw	x15, w15
               	cmp	x15, #0x8
               	b.eq	0x4008a8 <.text+0x628>
               	mov	x0, #0x5e               // =94
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x10
               	sxtw	x15, w15
               	cmp	x15, #0x10
               	b.eq	0x4008c4 <.text+0x644>
               	mov	x0, #0x5f               // =95
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x12
               	sxtw	x15, w15
               	cmp	x15, #0x12
               	b.eq	0x4008e0 <.text+0x660>
               	mov	x0, #0x60               // =96
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x14
               	sxtw	x15, w15
               	cmp	x15, #0x14
               	b.eq	0x4008fc <.text+0x67c>
               	mov	x0, #0x61               // =97
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x40090c <.text+0x68c>
               	mov	x0, #0x64               // =100
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	0x400924 <.text+0x6a4>
               	mov	x0, #0x65               // =101
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x4
               	sxtw	x15, w15
               	cmp	x15, #0x4
               	b.eq	0x400940 <.text+0x6c0>
               	mov	x0, #0x66               // =102
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x8
               	sxtw	x15, w15
               	cmp	x15, #0x8
               	b.eq	0x40095c <.text+0x6dc>
               	mov	x0, #0x67               // =103
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0xc
               	sxtw	x15, w15
               	cmp	x15, #0xc
               	b.eq	0x400978 <.text+0x6f8>
               	mov	x0, #0x68               // =104
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x14
               	sxtw	x15, w15
               	cmp	x15, #0x14
               	b.eq	0x400994 <.text+0x714>
               	mov	x0, #0x69               // =105
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x16
               	sxtw	x15, w15
               	cmp	x15, #0x16
               	b.eq	0x4009b0 <.text+0x730>
               	mov	x0, #0x6a               // =106
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x18
               	sxtw	x15, w15
               	cmp	x15, #0x18
               	b.eq	0x4009cc <.text+0x74c>
               	mov	x0, #0x6b               // =107
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x4009dc <.text+0x75c>
               	mov	x0, #0x6e               // =110
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x1
               	sxtw	x15, w15
               	cmp	x15, #0x1
               	b.eq	0x4009f8 <.text+0x778>
               	mov	x0, #0x6f               // =111
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400a08 <.text+0x788>
               	mov	x0, #0x78               // =120
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x4
               	sxtw	x15, w15
               	cmp	x15, #0x4
               	b.eq	0x400a24 <.text+0x7a4>
               	mov	x0, #0x79               // =121
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400a34 <.text+0x7b4>
               	mov	x0, #0x82               // =130
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x1
               	sxtw	x15, w15
               	cmp	x15, #0x1
               	b.eq	0x400a50 <.text+0x7d0>
               	mov	x0, #0x83               // =131
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400a60 <.text+0x7e0>
               	mov	x0, #0x8c               // =140
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	0x400a78 <.text+0x7f8>
               	mov	x0, #0x8d               // =141
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x4
               	sxtw	x15, w15
               	cmp	x15, #0x4
               	b.eq	0x400a94 <.text+0x814>
               	mov	x0, #0x8e               // =142
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x8
               	sxtw	x15, w15
               	cmp	x15, #0x8
               	b.eq	0x400ab0 <.text+0x830>
               	mov	x0, #0x8f               // =143
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400ac0 <.text+0x840>
               	mov	x0, #0x96               // =150
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400ad0 <.text+0x850>
               	mov	x0, #0x97               // =151
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	0x400ae8 <.text+0x868>
               	mov	x0, #0x98               // =152
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x1
               	sxtw	x15, w15
               	cmp	x15, #0x1
               	b.eq	0x400b04 <.text+0x884>
               	mov	x0, #0x99               // =153
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x9
               	sxtw	x15, w15
               	cmp	x15, #0x9
               	b.eq	0x400b20 <.text+0x8a0>
               	mov	x0, #0x9a               // =154
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400b30 <.text+0x8b0>
               	mov	x0, #0xa0               // =160
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	0x400b48 <.text+0x8c8>
               	mov	x0, #0xa1               // =161
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x2
               	sxtw	x15, w15
               	cmp	x15, #0x2
               	b.eq	0x400b64 <.text+0x8e4>
               	mov	x0, #0xa2               // =162
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0xa
               	sxtw	x15, w15
               	cmp	x15, #0xa
               	b.eq	0x400b80 <.text+0x900>
               	mov	x0, #0xa3               // =163
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0xc
               	sxtw	x15, w15
               	cmp	x15, #0xc
               	b.eq	0x400b9c <.text+0x91c>
               	mov	x0, #0xa4               // =164
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	ret
