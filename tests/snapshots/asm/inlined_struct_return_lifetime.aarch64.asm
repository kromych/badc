
inlined_struct_return_lifetime.aarch64:	file format elf64-littleaarch64

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

<returned_twice>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, #0xa                // =10
               	strh	w1, [x2]
               	sxth	x1, w1
               	cmp	w1, #0x0
               	b.gt	<addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	stur	x1, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<one_of_two>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	stur	x8, [x29, #-0x8]
               	sxtw	x3, w0
               	sub	x0, x29, #0x38
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	sub	x1, x29, #0x20
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldr	x16, [x2, #0x10]
               	str	x16, [x1, #0x10]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	mov	x2, #0xa                // =10
               	strh	w2, [x4]
               	sxth	x2, w2
               	cmp	w2, #0x0
               	b.gt	<addr>
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldr	x0, [x16, #0x10]
               	str	x0, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	stur	x2, [x29, #-0x40]
               	cbz	x3, <addr>
               	mov	x16, x1
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldr	x0, [x16, #0x10]
               	str	x0, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, x0
               	ldur	x17, [x29, #-0x8]
               	ldp	x0, x1, [x16]
               	stp	x0, x1, [x17]
               	ldr	x0, [x16, #0x10]
               	str	x0, [x17, #0x10]
               	mov	x0, x17
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_one>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x0, x29, #0x10
               	str	wzr, [x0]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x1, #0xa                // =10
               	strh	w1, [x3]
               	sxth	x1, w1
               	cmp	w1, #0x0
               	b.gt	<addr>
               	ldr	w0, [x0]
               	str	w0, [x2]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	stur	x1, [x29, #-0x8]
               	b	<addr>

<check_three>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sxtw	x0, w0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sub	x1, x29, #0x30
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldp	x16, x17, [x3]
               	stp	x16, x17, [x1]
               	ldr	x16, [x3, #0x10]
               	str	x16, [x1, #0x10]
               	sub	x3, x29, #0x18
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldp	x16, x17, [x4]
               	stp	x16, x17, [x3]
               	ldr	x16, [x4, #0x10]
               	str	x16, [x3, #0x10]
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	mov	x4, #0xa                // =10
               	strh	w4, [x5]
               	sxth	x4, w4
               	cmp	w4, #0x0
               	b.gt	<addr>
               	ldr	x0, [x1]
               	ldr	x3, [x1, #0x8]
               	ldr	x1, [x1, #0x10]
               	str	x0, [x2]
               	str	x3, [x2, #0x8]
               	str	x1, [x2, #0x10]
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	mov	x17, #0xa               // =10
               	mul	x2, x3, x17
               	add	x0, x0, x2
               	add	x0, x0, x1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	stur	x4, [x29, #-0x38]
               	cbz	x0, <addr>
               	mov	x1, x3
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x9                // =9
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x9                // =9
               	bl	<addr>
               	cmp	x0, #0x1c8
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0x7b
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
