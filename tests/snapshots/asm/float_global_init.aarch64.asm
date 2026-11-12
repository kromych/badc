
float_global_init.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <page>
               	ldr	s0, [x0, #0x14]
               	fcvt	d0, s0
               	fmov	d2, #1.00000000
               	fsub	d3, d0, d2
               	adrp	x16, <page>
               	ldr	d0, [x16]
               	fcmpe	d3, d0
               	b.pl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x8]
               	fcmpe	d3, d1
               	b.gt	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x0, <page>
               	ldr	s3, [x0, #0x18]
               	fcvt	d3, s3
               	fsub	d3, d3, d2
               	fcmpe	d3, d0
               	b.pl	<addr>
               	fcmpe	d3, d1
               	b.gt	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	ldr	s3, [x0, #0x1c]
               	fcvt	d4, s3
               	fmov	d3, #2.50000000
               	fsub	d4, d4, d3
               	fcmpe	d4, d0
               	b.pl	<addr>
               	fcmpe	d4, d1
               	b.gt	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x0, <page>
               	ldr	s4, [x0, #0x20]
               	fcvt	d4, s4
               	fsub	d4, d4, d2
               	fcmpe	d4, d0
               	b.pl	<addr>
               	fcmpe	d4, d1
               	b.gt	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x0, <page>
               	ldr	s4, [x0, #0x24]
               	fcvt	d4, s4
               	fsub	d4, d4, d2
               	fcmpe	d4, d0
               	b.pl	<addr>
               	fcmpe	d4, d1
               	b.gt	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	adrp	x0, <page>
               	ldr	d4, [x0, #0x28]
               	fsub	d2, d4, d2
               	fcmpe	d2, d0
               	b.pl	<addr>
               	fcmpe	d2, d1
               	b.gt	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x0, <page>
               	ldr	d2, [x0, #0x30]
               	fsub	d2, d2, d3
               	fcmpe	d2, d0
               	b.pl	<addr>
               	fcmpe	d2, d1
               	b.gt	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	adrp	x0, <page>
               	ldr	d2, [x0, #0x38]
               	fmov	d3, #3.00000000
               	fsub	d2, d2, d3
               	fcmpe	d2, d0
               	b.pl	<addr>
               	fcmpe	d2, d1
               	b.gt	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x0                // =0
               	ret
