
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
               	ldursw	x4, [x29, #-0x8]
               	ldur	x0, [x29, #-0x20]
               	ldursw	x2, [x29, #-0x10]
               	add	x3, x2, #0x1
               	stur	w3, [x29, #-0x10]
               	ldrb	w2, [x0, x2]
               	add	x2, x4, x2
               	stur	w2, [x29, #-0x8]
               	sxtw	x2, w3
               	add	x3, x2, #0x1
               	stur	w3, [x29, #-0x10]
               	ldrb	w0, [x0, x2]
               	ldr	x0, [x1, x0, lsl #3]
               	br	x0
               	ldursw	x4, [x29, #-0x8]
               	ldur	x0, [x29, #-0x20]
               	ldursw	x2, [x29, #-0x10]
               	add	x3, x2, #0x1
               	stur	w3, [x29, #-0x10]
               	ldrb	w2, [x0, x2]
               	sub	x2, x4, x2
               	stur	w2, [x29, #-0x8]
               	sxtw	x2, w3
               	add	x3, x2, #0x1
               	stur	w3, [x29, #-0x10]
               	ldrb	w0, [x0, x2]
               	ldr	x0, [x1, x0, lsl #3]
               	br	x0
               	ldursw	x0, [x29, #-0x8]
               	add	x0, x0, x0
               	stur	w0, [x29, #-0x8]
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
