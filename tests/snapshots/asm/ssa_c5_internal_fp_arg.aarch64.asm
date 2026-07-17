
ssa_c5_internal_fp_arg.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x2, x0
               	add	x0, x2, #0x64
               	sub	x0, x0, x2
               	sxtw	x0, w0
               	mov	x3, #0x400000000000     // =70368744177664
               	movk	x3, #0x4049, lsl #48
               	sub	x1, x2, x2
               	sxtw	x1, w1
               	scvtf	d0, x1
               	fmov	d16, x3
               	fadd	d0, d16, d0
               	scvtf	d1, x0
               	fcmp	d0, d1
               	cset	x1, mi
               	sxtw	x1, w1
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mov	x1, #0xd00000000000     // =228698418577408
               	movk	x1, #0x4062, lsl #48
               	scvtf	d0, x0
               	fmov	d16, x1
               	fcmp	d16, d0
               	cset	x1, mi
               	sxtw	x1, w1
               	cmp	x1, #0x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	scvtf	d0, x0
               	scvtf	d1, x0
               	fcmp	d0, d1
               	cset	x1, ls
               	sxtw	x1, w1
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	scvtf	d0, x0
               	mov	x1, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d17, x1
               	fadd	d0, d0, d17
               	scvtf	d1, x0
               	fcmp	d0, d1
               	cset	x0, ls
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
