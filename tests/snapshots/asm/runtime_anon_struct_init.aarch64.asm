
runtime_anon_struct_init.aarch64:	file format elf64-littleaarch64

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

<opaque>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<check_anon_struct>:
               	stp	x20, x21, [sp, #-0x70]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	mov	x20, x0
               	mov	x21, x1
               	sub	x0, x29, #0x40
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	str	x20, [x0, #0x8]
               	str	x21, [x0, #0x10]
               	mov	x1, #0x7                // =7
               	str	w1, [x0, #0x18]
               	sub	x2, x29, #0x20
               	stp	xzr, xzr, [x2]
               	stp	xzr, xzr, [x2, #0x10]
               	mov	x1, #0x2                // =2
               	str	w1, [x2]
               	str	x20, [x2, #0x8]
               	str	x21, [x2, #0x10]
               	mov	x1, #0x8                // =8
               	str	w1, [x2, #0x18]
               	bl	<addr>
               	mov	x22, x0
               	sub	x0, x29, #0x20
               	bl	<addr>
               	ldrsw	x1, [x22]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldr	x1, [x22, #0x8]
               	cmp	x1, x20
               	b.ne	<addr>
               	ldr	x1, [x22, #0x10]
               	cmp	x1, x21
               	b.ne	<addr>
               	ldrsw	x1, [x22, #0x18]
               	cmp	w1, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	ldrsw	x1, [x0]
               	cmp	w1, #0x2
               	b.ne	<addr>
               	ldr	x1, [x0, #0x8]
               	cmp	x1, x20
               	b.ne	<addr>
               	ldr	x1, [x0, #0x10]
               	cmp	x1, x21
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0x18]
               	cmp	w0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x70
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x70]!
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	stur	wzr, [x29, #-0x40]
               	sub	x0, x29, #0x40
               	stur	x0, [x29, #-0x50]
               	mov	x0, #0x10               // =16
               	stur	x0, [x29, #-0x48]
               	ldur	x20, [x29, #-0x50]
               	ldur	x1, [x29, #-0x48]
               	mov	x0, x20
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	sub	x0, x29, #0x38
               	stp	xzr, xzr, [x0]
               	mov	x1, #0x3                // =3
               	str	w1, [x0]
               	str	x20, [x0, #0x8]
               	bl	<addr>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x3
               	b.ne	<addr>
               	ldr	x0, [x0, #0x8]
               	cmp	x0, x20
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x18               // =24
               	stur	x0, [x29, #-0x48]
               	ldur	x21, [x29, #-0x48]
               	sub	x0, x29, #0x28
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	str	xzr, [x0, #0x20]
               	mov	x1, #0x9                // =9
               	str	w1, [x0]
               	mov	x1, #0x4                // =4
               	str	w1, [x0, #0x8]
               	str	x20, [x0, #0x10]
               	str	x21, [x0, #0x18]
               	mov	x1, #0x5                // =5
               	str	w1, [x0, #0x20]
               	bl	<addr>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x9
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x8]
               	cmp	w1, #0x4
               	b.ne	<addr>
               	ldr	x1, [x0, #0x10]
               	cmp	x1, x20
               	b.ne	<addr>
               	ldr	x1, [x0, #0x18]
               	cmp	x1, x21
               	b.ne	<addr>
               	ldrsw	x0, [x0, #0x20]
               	cmp	w0, #0x5
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x0, #0x4                // =4
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
