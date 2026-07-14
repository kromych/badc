
fp_load_folded_disp.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	ldr	d0, [x0, #0x10]
               	mov	x1, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d17, x1
               	fadd	d0, d0, d17
               	str	d0, [x0, #0x10]
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x0, x29, #0x28
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	str	x1, [x0]
               	sub	x0, x29, #0x28
               	mov	x1, #0x3fa00000         // =1067450368
               	fmov	s16, w1
               	str	s16, [x0, #0x8]
               	sub	x0, x29, #0x28
               	mov	x2, #0x4004000000000000 // =4612811918334230528
               	fmov	d16, x2
               	str	d16, [x0, #0x10]
               	sub	x0, x29, #0x28
               	mov	x2, #0x0                // =0
               	fmov	s16, w2
               	str	s16, [x0, #0x18]
               	sub	x0, x29, #0x28
               	fmov	s16, w2
               	str	s16, [x0, #0x1c]
               	sub	x0, x29, #0x28
               	mov	x2, #0x40980000         // =1083703296
               	fmov	s16, w2
               	str	s16, [x0, #0x20]
               	sub	x0, x29, #0x28
               	ldr	s0, [x0, #0x8]
               	fmov	s17, w1
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x28
               	ldr	d0, [x0, #0x10]
               	mov	x0, #0x4004000000000000 // =4612811918334230528
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x28
               	ldr	s0, [x0, #0x20]
               	mov	x0, #0x40980000         // =1083703296
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x28
               	bl	<addr>
               	sub	x0, x29, #0x28
               	ldr	d0, [x0, #0x10]
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
