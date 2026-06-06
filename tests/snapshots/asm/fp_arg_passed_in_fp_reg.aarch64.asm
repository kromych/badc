
fp_arg_passed_in_fp_reg.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	fmul	d1, d0, d1
               	fadd	d0, d1, d0
               	ret
               	sxtw	x0, w0
               	sxtw	x1, w1
               	scvtf	d2, x0
               	fmul	d0, d0, d2
               	scvtf	d2, x1
               	fmul	d1, d1, d2
               	fadd	d0, d0, d1
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	mov	x1, #0x4008000000000000 // =4613937818241073152
               	fmov	d16, x0
               	fmov	d17, x1
               	fmul	d0, d16, d17
               	fmov	d17, x0
               	fadd	d0, d0, d17
               	mov	x0, #0x4020000000000000 // =4620693217682128896
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	mov	x1, #0x3ff8000000000000 // =4609434218613702656
               	mov	x2, #0x4                // =4
               	mov	x3, #0x4004000000000000 // =4612811918334230528
               	scvtf	d0, x0
               	fmov	d16, x1
               	fmul	d0, d16, d0
               	scvtf	d1, x2
               	fmov	d16, x3
               	fmul	d1, d16, d1
               	fadd	d0, d0, d1
               	mov	x0, #0x402d000000000000 // =4624352392379367424
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x4019000000000000 // =4618722892845154304
               	fmov	d16, x0
               	sub	x17, x29, #0x18
               	str	d16, [x17]
               	sub	x16, x29, #0x18
               	ldr	d0, [x16]
               	mov	x0, #0x4010000000000000 // =4616189618054758400
               	fmov	d17, x0
               	fmul	d1, d0, d17
               	fadd	d0, d1, d0
               	mov	x0, #0x400000000000     // =70368744177664
               	movk	x0, #0x403f, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
