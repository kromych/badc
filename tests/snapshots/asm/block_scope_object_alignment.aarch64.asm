
block_scope_object_alignment.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
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
               	sub	sp, sp, #0x20
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffe0
               	add	x2, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x2]
               	mov	x0, #0x9                // =9
               	str	x0, [sp]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	and	x3, x1, #0xf
               	cbz	w3, <addr>
               	mov	x0, #0x1                // =1
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	and	x3, x4, #0x1f
               	cbz	w3, <addr>
               	mov	x0, #0x2                // =2
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	and	x5, x3, #0xf
               	cbz	w5, <addr>
               	mov	x0, #0x3                // =3
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x2, x2, #0xf
               	cbz	w2, <addr>
               	mov	x0, #0x4                // =4
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, sp
               	and	x2, x2, #0x1f
               	cbz	w2, <addr>
               	mov	x0, #0x5                // =5
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x2, TPIDR_EL0
               	add	x2, x2, #0x0, lsl #12   // =0x0
               	add	x2, x2, #0x10
               	and	x5, x2, #0x7
               	cbz	w5, <addr>
               	mov	x0, #0x6                // =6
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x5, TPIDR_EL0
               	add	x5, x5, #0x0, lsl #12   // =0x0
               	add	x5, x5, #0x20
               	and	x6, x5, #0x7
               	cbz	w6, <addr>
               	mov	x0, #0x7                // =7
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x6, [x1]
               	cmp	x6, #0x1
               	b.ne	<addr>
               	ldr	x1, [x1, #0x8]
               	cmp	x1, #0x2
               	b.ne	<addr>
               	ldr	x1, [x4]
               	cmp	x1, #0x3
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x1, [x3]
               	cmp	x1, #0x4
               	b.ne	<addr>
               	ldr	x1, [x3, #0x10]
               	cmp	x1, #0x6
               	b.eq	<addr>
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xd                // =13
               	str	x0, [x2]
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x18
               	mov	x3, #0xe                // =14
               	strb	w3, [x1]
               	mov	x3, #0xf                // =15
               	str	x3, [x5]
               	ldr	x2, [x2]
               	cmp	x2, #0xd
               	b.ne	<addr>
               	ldrb	w1, [x1]
               	cmp	w1, #0xe
               	b.ne	<addr>
               	adrp	x1, <page>
               	ldrb	w1, [x1, #0x21]
               	cmp	w1, #0x61
               	b.ne	<addr>
               	adrp	x1, <page>
               	ldrb	w1, [x1, #0x40]
               	cmp	w1, #0x63
               	b.ne	<addr>
               	adrp	x1, <page>
               	ldrb	w1, [x1, #0x68]
               	cmp	w1, #0x65
               	b.eq	<addr>
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xc                // =12
               	mov	sp, x29
               	ldp	x29, x30, [sp], #0x10
               	ret
