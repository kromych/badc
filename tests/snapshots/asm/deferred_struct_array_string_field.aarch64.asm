
deferred_struct_array_string_field.aarch64:	file format elf64-littleaarch64

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

<check>:
               	mov	x4, x1
               	mov	x5, x2
               	ldr	x1, [x0]
               	ldrb	w1, [x1]
               	ldrb	w2, [x4]
               	cmp	w1, w2
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	x1, [x0, #0x10]
               	ldrb	w1, [x1]
               	ldrb	w2, [x5]
               	cmp	w1, w2
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x1, #0x0                // =0
               	sxtw	x2, w1
               	add	x6, x4, x2
               	ldrb	w3, [x6]
               	cbnz	x3, <addr>
               	ldr	x3, [x0]
               	add	x3, x3, x2
               	ldrb	w3, [x3]
               	cbz	x3, <addr>
               	ldr	x3, [x0]
               	add	x3, x3, x2
               	ldrb	w3, [x3]
               	ldrb	w6, [x6]
               	cmp	w3, w6
               	b.ne	<addr>
               	add	x1, x2, #0x1
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x1, #0x0                // =0
               	sxtw	x2, w1
               	add	x4, x5, x2
               	ldrb	w3, [x4]
               	cbnz	x3, <addr>
               	ldr	x3, [x0, #0x10]
               	add	x3, x3, x2
               	ldrb	w3, [x3]
               	cbz	x3, <addr>
               	ldr	x3, [x0, #0x10]
               	add	x3, x3, x2
               	ldrb	w3, [x3]
               	ldrb	w4, [x4]
               	cmp	w3, w4
               	b.ne	<addr>
               	add	x1, x2, #0x1
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>

<main>:
               	str	x20, [sp, #-0x80]!
               	stp	x29, x30, [sp, #0x70]
               	add	x29, sp, #0x70
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, x20
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	ldrsw	x0, [x20, #0x8]
               	cmp	w0, #0x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrsw	x0, [x20, #0x18]
               	cmp	w0, #0x2
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x20, [sp], #0x80
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x18]
               	cmp	w0, #0x4
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x20, [sp], #0x80
               	ret
               	sub	x0, x29, #0x40
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
               	mov	x1, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x40
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x5
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x20, [sp], #0x80
               	ret
               	sub	x0, x29, #0x20
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
               	mov	x1, x0
               	sub	x1, x29, #0x50
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x20
               	ldrsw	x0, [x0, #0x18]
               	cmp	w0, #0x8
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x20, [sp], #0x80
               	ret
               	sub	x1, x29, #0x50
               	ldr	x0, [x1]
               	ldrb	w0, [x0, #0x7]
               	mov	x17, #0x69              // =105
               	eor	x0, x0, x17
               	mov	w2, w0
               	mov	x0, #0x1                // =1
               	cbnz	x2, <addr>
               	ldr	x0, [x1]
               	ldrb	w0, [x0, #0x8]
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrsw	x0, [x1, #0x8]
               	cmp	w0, #0x9
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x20, [sp], #0x80
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0xa
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x20, [sp], #0x80
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x20, [sp], #0x80
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
