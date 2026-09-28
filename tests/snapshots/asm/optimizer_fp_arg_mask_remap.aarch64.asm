
optimizer_fp_arg_mask_remap.aarch64:	file format elf64-littleaarch64

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
               	stp	d8, d9, [sp, #-0x30]!
               	str	d10, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	fmov	d0, #0.50000000
               	bl	<addr>
               	fmov	d8, d0
               	fmov	d0, #0.50000000
               	bl	<addr>
               	fmov	d9, d0
               	fmov	d0, #4.00000000
               	fsqrt	d10, d0
               	movi	d0, #0000000000000000
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16]
               	fcmp	d8, d1
               	b.mi	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x8]
               	fcmp	d8, d1
               	b.le	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x10]
               	fcmp	d9, d1
               	b.mi	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x18]
               	fcmp	d9, d1
               	b.le	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	fmov	d1, #2.00000000
               	fcmp	d10, d1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x20]
               	fcmp	d0, d1
               	b.mi	<addr>
               	adrp	x16, <page>
               	ldr	d1, [x16, #0x28]
               	fcmp	d0, d1
               	b.le	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x30
               	ret
               	mov	x0, #0x13               // =19
               	ldp	x29, x30, [sp, #0x20]
               	ldr	d10, [sp, #0x10]
               	ldp	d8, d9, [sp], #0x30
               	ret
