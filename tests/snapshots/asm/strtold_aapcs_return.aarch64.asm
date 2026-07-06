
strtold_aapcs_return.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x300              // =768
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	d8, [sp, #-0xa0]!
               	str	x20, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x90]
               	add	x29, sp, #0x90
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x20, #0x0               // =0
               	mov	x1, x20
               	bl	<addr>
               	bl	<addr>
               	fmov	d8, d0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, x20
               	bl	<addr>
               	bl	<addr>
               	mov	x0, #0x41f0000000000000 // =4751297606875873280
               	fmov	d17, x0
               	fcmp	d8, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x19, [sp, #0x20]
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp], #0xa0
               	ret
               	mov	x0, #0x43f0000000000000 // =4895412794951729152
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x19, [sp, #0x20]
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp], #0xa0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	bl	<addr>
               	mov	x0, #0x4090000000000000 // =4652218415073722368
               	fmov	d16, x0
               	fneg	d1, d16
               	fcmp	d0, d1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x19, [sp, #0x20]
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x38
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	fmov	d0, d8
               	bl	<addr>
               	sxtw	x0, w0
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.gt	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x19, [sp, #0x20]
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp], #0xa0
               	ret
               	sub	x0, x29, #0x38
               	ldrb	w0, [x0]
               	mov	x17, #0x34              // =52
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x19, [sp, #0x20]
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp], #0xa0
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x19, [sp, #0x20]
               	ldr	x20, [sp, #0x10]
               	ldr	d8, [sp], #0xa0
               	ret
