
local_init_int_to_float.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x16, #0x42280000        // =1109917696
               	fmov	s0, w16
               	adrp	x16, <page>
               	ldr	s1, [x16, #0x68]
               	fcmpe	s0, s1
               	b.mi	<addr>
               	adrp	x16, <page>
               	ldr	s1, [x16, #0x6c]
               	fcmpe	s0, s1
               	b.le	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x16, #0x4045000000000000 // =4631107791820423168
               	fmov	d0, x16
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x16, <page>
               	ldr	s0, [x16, #0x70]
               	adrp	x16, <page>
               	ldr	s1, [x16, #0x74]
               	fcmpe	s0, s1
               	b.mi	<addr>
               	adrp	x16, <page>
               	ldr	s1, [x16, #0x78]
               	fcmpe	s0, s1
               	b.le	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x16, <page>
               	ldr	d0, [x16, #0x60]
               	bl	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	fmov	d0, #-7.00000000
               	fmov	d1, #-7.50000000
               	fcmpe	d0, d1
               	b.mi	<addr>
               	fmov	d1, #-6.50000000
               	fcmpe	d0, d1
               	b.le	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x4f800000        // =1333788672
               	fmov	s0, w16
               	adrp	x16, <page>
               	ldr	s1, [x16, #0x7c]
               	fcmpe	s0, s1
               	b.mi	<addr>
               	adrp	x16, <page>
               	ldr	s1, [x16, #0x80]
               	fcmpe	s0, s1
               	b.le	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x16, #0x41f0000000000000 // =4751297606875873280
               	fmov	d0, x16
               	bl	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
