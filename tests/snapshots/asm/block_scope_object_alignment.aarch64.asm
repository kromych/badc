
block_scope_object_alignment.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	str	x19, [sp]
               	sub	sp, sp, #0x20
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffe0
               	add	x0, sp, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	mov	x2, #0x9                // =9
               	mov	x17, sp
               	str	x2, [x17]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x17, #0xf               // =15
               	and	x3, x1, x17
               	cmp	w3, #0x0
               	cset	x3, ne
               	sxtw	x3, w3
               	cbz	x3, <addr>
               	mov	x0, #0x1                // =1
               	sub	sp, x29, #0xa0
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x17, #0x1f              // =31
               	and	x3, x3, x17
               	cmp	w3, #0x0
               	cset	x3, ne
               	sxtw	x3, w3
               	cbz	x3, <addr>
               	mov	x0, #0x2                // =2
               	sub	sp, x29, #0xa0
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x17, #0xf               // =15
               	and	x3, x3, x17
               	cmp	w3, #0x0
               	cset	x3, ne
               	sxtw	x3, w3
               	cbz	x3, <addr>
               	mov	x0, #0x3                // =3
               	sub	sp, x29, #0xa0
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xf               // =15
               	and	x0, x0, x17
               	cmp	w0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	sub	sp, x29, #0xa0
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, sp
               	mov	x17, #0x1f              // =31
               	and	x0, x0, x17
               	cmp	w0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	sub	sp, x29, #0xa0
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x10
               	mov	x17, #0x7               // =7
               	and	x0, x0, x17
               	cmp	w0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	sub	sp, x29, #0xa0
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x20
               	mov	x17, #0x7               // =7
               	and	x0, x0, x17
               	cmp	w0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	sub	sp, x29, #0xa0
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x1]
               	cmp	x0, #0x1
               	mov	x0, #0x1                // =1
               	b.ne	<addr>
               	ldr	x1, [x1, #0x8]
               	cmp	x1, #0x2
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cmp	x1, #0x3
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x8                // =8
               	sub	sp, x29, #0xa0
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cmp	x1, #0x4
               	cset	x1, ne
               	cbnz	x1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1, #0x10]
               	cmp	x1, #0x6
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, x2
               	sub	sp, x29, #0xa0
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	mov	x16, sp
               	ldr	x1, [x16]
               	cmp	x1, #0x9
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0xb                // =11
               	sub	sp, x29, #0xa0
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x10
               	mov	x3, #0xd                // =13
               	str	x3, [x1]
               	mrs	x4, TPIDR_EL0
               	add	x4, x4, #0x0, lsl #12   // =0x0
               	add	x4, x4, #0x18
               	mov	x5, #0xe                // =14
               	strb	w5, [x4]
               	mrs	x4, TPIDR_EL0
               	add	x4, x4, #0x0, lsl #12   // =0x0
               	add	x4, x4, #0x20
               	mov	x5, #0xf                // =15
               	str	x5, [x4]
               	ldr	x1, [x1]
               	cmp	x1, #0xd
               	b.ne	<addr>
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x18
               	ldrb	w1, [x1]
               	mov	x17, #0xe               // =14
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	w1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x20
               	ldr	x1, [x1]
               	cmp	x1, #0xf
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0xc                // =12
               	sub	sp, x29, #0xa0
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w1, [x1]
               	mov	x17, #0x61              // =97
               	eor	x1, x1, x17
               	mov	w1, w1
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0]
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0]
               	mov	x17, #0x65              // =101
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, x3
               	sub	sp, x29, #0xa0
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x2
               	mov	x0, x2
               	sub	sp, x29, #0xa0
               	ldr	x19, [sp]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
