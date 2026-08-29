
compound_literal_addr_init.aarch64:	file format elf64-littleaarch64

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

<check_static>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldrsw	x1, [x1]
               	cmp	w1, #0x2a
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	x1, [x0]
               	ldrsw	x1, [x1, #0x4]
               	cmp	w1, #0x2b
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x7
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x1
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x4]
               	cmp	w0, #0x2
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x3
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0, #0x4]
               	cmp	w0, #0x4
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>

<check_local>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x1, x29, #0x38
               	mov	x2, #0x0                // =0
               	str	x2, [x1]
               	str	x2, [x1, #0x8]
               	str	x2, [x1, #0x10]
               	str	x2, [x1, #0x18]
               	sub	x0, x29, #0x18
               	str	x2, [x0]
               	str	x2, [x0, #0x8]
               	sub	x3, x29, #0x8
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x4]
               	str	x10, [x3]
               	ldr	x10, [sp], #0x10
               	mov	x4, x3
               	str	x3, [x0]
               	mov	x3, #0x5                // =5
               	str	w3, [x0, #0x8]
               	str	x0, [x1]
               	mov	x3, #0x6                // =6
               	str	w3, [x1, #0x8]
               	ldr	x1, [x0]
               	ldrsw	x1, [x1]
               	cmp	w1, #0xb
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	x1, [x0]
               	ldrsw	x1, [x1, #0x4]
               	cmp	w1, #0xc
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x5
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, x2
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x2
               	mov	x0, x2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	mov	x1, x0
               	sxtw	x0, w1
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
