
owned_parameter_copies.aarch64:	file format elf64-littleaarch64

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

<through>:
               	ldr	x1, [x0, #0x8]
               	add	x1, x1, #0xa
               	str	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	add	x0, x0, x1
               	ret

<escaped>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, x0
               	mov	x0, #0x5                // =5
               	str	x0, [x20]
               	mov	x0, x20
               	bl	<addr>
               	ldr	x1, [x20, #0x8]
               	add	x0, x0, x1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret

<read_after>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x20, x0
               	mov	x0, x20
               	bl	<addr>
               	ldr	x1, [x20, #0x8]
               	add	x0, x0, x1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret

<sum>:
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	add	x1, x1, x2
               	ldr	x0, [x0, #0x10]
               	add	x0, x1, x0
               	ret

<bump>:
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	add	x1, x1, #0x1
               	mul	x0, x1, x0
               	ret

<loop>:
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	ldr	x3, [x0, #0x10]
               	mov	x0, #0x0                // =0
               	cmp	x1, x2
               	b.ge	<addr>
               	add	x0, x0, x3
               	add	x1, x1, #0x1
               	cmp	x1, x2
               	b.lt	<addr>
               	ret

<forward>:
               	stp	x20, x21, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	mov	x20, x0
               	sub	x0, x29, #0x30
               	ldp	x16, x17, [x20]
               	stp	x16, x17, [x0]
               	ldr	x16, [x20, #0x10]
               	str	x16, [x0, #0x10]
               	bl	<addr>
               	mov	x21, x0
               	sub	x0, x29, #0x18
               	ldp	x16, x17, [x20]
               	stp	x16, x17, [x0]
               	ldr	x16, [x20, #0x10]
               	str	x16, [x0, #0x10]
               	bl	<addr>
               	add	x0, x21, x0
               	add	x0, x0, #0x1
               	ldp	x29, x30, [sp, #0x40]
               	ldp	x20, x21, [sp], #0x50
               	ret

<kept>:
               	adrp	x1, <page>
               	str	x0, [x1, #0x30]
               	ldr	x1, [x0, #0x10]
               	lsl	x1, x1, #1
               	str	x1, [x0, #0x10]
               	ldr	x0, [x0, #0x10]
               	ret

<chars>:
               	ldrb	w1, [x0]
               	ldrb	w0, [x0, #0x12]
               	eor	x0, x0, #0x1
               	add	x0, x1, x0
               	ret

<chars_escaped>:
               	mov	x1, #0x7a               // =122
               	strb	w1, [x0, #0x3]
               	ldrb	w1, [x0, #0x12]
               	add	x1, x1, #0x7a
               	ldrb	w0, [x0, #0x2]
               	add	x0, x1, x0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xf0
               	sub	x1, x29, #0xf0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x1]
               	ldr	x16, [x0, #0x10]
               	str	x16, [x1, #0x10]
               	sub	x0, x29, #0xd8
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	bl	<addr>
               	cmp	x0, #0x41
               	b.ne	<addr>
               	sub	x1, x29, #0xf0
               	ldur	x0, [x29, #-0xf0]
               	cmp	x0, #0x1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0xe8]
               	cmp	x0, #0x14
               	b.ne	<addr>
               	ldur	x0, [x29, #-0xe0]
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xc0
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	bl	<addr>
               	cmp	x0, #0x3d
               	b.ne	<addr>
               	sub	x1, x29, #0xf0
               	ldur	x0, [x29, #-0xf0]
               	cmp	x0, #0x1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0xe8]
               	cmp	x0, #0x14
               	b.ne	<addr>
               	ldur	x0, [x29, #-0xe0]
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa8
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	bl	<addr>
               	cmp	x0, #0x18
               	b.ne	<addr>
               	sub	x1, x29, #0xf0
               	ldur	x0, [x29, #-0xf0]
               	cmp	x0, #0x1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0xe8]
               	cmp	x0, #0x14
               	b.ne	<addr>
               	ldur	x0, [x29, #-0xe0]
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x90
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	bl	<addr>
               	cmp	x0, #0x28
               	b.ne	<addr>
               	sub	x1, x29, #0xf0
               	ldur	x0, [x29, #-0xf0]
               	cmp	x0, #0x1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0xe8]
               	cmp	x0, #0x14
               	b.ne	<addr>
               	ldur	x0, [x29, #-0xe0]
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x78
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	bl	<addr>
               	cmp	x0, #0x39
               	b.ne	<addr>
               	sub	x1, x29, #0xf0
               	ldur	x0, [x29, #-0xf0]
               	cmp	x0, #0x1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0xe8]
               	cmp	x0, #0x14
               	b.ne	<addr>
               	ldur	x0, [x29, #-0xe0]
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x60
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	bl	<addr>
               	cmp	x0, #0x5a
               	b.ne	<addr>
               	sub	x1, x29, #0xf0
               	ldur	x0, [x29, #-0xf0]
               	cmp	x0, #0x1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0xe8]
               	cmp	x0, #0x14
               	b.ne	<addr>
               	ldur	x0, [x29, #-0xe0]
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x48
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	bl	<addr>
               	cmp	x0, #0x6
               	b.ne	<addr>
               	sub	x2, x29, #0xf0
               	ldur	x0, [x29, #-0xf0]
               	cmp	x0, #0x1
               	b.ne	<addr>
               	ldur	x0, [x29, #-0xe8]
               	cmp	x0, #0x14
               	b.ne	<addr>
               	ldur	x0, [x29, #-0xe0]
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	x1, x0, #0x1
               	strb	w1, [x2, x0]
               	mov	x0, x1
               	cmp	w0, #0x13
               	b.lt	<addr>
               	sub	x1, x29, #0xf0
               	sub	x0, x29, #0x30
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldrh	w16, [x1, #0x10]
               	strh	w16, [x0, #0x10]
               	ldrb	w16, [x1, #0x12]
               	strb	w16, [x0, #0x12]
               	bl	<addr>
               	cmp	w0, #0x13
               	b.ne	<addr>
               	sub	x1, x29, #0xf0
               	ldurb	w0, [x29, #-0xde]
               	cmp	w0, #0x13
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldrh	w16, [x1, #0x10]
               	strh	w16, [x0, #0x10]
               	ldrb	w16, [x1, #0x12]
               	strb	w16, [x0, #0x12]
               	bl	<addr>
               	cmp	w0, #0x90
               	b.ne	<addr>
               	ldurb	w0, [x29, #-0xed]
               	cmp	w0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
