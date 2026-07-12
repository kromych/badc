
ftw_walk.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x470              // =1136
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x180
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sub	x0, x29, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldrb	w10, [x1, #0x10]
               	strb	w10, [x0, #0x10]
               	ldrb	w10, [x1, #0x11]
               	strb	w10, [x0, #0x11]
               	ldrb	w10, [x1, #0x12]
               	strb	w10, [x0, #0x12]
               	ldrb	w10, [x1, #0x13]
               	strb	w10, [x0, #0x13]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x18
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	b	<addr>
               	sub	x0, x29, #0x118
               	mov	x1, #0x100              // =256
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x3, x29, #0x18
               	sxtw	x4, w20
               	bl	<addr>
               	sxtw	x0, w0
               	sub	x0, x29, #0x118
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	bl	<addr>
               	sxtw	x0, w0
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	sxtw	x0, w20
               	cmp	x0, #0x3
               	b.lt	<addr>
               	sub	x0, x29, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x4
               	cset	x0, ge
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
