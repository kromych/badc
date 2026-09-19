
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
               	stp	x20, x21, [sp, #-0x80]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x70]
               	add	x29, sp, #0x70
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x0, #0x64               // =100
               	str	x0, [x20]
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	mov	x0, #0x7                // =7
               	str	w0, [x22]
               	sub	x1, x29, #0x18
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	ldr	x0, [x21]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sub	x0, x29, #0x18
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0x7fffffffffffffff // =9223372036854775807
               	cmp	x1, x17
               	b.lo	<addr>
               	mov	x1, #-0x16              // =-22
               	cmp	x1, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	mov	x1, #0x7ffffffffffffffc // =9223372036854775804
               	str	x1, [x20]
               	mov	x1, #0x9                // =9
               	str	w1, [x22]
               	ldr	x1, [x21]
               	mov	x9, x1
               	blr	x9
               	sub	x0, x29, #0x18
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0x7fffffffffffffff // =9223372036854775807
               	cmp	x1, x17
               	b.lo	<addr>
               	mov	x1, #-0x16              // =-22
               	cmp	x1, #0x3
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	mov	x1, #0x4                // =4
               	movk	x1, #0x8000, lsl #48
               	str	x1, [x20]
               	ldr	x1, [x21]
               	mov	x9, x1
               	blr	x9
               	sub	x0, x29, #0x18
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0x7fffffffffffffff // =9223372036854775807
               	cmp	x1, x17
               	b.lo	<addr>
               	mov	x0, #-0x16              // =-22
               	mov	x17, #-0x16             // =-22
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	ldr	x1, [x0, #0x8]
               	ldr	w0, [x0, #0x10]
               	mov	x2, #0x7fffffffffffffff // =9223372036854775807
               	sub	x1, x2, x1
               	cmp	x0, x1
               	b.hs	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	mov	w0, w1
               	b	<addr>
               	ldr	x2, [x0, #0x8]
               	ldr	w1, [x0, #0x10]
               	mov	x3, #0x7fffffffffffffff // =9223372036854775807
               	sub	x2, x3, x2
               	cmp	x1, x2
               	b.hs	<addr>
               	sxtw	x1, w1
               	b	<addr>
               	mov	w1, w2
               	b	<addr>
               	ldr	x2, [x0, #0x8]
               	ldr	w1, [x0, #0x10]
               	mov	x3, #0x7fffffffffffffff // =9223372036854775807
               	sub	x2, x3, x2
               	cmp	x1, x2
               	b.hs	<addr>
               	sxtw	x1, w1
               	b	<addr>
               	mov	w1, w2
               	b	<addr>
