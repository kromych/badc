
slot_coalesce_block_arrays.aarch64:	file format elf64-littleaarch64

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

<tally>:
               	mov	x3, x0
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	cmp	w0, w1
               	b.ge	<addr>
               	ldr	x4, [x3, x0, lsl #3]
               	add	x2, x2, x4
               	add	x0, x0, #0x1
               	cmp	w0, w1
               	b.lt	<addr>
               	mov	x0, x2
               	ret

<dispatch>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x400
               	mov	x1, x0
               	mov	x3, #0x3e8              // =1000
               	sxtw	x2, w2
               	mov	x0, #0x0                // =0
               	cmp	w1, #0x2
               	b.lt	<addr>
               	cmp	w1, #0x3
               	b.lt	<addr>
               	cmp	w1, #0x4
               	b.lt	<addr>
               	mov	x1, #0x3                // =3
               	cmp	w0, w2
               	b.ge	<addr>
               	sub	x3, x29, #0x200
               	mul	x4, x0, x1
               	sxtw	x4, w4
               	add	x4, x4, #0x3e8
               	str	x4, [x3, x0, lsl #3]
               	add	x0, x0, #0x1
               	cmp	w0, w2
               	b.lt	<addr>
               	sub	x0, x29, #0x200
               	mov	x1, x2
               	bl	<addr>
               	add	sp, sp, #0x400
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, x0
               	cmp	w1, w2
               	b.ge	<addr>
               	sub	x4, x29, #0x400
               	eor	x5, x3, x1
               	str	x5, [x4, x1, lsl #3]
               	add	x1, x1, #0x1
               	cmp	w1, w2
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	cmp	w1, w2
               	b.ge	<addr>
               	sub	x3, x29, #0x400
               	ldr	x3, [x3, x1, lsl #3]
               	add	x0, x0, x3
               	add	x1, x1, #0x1
               	cmp	w1, w2
               	b.ge	<addr>
               	b	<addr>
               	mov	x1, x0
               	cmp	w1, w2
               	b.ge	<addr>
               	sub	x4, x29, #0x400
               	sub	x5, x3, x1
               	str	x5, [x4, x1, lsl #3]
               	add	x1, x1, #0x1
               	cmp	w1, w2
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	cmp	w1, w2
               	b.ge	<addr>
               	sub	x3, x29, #0x400
               	ldr	x3, [x3, x1, lsl #3]
               	add	x0, x0, x3
               	add	x1, x1, #0x1
               	cmp	w1, w2
               	b.ge	<addr>
               	b	<addr>
               	cmp	w1, #0x1
               	b.lt	<addr>
               	mov	x1, x0
               	cmp	w1, w2
               	b.ge	<addr>
               	sub	x4, x29, #0x400
               	mul	x5, x3, x1
               	str	x5, [x4, x1, lsl #3]
               	add	x1, x1, #0x1
               	cmp	w1, w2
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	cmp	w1, w2
               	b.ge	<addr>
               	sub	x3, x29, #0x400
               	ldr	x3, [x3, x1, lsl #3]
               	add	x0, x0, x3
               	add	x1, x1, #0x1
               	cmp	w1, w2
               	b.ge	<addr>
               	b	<addr>
               	mov	x1, x0
               	cmp	w1, w2
               	b.ge	<addr>
               	sub	x3, x29, #0x400
               	add	x4, x1, #0x3e8
               	str	x4, [x3, x1, lsl #3]
               	add	x1, x1, #0x1
               	cmp	w1, w2
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	cmp	w1, w2
               	b.ge	<addr>
               	sub	x3, x29, #0x400
               	ldr	x3, [x3, x1, lsl #3]
               	add	x0, x0, x3
               	add	x1, x1, #0x1
               	cmp	w1, w2
               	b.ge	<addr>
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x21, [x0]
               	mov	x20, #0x3e8             // =1000
               	mov	x0, #0x0                // =0
               	mov	x1, x20
               	mov	x2, x21
               	bl	<addr>
               	mov	x22, x0
               	mov	x0, #0x1                // =1
               	mov	x1, x20
               	mov	x2, x21
               	bl	<addr>
               	add	x22, x22, x0
               	mov	x0, #0x2                // =2
               	mov	x1, x20
               	mov	x2, x21
               	bl	<addr>
               	add	x22, x22, x0
               	mov	x0, #0x3                // =3
               	mov	x1, x20
               	mov	x2, x21
               	bl	<addr>
               	add	x22, x22, x0
               	mov	x0, #0x4                // =4
               	mov	x1, x20
               	mov	x2, x21
               	bl	<addr>
               	add	x5, x22, x0
               	mov	x0, #0x0                // =0
               	mov	x2, #0x3                // =3
               	mov	x1, #0x0                // =0
               	cmp	w0, w21
               	b.ge	<addr>
               	add	x3, x0, #0x3e8
               	madd	x3, x20, x0, x3
               	sub	x4, x20, x0
               	add	x3, x3, x4
               	eor	x4, x20, x0
               	add	x3, x3, x4
               	mul	x4, x0, x2
               	sxtw	x4, w4
               	add	x4, x4, #0x3e8
               	add	x3, x3, x4
               	add	x1, x1, x3
               	add	x0, x0, #0x1
               	cmp	w0, w21
               	b.lt	<addr>
               	cmp	x5, x1
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
