
float_long_double_suffix.aarch64:	file format elf64-littleaarch64

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
               	fmov	s0, #1.00000000
               	fcvt	d0, s0
               	fmov	d1, #1.00000000
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ret
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ret
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ret
               	adrp	x16, <page>
               	ldr	d0, [x16]
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ret
               	mov	x0, #0x0                // =0
               	ret
