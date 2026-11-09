
ssa_fp_routing.aarch64:	file format elf64-littleaarch64

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
               	fmov	d0, #3.75000000
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	fmov	d1, #3.50000000
               	fcmp	d1, d1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	fmov	d1, #10.00000000
               	fcmp	d1, d1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	fmov	d0, #-2.50000000
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	fmov	d0, #7.00000000
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	fmov	d0, #1.00000000
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	fmov	d1, #2.00000000
               	fcmp	d0, d1
               	b.ne	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	fcmp	d0, d1
               	b.ne	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ret
               	fcmpe	d0, d1
               	b.mi	<addr>
               	mov	x0, #0xb                // =11
               	ret
               	fcmpe	d1, d0
               	b.pl	<addr>
               	mov	x0, #0xc                // =12
               	ret
               	fcmpe	d1, d0
               	b.gt	<addr>
               	mov	x0, #0xd                // =13
               	ret
               	fcmpe	d0, d1
               	b.le	<addr>
               	mov	x0, #0xe                // =14
               	ret
               	fcmpe	d0, d0
               	b.ls	<addr>
               	mov	x0, #0xf                // =15
               	ret
               	fcmpe	d0, d1
               	b.ls	<addr>
               	mov	x0, #0x10               // =16
               	ret
               	fcmpe	d1, d0
               	b.hi	<addr>
               	mov	x0, #0x11               // =17
               	ret
               	fcmpe	d0, d0
               	b.ge	<addr>
               	mov	x0, #0x12               // =18
               	ret
               	fcmpe	d1, d0
               	b.ge	<addr>
               	mov	x0, #0x13               // =19
               	ret
               	fmov	d1, #1.00000000
               	fmov	d0, #2.00000000
               	fcmpe	d1, d0
               	b.lt	<addr>
               	mov	x0, #0x14               // =20
               	ret
               	mov	x16, #0x4045000000000000 // =4631107791820423168
               	fmov	d1, x16
               	fcmp	d1, d1
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ret
               	fmov	d1, #-3.00000000
               	fcmp	d1, d1
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	ret
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	adrp	x16, <page>
               	ldr	d2, [x16, #0x8]
               	fcmp	d1, d2
               	b.ne	<addr>
               	mov	x0, #0x19               // =25
               	ret
               	fcmp	d0, d0
               	b.eq	<addr>
               	mov	x0, #0x1a               // =26
               	ret
               	mov	x0, #0x0                // =0
               	ret
