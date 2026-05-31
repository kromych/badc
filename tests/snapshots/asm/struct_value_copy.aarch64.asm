
struct_value_copy.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400238 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x15, x29, #0x8
               	mov	x14, #0x1               // =1
               	str	w14, [x15]
               	sub	x13, x29, #0x8
               	add	x14, x13, #0x4
               	mov	x13, #0x2               // =2
               	str	w13, [x14]
               	sub	x15, x29, #0x10
               	mov	x13, #0x63              // =99
               	str	w13, [x15]
               	sub	x14, x29, #0x10
               	add	x15, x14, #0x4
               	str	w13, [x15]
               	sub	x14, x29, #0x10
               	sub	x15, x29, #0x8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x15]
               	str	x10, [x14]
               	ldr	x10, [sp], #0x10
               	mov	x13, x14
               	sub	x13, x29, #0x10
               	ldrsw	x15, [x13]
               	cmp	x15, #0x1
               	b.eq	0x4002b4 <.text+0x94>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x10
               	add	x0, x13, #0x4
               	ldrsw	x13, [x0]
               	cmp	x13, #0x2
               	b.eq	0x4002dc <.text+0xbc>
               	mov	x13, #0x2               // =2
               	mov	x0, x13
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	mov	x13, #0x3e8             // =1000
               	str	w13, [x0]
               	sub	x14, x29, #0x8
               	add	x13, x14, #0x4
               	mov	x14, #0x7d0             // =2000
               	str	w14, [x13]
               	sub	x0, x29, #0x10
               	ldrsw	x14, [x0]
               	cmp	x14, #0x1
               	b.eq	0x40031c <.text+0xfc>
               	mov	x14, #0x3               // =3
               	mov	x0, x14
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	add	x14, x0, #0x4
               	ldrsw	x0, [x14]
               	cmp	x0, #0x2
               	b.eq	0x400340 <.text+0x120>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x20
               	mov	x0, #0x7                // =7
               	str	w0, [x14]
               	sub	x13, x29, #0x20
               	add	x0, x13, #0x4
               	mov	x13, #0xe               // =14
               	str	w13, [x0]
               	sub	x14, x29, #0x20
               	add	x13, x14, #0x8
               	mov	x14, #0x15              // =21
               	str	w14, [x13]
               	sub	x0, x29, #0x30
               	sub	x14, x29, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x14]
               	str	x10, [x0]
               	ldrb	w10, [x14, #0x8]
               	strb	w10, [x0, #0x8]
               	ldrb	w10, [x14, #0x9]
               	strb	w10, [x0, #0x9]
               	ldrb	w10, [x14, #0xa]
               	strb	w10, [x0, #0xa]
               	ldrb	w10, [x14, #0xb]
               	strb	w10, [x0, #0xb]
               	ldr	x10, [sp], #0x10
               	mov	x13, x0
               	sub	x13, x29, #0x30
               	ldrsw	x14, [x13]
               	cmp	x14, #0x7
               	b.eq	0x4003c8 <.text+0x1a8>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x30
               	add	x0, x13, #0x4
               	ldrsw	x13, [x0]
               	cmp	x13, #0xe
               	b.eq	0x4003f0 <.text+0x1d0>
               	mov	x13, #0x6               // =6
               	mov	x0, x13
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	add	x13, x0, #0x8
               	ldrsw	x0, [x13]
               	cmp	x0, #0x15
               	b.eq	0x400414 <.text+0x1f4>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x8
               	mov	x0, #0x32               // =50
               	str	w0, [x13]
               	sub	x14, x29, #0x8
               	add	x0, x14, #0x4
               	mov	x14, #0x3c              // =60
               	str	w14, [x0]
               	sub	x13, x29, #0x8
               	sub	x14, x29, #0x8
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x14]
               	str	x10, [x13]
               	ldr	x10, [sp], #0x10
               	mov	x0, x13
               	sub	x0, x29, #0x8
               	ldrsw	x14, [x0]
               	cmp	x14, #0x32
               	b.eq	0x400470 <.text+0x250>
               	mov	x14, #0x8               // =8
               	mov	x0, x14
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	add	x14, x0, #0x4
               	ldrsw	x0, [x14]
               	cmp	x0, #0x3c
               	b.eq	0x400494 <.text+0x274>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
