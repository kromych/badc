
computed_goto_static_table.aarch64:	file format elf64-littleaarch64

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

<interp>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	stur	x0, [x29, #-0x20]
               	mov	x1, #0x0                // =0
               	stur	w1, [x29, #-0x8]
               	stur	w1, [x29, #-0x10]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x1                // =1
               	stur	w2, [x29, #-0x10]
               	ldrb	w0, [x0]
               	ldr	x0, [x1, x0, lsl #3]
               	br	x0
               	ldursw	x3, [x29, #-0x8]
               	ldur	x0, [x29, #-0x20]
               	ldursw	x1, [x29, #-0x10]
               	add	x2, x1, #0x1
               	stur	w2, [x29, #-0x10]
               	ldrb	w1, [x0, x1]
               	add	x1, x3, x1
               	stur	w1, [x29, #-0x8]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	sxtw	x1, w2
               	add	x2, x1, #0x1
               	stur	w2, [x29, #-0x10]
               	ldrb	w0, [x0, x1]
               	ldr	x0, [x3, x0, lsl #3]
               	br	x0
               	ldursw	x3, [x29, #-0x8]
               	ldur	x0, [x29, #-0x20]
               	ldursw	x1, [x29, #-0x10]
               	add	x2, x1, #0x1
               	stur	w2, [x29, #-0x10]
               	ldrb	w1, [x0, x1]
               	sub	x1, x3, x1
               	stur	w1, [x29, #-0x8]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	sxtw	x1, w2
               	add	x2, x1, #0x1
               	stur	w2, [x29, #-0x10]
               	ldrb	w0, [x0, x1]
               	ldr	x0, [x3, x0, lsl #3]
               	br	x0
               	ldursw	x0, [x29, #-0x8]
               	add	x0, x0, x0
               	stur	w0, [x29, #-0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldur	x2, [x29, #-0x20]
               	ldursw	x0, [x29, #-0x10]
               	add	x3, x0, #0x1
               	stur	w3, [x29, #-0x10]
               	ldrb	w0, [x2, x0]
               	ldr	x0, [x1, x0, lsl #3]
               	br	x0
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
