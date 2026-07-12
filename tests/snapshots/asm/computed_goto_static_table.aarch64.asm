
computed_goto_static_table.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	stur	x0, [x29, #0x10]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsb	x1, [x0, #0x20]
               	cbz	x1, <addr>
               	mov	x1, #0x0                // =0
               	stur	x1, [x29, #-0x18]
               	b	<addr>
               	adr	x1, <addr>
               	str	x1, [x0]
               	adr	x1, <addr>
               	str	x1, [x0, #0x8]
               	adr	x1, <addr>
               	str	x1, [x0, #0x10]
               	adr	x1, <addr>
               	str	x1, [x0, #0x18]
               	mov	x1, #0x1                // =1
               	strb	w1, [x0, #0x20]
               	stur	x1, [x29, #-0x18]
               	mov	x1, #0x0                // =0
               	stur	w1, [x29, #-0x8]
               	stur	w1, [x29, #-0x10]
               	ldur	x2, [x29, #0x10]
               	sxtw	x1, w1
               	add	x3, x1, #0x1
               	stur	w3, [x29, #-0x10]
               	add	x1, x2, x1
               	ldrb	w1, [x1]
               	ldr	x1, [x0, x1, lsl #3]
               	br	x1
               	ldursw	x4, [x29, #-0x8]
               	ldur	x1, [x29, #0x10]
               	ldursw	x2, [x29, #-0x10]
               	add	x3, x2, #0x1
               	stur	w3, [x29, #-0x10]
               	add	x2, x1, x2
               	ldrb	w2, [x2]
               	add	x2, x4, x2
               	stur	w2, [x29, #-0x8]
               	sxtw	x2, w3
               	add	x3, x2, #0x1
               	stur	w3, [x29, #-0x10]
               	add	x1, x1, x2
               	ldrb	w1, [x1]
               	ldr	x1, [x0, x1, lsl #3]
               	br	x1
               	ldursw	x4, [x29, #-0x8]
               	ldur	x1, [x29, #0x10]
               	ldursw	x2, [x29, #-0x10]
               	add	x3, x2, #0x1
               	stur	w3, [x29, #-0x10]
               	add	x2, x1, x2
               	ldrb	w2, [x2]
               	sub	x2, x4, x2
               	stur	w2, [x29, #-0x8]
               	sxtw	x2, w3
               	add	x3, x2, #0x1
               	stur	w3, [x29, #-0x10]
               	add	x1, x1, x2
               	ldrb	w1, [x1]
               	ldr	x1, [x0, x1, lsl #3]
               	br	x1
               	ldursw	x1, [x29, #-0x8]
               	add	x1, x1, x1
               	stur	w1, [x29, #-0x8]
               	ldur	x2, [x29, #0x10]
               	ldursw	x1, [x29, #-0x10]
               	add	x3, x1, #0x1
               	stur	w3, [x29, #-0x10]
               	add	x1, x2, x1
               	ldrb	w1, [x1]
               	ldr	x1, [x0, x1, lsl #3]
               	br	x1
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
