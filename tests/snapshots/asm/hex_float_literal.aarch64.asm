
hex_float_literal.aarch64:	file format elf64-littleaarch64

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
               	fmov	d0, #16.00000000
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x16, #0x4090000000000000 // =4652218415073722368
               	fmov	d0, x16
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fmov	d0, #3.00000000
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	fmov	d0, #1.00000000
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	fmov	d1, #10.00000000
               	fcmp	d1, d1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	fmov	s2, #1.00000000
               	fcvt	d2, s2
               	fcmp	d2, d0
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	adrp	x16, <page>
               	ldr	d0, [x16]
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	fmov	d0, #-0.50000000
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ret
               	fcmp	d1, d1
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	mov	x0, #0x0                // =0
               	ret
