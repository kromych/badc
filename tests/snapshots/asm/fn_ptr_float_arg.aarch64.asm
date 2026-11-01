
fn_ptr_float_arg.aarch64:	file format elf64-littleaarch64

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
               	fmov	s1, #2.50000000
               	fmov	s0, #2.00000000
               	fmul	s1, s1, s0
               	fcvtzs	x0, s1
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fmov	s1, #3.50000000
               	fmul	s0, s1, s0
               	fcvtzs	x0, s0
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
