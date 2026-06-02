
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
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sxtw	x20, w0
               	adrp	x14, <page>
               	add	x14, x14, #0xf8
               	lsl	x13, x20, #3
               	add	x14, x14, x13
               	ldr	x14, [x14]
               	cbz	x14, <addr>
               	adrp	x13, <page>
               	add	x13, x13, #0xf8
               	lsl	x14, x20, #3
               	add	x13, x13, x14
               	ldr	x13, [x13]
               	mov	x0, x13
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x18
               	mov	x0, #0x0                // =0
               	adrp	x12, <page>
               	add	x12, x12, #0x110
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	add	x11, x11, #0x8
               	adrp	x12, <page>
               	add	x12, x12, #0x116
               	str	x12, [x11]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x10
               	adrp	x12, <page>
               	add	x12, x12, #0x11d
               	str	x12, [x14]
               	sub	x11, x29, #0x18
               	lsl	x12, x20, #3
               	add	x11, x11, x12
               	ldr	x1, [x11]
               	bl	<addr>
               	mov	x11, x0
               	cbz	x11, <addr>
               	adrp	x1, <page>
               	add	x1, x1, #0xf8
               	lsl	x0, x20, #3
               	add	x1, x1, x0
               	ldr	x11, [x11]
               	str	x11, [x1]
               	b	<addr>
               	adrp	x11, <page>
               	add	x11, x11, #0xf8
               	lsl	x20, x20, #3
               	add	x11, x11, x20
               	ldr	x11, [x11]
               	mov	x0, x11
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	b	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	b	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	b	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	b	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	b	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	b	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	b	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	b	<addr>
               	mov	x0, #0xa                // =10
               	ret
               	b	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	b	<addr>
               	mov	x0, #0xc                // =12
               	ret
               	b	<addr>
               	mov	x0, #0xd                // =13
               	ret
               	b	<addr>
               	mov	x0, #0xe                // =14
               	ret
               	b	<addr>
               	mov	x0, #0x14               // =20
               	ret
               	b	<addr>
               	mov	x0, #0x15               // =21
               	ret
               	b	<addr>
               	mov	x0, #0x16               // =22
               	ret
               	b	<addr>
               	mov	x0, #0x17               // =23
               	ret
               	b	<addr>
               	mov	x0, #0x1e               // =30
               	ret
               	b	<addr>
               	mov	x0, #0x1f               // =31
               	ret
               	b	<addr>
               	mov	x0, #0x20               // =32
               	ret
               	b	<addr>
               	mov	x0, #0x21               // =33
               	ret
               	b	<addr>
               	mov	x0, #0x28               // =40
               	ret
               	b	<addr>
               	mov	x0, #0x29               // =41
               	ret
               	b	<addr>
               	mov	x0, #0x2a               // =42
               	ret
               	b	<addr>
               	mov	x0, #0x2b               // =43
               	ret
               	b	<addr>
               	mov	x0, #0x32               // =50
               	ret
               	b	<addr>
               	mov	x0, #0x33               // =51
               	ret
               	b	<addr>
               	mov	x0, #0x34               // =52
               	ret
               	b	<addr>
               	mov	x0, #0x35               // =53
               	ret
               	b	<addr>
               	mov	x0, #0x3c               // =60
               	ret
               	b	<addr>
               	mov	x0, #0x3d               // =61
               	ret
               	b	<addr>
               	mov	x0, #0x3e               // =62
               	ret
               	b	<addr>
               	mov	x0, #0x3f               // =63
               	ret
               	b	<addr>
               	mov	x0, #0x40               // =64
               	ret
               	b	<addr>
               	mov	x0, #0x46               // =70
               	ret
               	b	<addr>
               	mov	x0, #0x47               // =71
               	ret
               	b	<addr>
               	mov	x0, #0x48               // =72
               	ret
               	b	<addr>
               	mov	x0, #0x49               // =73
               	ret
               	b	<addr>
               	mov	x0, #0x4a               // =74
               	ret
               	b	<addr>
               	mov	x0, #0x4b               // =75
               	ret
               	b	<addr>
               	mov	x0, #0x4c               // =76
               	ret
               	b	<addr>
               	mov	x0, #0x4d               // =77
               	ret
               	b	<addr>
               	mov	x0, #0x50               // =80
               	ret
               	b	<addr>
               	mov	x0, #0x51               // =81
               	ret
               	b	<addr>
               	mov	x0, #0x52               // =82
               	ret
               	b	<addr>
               	mov	x0, #0x53               // =83
               	ret
               	b	<addr>
               	mov	x0, #0x5a               // =90
               	ret
               	b	<addr>
               	mov	x0, #0x5b               // =91
               	ret
               	b	<addr>
               	mov	x0, #0x5c               // =92
               	ret
               	b	<addr>
               	mov	x0, #0x5d               // =93
               	ret
               	b	<addr>
               	mov	x0, #0x5e               // =94
               	ret
               	b	<addr>
               	mov	x0, #0x5f               // =95
               	ret
               	b	<addr>
               	mov	x0, #0x60               // =96
               	ret
               	b	<addr>
               	mov	x0, #0x61               // =97
               	ret
               	b	<addr>
               	mov	x0, #0x64               // =100
               	ret
               	b	<addr>
               	mov	x0, #0x65               // =101
               	ret
               	b	<addr>
               	mov	x0, #0x66               // =102
               	ret
               	b	<addr>
               	mov	x0, #0x67               // =103
               	ret
               	b	<addr>
               	mov	x0, #0x68               // =104
               	ret
               	b	<addr>
               	mov	x0, #0x69               // =105
               	ret
               	b	<addr>
               	mov	x0, #0x6a               // =106
               	ret
               	b	<addr>
               	mov	x0, #0x6b               // =107
               	ret
               	b	<addr>
               	mov	x0, #0x6e               // =110
               	ret
               	b	<addr>
               	mov	x0, #0x6f               // =111
               	ret
               	b	<addr>
               	mov	x0, #0x78               // =120
               	ret
               	b	<addr>
               	mov	x0, #0x79               // =121
               	ret
               	b	<addr>
               	mov	x0, #0x82               // =130
               	ret
               	b	<addr>
               	mov	x0, #0x83               // =131
               	ret
               	b	<addr>
               	mov	x0, #0x8c               // =140
               	ret
               	b	<addr>
               	mov	x0, #0x8d               // =141
               	ret
               	b	<addr>
               	mov	x0, #0x8e               // =142
               	ret
               	b	<addr>
               	mov	x0, #0x8f               // =143
               	ret
               	b	<addr>
               	mov	x0, #0x96               // =150
               	ret
               	b	<addr>
               	mov	x0, #0x97               // =151
               	ret
               	b	<addr>
               	mov	x0, #0x98               // =152
               	ret
               	b	<addr>
               	mov	x0, #0x99               // =153
               	ret
               	b	<addr>
               	mov	x0, #0x9a               // =154
               	ret
               	b	<addr>
               	mov	x0, #0xa0               // =160
               	ret
               	b	<addr>
               	mov	x0, #0xa1               // =161
               	ret
               	b	<addr>
               	mov	x0, #0xa2               // =162
               	ret
               	b	<addr>
               	mov	x0, #0xa3               // =163
               	ret
               	b	<addr>
               	mov	x0, #0xa4               // =164
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	ret
