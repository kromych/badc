
struct_layout.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
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
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x13, [x14]
               	cbz	x13, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x14, x19
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x0, [x14]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x21, #0x0               // =0
               	adrp	x19, <page>
               	add	x19, x19, #0x110
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0x116
               	mov	x12, x19
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x19, <page>
               	add	x19, x19, #0x11d
               	mov	x12, x19
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x22, [x11]
               	mov	x0, x21
               	mov	x1, x22
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x22, x19
               	lsl	x21, x20, #3
               	add	x22, x22, x21
               	ldr	x21, [x0]
               	str	x21, [x22]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x21, x19
               	lsl	x20, x20, #3
               	add	x21, x21, x20
               	ldr	x0, [x21]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x4
               	sxtw	x15, w15
               	cmp	x15, #0x4
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x8
               	sxtw	x15, w15
               	cmp	x15, #0x8
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x10
               	sxtw	x15, w15
               	cmp	x15, #0x10
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x18
               	sxtw	x15, w15
               	cmp	x15, #0x18
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x1a
               	sxtw	x15, w15
               	cmp	x15, #0x1a
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x20
               	sxtw	x15, w15
               	cmp	x15, #0x20
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0xa                // =10
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x1
               	sxtw	x15, w15
               	cmp	x15, #0x1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x2
               	sxtw	x15, w15
               	cmp	x15, #0x2
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x3
               	sxtw	x15, w15
               	cmp	x15, #0x3
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x14               // =20
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x4
               	sxtw	x15, w15
               	cmp	x15, #0x4
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x8
               	sxtw	x15, w15
               	cmp	x15, #0x8
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x1e               // =30
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x4
               	sxtw	x15, w15
               	cmp	x15, #0x4
               	b.eq	<addr>
               	mov	x0, #0x20               // =32
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x10
               	sxtw	x15, w15
               	cmp	x15, #0x10
               	b.eq	<addr>
               	mov	x0, #0x21               // =33
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x28               // =40
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x29               // =41
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x8
               	sxtw	x15, w15
               	cmp	x15, #0x8
               	b.eq	<addr>
               	mov	x0, #0x2a               // =42
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x20
               	sxtw	x15, w15
               	cmp	x15, #0x20
               	b.eq	<addr>
               	mov	x0, #0x2b               // =43
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x32               // =50
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x33               // =51
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x34               // =52
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x24
               	sxtw	x15, w15
               	cmp	x15, #0x24
               	b.eq	<addr>
               	mov	x0, #0x35               // =53
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x3c               // =60
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x3d               // =61
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x3e               // =62
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x8
               	sxtw	x15, w15
               	cmp	x15, #0x8
               	b.eq	<addr>
               	mov	x0, #0x3f               // =63
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x18
               	sxtw	x15, w15
               	cmp	x15, #0x18
               	b.eq	<addr>
               	mov	x0, #0x40               // =64
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x46               // =70
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x47               // =71
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x1
               	sxtw	x15, w15
               	cmp	x15, #0x1
               	b.eq	<addr>
               	mov	x0, #0x48               // =72
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x5
               	sxtw	x15, w15
               	cmp	x15, #0x5
               	b.eq	<addr>
               	mov	x0, #0x49               // =73
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x6
               	sxtw	x15, w15
               	cmp	x15, #0x6
               	b.eq	<addr>
               	mov	x0, #0x4a               // =74
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0xe
               	sxtw	x15, w15
               	cmp	x15, #0xe
               	b.eq	<addr>
               	mov	x0, #0x4b               // =75
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x10
               	sxtw	x15, w15
               	cmp	x15, #0x10
               	b.eq	<addr>
               	mov	x0, #0x4c               // =76
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x11
               	sxtw	x15, w15
               	cmp	x15, #0x11
               	b.eq	<addr>
               	mov	x0, #0x4d               // =77
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x50               // =80
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x51               // =81
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x1
               	sxtw	x15, w15
               	cmp	x15, #0x1
               	b.eq	<addr>
               	mov	x0, #0x52               // =82
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x1a
               	sxtw	x15, w15
               	cmp	x15, #0x1a
               	b.eq	<addr>
               	mov	x0, #0x53               // =83
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x5a               // =90
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x5b               // =91
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x2
               	sxtw	x15, w15
               	cmp	x15, #0x2
               	b.eq	<addr>
               	mov	x0, #0x5c               // =92
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x6
               	sxtw	x15, w15
               	cmp	x15, #0x6
               	b.eq	<addr>
               	mov	x0, #0x5d               // =93
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x8
               	sxtw	x15, w15
               	cmp	x15, #0x8
               	b.eq	<addr>
               	mov	x0, #0x5e               // =94
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x10
               	sxtw	x15, w15
               	cmp	x15, #0x10
               	b.eq	<addr>
               	mov	x0, #0x5f               // =95
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x12
               	sxtw	x15, w15
               	cmp	x15, #0x12
               	b.eq	<addr>
               	mov	x0, #0x60               // =96
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x14
               	sxtw	x15, w15
               	cmp	x15, #0x14
               	b.eq	<addr>
               	mov	x0, #0x61               // =97
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x64               // =100
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x65               // =101
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x4
               	sxtw	x15, w15
               	cmp	x15, #0x4
               	b.eq	<addr>
               	mov	x0, #0x66               // =102
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x8
               	sxtw	x15, w15
               	cmp	x15, #0x8
               	b.eq	<addr>
               	mov	x0, #0x67               // =103
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0xc
               	sxtw	x15, w15
               	cmp	x15, #0xc
               	b.eq	<addr>
               	mov	x0, #0x68               // =104
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x14
               	sxtw	x15, w15
               	cmp	x15, #0x14
               	b.eq	<addr>
               	mov	x0, #0x69               // =105
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x16
               	sxtw	x15, w15
               	cmp	x15, #0x16
               	b.eq	<addr>
               	mov	x0, #0x6a               // =106
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x18
               	sxtw	x15, w15
               	cmp	x15, #0x18
               	b.eq	<addr>
               	mov	x0, #0x6b               // =107
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x6e               // =110
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x1
               	sxtw	x15, w15
               	cmp	x15, #0x1
               	b.eq	<addr>
               	mov	x0, #0x6f               // =111
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x78               // =120
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x4
               	sxtw	x15, w15
               	cmp	x15, #0x4
               	b.eq	<addr>
               	mov	x0, #0x79               // =121
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x82               // =130
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x1
               	sxtw	x15, w15
               	cmp	x15, #0x1
               	b.eq	<addr>
               	mov	x0, #0x83               // =131
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x8c               // =140
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x8d               // =141
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x4
               	sxtw	x15, w15
               	cmp	x15, #0x4
               	b.eq	<addr>
               	mov	x0, #0x8e               // =142
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x8
               	sxtw	x15, w15
               	cmp	x15, #0x8
               	b.eq	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x96               // =150
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x97               // =151
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0x98               // =152
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x1
               	sxtw	x15, w15
               	cmp	x15, #0x1
               	b.eq	<addr>
               	mov	x0, #0x99               // =153
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x9
               	sxtw	x15, w15
               	cmp	x15, #0x9
               	b.eq	<addr>
               	mov	x0, #0x9a               // =154
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0xa0               // =160
               	ret
               	mov	x15, #0x0               // =0
               	sxtw	x15, w15
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0xa1               // =161
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0x2
               	sxtw	x15, w15
               	cmp	x15, #0x2
               	b.eq	<addr>
               	mov	x0, #0xa2               // =162
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0xa
               	sxtw	x15, w15
               	cmp	x15, #0xa
               	b.eq	<addr>
               	mov	x0, #0xa3               // =163
               	ret
               	mov	x15, #0x0               // =0
               	add	x15, x15, #0xc
               	sxtw	x15, w15
               	cmp	x15, #0xc
               	b.eq	<addr>
               	mov	x0, #0xa4               // =164
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	ret
