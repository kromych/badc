
asm_empty_barrier.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x29               // =41
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	add	x0, x0, #0x1
               	stur	w0, [x29, #-0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	w0, [x1]
               	mov	w0, w0
               	str	x0, [sp]
               	ldr	x0, [sp]
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x1234            // =4660
               	str	x16, [sp]
               	ldr	x0, [sp]
               	mov	x17, #0x1234            // =4660
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x16, <page>
               	add	x16, x16, <lo12>
               	str	x16, [sp]
               	ldr	x0, [sp]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x16, #0x5678            // =22136
               	str	x16, [sp]
               	ldr	x0, [sp]
               	mov	x17, #0x5678            // =22136
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	sub	x0, x0, #0x2a
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
