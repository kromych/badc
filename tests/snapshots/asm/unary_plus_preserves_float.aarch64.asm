
unary_plus_preserves_float.aarch64:	file format elf64-littleaarch64

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
               	mov	x1, #0x3ff8000000000000 // =4609434218613702656
               	mov	x0, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d16, x1
               	fmov	d17, x0
               	fadd	d0, d16, d17
               	mov	x3, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x3
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x2, #0x0                // =0
               	fmov	d16, x1
               	fmov	d17, x2
               	fcmp	d16, d17
               	b.pl	<addr>
               	fmov	d16, x0
               	fneg	d0, d16
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fmov	d16, x1
               	fadd	d0, d16, d0
               	fmov	d17, x3
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	fmov	d16, x1
               	fmov	d17, x2
               	fcmp	d16, d17
               	b.pl	<addr>
               	fmov	d16, x0
               	fneg	d0, d16
               	fmov	d16, x1
               	fadd	d0, d16, d0
               	fmov	d17, x3
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	fmov	d16, x1
               	fmov	d17, x2
               	fcmp	d16, d17
               	b.pl	<addr>
               	fmov	d16, x0
               	fneg	d0, d16
               	fmov	d16, x1
               	fadd	d0, d16, d0
               	fcvtzs	x4, d0
               	cmp	x4, #0x2
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	fmov	d16, x1
               	fmov	d17, x2
               	fcmp	d16, d17
               	b.pl	<addr>
               	fmov	d16, x0
               	fneg	d0, d16
               	fmov	d16, x1
               	fadd	d0, d16, d0
               	fcvtzs	x4, d0
               	scvtf	d0, x4
               	fmov	d17, x3
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	fmov	d16, x1
               	fneg	d0, d16
               	fmov	d17, x2
               	fcmp	d0, d17
               	b.pl	<addr>
               	fmov	d16, x0
               	fneg	d1, d16
               	fadd	d0, d0, d1
               	fcvtzs	x0, d0
               	scvtf	d0, x0
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fneg	d1, d16
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	mov	x17, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d1, x17
               	b	<addr>
               	mov	x17, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, x17
               	b	<addr>
               	mov	x17, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, x17
               	b	<addr>
               	mov	x17, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, x17
               	b	<addr>
               	mov	x17, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d0, x17
               	b	<addr>
