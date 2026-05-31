
unions_basic.aarch64:	file format elf64-littleaarch64

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
               	str	x19, [sp]
               	sub	x15, x29, #0x8
               	mov	x14, #0x2a              // =42
               	str	w14, [x15]
               	sub	x13, x29, #0x8
               	ldrsw	x14, [x13]
               	cmp	x14, #0x2a
               	b.eq	0x400278 <.text+0x58>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x8
               	mov	x0, #0x0                // =0
               	str	w0, [x14]
               	sub	x15, x29, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd0
               	mov	x0, x19
               	str	x0, [x15]
               	sub	x14, x29, #0x8
               	ldr	x0, [x14]
               	ldrb	w14, [x0]
               	mov	x17, #0x68              // =104
               	eor	x14, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x14, x17
               	cmp	x14, #0x0
               	b.eq	0x4002d4 <.text+0xb4>
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x8
               	ldr	x0, [x14]
               	add	x0, x0, #0x1
               	ldrb	w14, [x0]
               	mov	x17, #0x69              // =105
               	eor	x14, x14, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x14, x14, x17
               	cmp	x14, #0x0
               	b.eq	0x400314 <.text+0xf4>
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x8
               	mov	x0, #0x400c000000000000 // =4615063718147915776
               	str	x0, [x14]
               	sub	x15, x29, #0x8
               	ldr	x0, [x15]
               	mov	x15, #0x3333            // =13107
               	movk	x15, #0x3333, lsl #16
               	movk	x15, #0x3333, lsl #32
               	movk	x15, #0x400b, lsl #48
               	fmov	d0, x0
               	fmov	d1, x15
               	fcmp	d0, d1
               	cset	x0, mi
               	cbz	x0, 0x400364 <.text+0x144>
               	mov	x15, #0x4               // =4
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldr	x15, [x0]
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0xcccc, lsl #16
               	movk	x0, #0xcccc, lsl #32
               	movk	x0, #0x400c, lsl #48
               	fmov	d0, x15
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x15, gt
               	cbz	x15, 0x4003a4 <.text+0x184>
               	mov	x0, #0x5                // =5
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, 0x4003c0 <.text+0x1a0>
               	mov	x0, #0x6                // =6
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x18
               	mov	x0, #0x1                // =1
               	str	w0, [x15]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x8
               	mov	x0, #0x64               // =100
               	str	w0, [x14]
               	sub	x15, x29, #0x18
               	ldrsw	x0, [x15]
               	cmp	x0, #0x1
               	b.eq	0x400404 <.text+0x1e4>
               	mov	x15, #0x7               // =7
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x8
               	ldrsw	x15, [x0]
               	cmp	x15, #0x64
               	b.eq	0x40042c <.text+0x20c>
               	mov	x0, #0x8                // =8
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x18
               	mov	x0, #0x2                // =2
               	str	w0, [x15]
               	sub	x14, x29, #0x18
               	add	x14, x14, #0x8
               	adrp	x19, 0x410000
               	add	x19, x19, #0xd3
               	mov	x0, x19
               	str	x0, [x14]
               	sub	x15, x29, #0x18
               	ldrsw	x0, [x15]
               	cmp	x0, #0x2
               	b.eq	0x400478 <.text+0x258>
               	mov	x15, #0x9               // =9
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	add	x0, x0, #0x8
               	ldr	x15, [x0]
               	ldrb	w0, [x15]
               	mov	x17, #0x79              // =121
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.eq	0x4004bc <.text+0x29c>
               	mov	x15, #0xa               // =10
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	cbz	x0, 0x4004dc <.text+0x2bc>
               	mov	x15, #0xb               // =11
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
