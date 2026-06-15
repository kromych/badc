
struct_arg_by_stack.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sub	sp, sp, #0x10
               	str	x1, [sp, #-0x10]!
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x16, x29, #0x30
               	str	x2, [x16]
               	str	x3, [x16, #0x8]
               	sxtw	x0, w0
               	sub	x1, x29, #0x20
               	ldur	x2, [x29, #0x20]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x2, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [x2, #0x18]
               	str	x10, [x1, #0x18]
               	ldr	x10, [sp], #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x0, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x20
               	ldr	x1, [x1]
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x20
               	ldr	x1, [x1, #0x8]
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x20
               	ldr	x1, [x1, #0x10]
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x20
               	ldr	x1, [x1, #0x18]
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x30
               	ldr	x1, [x1]
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x30
               	ldr	x1, [x1, #0x8]
               	str	x1, [x0]
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x30
               	ret

<mutate>:
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x20
               	ldur	x1, [x29, #0x10]
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
               	sub	x0, x29, #0x20
               	ldr	x1, [x0]
               	add	x1, x1, #0x3e8
               	str	x1, [x0]
               	sub	x0, x29, #0x20
               	ldr	x1, [x0, #0x18]
               	sub	x1, x1, #0x1
               	str	x1, [x0, #0x18]
               	sub	x0, x29, #0x20
               	ldr	x0, [x0]
               	sub	x1, x29, #0x20
               	ldr	x1, [x1, #0x8]
               	add	x0, x0, x1
               	sub	x1, x29, #0x20
               	ldr	x1, [x1, #0x10]
               	add	x0, x0, x1
               	sub	x1, x29, #0x20
               	ldr	x1, [x1, #0x18]
               	add	x0, x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	sub	x0, x29, #0x20
               	mov	x1, #0xb                // =11
               	str	x1, [x0]
               	sub	x0, x29, #0x20
               	mov	x1, #0x16               // =22
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x20
               	mov	x1, #0x21               // =33
               	str	x1, [x0, #0x10]
               	sub	x0, x29, #0x20
               	mov	x1, #0x2c               // =44
               	str	x1, [x0, #0x18]
               	sub	x0, x29, #0x30
               	mov	x1, #0x5                // =5
               	str	x1, [x0]
               	sub	x0, x29, #0x30
               	mov	x1, #0x6                // =6
               	str	x1, [x0, #0x8]
               	mov	x0, #0x7                // =7
               	sub	x1, x29, #0x20
               	sub	x2, x29, #0x30
               	ldr	x3, [x2, #0x8]
               	ldr	x2, [x2]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0xb
               	cset	x0, ne
               	mov	x20, #0x1               // =1
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x16
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x20, ne
               	mov	x21, #0x1               // =1
               	cbnz	x20, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x21
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x21, ne
               	cbnz	x21, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x2c
               	cset	x21, ne
               	cbz	x21, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x5
               	cset	x20, ne
               	cbnz	x20, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x6
               	cset	x20, ne
               	cbz	x20, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	bl	<addr>
               	cmp	x0, #0x455
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	ldr	x0, [x0]
               	cmp	x0, #0xb
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x20
               	ldr	x0, [x0, #0x18]
               	cmp	x0, #0x2c
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
