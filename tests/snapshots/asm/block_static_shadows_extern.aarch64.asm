
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
               	mov	x2, x0
               	mov	x3, x1
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	cmp	w0, w3
               	b.ge	<addr>
               	lsl	x1, x1, #4
               	ldrb	w4, [x2, x0]
               	add	x1, x1, x4
               	add	x0, x0, #0x1
               	cmp	w0, w3
               	b.lt	<addr>
               	sxtw	x0, w1
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x2                // =2
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	mov	x9, x2
               	blr	x9
               	cmp	w0, #0x12
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x3                // =3
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	mov	x9, x2
               	blr	x9
               	cmp	w0, #0x345
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x2                // =2
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	mov	x9, x2
               	blr	x9
               	cmp	w0, #0x67
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	mov	x9, x2
               	blr	x9
               	cmp	w0, #0x8
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	mov	x9, x2
               	blr	x9
               	cmp	w0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x1, #0x3                // =3
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	mov	x9, x2
               	blr	x9
               	mov	x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	add	x0, x0, #0x1
               	mov	x1, #0x2                // =2
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	mov	x9, x2
               	blr	x9
               	add	x20, x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x8]
               	mov	x1, #0x1                // =1
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	mov	x9, x2
               	blr	x9
               	add	x20, x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1                // =1
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	mov	x9, x2
               	blr	x9
               	add	x20, x20, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x1, #0x1                // =1
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	mov	x9, x2
               	blr	x9
               	add	x0, x20, x0
               	cmp	w0, #0xb9b
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
