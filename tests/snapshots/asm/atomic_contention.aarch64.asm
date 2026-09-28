
atomic_contention.aarch64:	file format elf64-littleaarch64

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

<worker>:
               	mov	x1, #0x1                // =1
               	mov	w0, w0
               	lsl	x8, x1, x0
               	mov	x7, #0x0                // =0
               	mov	x12, #0x2710            // =10000
               	adrp	x13, <page>
               	add	x13, x13, <lo12>
               	adrp	x14, <page>
               	add	x14, x14, <lo12>
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	adrp	x15, <page>
               	add	x15, x15, <lo12>
               	adrp	x9, <page>
               	add	x9, x9, <lo12>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	adrp	x10, <page>
               	add	x10, x10, <lo12>
               	adrp	x11, <page>
               	add	x11, x11, <lo12>
               	ldr	x0, [x4]
               	mov	x1, #0x1                // =1
               	stadd	x1, [x14]
               	neg	x16, x1
               	ldaddal	x16, x17, [x13]
               	staddh	w1, [x15]
               	steorl	w8, [x9]
               	ldeora	w8, w16, [x9]
               	add	x3, x0, #0x1
               	mov	x2, x0
               	casal	x2, x3, [x4]
               	cmp	x2, x0
               	cset	x3, eq
               	cbz	x3, <addr>
               	cbnz	w3, <addr>
               	b	<addr>
               	mov	x0, x2
               	cbz	w3, <addr>
               	swpa	w1, w0, [x5]
               	cbnz	w0, <addr>
               	ldr	x0, [x10]
               	add	x0, x0, #0x1
               	str	x0, [x10]
               	mov	x0, #0x0                // =0
               	stlr	w0, [x5]
               	swpab	w1, w0, [x6]
               	and	x0, x0, #0xff
               	cbnz	x0, <addr>
               	ldr	x0, [x11]
               	add	x0, x0, #0x1
               	str	x0, [x11]
               	mov	x0, #0x0                // =0
               	stlrb	w0, [x6]
               	add	x7, x7, #0x1
               	cmp	w7, w12
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ret

<run_threads>:
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x0, #0x0                // =0
               	mov	x1, #0x2                // =2
               	bl	<addr>
               	mov	x21, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x21
               	bl	<addr>
               	mov	x20, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x21
               	bl	<addr>
               	mov	x21, x0
               	cbz	x20, <addr>
               	cbnz	x21, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x1, #0x0                // =0
               	sub	x0, x29, #0x20
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x3, x1
               	blr	x20
               	cbz	w0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x3, #0x1                // =1
               	sub	x0, x29, #0x20
               	add	x0, x0, #0x8
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	blr	x20
               	cbnz	w0, <addr>
               	mov	x3, #0x2                // =2
               	sub	x0, x29, #0x20
               	add	x0, x0, #0x10
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	blr	x20
               	cbnz	w0, <addr>
               	mov	x3, #0x3                // =3
               	sub	x0, x29, #0x20
               	add	x0, x0, #0x18
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	blr	x20
               	cbnz	w0, <addr>
               	sub	x0, x29, #0x20
               	ldr	x0, [x0]
               	mov	x1, #0x0                // =0
               	blr	x21
               	sub	x0, x29, #0x20
               	ldr	x0, [x0, #0x8]
               	mov	x1, #0x0                // =0
               	blr	x21
               	sub	x0, x29, #0x20
               	ldr	x0, [x0, #0x10]
               	mov	x1, #0x0                // =0
               	blr	x21
               	sub	x0, x29, #0x20
               	ldr	x0, [x0, #0x18]
               	mov	x1, #0x0                // =0
               	blr	x21
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x20, x21, [sp], #0x40
               	ret

<contended>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	cbz	w0, <addr>
               	mov	x0, #0x66               // =102
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x17, #0x9c40            // =40000
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x67               // =103
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x17, #0x9c40            // =40000
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x68               // =104
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cbz	x0, <addr>
               	mov	x0, #0x69               // =105
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsh	x0, [x0]
               	mov	x17, #-0x63c0           // =-25536
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x6a               // =106
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0]
               	cbz	w0, <addr>
               	mov	x0, #0x6b               // =107
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x17, #0x9c40            // =40000
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6c               // =108
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x17, #0x9c40            // =40000
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x6d               // =109
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
