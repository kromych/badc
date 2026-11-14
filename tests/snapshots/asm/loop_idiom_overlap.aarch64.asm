
loop_idiom_overlap.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	add	x3, x1, #0x3
               	str	xzr, [x1]
               	str	xzr, [x1, #0x8]
               	str	xzr, [x1, #0x10]
               	str	xzr, [x1, #0x18]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrh	w16, [x2]
               	strh	w16, [x1]
               	ldrb	w16, [x2, #0x2]
               	strb	w16, [x1, #0x2]
               	mov	x2, #0x9                // =9
               	sub	x4, x3, x1
               	cmp	x4, #0x9
               	b.lo	<addr>
               	mov	x0, x3
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0xc                // =12
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	add	x3, x1, #0x3
               	str	xzr, [x1]
               	str	xzr, [x1, #0x8]
               	str	xzr, [x1, #0x10]
               	str	xzr, [x1, #0x18]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x16, [x2]
               	str	x16, [x1]
               	ldrh	w16, [x2, #0x8]
               	strh	w16, [x1, #0x8]
               	mov	x2, #0x7                // =7
               	sub	x4, x1, x3
               	cmp	x4, #0x7
               	b.lo	<addr>
               	mov	x0, x1
               	mov	x1, x3
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0xa                // =10
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, #0x0                // =0
               	str	xzr, [x1]
               	str	xzr, [x1, #0x8]
               	str	xzr, [x1, #0x10]
               	str	xzr, [x1, #0x18]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrh	w16, [x2]
               	strh	w16, [x1]
               	add	x2, x0, #0x2
               	ldrb	w3, [x1, x0]
               	strb	w3, [x1, x2]
               	add	x0, x0, #0x1
               	cmp	w0, #0xa
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0xc                // =12
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w2, [x3, x0]
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x7
               	b.lt	<addr>
               	b	<addr>
               	ldrb	w2, [x1, x0]
               	strb	w2, [x3, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x9
               	b.lt	<addr>
               	b	<addr>
