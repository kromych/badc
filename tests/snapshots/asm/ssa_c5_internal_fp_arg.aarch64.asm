
ssa_c5_internal_fp_arg.aarch64:	file format elf64-littleaarch64

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
               	add	x1, x0, #0x64
               	sub	x1, x1, x0
               	sxtw	x1, w1
               	mov	x2, #0x400000000000     // =70368744177664
               	movk	x2, #0x4049, lsl #48
               	sub	x0, x0, x0
               	sxtw	x0, w0
               	scvtf	d0, x0
               	fmov	d16, x2
               	fadd	d1, d16, d0
               	scvtf	d0, x1
               	fcmp	d1, d0
               	cset	x0, mi
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xd00000000000     // =228698418577408
               	movk	x0, #0x4062, lsl #48
               	fmov	d16, x0
               	fcmp	d16, d0
               	b.pl	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fcmp	d0, d0
               	cset	x0, ls
               	cmp	w0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d17, x0
               	fadd	d1, d0, d17
               	fcmp	d1, d0
               	b.hi	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
