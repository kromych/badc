
inline_asm_a64_pair_array_operand.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x80
               	sub	x0, x29, #0x50
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	add	x0, x0, #0x20
               	sub	x1, x29, #0x10
               	sub	x2, x29, #0x8
               	stp	x9, x10, [sp, #-0x40]!
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	mov	x9, x0
               	ldp	x10, x11, [x9]
               	mov	x16, x1
               	str	x10, [x16]
               	mov	x16, x2
               	str	x11, [x16]
               	ldr	x15, [sp, #0x30]
               	ldp	x13, x14, [sp, #0x20]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x40
               	ldur	x0, [x29, #-0x10]
               	cmp	x0, #0x4
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x50
               	add	x0, x0, #0x30
               	str	x0, [sp, #0x10]
               	mov	x16, #0x3c              // =60
               	str	x16, [sp, #0x18]
               	mov	x16, #0x46              // =70
               	str	x16, [sp, #0x20]
               	ldr	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x18]
               	ldr	x2, [sp, #0x20]
               	stp	x1, x2, [x0]
               	sub	x0, x29, #0x50
               	ldur	x1, [x29, #-0x20]
               	cmp	x1, #0x3c
               	b.ne	<addr>
               	ldur	x1, [x29, #-0x18]
               	cmp	x1, #0x46
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x0, #0x10
               	sub	x1, x29, #0x10
               	sub	x2, x29, #0x8
               	stp	x9, x10, [sp, #-0x40]!
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	mov	x9, x0
               	ldp	x10, x11, [x9]
               	mov	x16, x1
               	str	x10, [x16]
               	mov	x16, x2
               	str	x11, [x16]
               	ldr	x15, [sp, #0x30]
               	ldp	x13, x14, [sp, #0x20]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x40
               	ldur	x0, [x29, #-0x10]
               	cmp	x0, #0x2
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x50
               	add	x0, x0, #0x8
               	str	x0, [sp, #0x10]
               	ldr	x1, [sp, #0x10]
               	ldr	x0, [x1]
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x80
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	sub	x1, x29, #0x10
               	sub	x2, x29, #0x8
               	stp	x9, x10, [sp, #-0x40]!
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	mov	x9, x0
               	ldp	x10, x11, [x9]
               	mov	x16, x1
               	str	x10, [x16]
               	mov	x16, x2
               	str	x11, [x16]
               	ldr	x15, [sp, #0x30]
               	ldp	x13, x14, [sp, #0x20]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x40
               	ldur	x0, [x29, #-0x10]
               	cmp	x0, #0x7
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x10
               	sub	x2, x29, #0x8
               	stp	x9, x10, [sp, #-0x40]!
               	stp	x11, x12, [sp, #0x10]
               	stp	x13, x14, [sp, #0x20]
               	str	x15, [sp, #0x30]
               	mov	x9, x0
               	ldp	x10, x11, [x9]
               	mov	x16, x1
               	str	x10, [x16]
               	mov	x16, x2
               	str	x11, [x16]
               	ldr	x15, [sp, #0x30]
               	ldp	x13, x14, [sp, #0x20]
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x40
               	ldur	x0, [x29, #-0x10]
               	mov	x17, #0x4241            // =16961
               	movk	x17, #0x4443, lsl #16
               	movk	x17, #0x4645, lsl #32
               	movk	x17, #0x4847, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x8]
               	mov	x17, #0x4a49            // =19017
               	movk	x17, #0x4c4b, lsl #16
               	movk	x17, #0x4e4d, lsl #32
               	movk	x17, #0x504f, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x50]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
