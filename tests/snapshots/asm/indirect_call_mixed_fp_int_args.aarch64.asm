
indirect_call_mixed_fp_int_args.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x3, #0x4024000000000000 // =4621819117588971520
               	fmov	d17, x3
               	fmul	d0, d0, d17
               	fcvtzs	x3, d0
               	add	x0, x0, x3
               	add	x0, x0, x1
               	mov	x1, #0x4059000000000000 // =4636737291354636288
               	fmov	d17, x1
               	fmul	d0, d1, d17
               	fcvtzs	x1, d0
               	add	x0, x0, x1
               	mov	x1, #0x40000000         // =1073741824
               	fmov	s17, w1
               	fmul	s0, s2, s17
               	fcvt	d0, s0
               	fcvtzs	x1, d0
               	add	x0, x0, x1
               	add	x0, x0, x2
               	sxtw	x0, w0
               	ret

<main>:
               	str	d8, [sp, #-0x40]!
               	str	x20, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x20, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	d8, [x1]
               	add	x1, x20, #0x2
               	sxtw	x1, w1
               	mov	x2, #0x3fd0000000000000 // =4598175219545276416
               	mov	x3, #0x3fc00000         // =1069547520
               	mov	x4, #0x7                // =7
               	mov	x9, x0
               	fmov	d0, d8
               	fmov	d1, x2
               	fmov	d2, x3
               	mov	x0, x20
               	mov	x2, x4
               	blr	x9
               	sxtw	x0, w0
               	cmp	x0, #0x40
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp], #0x40
               	ret
               	add	x2, x20, #0x2
               	mov	x4, #0x3fd0000000000000 // =4598175219545276416
               	mov	x5, #0x3fc00000         // =1069547520
               	mov	x1, #0x4024000000000000 // =4621819117588971520
               	fmov	d17, x1
               	fmul	d0, d8, d17
               	fcvtzs	x1, d0
               	add	x1, x20, x1
               	add	x1, x1, x2
               	mov	x2, #0x4059000000000000 // =4636737291354636288
               	fmov	d16, x4
               	fmov	d17, x2
               	fmul	d0, d16, d17
               	fcvtzs	x2, d0
               	add	x1, x1, x2
               	mov	x2, #0x40000000         // =1073741824
               	fmov	s16, w5
               	fmov	s17, w2
               	fmul	s0, s16, s17
               	fcvt	d0, s0
               	fcvtzs	x2, d0
               	add	x1, x1, x2
               	add	x1, x1, #0x7
               	sxtw	x1, w1
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp], #0x40
               	ret
