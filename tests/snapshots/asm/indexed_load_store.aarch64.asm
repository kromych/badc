
indexed_load_store.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sxtw	x2, w2
               	sxtw	x3, w3
               	mov	x5, #0x0                // =0
               	mov	x4, x5
               	sxtw	x6, w4
               	cmp	x6, x2
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x4, w4
               	add	x4, x4, #0x1
               	b	<addr>
               	sxtw	x6, w4
               	lsl	x6, x6, #2
               	add	x7, x0, x6
               	ldrsw	x8, [x7]
               	add	x8, x8, x3
               	add	x6, x1, x6
               	ldrsw	x6, [x6]
               	sub	x6, x6, x3
               	str	w6, [x7]
               	sxtw	x6, w4
               	str	w8, [x1, x6, lsl #2]
               	sxtw	x6, w4
               	lsl	x6, x6, #2
               	add	x7, x0, x6
               	ldrsw	x7, [x7]
               	add	x6, x1, x6
               	ldrsw	x6, [x6]
               	mul	x6, x7, x6
               	add	x5, x5, x6
               	sxtw	x5, w5
               	b	<addr>
               	sxtw	x0, w5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	mov	x1, #0x0                // =0
               	sxtw	x0, w1
               	cmp	x0, #0x8
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w1
               	add	x1, x0, #0x1
               	b	<addr>
               	sub	x0, x29, #0x20
               	sxtw	x2, w1
               	add	x3, x2, #0x1
               	str	w3, [x0, x2, lsl #2]
               	sub	x0, x29, #0x40
               	sxtw	x2, w1
               	add	x3, x2, #0x1
               	mov	x17, #0xa               // =10
               	mul	x3, x3, x17
               	str	w3, [x0, x2, lsl #2]
               	b	<addr>
               	sub	x0, x29, #0x20
               	sub	x1, x29, #0x40
               	mov	x2, #0x8                // =8
               	mov	x3, #0x3                // =3
               	bl	<addr>
               	cmp	x0, #0xb7c
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x1                // =1
               	mov	x0, x1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
