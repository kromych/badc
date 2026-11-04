
struct_stack_param_tail.aarch64:	file format elf64-littleaarch64

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

<sum20>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	stur	x0, [x29, #-0x30]
               	sub	x0, x29, #0x18
               	ldur	x1, [x29, #-0x30]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	w16, [x1, #0x10]
               	str	w16, [x0, #0x10]
               	ldur	s0, [x29, #-0x18]
               	ldur	s1, [x29, #-0x14]
               	fadd	s0, s0, s1
               	ldur	s1, [x29, #-0x10]
               	fadd	s0, s0, s1
               	ldur	s1, [x29, #-0xc]
               	fadd	s0, s0, s1
               	ldur	s1, [x29, #-0x8]
               	fadd	s0, s0, s1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<sum_bytes>:
               	mov	x3, x0
               	mov	x0, #0x0                // =0
               	mov	x4, #0x3                // =3
               	mov	x2, x0
               	cmp	w0, w1
               	b.ge	<addr>
               	mul	x2, x2, x4
               	ldrb	w5, [x3, x0]
               	add	x2, x2, x5
               	add	x0, x0, #0x1
               	cmp	w0, w1
               	b.lt	<addr>
               	mov	x0, x2
               	ret

<sum22>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	stur	x0, [x29, #-0x30]
               	sub	x0, x29, #0x18
               	ldur	x1, [x29, #-0x30]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	w16, [x1, #0x10]
               	str	w16, [x0, #0x10]
               	ldrh	w16, [x1, #0x14]
               	strh	w16, [x0, #0x14]
               	mov	x1, #0x16               // =22
               	bl	<addr>
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<sum23>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	stur	x0, [x29, #-0x30]
               	sub	x0, x29, #0x18
               	ldur	x1, [x29, #-0x30]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	w16, [x1, #0x10]
               	str	w16, [x0, #0x10]
               	ldrh	w16, [x1, #0x14]
               	strh	w16, [x0, #0x14]
               	ldrb	w16, [x1, #0x16]
               	strb	w16, [x0, #0x16]
               	mov	x1, #0x17               // =23
               	bl	<addr>
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<sum17>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	stur	x0, [x29, #-0x30]
               	sub	x0, x29, #0x18
               	ldur	x1, [x29, #-0x30]
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldrb	w16, [x1, #0x10]
               	strb	w16, [x0, #0x10]
               	mov	x1, #0x11               // =17
               	bl	<addr>
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0xe0]!
               	stp	x29, x30, [sp, #0xd0]
               	add	x29, sp, #0xd0
               	sub	x0, x29, #0xc0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	w16, [x1, #0x10]
               	str	w16, [x0, #0x10]
               	mov	x0, #0x0                // =0
               	cmp	w0, #0x16
               	b.ge	<addr>
               	sub	x1, x29, #0xa8
               	add	x2, x0, #0x1
               	strb	w2, [x1, x0]
               	sub	x1, x29, #0x90
               	lsl	x2, x0, #1
               	add	x2, x2, #0x1
               	strb	w2, [x1, x0]
               	cmp	w0, #0x11
               	b.ge	<addr>
               	sub	x1, x29, #0x78
               	mov	x2, #0x28               // =40
               	sub	x2, x2, x0
               	strb	w2, [x1, x0]
               	add	x0, x0, #0x1
               	cmp	w0, #0x17
               	b.lt	<addr>
               	sub	x1, x29, #0xc0
               	sub	x0, x29, #0x60
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	w16, [x1, #0x10]
               	str	w16, [x0, #0x10]
               	bl	<addr>
               	fmov	s1, #15.00000000
               	fcmp	s0, s1
               	b.eq	<addr>
               	mov	x20, #0x1               // =1
               	sub	x1, x29, #0xa8
               	sub	x0, x29, #0x48
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	w16, [x1, #0x10]
               	str	w16, [x0, #0x10]
               	ldrh	w16, [x1, #0x14]
               	strh	w16, [x0, #0x14]
               	bl	<addr>
               	mov	x21, x0
               	sub	x0, x29, #0xa8
               	mov	x1, #0x16               // =22
               	bl	<addr>
               	cmp	w21, w0
               	b.eq	<addr>
               	add	x20, x20, #0x1
               	sub	x1, x29, #0x90
               	sub	x0, x29, #0x30
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	w16, [x1, #0x10]
               	str	w16, [x0, #0x10]
               	ldrh	w16, [x1, #0x14]
               	strh	w16, [x0, #0x14]
               	ldrb	w16, [x1, #0x16]
               	strb	w16, [x0, #0x16]
               	bl	<addr>
               	mov	x21, x0
               	sub	x0, x29, #0x90
               	mov	x1, #0x17               // =23
               	bl	<addr>
               	cmp	w21, w0
               	b.eq	<addr>
               	add	x20, x20, #0x1
               	sub	x1, x29, #0x78
               	sub	x0, x29, #0x18
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldrb	w16, [x1, #0x10]
               	strb	w16, [x0, #0x10]
               	bl	<addr>
               	mov	x21, x0
               	sub	x0, x29, #0x78
               	mov	x1, #0x11               // =17
               	bl	<addr>
               	cmp	w21, w0
               	b.eq	<addr>
               	add	x20, x20, #0x1
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0xd0]
               	ldp	x20, x21, [sp], #0xe0
               	ret
               	mov	x20, #0x0               // =0
               	b	<addr>
