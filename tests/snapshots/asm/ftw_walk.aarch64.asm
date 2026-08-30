
ftw_walk.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<visit>:
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x160]!
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x150]
               	add	x29, sp, #0x150
               	sub	x21, x29, #0x118
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x21]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x21, #0x8]
               	ldrb	w10, [x0, #0x10]
               	strb	w10, [x21, #0x10]
               	ldrb	w10, [x0, #0x11]
               	strb	w10, [x21, #0x11]
               	ldrb	w10, [x0, #0x12]
               	strb	w10, [x21, #0x12]
               	ldrb	w10, [x0, #0x13]
               	strb	w10, [x21, #0x13]
               	ldr	x10, [sp], #0x10
               	mov	x0, x21
               	mov	x0, x21
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x150]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x160
               	ret
               	sub	x20, x29, #0x100
               	mov	x22, #0x100             // =256
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x4, #0x0                // =0
               	mov	x0, x20
               	mov	x3, x21
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x20
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x150]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x160
               	ret
               	bl	<addr>
               	sxtw	x0, w0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x21, x29, #0x118
               	mov	x4, #0x1                // =1
               	mov	x0, x20
               	mov	x3, x21
               	mov	x1, x22
               	bl	<addr>
               	sxtw	x0, w0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x20
               	bl	<addr>
               	cbz	x0, <addr>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, #0x100              // =256
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x4, #0x2                // =2
               	mov	x0, x20
               	mov	x3, x21
               	bl	<addr>
               	sxtw	x0, w0
               	sub	x0, x29, #0x100
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cbz	x0, <addr>
               	bl	<addr>
               	sxtw	x0, w0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x10               // =16
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	w0, #0x0
               	cset	x1, eq
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x4
               	cset	x1, ge
               	cbz	x1, <addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x150]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x160
               	ret
               	mov	x0, #0x3                // =3
               	b	<addr>
               	b	<addr>
