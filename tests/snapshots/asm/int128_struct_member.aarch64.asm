
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x220
               	stp	x20, x21, [sp]
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	orr	x22, x0, x2
               	orr	x23, x1, x0
               	sub	x1, x29, #0x110
               	str	x22, [x1]
               	str	x23, [x1, #0x8]
               	sub	x4, x29, #0x1f0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x4]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x4, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, x4
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x3, [x2]
               	cmp	x3, #0x1
               	mov	x5, #0x1                // =1
               	b.ne	<addr>
               	ldrsw	x3, [x2, #0x20]
               	cmp	x3, #0x2
               	cset	x3, ne
               	cbnz	x3, <addr>
               	ldr	x3, [x2, #0x10]
               	ldr	x6, [x2, #0x18]
               	eor	x2, x3, x22
               	eor	x3, x6, x23
               	orr	x2, x2, x3
               	cmp	x2, #0x0
               	cset	x3, ne
               	cbz	x3, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x3, [x2]
               	ldr	x6, [x2, #0x8]
               	eor	x2, x3, x22
               	eor	x3, x6, x23
               	orr	x2, x2, x3
               	cbz	x2, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x3, [x2]
               	ldr	x2, [x2, #0x8]
               	mov	x17, #0x0               // =0
               	eor	x3, x3, x17
               	mov	x17, #0x1000000000      // =68719476736
               	eor	x2, x2, x17
               	orr	x3, x3, x2
               	cmp	x3, #0x0
               	cset	x2, ne
               	cbnz	x3, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2, #0x8]
               	mov	x17, #0x1000000000      // =68719476736
               	cmp	x2, x17
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x2, x29, #0x1e0
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
               	ldr	x10, [x3, #0x20]
               	str	x10, [x2, #0x20]
               	ldr	x10, [x3, #0x28]
               	str	x10, [x2, #0x28]
               	ldr	x10, [sp], #0x10
               	mov	x2, x0
               	mov	x17, #0x4               // =4
               	eor	x2, x22, x17
               	mov	x17, #0x9               // =9
               	eor	x3, x23, x17
               	orr	x2, x2, x3
               	cmp	x2, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x8                // =8
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, x0
               	eor	x25, x22, x22
               	eor	x2, x23, x23
               	orr	x2, x25, x2
               	cmp	x2, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x20, x29, #0x180
               	str	x0, [x20]
               	str	x0, [x20, #0x8]
               	str	x0, [x20, #0x10]
               	str	x0, [x20, #0x18]
               	str	x0, [x20, #0x20]
               	str	x0, [x20, #0x28]
               	str	w5, [x20]
               	add	x24, x20, #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x4]
               	str	x10, [x24]
               	ldr	x10, [x4, #0x8]
               	str	x10, [x24, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x24
               	mov	x0, #0x2                // =2
               	str	w0, [x20, #0x20]
               	ldr	x0, [x24]
               	ldr	x3, [x20, #0x18]
               	add	x2, x0, #0x3
               	cmp	x2, x0
               	cset	x0, lo
               	add	x3, x3, #0x1
               	add	x0, x3, x0
               	str	x2, [x1]
               	str	x0, [x1, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x24]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x24, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x24
               	ldrsw	x0, [x20]
               	add	x0, x0, #0x1
               	str	w0, [x20]
               	ldrsw	x0, [x20]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrsw	x0, [x20, #0x20]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x20
               	bl	<addr>
               	sub	x16, x29, #0x110
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	sub	x21, x29, #0x110
               	ldr	x0, [x21]
               	ldr	x1, [x21, #0x8]
               	mov	x17, #0x7               // =7
               	eor	x0, x0, x17
               	mov	x17, #0xa               // =10
               	eor	x1, x1, x17
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	str	x1, [x21]
               	str	x1, [x21, #0x8]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x21]
               	str	x10, [x24]
               	ldr	x10, [x21, #0x8]
               	str	x10, [x24, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x24
               	sub	x0, x29, #0x180
               	ldr	x2, [x0, #0x10]
               	ldr	x3, [x0, #0x18]
               	eor	x2, x2, x1
               	eor	x1, x3, x1
               	orr	x2, x2, x1
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	ldrsw	x1, [x0]
               	cmp	x1, #0x2
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrsw	x1, [x0, #0x20]
               	cmp	x1, #0x2
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0xc                // =12
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x1, x0, #0x10
               	sub	x2, x29, #0x1f0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	bl	<addr>
               	sub	x16, x29, #0x110
               	str	x0, [x16]
               	str	x1, [x16, #0x8]
               	ldr	x1, [x21]
               	ldr	x2, [x21, #0x8]
               	eor	x0, x1, x22
               	eor	x1, x2, x23
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	eor	x0, x23, x23
               	orr	x0, x25, x0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xf                // =15
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x3, x5
               	b	<addr>
