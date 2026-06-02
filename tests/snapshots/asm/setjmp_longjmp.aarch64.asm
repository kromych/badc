
setjmp_longjmp.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xd0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	sxtw	x1, w1
               	add	x13, x0, #0x200
               	str	w1, [x13]
               	bl	<addr>
               	uxtb	w0, w0
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x250
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	b	<addr>
               	mov	x14, #0xb               // =11
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x250
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	sub	x0, x29, #0x208
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x21, x0
               	sxtw	x13, w21
               	cmp	x13, #0x0
               	b.ne	<addr>
               	sub	x0, x29, #0x208
               	mov	x1, #0x7                // =7
               	bl	<addr>
               	mov	x0, #0xc                // =12
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x250
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x21, w21
               	cmp	x21, #0x7
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x250
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x20, #0x1
               	b.eq	<addr>
               	mov	x21, #0xe               // =14
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x250
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x208
               	add	x20, x20, #0x200
               	ldrsw	x20, [x20]
               	cmp	x20, #0x7
               	b.eq	<addr>
               	mov	x21, #0xf               // =15
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x250
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x20, #0x0               // =0
               	mov	x0, x20
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x250
               	ldp	x29, x30, [sp], #0x10
               	ret
