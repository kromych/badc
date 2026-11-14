
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
               	fmov	d1, #5.00000000
               	fcmp	d0, d0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fcmp	d0, d1
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fcmp	d1, d0
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
               	fcmp	d0, d1
               	b.ne	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	fcmp	d1, d0
               	b.ne	<addr>
               	mov	x0, #0xc                // =12
               	ret
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.ne	<addr>
               	mov	x0, #0xd                // =13
               	ret
               	fcmpe	d0, d1
               	b.pl	<addr>
               	mov	x0, #0x14               // =20
               	ret
               	fcmpe	d0, d1
               	b.le	<addr>
               	mov	x0, #0x15               // =21
               	ret
               	fcmpe	d0, d1
               	b.hi	<addr>
               	mov	x0, #0x16               // =22
               	ret
               	fcmpe	d0, d1
               	b.lt	<addr>
               	mov	x0, #0x17               // =23
               	ret
               	fcmpe	d1, d0
               	b.pl	<addr>
               	mov	x0, #0x18               // =24
               	ret
               	fcmpe	d1, d0
               	b.le	<addr>
               	mov	x0, #0x19               // =25
               	ret
               	fcmpe	d1, d0
               	b.hi	<addr>
               	mov	x0, #0x1a               // =26
               	ret
               	fcmpe	d1, d0
               	b.lt	<addr>
               	mov	x0, #0x1b               // =27
               	ret
               	fcmpe	d0, d0
               	b.pl	<addr>
               	mov	x0, #0x1c               // =28
               	ret
               	fcmpe	d0, d0
               	b.hi	<addr>
               	mov	x0, #0x1d               // =29
               	ret
               	fcmpe	d0, d0
               	b.lt	<addr>
               	mov	x0, #0x1e               // =30
               	ret
               	ret
