
scanf_reads_the_standard_input.aarch64:	file format elf64-littleaarch64

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
               	str	x20, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	stur	wzr, [x29, #-0x28]
               	stur	wzr, [x29, #-0x20]
               	stur	xzr, [x29, #-0x18]
               	sub	x0, x29, #0x10
               	stp	xzr, xzr, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x28
               	sub	x2, x29, #0x20
               	bl	<addr>
               	mov	x20, x0
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x30]
               	cbz	x1, <addr>
               	ldr	x0, [x0, #0x30]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x18
               	sub	x3, x29, #0x10
               	bl	<addr>
               	mov	x4, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldursw	x2, [x29, #-0x28]
               	ldursw	x3, [x29, #-0x20]
               	ldur	d0, [x29, #-0x18]
               	sub	x5, x29, #0x10
               	mov	x1, x20
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x28
               	bl	<addr>
               	mov	x1, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x6                // =6
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	mov	x1, x0
               	ldr	x2, [x20]
               	ldr	x3, [x20, #0x8]
               	ldrb	w4, [x20, #0x51]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x6                // =6
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x1, eq
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cbz	x0, <addr>
               	adrp	x1, <page>
               	ldr	x0, [x0]
               	str	x0, [x1, #0x30]
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	b	<addr>
