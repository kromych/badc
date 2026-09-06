
int128_struct_member.aarch64:	file format elf64-littleaarch64

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

<read_wide>:
               	add	x0, x0, #0x10
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x1c0]!
               	stp	x29, x30, [sp, #0x1b0]
               	add	x29, sp, #0x1b0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	orr	x20, x1, x2
               	orr	x21, x0, x1
               	sub	x2, x29, #0x80
               	str	x20, [x2]
               	str	x21, [x2, #0x8]
               	sub	x4, x29, #0x1a0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x4]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x4
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x3, [x0]
               	cmp	w3, #0x1
               	b.ne	<addr>
               	ldrsw	x3, [x0, #0x20]
               	cmp	w3, #0x2
               	cset	x3, ne
               	cbnz	x3, <addr>
               	ldr	x3, [x0, #0x10]
               	ldr	x5, [x0, #0x18]
               	eor	x0, x3, x20
               	eor	x3, x5, x21
               	orr	x0, x0, x3
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x1b0]
               	ldp	x20, x21, [sp], #0x1c0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x3, [x0]
               	ldr	x5, [x0, #0x8]
               	eor	x0, x3, x20
               	eor	x3, x5, x21
               	orr	x0, x0, x3
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x1b0]
               	ldp	x20, x21, [sp], #0x1c0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0x0               // =0
               	eor	x3, x3, x17
               	mov	x17, #0x1000000000      // =68719476736
               	eor	x0, x0, x17
               	orr	x0, x3, x0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0x1000000000      // =68719476736
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x1b0]
               	ldp	x20, x21, [sp], #0x1c0
               	ret
               	mov	x0, x1
               	mov	x17, #0x4               // =4
               	eor	x0, x20, x17
               	mov	x17, #0x9               // =9
               	eor	x3, x21, x17
               	orr	x0, x0, x3
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x1b0]
               	ldp	x20, x21, [sp], #0x1c0
               	ret
               	mov	x0, x1
               	eor	x0, x20, x20
               	eor	x3, x21, x21
               	orr	x0, x0, x3
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x1b0]
               	ldp	x20, x21, [sp], #0x1c0
               	ret
               	sub	x0, x29, #0x130
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	str	x1, [x0, #0x18]
               	str	x1, [x0, #0x20]
               	str	x1, [x0, #0x28]
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	add	x1, x0, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x4]
               	str	x10, [x1]
               	ldr	x10, [x4, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x3, x1
               	mov	x3, #0x2                // =2
               	str	w3, [x0, #0x20]
               	ldr	x3, [x1]
               	ldr	x5, [x0, #0x18]
               	add	x4, x3, #0x3
               	cmp	x4, x3
               	cset	x3, lo
               	add	x5, x5, #0x1
               	add	x3, x5, x3
               	str	x4, [x2]
               	str	x3, [x2, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	ldrsw	x1, [x0]
               	cmp	w1, #0x2
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x20]
               	cmp	w1, #0x2
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x1b0]
               	ldp	x20, x21, [sp], #0x1c0
               	ret
               	bl	<addr>
               	sub	x16, x29, #0x80
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x1, x29, #0x80
               	ldr	x0, [x1]
               	ldr	x2, [x1, #0x8]
               	mov	x17, #0x7               // =7
               	eor	x0, x0, x17
               	mov	x17, #0xa               // =10
               	eor	x2, x2, x17
               	orr	x0, x0, x2
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x1b0]
               	ldp	x20, x21, [sp], #0x1c0
               	ret
               	sub	x0, x29, #0x130
               	add	x3, x0, #0x10
               	mov	x2, #0x0                // =0
               	str	x2, [x1]
               	str	x2, [x1, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x3]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x3
               	ldr	x1, [x0, #0x10]
               	ldr	x4, [x0, #0x18]
               	eor	x1, x1, x2
               	eor	x2, x4, x2
               	orr	x1, x1, x2
               	cbnz	x1, <addr>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x2
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrsw	x1, [x0, #0x20]
               	cmp	w1, #0x2
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x1b0]
               	ldp	x20, x21, [sp], #0x1c0
               	ret
               	sub	x1, x29, #0x1a0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x3]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x3, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x3
               	bl	<addr>
               	sub	x16, x29, #0x80
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x0, x29, #0x80
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	eor	x0, x1, x20
               	eor	x1, x2, x21
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x1b0]
               	ldp	x20, x21, [sp], #0x1c0
               	ret
               	eor	x0, x20, x20
               	eor	x1, x21, x21
               	orr	x0, x0, x1
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x1b0]
               	ldp	x20, x21, [sp], #0x1c0
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	ldp	x29, x30, [sp, #0x1b0]
               	ldp	x20, x21, [sp], #0x1c0
               	ret
