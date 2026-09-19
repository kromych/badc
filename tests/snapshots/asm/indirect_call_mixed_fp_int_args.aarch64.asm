
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	d0, [x1]
               	add	x1, x0, #0x2
               	mov	x2, #0x3fd0000000000000 // =4598175219545276416
               	mov	x3, #0x3fc00000         // =1069547520
               	mov	x4, #0x4024000000000000 // =4621819117588971520
               	fmov	d17, x4
               	fmul	d0, d0, d17
               	fcvtzs	x4, d0
               	add	x0, x0, x4
               	add	x0, x0, x1
               	mov	x1, #0x4059000000000000 // =4636737291354636288
               	fmov	d16, x2
               	fmov	d17, x1
               	fmul	d0, d16, d17
               	fcvtzs	x1, d0
               	add	x0, x0, x1
               	mov	x1, #0x40000000         // =1073741824
               	fmov	s16, w3
               	fmov	s17, w1
               	fmul	s0, s16, s17
               	fcvtzs	x1, s0
               	add	x0, x0, x1
               	add	x0, x0, #0x7
               	cmp	w0, #0x40
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	cmp	w0, w0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x0                // =0
               	ret
