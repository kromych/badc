
function_designator_address_constants.aarch64:	file format elf64-littleaarch64

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

<fn>:
               	mov	x0, #0x1                // =1
               	ret

<g>:
               	mov	x0, #0x2                // =2
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	blr	x0
               	mov	x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	blr	x0
               	add	x20, x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	blr	x0
               	add	x20, x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	blr	x0
               	add	x20, x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	blr	x0
               	add	x0, x20, x0
               	cmp	w0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x2, #0x0                // =0
               	mov	x4, #0x38               // =56
               	adrp	x5, <addr>
               	add	x5, x5, <lo12>
               	adrp	x6, <page>
               	add	x6, x6, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	adrp	x7, <page>
               	add	x7, x7, <lo12>
               	mul	x0, x2, x4
               	add	x0, x6, x0
               	ldr	x1, [x5, x2, lsl #3]
               	ldr	x8, [x0]
               	sub	x8, x8, x3
               	cmp	x8, x1
               	b.ne	<addr>
               	ldr	x8, [x0, #0x8]
               	sub	x8, x8, x3
               	cmp	x8, x1
               	b.ne	<addr>
               	ldr	x8, [x0, #0x10]
               	sub	x8, x8, x3
               	cmp	x8, x1
               	b.ne	<addr>
               	ldr	x8, [x0, #0x18]
               	sub	x8, x8, x3
               	cmp	x8, x1
               	b.ne	<addr>
               	ldr	x8, [x0, #0x20]
               	sub	x8, x8, x3
               	cmp	x8, x1
               	b.ne	<addr>
               	ldr	x8, [x0, #0x28]
               	sub	x8, x8, x3
               	cmp	x8, x1
               	b.ne	<addr>
               	ldr	x0, [x0, #0x30]
               	sub	x0, x0, x7
               	cmp	x0, x1
               	b.ne	<addr>
               	add	x2, x2, #0x1
               	cmp	w2, #0x5
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x1, x0
               	cmp	x1, #0x3
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cmp	x1, #0x8
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	sub	x1, x1, x0
               	cmp	x1, #0x8
               	b.eq	<addr>
               	mov	x0, #0xe                // =14
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	sub	x0, x1, x0
               	cmp	x0, #0x1
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x0, x0, x1
               	cmp	x0, #0x28
               	b.eq	<addr>
               	mov	x0, #0xf                // =15
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	add	x0, x2, #0x7
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	add	x0, x2, #0x2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
