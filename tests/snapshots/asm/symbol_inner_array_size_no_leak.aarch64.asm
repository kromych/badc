
symbol_inner_array_size_no_leak.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x1, w1
               	mov	x3, #0x0                // =0
               	b	<addr>
               	sxtw	x2, w3
               	cmp	x2, x1
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x2, w3
               	add	x3, x2, #0x1
               	b	<addr>
               	sxtw	x2, w3
               	mov	x17, #0x3               // =3
               	mul	x4, x2, x17
               	sxtw	x4, w4
               	sxth	x4, w4
               	strh	w4, [x0, x2, lsl #1]
               	b	<addr>
               	sub	x1, x1, #0x1
               	sxtw	x1, w1
               	ldrsh	x0, [x0, x1, lsl #1]
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x0, x29, #0x10
               	mov	x1, #0x8                // =8
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldrsh	x0, [x0]
               	cmp	x0, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x10
               	ldrsh	x0, [x0, #0xe]
               	cmp	x0, #0x15
               	cset	x1, ne
               	b	<addr>
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x28
               	mov	x1, #0x63               // =99
               	strh	w1, [x0, #0xe]
               	sub	x0, x29, #0x28
               	ldrsh	x0, [x0, #0xe]
               	cmp	x0, #0x63
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
