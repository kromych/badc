
global_struct_return_indirect.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x16, x29, #0x8
               	str	x8, [x16]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x16, x0
               	sub	x17, x29, #0x8
               	ldr	x17, [x17]
               	ldr	x0, [x16]
               	str	x0, [x17]
               	ldr	x0, [x16, #0x8]
               	str	x0, [x17, #0x8]
               	ldrb	w0, [x16, #0x10]
               	strb	w0, [x17, #0x10]
               	ldrb	w0, [x16, #0x11]
               	strb	w0, [x17, #0x11]
               	ldrb	w0, [x16, #0x12]
               	strb	w0, [x17, #0x12]
               	ldrb	w0, [x16, #0x13]
               	strb	w0, [x17, #0x13]
               	mov	x0, x17
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xd0
               	str	x20, [sp]
               	sub	x8, x29, #0x80
               	bl	<addr>
               	sub	x0, x29, #0x80
               	sub	x1, x29, #0x18
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldrb	w10, [x0, #0x10]
               	strb	w10, [x1, #0x10]
               	ldrb	w10, [x0, #0x11]
               	strb	w10, [x1, #0x11]
               	ldrb	w10, [x0, #0x12]
               	strb	w10, [x1, #0x12]
               	ldrb	w10, [x0, #0x13]
               	strb	w10, [x1, #0x13]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x18
               	ldr	w0, [x0]
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x2, #0x1                // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	sub	x0, x29, #0x18
               	ldrsw	x0, [x0, #0x10]
               	cmp	x0, #0x5
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x8, x29, #0xa8
               	bl	<addr>
               	sub	x0, x29, #0xa8
               	ldr	w20, [x0]
               	sub	x8, x29, #0xc0
               	bl	<addr>
               	sub	x0, x29, #0xc0
               	ldrsw	x0, [x0, #0x10]
               	add	x0, x20, x0
               	mov	w0, w0
               	sxtw	x0, w0
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
