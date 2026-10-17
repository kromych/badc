
compound_literal_of_pointer_type_is_an_object.aarch64:	file format elf64-littleaarch64

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

<h>:
               	mov	x0, #0x2a               // =42
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	x0, x29, #0x48
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w16, [x1]
               	str	w16, [x0]
               	mov	x1, #0x7                // =7
               	stur	w1, [x29, #-0x40]
               	sub	x2, x29, #0x38
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w16, [x1]
               	str	w16, [x2]
               	stur	x0, [x29, #-0x30]
               	sub	x4, x29, #0x30
               	add	x1, x0, #0x1
               	stur	x1, [x29, #-0x28]
               	stur	x0, [x29, #-0x20]
               	sub	x1, x29, #0x40
               	stur	x1, [x29, #-0x18]
               	sub	x5, x29, #0x18
               	stur	x2, [x29, #-0x10]
               	stur	xzr, [x29, #-0x8]
               	cmp	x4, x0
               	b.eq	<addr>
               	ldur	x2, [x29, #-0x30]
               	cmp	x2, x0
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x28]
               	ldrb	w0, [x0]
               	mov	x17, #0x69              // =105
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	ldur	x0, [x29, #-0x20]
               	ldrb	w0, [x0]
               	mov	x17, #0x6c              // =108
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x18]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x7
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x10]
               	ldrsw	x0, [x0]
               	cmp	w0, #0x9
               	b.ne	<addr>
               	stur	x1, [x29, #-0x8]
               	ldrsw	x0, [x1]
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x30]
               	add	x0, x0, #0x2
               	stur	x0, [x29, #-0x30]
               	ldrb	w0, [x0]
               	mov	x17, #0x74              // =116
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x18]
               	stur	x0, [x29, #-0x10]
               	stur	x0, [x29, #-0x8]
               	cmp	x5, x0
               	b.eq	<addr>
               	ldur	x0, [x29, #-0x18]
               	blr	x0
               	cmp	x0, #0x2a
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x10]
               	blr	x0
               	cmp	x0, #0x2a
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x8]
               	blr	x0
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x8]
               	bl	<addr>
               	cmp	x0, #0x2a
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x8]
               	bl	<addr>
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
