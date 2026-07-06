
ssa_variadic_fp_arg.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x20, x21, [sp, #-0x50]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldr	d0, [x20]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x21, #0x900000000000    // =158329674399744
               	movk	x21, #0x407f, lsl #48
               	fmov	d16, x21
               	sub	x17, x29, #0x8
               	str	d16, [x17]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x16, x29, #0x8
               	ldr	d0, [x16]
               	bl	<addr>
               	sxtw	x0, w0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	d0, [x1]
               	ldr	d1, [x20]
               	bl	<addr>
               	sxtw	x0, w0
               	sub	x16, x29, #0x8
               	ldr	d0, [x16]
               	fmov	d17, x21
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	ldr	d0, [x20]
               	mov	x0, #0x900000000000     // =158329674399744
               	movk	x0, #0x407f, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret
