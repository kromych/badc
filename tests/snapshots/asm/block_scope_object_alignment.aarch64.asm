
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
               	sub	sp, sp, #0x20
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffe0
               	add	x3, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldp	x16, x17, [x0]
               	stp	x16, x17, [x3]
               	mov	x0, #0x9                // =9
               	str	x0, [sp]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	and	x2, x1, #0xf
               	cbz	w2, <addr>
               	mov	x0, #0x1                // =1
               	sub	sp, x29, #0x0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	and	x2, x5, #0x1f
               	cbz	w2, <addr>
               	mov	x0, #0x2                // =2
               	sub	sp, x29, #0x0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	and	x4, x2, #0xf
               	cbz	w4, <addr>
               	mov	x0, #0x3                // =3
               	sub	sp, x29, #0x0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x3, x3, #0xf
               	cbz	w3, <addr>
               	mov	x0, #0x4                // =4
               	sub	sp, x29, #0x0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, sp
               	and	x3, x3, #0x1f
               	cbz	w3, <addr>
               	mov	x0, #0x5                // =5
               	sub	sp, x29, #0x0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x3, TPIDR_EL0
               	add	x3, x3, #0x0, lsl #12   // =0x0
               	add	x3, x3, #0x10
               	and	x4, x3, #0x7
               	cbz	w4, <addr>
               	mov	x0, #0x6                // =6
               	sub	sp, x29, #0x0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x4, TPIDR_EL0
               	add	x4, x4, #0x0, lsl #12   // =0x0
               	add	x4, x4, #0x20
               	and	x6, x4, #0x7
               	cbz	w6, <addr>
               	mov	x0, #0x7                // =7
               	sub	sp, x29, #0x0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x6, [x1]
               	cmp	x6, #0x1
               	b.ne	<addr>
               	ldr	x1, [x1, #0x8]
               	cmp	x1, #0x2
               	b.ne	<addr>
               	ldr	x1, [x5]
               	cmp	x1, #0x3
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	sub	sp, x29, #0x0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x1, [x2]
               	cmp	x1, #0x4
               	b.ne	<addr>
               	ldr	x1, [x2, #0x10]
               	cmp	x1, #0x6
               	b.eq	<addr>
               	sub	sp, x29, #0x0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xd                // =13
               	str	x0, [x3]
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x18
               	mov	x2, #0xe                // =14
               	strb	w2, [x1]
               	mov	x2, #0xf                // =15
               	str	x2, [x4]
               	ldr	x2, [x3]
               	cmp	x2, #0xd
               	b.ne	<addr>
               	ldrb	w1, [x1]
               	eor	x1, x1, #0xe
               	cbnz	w1, <addr>
               	ldr	x1, [x4]
               	cmp	x1, #0xf
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	sub	sp, x29, #0x0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w1, [x1]
               	mov	x17, #0x61              // =97
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w1, [x1]
               	mov	x17, #0x63              // =99
               	eor	x1, x1, x17
               	cbnz	w1, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrb	w1, [x1]
               	mov	x17, #0x65              // =101
               	eor	x1, x1, x17
               	cbz	w1, <addr>
               	sub	sp, x29, #0x0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	sp, x29, #0x0
               	ldp	x29, x30, [sp], #0x10
               	ret
