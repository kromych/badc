
range_guard_field_reload.aarch64:	file format elf64-littleaarch64

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

<fill>:
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	str	x1, [x0, #0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w1, [x1]
               	str	w1, [x0, #0x10]
               	mov	x1, #0x0                // =0
               	str	w1, [x0, #0x14]
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x64               // =100
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x7                // =7
               	str	w1, [x0]
               	sub	x0, x29, #0x18
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x9, x1
               	blr	x9
               	sub	x1, x29, #0x18
               	ldr	x0, [x1, #0x8]
               	mov	x17, #0x7fffffffffffffff // =9223372036854775807
               	cmp	x0, x17
               	b.lo	<addr>
               	mov	x0, #-0x16              // =-22
               	cmp	w0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x7ffffffffffffffc // =9223372036854775804
               	str	x2, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x9                // =9
               	str	w2, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sub	x1, x29, #0x18
               	ldr	x0, [x1, #0x8]
               	mov	x17, #0x7fffffffffffffff // =9223372036854775807
               	cmp	x0, x17
               	b.lo	<addr>
               	mov	x0, #-0x16              // =-22
               	cmp	w0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, #0x4                // =4
               	movk	x2, #0x8000, lsl #48
               	str	x2, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sub	x0, x29, #0x18
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0x7fffffffffffffff // =9223372036854775807
               	cmp	x1, x17
               	b.lo	<addr>
               	mov	x0, #-0x16              // =-22
               	mov	x17, #-0x16             // =-22
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x1, [x0, #0x8]
               	ldr	w0, [x0, #0x10]
               	mov	x2, #0x7fffffffffffffff // =9223372036854775807
               	sub	x1, x2, x1
               	cmp	x0, x1
               	b.lo	<addr>
               	mov	x0, x1
               	b	<addr>
               	ldr	x2, [x1, #0x8]
               	ldr	w0, [x1, #0x10]
               	mov	x3, #0x7fffffffffffffff // =9223372036854775807
               	sub	x2, x3, x2
               	cmp	x0, x2
               	b.lo	<addr>
               	mov	x0, x2
               	b	<addr>
               	ldr	x2, [x1, #0x8]
               	ldr	w0, [x1, #0x10]
               	mov	x3, #0x7fffffffffffffff // =9223372036854775807
               	sub	x2, x3, x2
               	cmp	x0, x2
               	b.lo	<addr>
               	mov	x0, x2
               	b	<addr>
