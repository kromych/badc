
inline_fp_class_struct_param.aarch64:	file format elf64-littleaarch64

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

<use_pair>:
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	fmov	d2, #2.00000000
               	fmadd	d0, d1, d2, d0
               	ret

<use_quad>:
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	fmov	d2, #2.00000000
               	fmadd	d0, d1, d2, d0
               	ldr	d1, [x0, #0x10]
               	fmov	d2, #4.00000000
               	fmadd	d0, d1, d2, d0
               	ldr	d1, [x0, #0x18]
               	fmov	d2, #8.00000000
               	fmadd	d0, d1, d2, d0
               	ret

<use_mixed>:
               	ldr	x1, [x0]
               	scvtf	d0, x1
               	ldr	d1, [x0, #0x8]
               	fadd	d0, d0, d1
               	ret

<use_pair_clobber>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x16, #0x4059000000000000 // =4636737291354636288
               	fmov	d0, x16
               	str	d0, [x0]
               	mov	x16, #0x4069000000000000 // =4641240890982006784
               	fmov	d0, x16
               	str	d0, [x0, #0x8]
               	ldr	d0, [x1]
               	fmov	d1, #10.00000000
               	ldr	d2, [x1, #0x8]
               	fmadd	d0, d0, d1, d2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	bl	<addr>
               	fmov	d1, #6.50000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [sp], #0x10
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x40]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	bl	<addr>
               	fmov	d1, #7.25000000
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x40
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x48]
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	mov	x16, #0x4059000000000000 // =4636737291354636288
               	fmov	d1, x16
               	fcmp	d0, d1
               	b.ne	<addr>
               	ldr	d0, [x0, #0x8]
               	mov	x16, #0x4069000000000000 // =4641240890982006784
               	fmov	d1, x16
               	fcmp	d0, d1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
