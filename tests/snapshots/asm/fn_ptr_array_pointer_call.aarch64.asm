
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
               	mov	x2, x1
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x17, #0xa               // =10
               	mul	x0, x0, x17
               	add	x0, x0, x2
               	str	w0, [x1]
               	mov	x0, x1
               	ret

<g>:
               	mov	x17, #0xa               // =10
               	mul	x0, x0, x17
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x90]!
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldr	x0, [x20, #0x8]
               	mov	x1, #0x2                // =2
               	mov	x2, #0x1                // =1
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	ldr	x0, [x20, #0x8]
               	mov	x1, #0x2                // =2
               	mov	x2, #0x1                // =1
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	ldrsw	x0, [x0]
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	ldr	x0, [x20, #0x8]
               	mov	x1, #0x3                // =3
               	mov	x2, #0x4                // =4
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	ldrsw	x0, [x0]
               	cmp	w0, #0x22
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	ldr	x0, [x20, #0x10]
               	mov	x1, #0x5                // =5
               	mov	x2, #0x6                // =6
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	ldrsw	x0, [x0]
               	cmp	w0, #0x38
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	ldr	x0, [x20]
               	mov	x1, #0x7                // =7
               	mov	x2, #0x8                // =8
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	ldrsw	x0, [x0]
               	cmp	w0, #0x4e
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	ldr	x0, [x20, #0x8]
               	mov	x1, #0x1                // =1
               	mov	x2, #0x2                // =2
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	cbnz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	stur	x20, [x29, #-0x8]
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	sub	x22, x29, #0x8
               	ldr	x0, [x20, #0x8]
               	mov	x1, #0x2                // =2
               	mov	x2, #0x1                // =1
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	ldur	x0, [x29, #-0x8]
               	ldr	x0, [x0, #0x8]
               	mov	x1, #0x2                // =2
               	mov	x2, #0x1                // =1
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	ldr	x0, [x20, #0x8]
               	mov	x1, #0x2                // =2
               	mov	x2, #0x1                // =1
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	ldr	x0, [x20, #0x8]
               	mov	x1, #0x2                // =2
               	mov	x2, #0x1                // =1
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	ldr	x0, [x20]
               	mov	x1, #0x2                // =2
               	mov	x2, #0x1                // =1
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	ldr	x0, [x20]
               	mov	x1, #0x2                // =2
               	mov	x2, #0x1                // =1
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	ldr	x0, [x22]
               	ldr	x0, [x0, #0x8]
               	mov	x1, #0x2                // =2
               	mov	x2, #0x1                // =1
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	ldr	x0, [x22]
               	ldr	x0, [x0, #0x8]
               	mov	x1, #0x2                // =2
               	mov	x2, #0x1                // =1
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	ldr	x0, [x22]
               	ldr	x0, [x0]
               	mov	x1, #0x2                // =2
               	mov	x2, #0x1                // =1
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	ldr	x0, [x21, #0x28]
               	mov	x1, #0x2                // =2
               	mov	x2, #0x1                // =1
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x10               // =16
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	ldr	x0, [x21, #0x28]
               	mov	x1, #0x2                // =2
               	mov	x2, #0x1                // =1
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x11               // =17
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	ldr	x0, [x21, #0x18]
               	mov	x1, #0x2                // =2
               	mov	x2, #0x1                // =1
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x12               // =18
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x1, #0x2                // =2
               	mov	x2, #0x1                // =1
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x13               // =19
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x18]
               	mov	x1, #0x2                // =2
               	mov	x2, #0x1                // =1
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x14               // =20
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x1, #0x2                // =2
               	mov	x2, #0x1                // =1
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x15               // =21
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x28]
               	mov	x1, #0x2                // =2
               	mov	x2, #0x1                // =1
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x16               // =22
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x8]
               	mov	x1, #0x2                // =2
               	mov	x2, #0x1                // =1
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x17               // =23
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x1, #0x2                // =2
               	mov	x2, #0x1                // =1
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x18               // =24
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x19               // =25
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x1a               // =26
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x1b               // =27
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	ldr	x0, [x20, #0x8]
               	mov	x1, #0x2                // =2
               	mov	x2, #0x1                // =1
               	mov	x9, x0
               	mov	x0, x1
               	mov	x1, x2
               	blr	x9
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x1c               // =28
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x1d               // =29
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x1e               // =30
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	bl	<addr>
               	cmp	w0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
