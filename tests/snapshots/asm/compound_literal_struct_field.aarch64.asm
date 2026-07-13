
compound_literal_struct_field.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x280              // =640
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x2, x29, #0x20
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x2]
               	ldr	x10, [x3, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [x3, #0x10]
               	str	x10, [x2, #0x10]
               	ldr	x10, [x3, #0x18]
               	str	x10, [x2, #0x18]
               	ldr	x10, [sp], #0x10
               	sub	x2, x29, #0x20
               	str	x0, [x2]
               	sub	x2, x29, #0x20
               	str	x1, [x2, #0x8]
               	sub	x2, x29, #0x28
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x3]
               	str	x10, [x2]
               	ldr	x10, [sp], #0x10
               	sub	x3, x29, #0x28
               	sub	x2, x29, #0x20
               	str	x3, [x2, #0x10]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	sub	x2, x29, #0x20
               	str	x3, [x2, #0x18]
               	sub	x2, x29, #0x20
               	ldr	x2, [x2]
               	cmp	x2, x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	ldr	x0, [x0, #0x8]
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	ldr	x0, [x0, #0x10]
               	ldrsw	x0, [x0]
               	cmp	x0, #0x3
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x20
               	ldr	x0, [x0, #0x10]
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x4
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	ldr	x0, [x0, #0x18]
               	ldrb	w0, [x0]
               	mov	x17, #0x6f              // =111
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x20
               	ldr	x0, [x0, #0x18]
               	ldrb	w0, [x0, #0x1]
               	mov	x17, #0x6b              // =107
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x20
               	ldr	x0, [x0, #0x18]
               	ldrb	w0, [x0, #0x2]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x0, x29, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x18
               	ldr	x0, [x0]
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	ldr	x0, [x0, #0x8]
               	add	x0, x0, #0x0
               	ldrsw	x0, [x0]
               	add	x1, x0, #0x0
               	sub	x0, x29, #0x18
               	ldr	x0, [x0, #0x8]
               	ldrsw	x0, [x0, #0x4]
               	add	x1, x1, x0
               	sub	x0, x29, #0x18
               	ldr	x0, [x0, #0x8]
               	ldrsw	x0, [x0, #0x8]
               	add	x0, x1, x0
               	cmp	x0, #0x12
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xb                // =11
               	mov	x1, #0x16               // =22
               	bl	<addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
