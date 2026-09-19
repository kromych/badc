
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
               	sub	sp, sp, #0x90
               	sub	sp, sp, #0x20
               	mov	x16, sp
               	and	sp, x16, #0xffffffffffffffe0
               	add	x1, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x2, #0x9                // =9
               	str	x2, [sp]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	and	x3, x0, #0xf
               	cbz	x3, <addr>
               	mov	x0, #0x1                // =1
               	sub	sp, x29, #0x90
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	and	x3, x3, #0x1f
               	cbz	x3, <addr>
               	mov	x0, #0x2                // =2
               	sub	sp, x29, #0x90
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	and	x3, x3, #0xf
               	cbz	x3, <addr>
               	mov	x0, #0x3                // =3
               	sub	sp, x29, #0x90
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	and	x1, x1, #0xf
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	sub	sp, x29, #0x90
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, sp
               	and	x1, x1, #0x1f
               	cbz	x1, <addr>
               	mov	x0, #0x5                // =5
               	sub	sp, x29, #0x90
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x10
               	and	x1, x1, #0x7
               	cbz	x1, <addr>
               	mov	x0, #0x6                // =6
               	sub	sp, x29, #0x90
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x1, TPIDR_EL0
               	add	x1, x1, #0x0, lsl #12   // =0x0
               	add	x1, x1, #0x20
               	and	x1, x1, #0x7
               	cbz	x1, <addr>
               	mov	x0, #0x7                // =7
               	sub	sp, x29, #0x90
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x1, [x0]
               	cmp	x1, #0x1
               	b.ne	<addr>
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x2
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	sub	sp, x29, #0x90
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x4
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x10]
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, x2
               	sub	sp, x29, #0x90
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x10
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	mrs	x2, TPIDR_EL0
               	add	x2, x2, #0x0, lsl #12   // =0x0
               	add	x2, x2, #0x18
               	mov	x3, #0xe                // =14
               	strb	w3, [x2]
               	mrs	x2, TPIDR_EL0
               	add	x2, x2, #0x0, lsl #12   // =0x0
               	add	x2, x2, #0x20
               	mov	x3, #0xf                // =15
               	str	x3, [x2]
               	ldr	x0, [x0]
               	cmp	x0, #0xd
               	b.ne	<addr>
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x18
               	ldrb	w0, [x0]
               	eor	x0, x0, #0xe
               	cbnz	w0, <addr>
               	mrs	x0, TPIDR_EL0
               	add	x0, x0, #0x0, lsl #12   // =0x0
               	add	x0, x0, #0x20
               	ldr	x0, [x0]
               	cmp	x0, #0xf
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	sub	sp, x29, #0x90
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0]
               	mov	x17, #0x61              // =97
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0]
               	mov	x17, #0x63              // =99
               	eor	x0, x0, x17
               	cbnz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrb	w0, [x0]
               	mov	x17, #0x65              // =101
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, x1
               	sub	sp, x29, #0x90
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	sub	sp, x29, #0x90
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
