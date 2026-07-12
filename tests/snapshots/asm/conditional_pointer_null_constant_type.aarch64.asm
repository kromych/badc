
conditional_pointer_null_constant_type.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	ldrsw	x0, [x0, #0x10]
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>

<then_voidnull_else_ptr>:
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x0                // =0
               	ldrsw	x0, [x0, #0x10]
               	ret
               	b	<addr>

<then_ptr_else_intnull>:
               	sxtw	x1, w1
               	cbz	x1, <addr>
               	ldrsw	x0, [x0, #0x10]
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	sub	x0, x29, #0x18
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	sub	x0, x29, #0x18
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x18
               	mov	x2, #0x2a               // =42
               	str	w2, [x0, #0x10]
               	sub	x0, x29, #0x18
               	bl	<addr>
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	cbz	x0, <addr>
               	ldrsw	x0, [x0, #0x10]
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	cbz	x0, <addr>
               	cbz	x0, <addr>
               	ldrsw	x0, [x0, #0x10]
               	cmp	x0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
