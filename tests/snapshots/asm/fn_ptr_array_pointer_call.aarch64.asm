
fn_ptr_array_pointer_call.aarch64:	file format elf64-littleaarch64

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

<sel>:
               	mov	x2, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x17, #0xa               // =10
               	mul	x2, x2, x17
               	add	x1, x2, x1
               	str	w1, [x0]
               	ret

<g>:
               	mov	x17, #0xa               // =10
               	mul	x0, x0, x17
               	add	x0, x0, x1
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0, #0x8]
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	blr	x2
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0, #0x8]
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	blr	x2
               	ldrsw	x0, [x0]
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0, #0x8]
               	mov	x0, #0x3                // =3
               	mov	x1, #0x4                // =4
               	blr	x2
               	ldrsw	x0, [x0]
               	cmp	w0, #0x22
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0, #0x10]
               	mov	x0, #0x5                // =5
               	mov	x1, #0x6                // =6
               	blr	x2
               	ldrsw	x0, [x0]
               	cmp	w0, #0x38
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	mov	x0, #0x7                // =7
               	mov	x1, #0x8                // =8
               	blr	x2
               	ldrsw	x0, [x0]
               	cmp	w0, #0x4e
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0, #0x8]
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	blr	x2
               	cbnz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x8]
               	ldr	x2, [x0, #0x8]
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	blr	x2
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	ldr	x2, [x0, #0x8]
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	blr	x2
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0, #0x8]
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	blr	x2
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0, #0x8]
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	blr	x2
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	blr	x2
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	blr	x2
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	ldr	x2, [x0, #0x8]
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	blr	x2
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	ldr	x2, [x0, #0x8]
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	blr	x2
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldr	x0, [x0]
               	ldr	x2, [x0]
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	blr	x2
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0, #0x28]
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	blr	x2
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0, #0x28]
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	blr	x2
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0, #0x18]
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	blr	x2
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	blr	x2
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0, #0x18]
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	blr	x2
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	blr	x2
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0, #0x28]
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	blr	x2
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0, #0x8]
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	blr	x2
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	blr	x2
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x1a               // =26
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x1b               // =27
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0, #0x8]
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	blr	x2
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x1c               // =28
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x1d               // =29
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x1e               // =30
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
