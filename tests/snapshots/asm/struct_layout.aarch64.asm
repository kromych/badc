
struct_layout.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4003c8 <.text+0x148>
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
               	add	x12, x14, x13
               	ldr	x13, [x12]
               	cbz	x13, 0x40030c <.text+0x8c>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x12, x19
               	lsl	x13, x20, #3
               	add	x14, x12, x13
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
               	add	x12, x11, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0x116
               	mov	x11, x19
               	str	x11, [x12]
               	sub	x14, x29, #0x18
               	add	x11, x14, #0x10
               	adrp	x19, 0x410000
               	add	x19, x19, #0x11d
               	mov	x14, x19
               	str	x14, [x11]
               	sub	x12, x29, #0x18
               	lsl	x14, x20, #3
               	add	x11, x12, x14
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	0x400d98 <dlsym>
               	cbz	x0, 0x400394 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x12]
               	b	0x400394 <.text+0x114>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x21, x19
               	lsl	x0, x20, #3
               	add	x20, x21, x0
               	ldr	x0, [x20]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x4003d8 <.text+0x158>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	0x4003f4 <.text+0x174>
               	mov	x15, #0x2               // =2
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x4
               	sxtw	x15, w15
               	cmp	x15, #0x4
               	b.eq	0x400414 <.text+0x194>
               	mov	x15, #0x3               // =3
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x8
               	sxtw	x15, w15
               	cmp	x15, #0x8
               	b.eq	0x400434 <.text+0x1b4>
               	mov	x15, #0x4               // =4
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x10
               	sxtw	x15, w15
               	cmp	x15, #0x10
               	b.eq	0x400454 <.text+0x1d4>
               	mov	x15, #0x5               // =5
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x18
               	sxtw	x15, w15
               	cmp	x15, #0x18
               	b.eq	0x400474 <.text+0x1f4>
               	mov	x15, #0x6               // =6
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x1a
               	sxtw	x15, w15
               	cmp	x15, #0x1a
               	b.eq	0x400494 <.text+0x214>
               	mov	x15, #0x7               // =7
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x20
               	sxtw	x15, w15
               	cmp	x15, #0x20
               	b.eq	0x4004b4 <.text+0x234>
               	mov	x15, #0x8               // =8
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, 0x4004c8 <.text+0x248>
               	mov	x15, #0xa               // =10
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	0x4004e0 <.text+0x260>
               	mov	x0, #0xb                // =11
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x1
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.eq	0x4004fc <.text+0x27c>
               	mov	x0, #0xc                // =12
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x2
               	sxtw	x0, w0
               	cmp	x0, #0x2
               	b.eq	0x400518 <.text+0x298>
               	mov	x0, #0xd                // =13
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x3
               	sxtw	x0, w0
               	cmp	x0, #0x3
               	b.eq	0x400534 <.text+0x2b4>
               	mov	x0, #0xe                // =14
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400544 <.text+0x2c4>
               	mov	x0, #0x14               // =20
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	0x400560 <.text+0x2e0>
               	mov	x15, #0x15              // =21
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x4
               	sxtw	x15, w15
               	cmp	x15, #0x4
               	b.eq	0x400580 <.text+0x300>
               	mov	x15, #0x16              // =22
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x8
               	sxtw	x15, w15
               	cmp	x15, #0x8
               	b.eq	0x4005a0 <.text+0x320>
               	mov	x15, #0x17              // =23
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, 0x4005b4 <.text+0x334>
               	mov	x15, #0x1e              // =30
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	0x4005cc <.text+0x34c>
               	mov	x0, #0x1f               // =31
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x4
               	sxtw	x0, w0
               	cmp	x0, #0x4
               	b.eq	0x4005e8 <.text+0x368>
               	mov	x0, #0x20               // =32
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x10
               	sxtw	x0, w0
               	cmp	x0, #0x10
               	b.eq	0x400604 <.text+0x384>
               	mov	x0, #0x21               // =33
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400614 <.text+0x394>
               	mov	x0, #0x28               // =40
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	0x400630 <.text+0x3b0>
               	mov	x15, #0x29              // =41
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x8
               	sxtw	x15, w15
               	cmp	x15, #0x8
               	b.eq	0x400650 <.text+0x3d0>
               	mov	x15, #0x2a              // =42
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x20
               	sxtw	x15, w15
               	cmp	x15, #0x20
               	b.eq	0x400670 <.text+0x3f0>
               	mov	x15, #0x2b              // =43
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, 0x400684 <.text+0x404>
               	mov	x15, #0x32              // =50
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, 0x400698 <.text+0x418>
               	mov	x15, #0x33              // =51
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	0x4006b0 <.text+0x430>
               	mov	x0, #0x34               // =52
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x24
               	sxtw	x0, w0
               	cmp	x0, #0x24
               	b.eq	0x4006cc <.text+0x44c>
               	mov	x0, #0x35               // =53
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x4006dc <.text+0x45c>
               	mov	x0, #0x3c               // =60
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x4006ec <.text+0x46c>
               	mov	x0, #0x3d               // =61
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	0x400708 <.text+0x488>
               	mov	x15, #0x3e              // =62
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x8
               	sxtw	x15, w15
               	cmp	x15, #0x8
               	b.eq	0x400728 <.text+0x4a8>
               	mov	x15, #0x3f              // =63
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x18
               	sxtw	x15, w15
               	cmp	x15, #0x18
               	b.eq	0x400748 <.text+0x4c8>
               	mov	x15, #0x40              // =64
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, 0x40075c <.text+0x4dc>
               	mov	x15, #0x46              // =70
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	0x400774 <.text+0x4f4>
               	mov	x0, #0x47               // =71
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x1
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.eq	0x400790 <.text+0x510>
               	mov	x0, #0x48               // =72
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x5
               	sxtw	x0, w0
               	cmp	x0, #0x5
               	b.eq	0x4007ac <.text+0x52c>
               	mov	x0, #0x49               // =73
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x6
               	sxtw	x0, w0
               	cmp	x0, #0x6
               	b.eq	0x4007c8 <.text+0x548>
               	mov	x0, #0x4a               // =74
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0xe
               	sxtw	x0, w0
               	cmp	x0, #0xe
               	b.eq	0x4007e4 <.text+0x564>
               	mov	x0, #0x4b               // =75
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x10
               	sxtw	x0, w0
               	cmp	x0, #0x10
               	b.eq	0x400800 <.text+0x580>
               	mov	x0, #0x4c               // =76
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x11
               	sxtw	x0, w0
               	cmp	x0, #0x11
               	b.eq	0x40081c <.text+0x59c>
               	mov	x0, #0x4d               // =77
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x40082c <.text+0x5ac>
               	mov	x0, #0x50               // =80
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	0x400848 <.text+0x5c8>
               	mov	x15, #0x51              // =81
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x1
               	sxtw	x15, w15
               	cmp	x15, #0x1
               	b.eq	0x400868 <.text+0x5e8>
               	mov	x15, #0x52              // =82
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x1a
               	sxtw	x15, w15
               	cmp	x15, #0x1a
               	b.eq	0x400888 <.text+0x608>
               	mov	x15, #0x53              // =83
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, 0x40089c <.text+0x61c>
               	mov	x15, #0x5a              // =90
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	0x4008b4 <.text+0x634>
               	mov	x0, #0x5b               // =91
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x2
               	sxtw	x0, w0
               	cmp	x0, #0x2
               	b.eq	0x4008d0 <.text+0x650>
               	mov	x0, #0x5c               // =92
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x6
               	sxtw	x0, w0
               	cmp	x0, #0x6
               	b.eq	0x4008ec <.text+0x66c>
               	mov	x0, #0x5d               // =93
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x8
               	sxtw	x0, w0
               	cmp	x0, #0x8
               	b.eq	0x400908 <.text+0x688>
               	mov	x0, #0x5e               // =94
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x10
               	sxtw	x0, w0
               	cmp	x0, #0x10
               	b.eq	0x400924 <.text+0x6a4>
               	mov	x0, #0x5f               // =95
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x12
               	sxtw	x0, w0
               	cmp	x0, #0x12
               	b.eq	0x400940 <.text+0x6c0>
               	mov	x0, #0x60               // =96
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x14
               	sxtw	x0, w0
               	cmp	x0, #0x14
               	b.eq	0x40095c <.text+0x6dc>
               	mov	x0, #0x61               // =97
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x40096c <.text+0x6ec>
               	mov	x0, #0x64               // =100
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	0x400988 <.text+0x708>
               	mov	x15, #0x65              // =101
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x4
               	sxtw	x15, w15
               	cmp	x15, #0x4
               	b.eq	0x4009a8 <.text+0x728>
               	mov	x15, #0x66              // =102
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x8
               	sxtw	x15, w15
               	cmp	x15, #0x8
               	b.eq	0x4009c8 <.text+0x748>
               	mov	x15, #0x67              // =103
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0xc
               	sxtw	x15, w15
               	cmp	x15, #0xc
               	b.eq	0x4009e8 <.text+0x768>
               	mov	x15, #0x68              // =104
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x14
               	sxtw	x15, w15
               	cmp	x15, #0x14
               	b.eq	0x400a08 <.text+0x788>
               	mov	x15, #0x69              // =105
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x16
               	sxtw	x15, w15
               	cmp	x15, #0x16
               	b.eq	0x400a28 <.text+0x7a8>
               	mov	x15, #0x6a              // =106
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x18
               	sxtw	x15, w15
               	cmp	x15, #0x18
               	b.eq	0x400a48 <.text+0x7c8>
               	mov	x15, #0x6b              // =107
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, 0x400a5c <.text+0x7dc>
               	mov	x15, #0x6e              // =110
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x1
               	sxtw	x15, w15
               	cmp	x15, #0x1
               	b.eq	0x400a7c <.text+0x7fc>
               	mov	x15, #0x6f              // =111
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, 0x400a90 <.text+0x810>
               	mov	x15, #0x78              // =120
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x4
               	sxtw	x15, w15
               	cmp	x15, #0x4
               	b.eq	0x400ab0 <.text+0x830>
               	mov	x15, #0x79              // =121
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, 0x400ac4 <.text+0x844>
               	mov	x15, #0x82              // =130
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x1
               	sxtw	x15, w15
               	cmp	x15, #0x1
               	b.eq	0x400ae4 <.text+0x864>
               	mov	x15, #0x83              // =131
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, 0x400af8 <.text+0x878>
               	mov	x15, #0x8c              // =140
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	0x400b10 <.text+0x890>
               	mov	x0, #0x8d               // =141
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x4
               	sxtw	x0, w0
               	cmp	x0, #0x4
               	b.eq	0x400b2c <.text+0x8ac>
               	mov	x0, #0x8e               // =142
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x8
               	sxtw	x0, w0
               	cmp	x0, #0x8
               	b.eq	0x400b48 <.text+0x8c8>
               	mov	x0, #0x8f               // =143
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400b58 <.text+0x8d8>
               	mov	x0, #0x96               // =150
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400b68 <.text+0x8e8>
               	mov	x0, #0x97               // =151
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	0x400b84 <.text+0x904>
               	mov	x15, #0x98              // =152
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x1
               	sxtw	x15, w15
               	cmp	x15, #0x1
               	b.eq	0x400ba4 <.text+0x924>
               	mov	x15, #0x99              // =153
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x9
               	sxtw	x15, w15
               	cmp	x15, #0x9
               	b.eq	0x400bc4 <.text+0x944>
               	mov	x15, #0x9a              // =154
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, 0x400bd8 <.text+0x958>
               	mov	x15, #0xa0              // =160
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	0x400bf0 <.text+0x970>
               	mov	x0, #0xa1               // =161
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x2
               	sxtw	x0, w0
               	cmp	x0, #0x2
               	b.eq	0x400c0c <.text+0x98c>
               	mov	x0, #0xa2               // =162
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0xa
               	sxtw	x0, w0
               	cmp	x0, #0xa
               	b.eq	0x400c28 <.text+0x9a8>
               	mov	x0, #0xa3               // =163
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0xc
               	sxtw	x0, w0
               	cmp	x0, #0xc
               	b.eq	0x400c44 <.text+0x9c4>
               	mov	x0, #0xa4               // =164
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	ret
