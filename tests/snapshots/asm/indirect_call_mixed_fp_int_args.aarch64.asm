
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
               	ldrsw	x0, [x0, #0x18]
               	adrp	x1, <page>
               	ldr	d0, [x1, #0x20]
               	add	x1, x0, #0x2
               	fmov	d1, #10.00000000
               	fmul	d0, d0, d1
               	fcvtzs	x2, d0
               	add	x0, x0, x2
               	add	x0, x0, x1
               	add	x0, x0, #0x19
               	add	x0, x0, #0x3
               	add	x0, x0, #0x7
               	cmp	w0, #0x40
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret
