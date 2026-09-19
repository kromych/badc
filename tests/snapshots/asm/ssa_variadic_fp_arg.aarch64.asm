
ssa_variadic_fp_arg.aarch64:	file format elf64-littleaarch64

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
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	d0, [x1]
               	bl	<addr>
               	mov	x20, #0x900000000000    // =158329674399744
               	movk	x20, #0x407f, lsl #48
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	fmov	d0, x20
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	d0, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	d1, [x1]
               	bl	<addr>
               	mov	x0, #0x900000000000     // =158329674399744
               	movk	x0, #0x407f, lsl #48
               	fmov	d16, x20
               	fmov	d17, x0
               	fcmp	d16, d17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	d0, [x1]
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
