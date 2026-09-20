
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
               	fmov	d1, #0.25000000
               	fmov	s2, #1.50000000
               	fmov	d3, #10.00000000
               	fmul	d0, d0, d3
               	fcvtzs	x2, d0
               	add	x0, x0, x2
               	add	x0, x0, x1
               	mov	x16, #0x4059000000000000 // =4636737291354636288
               	fmov	d0, x16
               	fmul	d0, d1, d0
               	fcvtzs	x1, d0
               	add	x0, x0, x1
               	fmov	s0, #2.00000000
               	fmul	s0, s2, s0
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
