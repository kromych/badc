
fp_arg_passed_in_fp_reg.aarch64:	file format elf64-littleaarch64

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
               	fmov	d0, #2.00000000
               	fmov	d1, #3.00000000
               	fmadd	d0, d0, d1, d0
               	fmov	d1, #8.00000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fmov	d0, #1.50000000
               	fmov	d1, #2.50000000
               	mov	x0, #0x3                // =3
               	mov	x1, #0x4                // =4
               	scvtf	d2, x0
               	scvtf	d3, x1
               	fmul	d1, d1, d3
               	fmadd	d0, d0, d2, d1
               	fmov	d1, #14.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fmov	d0, #6.25000000
               	fmov	d1, #4.00000000
               	fmadd	d0, d0, d1, d0
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fcmp	d0, d1
               	b.eq	<addr>
               	ret
               	mov	x0, #0x0                // =0
               	ret
