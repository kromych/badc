
array_range_designator_unsized.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<main>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x0, [x3]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x0                // =0
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w4, [x1]
               	cmp	x2, x4
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	x0, x1
               	cset	x0, eq
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	ldr	x0, [x3, #0x20]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x0                // =0
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w4, [x1]
               	cmp	x2, x4
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	x0, x1
               	cset	x0, eq
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	ldr	x0, [x3, #0x30]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x0                // =0
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w4, [x1]
               	cmp	x2, x4
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	x0, x1
               	cset	x0, eq
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	ldr	x0, [x3, #0x40]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x0                // =0
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w4, [x1]
               	cmp	x2, x4
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	x0, x1
               	cset	x0, eq
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x0                // =0
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w3, [x1]
               	cmp	x2, x3
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	x0, x1
               	cset	x0, eq
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x20]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x0                // =0
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w3, [x1]
               	cmp	x2, x3
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	x0, x1
               	cset	x0, eq
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x30]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x0                // =0
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w3, [x1]
               	cmp	x2, x3
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	x0, x1
               	cset	x0, eq
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x40]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x0                // =0
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w3, [x1]
               	cmp	x2, x3
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	x0, x1
               	cset	x0, eq
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x60]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x0                // =0
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w3, [x1]
               	cmp	x2, x3
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	x0, x1
               	cset	x0, eq
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x30]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x0                // =0
               	ldrb	w2, [x0]
               	cbz	x2, <addr>
               	ldrb	w2, [x0]
               	ldrb	w3, [x1]
               	cmp	x2, x3
               	cset	x2, eq
               	cbz	x2, <addr>
               	add	x0, x0, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	b	<addr>
               	ldrb	w0, [x0]
               	ldrb	w1, [x1]
               	cmp	x0, x1
               	cset	x0, eq
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x17               // =23
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
