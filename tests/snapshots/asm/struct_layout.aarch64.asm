
struct_layout.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x4003d0 <.text+0x150>
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
               	mov	x11, x0
               	cbz	x11, 0x400398 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x12, x22, x21
               	ldr	x21, [x11]
               	str	x21, [x12]
               	b	0x400398 <.text+0x118>
               	adrp	x19, 0x410000
               	add	x19, x19, #0xf8
               	mov	x21, x19
               	lsl	x11, x20, #3
               	add	x20, x21, x11
               	ldr	x11, [x20]
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x4003e0 <.text+0x160>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	0x4003fc <.text+0x17c>
               	mov	x15, #0x2               // =2
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x4
               	sxtw	x15, w15
               	cmp	x15, #0x4
               	b.eq	0x40041c <.text+0x19c>
               	mov	x15, #0x3               // =3
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x8
               	sxtw	x15, w15
               	cmp	x15, #0x8
               	b.eq	0x40043c <.text+0x1bc>
               	mov	x15, #0x4               // =4
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x10
               	sxtw	x15, w15
               	cmp	x15, #0x10
               	b.eq	0x40045c <.text+0x1dc>
               	mov	x15, #0x5               // =5
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x18
               	sxtw	x15, w15
               	cmp	x15, #0x18
               	b.eq	0x40047c <.text+0x1fc>
               	mov	x15, #0x6               // =6
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x1a
               	sxtw	x15, w15
               	cmp	x15, #0x1a
               	b.eq	0x40049c <.text+0x21c>
               	mov	x15, #0x7               // =7
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x20
               	sxtw	x15, w15
               	cmp	x15, #0x20
               	b.eq	0x4004bc <.text+0x23c>
               	mov	x15, #0x8               // =8
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, 0x4004d0 <.text+0x250>
               	mov	x15, #0xa               // =10
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	0x4004e8 <.text+0x268>
               	mov	x0, #0xb                // =11
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x1
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.eq	0x400504 <.text+0x284>
               	mov	x0, #0xc                // =12
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x2
               	sxtw	x0, w0
               	cmp	x0, #0x2
               	b.eq	0x400520 <.text+0x2a0>
               	mov	x0, #0xd                // =13
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x3
               	sxtw	x0, w0
               	cmp	x0, #0x3
               	b.eq	0x40053c <.text+0x2bc>
               	mov	x0, #0xe                // =14
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x40054c <.text+0x2cc>
               	mov	x0, #0x14               // =20
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	0x400568 <.text+0x2e8>
               	mov	x15, #0x15              // =21
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x4
               	sxtw	x15, w15
               	cmp	x15, #0x4
               	b.eq	0x400588 <.text+0x308>
               	mov	x15, #0x16              // =22
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x8
               	sxtw	x15, w15
               	cmp	x15, #0x8
               	b.eq	0x4005a8 <.text+0x328>
               	mov	x15, #0x17              // =23
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, 0x4005bc <.text+0x33c>
               	mov	x15, #0x1e              // =30
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	0x4005d4 <.text+0x354>
               	mov	x0, #0x1f               // =31
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x4
               	sxtw	x0, w0
               	cmp	x0, #0x4
               	b.eq	0x4005f0 <.text+0x370>
               	mov	x0, #0x20               // =32
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x10
               	sxtw	x0, w0
               	cmp	x0, #0x10
               	b.eq	0x40060c <.text+0x38c>
               	mov	x0, #0x21               // =33
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x40061c <.text+0x39c>
               	mov	x0, #0x28               // =40
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	0x400638 <.text+0x3b8>
               	mov	x15, #0x29              // =41
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x8
               	sxtw	x15, w15
               	cmp	x15, #0x8
               	b.eq	0x400658 <.text+0x3d8>
               	mov	x15, #0x2a              // =42
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x20
               	sxtw	x15, w15
               	cmp	x15, #0x20
               	b.eq	0x400678 <.text+0x3f8>
               	mov	x15, #0x2b              // =43
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, 0x40068c <.text+0x40c>
               	mov	x15, #0x32              // =50
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, 0x4006a0 <.text+0x420>
               	mov	x15, #0x33              // =51
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	0x4006b8 <.text+0x438>
               	mov	x0, #0x34               // =52
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x24
               	sxtw	x0, w0
               	cmp	x0, #0x24
               	b.eq	0x4006d4 <.text+0x454>
               	mov	x0, #0x35               // =53
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x4006e4 <.text+0x464>
               	mov	x0, #0x3c               // =60
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x4006f4 <.text+0x474>
               	mov	x0, #0x3d               // =61
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	0x400710 <.text+0x490>
               	mov	x15, #0x3e              // =62
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x8
               	sxtw	x15, w15
               	cmp	x15, #0x8
               	b.eq	0x400730 <.text+0x4b0>
               	mov	x15, #0x3f              // =63
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x18
               	sxtw	x15, w15
               	cmp	x15, #0x18
               	b.eq	0x400750 <.text+0x4d0>
               	mov	x15, #0x40              // =64
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, 0x400764 <.text+0x4e4>
               	mov	x15, #0x46              // =70
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	0x40077c <.text+0x4fc>
               	mov	x0, #0x47               // =71
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x1
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.eq	0x400798 <.text+0x518>
               	mov	x0, #0x48               // =72
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x5
               	sxtw	x0, w0
               	cmp	x0, #0x5
               	b.eq	0x4007b4 <.text+0x534>
               	mov	x0, #0x49               // =73
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x6
               	sxtw	x0, w0
               	cmp	x0, #0x6
               	b.eq	0x4007d0 <.text+0x550>
               	mov	x0, #0x4a               // =74
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0xe
               	sxtw	x0, w0
               	cmp	x0, #0xe
               	b.eq	0x4007ec <.text+0x56c>
               	mov	x0, #0x4b               // =75
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x10
               	sxtw	x0, w0
               	cmp	x0, #0x10
               	b.eq	0x400808 <.text+0x588>
               	mov	x0, #0x4c               // =76
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x11
               	sxtw	x0, w0
               	cmp	x0, #0x11
               	b.eq	0x400824 <.text+0x5a4>
               	mov	x0, #0x4d               // =77
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400834 <.text+0x5b4>
               	mov	x0, #0x50               // =80
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	0x400850 <.text+0x5d0>
               	mov	x15, #0x51              // =81
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x1
               	sxtw	x15, w15
               	cmp	x15, #0x1
               	b.eq	0x400870 <.text+0x5f0>
               	mov	x15, #0x52              // =82
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x1a
               	sxtw	x15, w15
               	cmp	x15, #0x1a
               	b.eq	0x400890 <.text+0x610>
               	mov	x15, #0x53              // =83
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, 0x4008a4 <.text+0x624>
               	mov	x15, #0x5a              // =90
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	0x4008bc <.text+0x63c>
               	mov	x0, #0x5b               // =91
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x2
               	sxtw	x0, w0
               	cmp	x0, #0x2
               	b.eq	0x4008d8 <.text+0x658>
               	mov	x0, #0x5c               // =92
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x6
               	sxtw	x0, w0
               	cmp	x0, #0x6
               	b.eq	0x4008f4 <.text+0x674>
               	mov	x0, #0x5d               // =93
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x8
               	sxtw	x0, w0
               	cmp	x0, #0x8
               	b.eq	0x400910 <.text+0x690>
               	mov	x0, #0x5e               // =94
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x10
               	sxtw	x0, w0
               	cmp	x0, #0x10
               	b.eq	0x40092c <.text+0x6ac>
               	mov	x0, #0x5f               // =95
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x12
               	sxtw	x0, w0
               	cmp	x0, #0x12
               	b.eq	0x400948 <.text+0x6c8>
               	mov	x0, #0x60               // =96
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x14
               	sxtw	x0, w0
               	cmp	x0, #0x14
               	b.eq	0x400964 <.text+0x6e4>
               	mov	x0, #0x61               // =97
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400974 <.text+0x6f4>
               	mov	x0, #0x64               // =100
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	0x400990 <.text+0x710>
               	mov	x15, #0x65              // =101
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x4
               	sxtw	x15, w15
               	cmp	x15, #0x4
               	b.eq	0x4009b0 <.text+0x730>
               	mov	x15, #0x66              // =102
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x8
               	sxtw	x15, w15
               	cmp	x15, #0x8
               	b.eq	0x4009d0 <.text+0x750>
               	mov	x15, #0x67              // =103
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0xc
               	sxtw	x15, w15
               	cmp	x15, #0xc
               	b.eq	0x4009f0 <.text+0x770>
               	mov	x15, #0x68              // =104
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x14
               	sxtw	x15, w15
               	cmp	x15, #0x14
               	b.eq	0x400a10 <.text+0x790>
               	mov	x15, #0x69              // =105
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x16
               	sxtw	x15, w15
               	cmp	x15, #0x16
               	b.eq	0x400a30 <.text+0x7b0>
               	mov	x15, #0x6a              // =106
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x18
               	sxtw	x15, w15
               	cmp	x15, #0x18
               	b.eq	0x400a50 <.text+0x7d0>
               	mov	x15, #0x6b              // =107
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, 0x400a64 <.text+0x7e4>
               	mov	x15, #0x6e              // =110
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x1
               	sxtw	x15, w15
               	cmp	x15, #0x1
               	b.eq	0x400a84 <.text+0x804>
               	mov	x15, #0x6f              // =111
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, 0x400a98 <.text+0x818>
               	mov	x15, #0x78              // =120
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x4
               	sxtw	x15, w15
               	cmp	x15, #0x4
               	b.eq	0x400ab8 <.text+0x838>
               	mov	x15, #0x79              // =121
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, 0x400acc <.text+0x84c>
               	mov	x15, #0x82              // =130
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x1
               	sxtw	x15, w15
               	cmp	x15, #0x1
               	b.eq	0x400aec <.text+0x86c>
               	mov	x15, #0x83              // =131
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, 0x400b00 <.text+0x880>
               	mov	x15, #0x8c              // =140
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	0x400b18 <.text+0x898>
               	mov	x0, #0x8d               // =141
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x4
               	sxtw	x0, w0
               	cmp	x0, #0x4
               	b.eq	0x400b34 <.text+0x8b4>
               	mov	x0, #0x8e               // =142
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x8
               	sxtw	x0, w0
               	cmp	x0, #0x8
               	b.eq	0x400b50 <.text+0x8d0>
               	mov	x0, #0x8f               // =143
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400b60 <.text+0x8e0>
               	mov	x0, #0x96               // =150
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x400b70 <.text+0x8f0>
               	mov	x0, #0x97               // =151
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	0x400b8c <.text+0x90c>
               	mov	x15, #0x98              // =152
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x1
               	sxtw	x15, w15
               	cmp	x15, #0x1
               	b.eq	0x400bac <.text+0x92c>
               	mov	x15, #0x99              // =153
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	add	x15, x0, #0x9
               	sxtw	x15, w15
               	cmp	x15, #0x9
               	b.eq	0x400bcc <.text+0x94c>
               	mov	x15, #0x9a              // =154
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, 0x400be0 <.text+0x960>
               	mov	x15, #0xa0              // =160
               	mov	x0, x15
               	ret
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	0x400bf8 <.text+0x978>
               	mov	x0, #0xa1               // =161
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0x2
               	sxtw	x0, w0
               	cmp	x0, #0x2
               	b.eq	0x400c14 <.text+0x994>
               	mov	x0, #0xa2               // =162
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0xa
               	sxtw	x0, w0
               	cmp	x0, #0xa
               	b.eq	0x400c30 <.text+0x9b0>
               	mov	x0, #0xa3               // =163
               	ret
               	mov	x15, #0x0               // =0
               	add	x0, x15, #0xc
               	sxtw	x0, w0
               	cmp	x0, #0xc
               	b.eq	0x400c4c <.text+0x9cc>
               	mov	x0, #0xa4               // =164
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	ret
