
signaling_nan_float_copy_keeps_its_bits.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x20
               	mov	x0, #0x1                // =1
               	movk	x0, #0x7f80, lsl #16
               	stur	w0, [x29, #-0x20]
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	ldur	s0, [x29, #-0x20]
               	stur	s0, [x29, #-0x18]
               	ldur	s0, [x29, #-0x18]
               	stur	s0, [x29, #-0x20]
               	ldur	w0, [x29, #-0x20]
               	mov	x1, #0x1                // =1
               	movk	x1, #0x7f80, lsl #16
               	cmp	w0, w1
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	s0, [x29, #-0x20]
               	fcvt	d0, s0
               	stur	d0, [x29, #-0x10]
               	ldur	d0, [x29, #-0x10]
               	fmov	x0, d0
               	mov	x17, #0x20000000        // =536870912
               	movk	x17, #0x7ff8, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1f               // =31
               	bl	<addr>
               	ldur	s0, [x29, #-0x20]
               	fmov	s1, #1.00000000
               	fadd	s0, s0, s1
               	stur	s0, [x29, #-0x8]
               	ldur	s0, [x29, #-0x8]
               	stur	s0, [x29, #-0x20]
               	ldur	w0, [x29, #-0x20]
               	mov	x17, #0x1               // =1
               	movk	x17, #0x7fc0, lsl #16
               	cmp	w0, w17
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	b	<addr>
