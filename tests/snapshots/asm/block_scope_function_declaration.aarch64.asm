
block_scope_function_declaration.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x260              // =608
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x2, x0
               	ldrb	w3, [x2]
               	cbz	x3, <addr>
               	b	<addr>
               	add	x2, x2, #0x1
               	add	x1, x1, #0x1
               	b	<addr>
               	ldrb	w0, [x2]
               	ldrb	w1, [x1]
               	cmp	x0, x1
               	cset	x0, eq
               	ret
               	ldrb	w0, [x2]
               	ldrb	w3, [x1]
               	cmp	x0, x3
               	cset	x3, eq
               	cbz	x3, <addr>
               	b	<addr>
               	b	<addr>

<main>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x28               // =40
               	mov	x1, #0x2                // =2
               	add	x0, x0, x1
               	sxtw	x0, w0
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	add	x0, x0, x1
               	sxtw	x0, w0
               	cmp	x0, #0x3
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	bl	<addr>
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mov	x0, #0x5                // =5
               	mov	x1, #0x1                // =1
               	mov	x2, #0x2                // =2
               	mov	x3, #0x3                // =3
               	add	x1, x1, x2
               	add	x1, x1, x3
               	sxtw	x1, w1
               	cmp	x1, #0x6
               	cset	x2, ne
               	cbnz	x2, <addr>
               	cmp	x0, #0x5
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mov	x0, #0x7                // =7
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	b	<addr>
               	b	<addr>

<sum3>:
               	add	x0, x0, x1
               	add	x0, x0, x2
               	sxtw	x0, w0
               	ret

<add>:
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ret

<label>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ret
