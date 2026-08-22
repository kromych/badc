
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
               	ldrsw	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	add	x2, x1, #0x2
               	mov	x8, #0x3fd0000000000000 // =4598175219545276416
               	mov	x9, #0x3fc00000         // =1069547520
               	mov	x10, #0x4024000000000000 // =4621819117588971520
               	fmov	d17, x10
               	fmul	d1, d0, d17
               	fcvtzs	x11, d1
               	add	x3, x1, x11
               	add	x4, x3, x2
               	mov	x12, #0x4059000000000000 // =4636737291354636288
               	fmov	d16, x8
               	fmov	d17, x12
               	fmul	d2, d16, d17
               	fcvtzs	x13, d2
               	add	x5, x4, x13
               	mov	x14, #0x40000000        // =1073741824
               	fmov	s16, w9
               	fmov	s17, w14
               	fmul	s3, s16, s17
               	fcvtzs	x15, s3
               	add	x6, x5, x15
               	add	x7, x6, #0x7
               	sxtw	x0, w7
               	cmp	x0, #0x40
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	cmp	x0, x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
