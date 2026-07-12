
struct_array_init_from_lvalue.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, x0
               	sub	x0, x29, #0x10
               	mov	x2, #0x2222             // =8738
               	str	x2, [x0]
               	sub	x0, x29, #0x10
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x10
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x100
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x20
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x30
               	ldr	x0, [x0]
               	mov	x17, #0x1111            // =4369
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x30
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x60
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
               	ldr	x10, [x1, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x1, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x60
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	mov	x1, #0x7                // =7
               	sub	x0, x29, #0xc0
               	mov	x2, #0x2222             // =8738
               	str	x2, [x0]
               	sub	x0, x29, #0xc0
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0xc0
               	sub	x1, x29, #0x60
               	add	x1, x1, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x20
               	sub	x1, x29, #0x60
               	add	x1, x1, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x60
               	ldr	x0, [x0]
               	mov	x17, #0x1111            // =4369
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x60
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x60
               	ldr	x0, [x0, #0x10]
               	mov	x17, #0x2222            // =8738
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x60
               	ldr	x0, [x0, #0x18]
               	cmp	x0, #0x7
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x60
               	ldr	x0, [x0, #0x20]
               	mov	x17, #0x3333            // =13107
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x60
               	ldr	x0, [x0, #0x28]
               	cmp	x0, #0x3
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x90
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
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x90
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x90
               	ldr	x0, [x0, #0x10]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x90
               	ldr	x0, [x0, #0x18]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa                // =10
               	sub	x1, x29, #0xa8
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0xa8
               	str	w0, [x1]
               	mov	x1, #0x2                // =2
               	sub	x0, x29, #0xa8
               	str	w1, [x0, #0x4]
               	mov	x1, #0x3                // =3
               	sub	x0, x29, #0xa8
               	str	w1, [x0, #0x8]
               	mov	x1, #0x4                // =4
               	sub	x0, x29, #0xa8
               	str	w1, [x0, #0xc]
               	sub	x0, x29, #0xa8
               	ldrsw	x0, [x0]
               	cmp	x0, #0xa
               	cset	x0, ne
               	mov	x1, #0x1                // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xa8
               	ldrsw	x0, [x0, #0x4]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0xa8
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x3
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0xa8
               	ldrsw	x0, [x0, #0xc]
               	cmp	x0, #0x4
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
