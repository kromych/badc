
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
               	mov	x3, x0
               	mov	x4, x1
               	ldr	x0, [x3]
               	ldrb	w0, [x0]
               	ldrb	w1, [x4]
               	cmp	w0, w1
               	b.ne	<addr>
               	ldr	x0, [x3, #0x10]
               	ldrb	w0, [x0]
               	ldrb	w1, [x2]
               	cmp	w0, w1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	sxtw	x1, w0
               	add	x5, x4, x1
               	ldrb	w6, [x5]
               	cbnz	x6, <addr>
               	ldr	x6, [x3]
               	add	x6, x6, x1
               	ldrb	w6, [x6]
               	cbz	x6, <addr>
               	ldr	x6, [x3]
               	add	x6, x6, x1
               	ldrb	w6, [x6]
               	ldrb	w1, [x5]
               	cmp	w6, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	b	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	sxtw	x1, w0
               	add	x4, x2, x1
               	ldrb	w5, [x4]
               	cbnz	x5, <addr>
               	ldr	x5, [x3, #0x10]
               	add	x5, x5, x1
               	ldrb	w5, [x5]
               	cbz	x5, <addr>
               	ldr	x5, [x3, #0x10]
               	add	x5, x5, x1
               	ldrb	w5, [x5]
               	ldrb	w1, [x4]
               	cmp	w5, w1
               	b.ne	<addr>
               	add	x0, x0, #0x1
               	b	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	str	x20, [sp, #-0x60]!
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, x20
               	bl	<addr>
               	cbnz	x0, <addr>
               	ldrsw	x0, [x20, #0x8]
               	cmp	w0, #0x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrsw	x0, [x20, #0x18]
               	cmp	w0, #0x2
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
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
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
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
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	x1, x0
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
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
