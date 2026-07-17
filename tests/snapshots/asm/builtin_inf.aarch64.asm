
builtin_inf.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0xc8a0             // =51360
               	movk	x0, #0x85eb, lsl #16
               	movk	x0, #0xccf3, lsl #32
               	movk	x0, #0x7fe1, lsl #48
               	mov	x1, #0x4024000000000000 // =4621819117588971520
               	fmov	d16, x0
               	fmov	d17, x1
               	fmul	d0, d16, d17
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, gt
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0xc8a0             // =51360
               	movk	x0, #0x85eb, lsl #16
               	movk	x0, #0xccf3, lsl #32
               	movk	x0, #0x7fe1, lsl #48
               	mov	x1, #0x4024000000000000 // =4621819117588971520
               	fmov	d16, x0
               	fmov	d17, x1
               	fmul	d0, d16, d17
               	fcvt	s0, d0
               	mov	x0, #0xb1e6             // =45542
               	movk	x0, #0x7f61, lsl #16
               	fmov	s17, w0
               	fcmp	s0, s17
               	cset	x0, gt
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0xc8a0             // =51360
               	movk	x0, #0x85eb, lsl #16
               	movk	x0, #0xccf3, lsl #32
               	movk	x0, #0x7fe1, lsl #48
               	mov	x1, #0x4024000000000000 // =4621819117588971520
               	fmov	d16, x0
               	fmov	d17, x1
               	fmul	d0, d16, d17
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ls
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x0                // =0
               	ret
