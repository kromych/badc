
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
               	mov	x4, x1
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	b	<addr>
               	sxtw	x1, w0
               	ldr	x5, [x3, x1, lsl #3]
               	add	x2, x2, x5
               	add	x0, x1, #0x1
               	cmp	w0, w4
               	b.lt	<addr>
               	mov	x0, x2
               	ret

<dispatch>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x410
               	mov	x1, x0
               	sxtw	x1, w1
               	sxtw	x2, w2
               	mov	x4, #0x3e8              // =1000
               	mov	x0, #0x0                // =0
               	cmp	w1, #0x2
               	b.lt	<addr>
               	cmp	w1, #0x3
               	b.lt	<addr>
               	cmp	w1, #0x4
               	b.lt	<addr>
               	cmp	w1, #0x4
               	b.eq	<addr>
               	add	sp, sp, #0x410
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	sub	x3, x29, #0x200
               	sxtw	x1, w0
               	mov	x17, #0x3               // =3
               	mul	x4, x1, x17
               	sxtw	x4, w4
               	add	x4, x4, #0x3e8
               	str	x4, [x3, x1, lsl #3]
               	add	x0, x1, #0x1
               	cmp	w0, w2
               	b.lt	<addr>
               	sub	x0, x29, #0x200
               	mov	x1, x2
               	bl	<addr>
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	sub	x5, x29, #0x400
               	sxtw	x3, w1
               	eor	x6, x4, x3
               	str	x6, [x5, x3, lsl #3]
               	add	x1, x3, #0x1
               	cmp	w1, w2
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0x400
               	sxtw	x3, w1
               	ldr	x4, [x4, x3, lsl #3]
               	add	x0, x0, x4
               	add	x1, x3, #0x1
               	cmp	w1, w2
               	b.lt	<addr>
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	sub	x5, x29, #0x400
               	sxtw	x3, w1
               	sub	x6, x4, x3
               	str	x6, [x5, x3, lsl #3]
               	add	x1, x3, #0x1
               	cmp	w1, w2
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0x400
               	sxtw	x3, w1
               	ldr	x4, [x4, x3, lsl #3]
               	add	x0, x0, x4
               	add	x1, x3, #0x1
               	cmp	w1, w2
               	b.lt	<addr>
               	b	<addr>
               	cmp	w1, #0x1
               	b.lt	<addr>
               	mov	x1, x0
               	b	<addr>
               	sub	x5, x29, #0x400
               	sxtw	x3, w1
               	mul	x6, x4, x3
               	str	x6, [x5, x3, lsl #3]
               	add	x1, x3, #0x1
               	cmp	w1, w2
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0x400
               	sxtw	x3, w1
               	ldr	x4, [x4, x3, lsl #3]
               	add	x0, x0, x4
               	add	x1, x3, #0x1
               	cmp	w1, w2
               	b.lt	<addr>
               	b	<addr>
               	cbz	x1, <addr>
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	sub	x4, x29, #0x400
               	sxtw	x3, w1
               	add	x5, x3, #0x3e8
               	str	x5, [x4, x3, lsl #3]
               	add	x1, x3, #0x1
               	cmp	w1, w2
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sub	x4, x29, #0x400
               	sxtw	x3, w1
               	ldr	x4, [x4, x3, lsl #3]
               	add	x0, x0, x4
               	add	x1, x3, #0x1
               	cmp	w1, w2
               	b.lt	<addr>
               	b	<addr>

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x22, [x0]
               	mov	x20, #0x3e8             // =1000
               	mov	x21, #0x0               // =0
               	mov	x0, x21
               	mov	x2, x22
               	mov	x1, x20
               	bl	<addr>
               	add	x23, x0, #0x0
               	mov	x0, #0x1                // =1
               	mov	x1, x20
               	mov	x2, x22
               	bl	<addr>
               	add	x23, x23, x0
               	mov	x0, #0x2                // =2
               	mov	x1, x20
               	mov	x2, x22
               	bl	<addr>
               	add	x23, x23, x0
               	mov	x0, #0x3                // =3
               	mov	x1, x20
               	mov	x2, x22
               	bl	<addr>
               	add	x23, x23, x0
               	mov	x0, #0x4                // =4
               	mov	x1, x20
               	mov	x2, x22
               	bl	<addr>
               	add	x4, x23, x0
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sxtw	x1, w0
               	add	x2, x1, #0x3e8
               	mul	x3, x20, x1
               	add	x2, x2, x3
               	sub	x3, x20, x1
               	add	x2, x2, x3
               	eor	x3, x20, x1
               	add	x3, x2, x3
               	mov	x17, #0x3               // =3
               	mul	x2, x1, x17
               	sxtw	x2, w2
               	add	x2, x2, #0x3e8
               	add	x2, x3, x2
               	add	x21, x21, x2
               	add	x0, x1, #0x1
               	cmp	w0, w22
               	b.lt	<addr>
               	cmp	x4, x21
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
