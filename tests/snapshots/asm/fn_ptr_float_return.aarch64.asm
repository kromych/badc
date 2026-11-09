
fn_ptr_float_return.aarch64:	file format elf64-littleaarch64

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
               	fmov	s0, #2.50000000
               	fcmp	s0, s0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fmov	s1, #5.00000000
               	fcmp	s1, s1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fmov	s1, #3.00000000
               	fcmp	s1, s1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	fcmp	s0, s0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	fmov	d0, #2.00000000
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret
