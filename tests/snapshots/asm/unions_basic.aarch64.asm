
unions_basic.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
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
               	ldrsw	x13, [x13]
               	cmp	x13, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x8
               	mov	x0, #0x0                // =0
               	str	w0, [x13]
               	sub	x15, x29, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0xd0
               	mov	x0, x19
               	str	x0, [x15]
               	sub	x13, x29, #0x8
               	ldr	x13, [x13]
               	ldrb	w13, [x13]
               	mov	x17, #0x68              // =104
               	eor	x13, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	cmp	x13, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x8
               	ldr	x13, [x13]
               	add	x13, x13, #0x1
               	ldrb	w13, [x13]
               	mov	x17, #0x69              // =105
               	eor	x13, x13, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x13, x13, x17
               	cmp	x13, #0x0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x13, x29, #0x8
               	mov	x0, #0x400c000000000000 // =4615063718147915776
               	str	x0, [x13]
               	sub	x15, x29, #0x8
               	ldr	x15, [x15]
               	mov	x0, #0x3333             // =13107
               	movk	x0, #0x3333, lsl #16
               	movk	x0, #0x3333, lsl #32
               	movk	x0, #0x400b, lsl #48
               	fmov	d0, x15
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x15, mi
               	cbz	x15, <addr>
               	mov	x0, #0x4                // =4
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x8
               	ldr	x15, [x15]
               	mov	x0, #0xcccd             // =52429
               	movk	x0, #0xcccc, lsl #16
               	movk	x0, #0xcccc, lsl #32
               	movk	x0, #0x400c, lsl #48
               	fmov	d0, x15
               	fmov	d1, x0
               	fcmp	d0, d1
               	cset	x15, gt
               	cbz	x15, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x6                // =6
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x18
               	mov	x0, #0x1                // =1
               	str	w0, [x15]
               	sub	x13, x29, #0x18
               	add	x13, x13, #0x8
               	mov	x0, #0x64               // =100
               	str	w0, [x13]
               	sub	x15, x29, #0x18
               	ldrsw	x15, [x15]
               	cmp	x15, #0x1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x18
               	add	x15, x15, #0x8
               	ldrsw	x15, [x15]
               	cmp	x15, #0x64
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x18
               	mov	x0, #0x2                // =2
               	str	w0, [x15]
               	sub	x13, x29, #0x18
               	add	x13, x13, #0x8
               	adrp	x19, <page>
               	add	x19, x19, #0xd3
               	mov	x0, x19
               	str	x0, [x13]
               	sub	x15, x29, #0x18
               	ldrsw	x15, [x15]
               	cmp	x15, #0x2
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x18
               	add	x15, x15, #0x8
               	ldr	x15, [x15]
               	ldrb	w15, [x15]
               	mov	x17, #0x79              // =121
               	eor	x15, x15, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x15, x15, x17
               	cmp	x15, #0x0
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0xb                // =11
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	ldr	x19, [sp]
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
