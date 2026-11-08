
math_constant_types.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	mov	x16, #0x7fc00000        // =2143289344
               	fmov	s0, w16
               	stur	s0, [x29, #-0x10]
               	sub	x0, x29, #0x8
               	sub	x1, x29, #0x10
               	ldr	w16, [x1]
               	str	w16, [x0]
               	ldur	w0, [x29, #-0x8]
               	and	x0, x0, #0xffc00000
               	mov	x17, #0x7fc00000        // =2143289344
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <addr>
               	ldr	s1, [x0]
               	fcmp	s1, s1
               	b.eq	<addr>
               	adrp	x0, <addr>
               	ldr	s1, [x0, #0x4]
               	adrp	x16, <addr>
               	ldr	s2, [x16, #0x10]
               	fcmpe	s1, s2
               	b.le	<addr>
               	mov	x16, #0x7ff0000000000000 // =9218868437227405312
               	fmov	d1, x16
               	adrp	x16, <addr>
               	ldr	d2, [x16, #0x8]
               	fcmpe	d1, d2
               	b.gt	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stur	s0, [x29, #-0x8]
               	ldur	w0, [x29, #-0x8]
               	lsr	x0, x0, #31
               	cbnz	x0, <addr>
               	mov	x16, #0xffc00000        // =4290772992
               	fmov	s0, w16
               	stur	s0, [x29, #-0x8]
               	ldur	w0, [x29, #-0x8]
               	lsr	x0, x0, #31
               	cbnz	w0, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
