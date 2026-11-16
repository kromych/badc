
block_static_shadows_extern.aarch64:	file format elf64-littleaarch64

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

<sink>:
               	mov	x3, x0
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	cmp	w0, w1
               	b.ge	<addr>
               	ldrb	w4, [x3, x0]
               	add	x2, x4, x2, lsl #4
               	add	x0, x0, #0x1
               	cmp	w0, w1
               	b.lt	<addr>
               	mov	x0, x2
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	mov	x1, #0x2                // =2
               	adrp	x2, <page>
               	ldr	x2, [x2, <lo12>]
               	blr	x2
               	cmp	w0, #0x12
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	mov	x1, #0x3                // =3
               	adrp	x2, <page>
               	ldr	x2, [x2, <lo12>]
               	blr	x2
               	cmp	w0, #0x345
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	mov	x1, #0x2                // =2
               	adrp	x2, <page>
               	ldr	x2, [x2, <lo12>]
               	blr	x2
               	cmp	w0, #0x67
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	adrp	x2, <page>
               	ldr	x2, [x2, <lo12>]
               	blr	x2
               	cmp	w0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	adrp	x2, <page>
               	ldr	x2, [x2, <lo12>]
               	blr	x2
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	mov	x1, #0x3                // =3
               	adrp	x2, <page>
               	ldr	x2, [x2, <lo12>]
               	blr	x2
               	str	x0, [sp, #0x8]
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x1
               	mov	x1, #0x2                // =2
               	adrp	x2, <page>
               	ldr	x2, [x2, <lo12>]
               	blr	x2
               	ldr	x16, [sp, #0x8]
               	add	x16, x16, x0
               	str	x16, [sp, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x8]
               	mov	x1, #0x1                // =1
               	adrp	x2, <page>
               	ldr	x2, [x2, <lo12>]
               	blr	x2
               	ldr	x16, [sp, #0x8]
               	add	x16, x16, x0
               	str	x16, [sp, #0x8]
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	adrp	x2, <page>
               	ldr	x2, [x2, <lo12>]
               	blr	x2
               	ldr	x16, [sp, #0x8]
               	add	x16, x16, x0
               	str	x16, [sp, #0x8]
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	mov	x1, #0x1                // =1
               	adrp	x2, <page>
               	ldr	x2, [x2, <lo12>]
               	blr	x2
               	ldr	x16, [sp, #0x8]
               	add	x0, x16, x0
               	cmp	w0, #0xb9b
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
