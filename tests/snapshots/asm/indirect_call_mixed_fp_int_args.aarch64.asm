
indirect_call_mixed_fp_int_args.aarch64:	file format elf64-littleaarch64

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
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	d0, [x1]
               	add	x1, x0, #0x2
               	mov	x7, #0x3fd0000000000000 // =4598175219545276416
               	mov	x8, #0x3fc00000         // =1069547520
               	mov	x9, #0x4024000000000000 // =4621819117588971520
               	fmov	d17, x9
               	fmul	d1, d0, d17
               	fcvtzs	x10, d1
               	add	x3, x0, x10
               	add	x4, x3, x1
               	mov	x11, #0x4059000000000000 // =4636737291354636288
               	fmov	d16, x7
               	fmov	d17, x11
               	fmul	d2, d16, d17
               	fcvtzs	x12, d2
               	add	x5, x4, x12
               	mov	x13, #0x40000000        // =1073741824
               	fmov	s16, w8
               	fmov	s17, w13
               	fmul	s3, s16, s17
               	fcvtzs	x14, s3
               	add	x6, x5, x14
               	add	x15, x6, #0x7
               	sxtw	x2, w15
               	cmp	x2, #0x40
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	cmp	x2, x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
