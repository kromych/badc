
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
               	mov	x0, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x0
               	fmadd	d0, d1, d17, d0
               	ret

<use_quad>:
               	ldr	d0, [x0]
               	ldr	d1, [x0, #0x8]
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d17, x1
               	fmadd	d0, d1, d17, d0
               	ldr	d1, [x0, #0x10]
               	mov	x1, #0x4010000000000000 // =4616189618054758400
               	fmov	d17, x1
               	fmadd	d0, d1, d17, d0
               	ldr	d1, [x0, #0x18]
               	mov	x0, #0x4020000000000000 // =4620693217682128896
               	fmov	d17, x0
               	fmadd	d0, d1, d17, d0
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
               	mov	x2, #0x4059000000000000 // =4636737291354636288
               	fmov	d16, x2
               	str	d16, [x0]
               	mov	x2, #0x4069000000000000 // =4641240890982006784
               	fmov	d16, x2
               	str	d16, [x0, #0x8]
               	ldr	d0, [x1]
               	mov	x0, #0x4024000000000000 // =4621819117588971520
               	ldr	d1, [x1, #0x8]
               	fmov	d17, x0
               	fmadd	d0, d0, d17, d1
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
               	mov	x0, #0x401a000000000000 // =4619004367821864960
               	fmov	d17, x0
               	fcmp	d0, d17
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
               	mov	x0, #0x800000000000     // =140737488355328
               	movk	x0, #0x4048, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
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
               	mov	x0, #0x401d000000000000 // =4619848792751996928
               	fmov	d17, x0
               	fcmp	d0, d17
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
               	mov	x0, #0x800000000000     // =140737488355328
               	movk	x0, #0x4031, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	mov	x1, #0x4059000000000000 // =4636737291354636288
               	fmov	d17, x1
               	fcmp	d0, d17
               	b.ne	<addr>
               	ldr	d0, [x0, #0x8]
               	mov	x0, #0x4069000000000000 // =4641240890982006784
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
