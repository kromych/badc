
variadic_agg_return_classes.aarch64:	file format elf64-littleaarch64

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
               	fmov	d0, #1.50000000
               	mov	x0, #0x2                // =2
               	scvtf	d1, x0
               	fmul	d1, d0, d1
               	fmov	d0, #2.25000000
               	fmov	d2, #3.00000000
               	fcmp	d1, d2
               	b.ne	<addr>
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fmov	d0, #0.50000000
               	fcmp	d0, d0
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	ret
