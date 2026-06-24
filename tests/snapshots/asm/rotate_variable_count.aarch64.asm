
rotate_variable_count.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x1, w1
               	ror	x0, x0, x1
               	ret

<ref_ror>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x3, #0x0                // =0
               	mov	x2, x3
               	sxtw	x4, w3
               	cmp	x4, #0x40
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x3, w3
               	add	x3, x3, #0x1
               	b	<addr>
               	mov	x4, #0x1                // =1
               	sxtw	x5, w3
               	lsl	x4, x4, x5
               	and	x4, x0, x4
               	cbz	x4, <addr>
               	b	<addr>
               	mov	x0, x2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x3, x1
               	mov	x17, #0x3f              // =63
               	and	x4, x4, x17
               	mov	x5, #0x1                // =1
               	sxtw	x4, w4
               	lsl	x4, x5, x4
               	orr	x2, x2, x4
               	b	<addr>
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	sub	x0, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x1, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x1, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [sp], #0x10
               	mov	x20, #0x0               // =0
               	mov	w0, w20
               	mov	x1, #0x30               // =48
               	mov	x2, #0x0                // =0
               	add	x1, x1, x2
               	asr	x1, x1, #3
               	cmp	x0, x1
               	b.hs	<addr>
               	b	<addr>
               	mov	w0, w20
               	add	x20, x0, #0x1
               	b	<addr>
               	mov	x21, #0x1               // =1
               	b	<addr>
               	mov	x0, #0xcdef             // =52719
               	movk	x0, #0x89ab, lsl #16
               	movk	x0, #0x4567, lsl #32
               	movk	x0, #0x123, lsl #48
               	ror	x20, x0, #0x7
               	mov	x1, #0x7                // =7
               	bl	<addr>
               	cmp	x20, x0
               	b.eq	<addr>
               	b	<addr>
               	sxtw	x0, w21
               	cmp	x0, #0x40
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w21
               	add	x21, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x30
               	mov	w1, w20
               	ldr	x0, [x0, x1, lsl #3]
               	sxtw	x1, w21
               	sxtw	x1, w1
               	ror	x22, x0, x1
               	sub	x0, x29, #0x30
               	mov	w1, w20
               	ldr	x0, [x0, x1, lsl #3]
               	sxtw	x1, w21
               	bl	<addr>
               	cmp	x22, x0
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
