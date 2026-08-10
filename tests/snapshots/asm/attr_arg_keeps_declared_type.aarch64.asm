
attr_arg_keeps_declared_type.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<add>:
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ret

<main>:
               	str	x19, [sp, #-0x60]!
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	w1, w0
               	add	x3, x2, x1
               	ldrb	w3, [x3]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	add	x1, x4, x1
               	ldrb	w1, [x1]
               	cmp	x3, x1
               	b.ne	<addr>
               	mov	w0, w0
               	add	x0, x0, #0x1
               	mov	w1, w0
               	cmp	x1, #0x18
               	b.lo	<addr>
               	sub	x0, x29, #0x28
               	add	x0, x0, #0x8
               	sub	x1, x29, #0x28
               	sub	x0, x0, x1
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp], #0x60
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp], #0x60
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsb	x0, [x0, #0x4]
               	cmp	x0, #0x6f
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsb	x0, [x0, #0x5]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp], #0x60
               	ret
               	sub	x0, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldrb	w10, [x1]
               	strb	w10, [x0]
               	ldrb	w10, [x1, #0x1]
               	strb	w10, [x0, #0x1]
               	ldrb	w10, [x1, #0x2]
               	strb	w10, [x0, #0x2]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp], #0x60
               	ret
               	b	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp], #0x60
               	ret
