
ternary_arith_conversion.aarch64:	file format elf64-littleaarch64

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
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	mov	x17, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d0, x17
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	mov	x17, #0x4000000000000000 // =4611686018427387904
               	fmov	d0, x17
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ret
               	mov	x17, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d0, x17
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ret
               	mov	x17, #0x4000000000000000 // =4611686018427387904
               	fmov	d0, x17
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ret
               	mov	x2, #0x3f800000         // =1065353216
               	fmov	s16, w2
               	fcvt	d0, s16
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ret
               	mov	x17, #0x4000000000000000 // =4611686018427387904
               	fmov	d0, x17
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ret
               	mov	x17, #0x3f800000        // =1065353216
               	fmov	s0, w17
               	fmov	s17, w2
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ret
               	mov	x0, #0x40000000         // =1073741824
               	mov	x17, #0x40000000        // =1073741824
               	fmov	s0, w17
               	fmov	s17, w0
               	fcmp	s0, s17
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ret
               	mov	x0, #0xa                // =10
               	mov	x0, #0x2                // =2
               	mov	x0, #0x0                // =0
               	ret
