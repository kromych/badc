
address_phi_object_or_pointer.aarch64:	file format elf64-littleaarch64

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

<pick_mem>:
               	sxtw	x1, w1
               	cbz	w2, <addr>
               	mov	x0, #0x9                // =9
               	ret
               	add	x0, x0, x1, lsl #3
               	ldr	x0, [x0]
               	b	<addr>

<pick_ptr>:
               	cbz	w1, <addr>
               	add	x0, x2, #0x1
               	ret
               	ldr	x2, [x0]
               	b	<addr>

<pick_scalar>:
               	mov	x3, x0
               	lsl	x0, x2, #1
               	cbz	w1, <addr>
               	ret
               	ldr	x0, [x3]
               	b	<addr>

<sum_some>:
               	mov	x6, x0
               	mov	x0, #0x0                // =0
               	mov	x4, #0xa                // =10
               	mov	x3, x0
               	b	<addr>
               	add	x3, x3, x2
               	add	x0, x0, #0x1
               	cmp	w0, w1
               	b.ge	<addr>
               	mul	x2, x0, x4
               	sxtw	x2, w2
               	tbnz	w0, #0x0, <addr>
               	add	x2, x6, x0, lsl #3
               	ldr	x2, [x2]
               	b	<addr>
               	mov	x0, x3
               	ret

<guarded>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	adrp	x2, <page>
               	ldr	x2, [x2, <lo12>]
               	stur	x2, [x29, #-0x8]
               	cbnz	w1, <addr>
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<unused_read_in_a_loop>:
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	adrp	x0, <page>
               	ldrsb	x1, [x0, #0x40]
               	cmp	w1, #0x1
               	b.gt	<addr>
               	add	x1, x1, #0x1
               	strb	w1, [x0, #0x40]
               	ldrsb	x1, [x0, #0x40]
               	cmp	w1, #0x1
               	b.le	<addr>
               	adrp	x0, <page>
               	ldrsb	x0, [x0, #0x40]
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x0, x29, #0x38
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	x16, [x1, #0x10]
               	str	x16, [x0, #0x10]
               	sub	x1, x29, #0x20
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	mov	x1, #0x2                // =2
               	mov	x2, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x9
               	b.ne	<addr>
               	sub	x0, x29, #0x38
               	mov	x1, #0x2                // =2
               	mov	x2, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0x1e
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	x2, [x0, #0x10]
               	sub	x0, x29, #0x38
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x7
               	b.ne	<addr>
               	sub	x0, x29, #0x38
               	mov	x1, #0x0                // =0
               	mov	x2, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0xb
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	x2, [x0, #0x10]
               	sub	x0, x29, #0x20
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0xc
               	b.ne	<addr>
               	adrp	x0, <page>
               	ldr	x2, [x0, #0x10]
               	sub	x0, x29, #0x20
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	mov	x1, #0x4                // =4
               	bl	<addr>
               	cmp	x0, #0x2c
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	cmp	x0, x1
               	b.ne	<addr>
               	sub	x0, x29, #0x20
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
