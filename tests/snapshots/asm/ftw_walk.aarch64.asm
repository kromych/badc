
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
               	stp	x22, x23, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x150]
               	add	x29, sp, #0x150
               	sub	x23, x29, #0x118
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x23]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x23, #0x8]
               	ldrb	w10, [x0, #0x10]
               	strb	w10, [x23, #0x10]
               	ldrb	w10, [x0, #0x11]
               	strb	w10, [x23, #0x11]
               	ldrb	w10, [x0, #0x12]
               	strb	w10, [x23, #0x12]
               	ldrb	w10, [x0, #0x13]
               	strb	w10, [x23, #0x13]
               	ldr	x10, [sp], #0x10
               	mov	x0, x23
               	mov	x0, x23
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x150]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x160
               	ret
               	mov	x20, #0x0               // =0
               	b	<addr>
               	sub	x22, x29, #0x100
               	mov	x1, #0x100              // =256
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, x22
               	mov	x4, x21
               	mov	x3, x23
               	bl	<addr>
               	sxtw	x0, w0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x22
               	bl	<addr>
               	cbz	x0, <addr>
               	bl	<addr>
               	sxtw	x0, w0
               	add	x20, x21, #0x1
               	sxtw	x21, w20
               	cmp	x21, #0x3
               	b.lt	<addr>
               	sub	x0, x29, #0x118
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x10               // =16
               	bl	<addr>
               	sxtw	x0, w0
               	sxtw	x1, w0
               	cmp	x1, #0x0
               	cset	x0, eq
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	x0, #0x4
               	cset	x0, ge
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x150]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x160
               	ret
               	mov	x0, #0x3                // =3
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x150]
               	ldr	x19, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x160
               	ret
