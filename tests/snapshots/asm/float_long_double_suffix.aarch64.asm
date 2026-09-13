
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
               	mov	x0, #0x3f800000         // =1065353216
               	fmov	s16, w0
               	fcvt	d0, s16
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ret
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ret
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ret
               	mov	x0, #0xb0000000         // =2952790016
               	movk	x0, #0xf08e, lsl #32
               	movk	x0, #0x420b, lsl #48
               	fmov	d16, x0
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ret
               	mov	x0, #0x0                // =0
               	ret
