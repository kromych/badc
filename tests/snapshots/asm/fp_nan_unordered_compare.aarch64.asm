
fp_nan_unordered_compare.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	fmov	d17, x0
               	fdiv	d0, d16, d17
               	mov	x1, #0x4014000000000000 // =4617315517961601024
               	mov	x2, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d16, x2
               	fmov	d17, x0
               	fdiv	d1, d16, d17
               	fcmp	d0, d0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fmov	d16, x1
               	fcmp	d16, d0
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	fcmp	d0, d0
               	b.ne	<addr>
               	mov	x0, #0xa                // =10
               	ret
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.ne	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	fmov	d16, x1
               	fcmp	d16, d0
               	b.ne	<addr>
               	mov	x0, #0xc                // =12
               	ret
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.ne	<addr>
               	mov	x0, #0xd                // =13
               	ret
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.pl	<addr>
               	mov	x0, #0x14               // =20
               	ret
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.le	<addr>
               	mov	x0, #0x15               // =21
               	ret
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.hi	<addr>
               	mov	x0, #0x16               // =22
               	ret
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.lt	<addr>
               	mov	x0, #0x17               // =23
               	ret
               	fmov	d16, x1
               	fcmp	d16, d0
               	b.pl	<addr>
               	mov	x0, #0x18               // =24
               	ret
               	fmov	d16, x1
               	fcmp	d16, d0
               	b.le	<addr>
               	mov	x0, #0x19               // =25
               	ret
               	fmov	d16, x1
               	fcmp	d16, d0
               	b.hi	<addr>
               	mov	x0, #0x1a               // =26
               	ret
               	fmov	d16, x1
               	fcmp	d16, d0
               	b.lt	<addr>
               	mov	x0, #0x1b               // =27
               	ret
               	fcmp	d0, d0
               	b.pl	<addr>
               	mov	x0, #0x1c               // =28
               	ret
               	fcmp	d0, d0
               	b.hi	<addr>
               	mov	x0, #0x1d               // =29
               	ret
               	fcmp	d0, d0
               	b.lt	<addr>
               	mov	x0, #0x1e               // =30
               	ret
               	mov	x2, #0x4018000000000000 // =4618441417868443648
               	fmov	d16, x1
               	fmov	d17, x2
               	fcmp	d16, d17
               	b.mi	<addr>
               	mov	x0, #0x28               // =40
               	ret
               	fmov	d16, x1
               	fmov	d17, x1
               	fcmp	d16, d17
               	b.eq	<addr>
               	mov	x0, #0x29               // =41
               	ret
               	fmov	d17, x1
               	fcmp	d1, d17
               	b.gt	<addr>
               	mov	x0, #0x2a               // =42
               	ret
               	mov	x1, #0x759c             // =30108
               	movk	x1, #0x8800, lsl #16
               	movk	x1, #0xe43c, lsl #32
               	movk	x1, #0x7e37, lsl #48
               	fmov	d17, x1
               	fcmp	d1, d17
               	b.gt	<addr>
               	mov	x0, #0x2b               // =43
               	ret
               	fcmp	d1, d1
               	b.eq	<addr>
               	mov	x0, #0x2c               // =44
               	ret
               	ret
