
symbol_inner_array_size_no_leak.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x3, x29, #0x10
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x17, #0x3               // =3
               	mul	x2, x1, x17
               	sxtw	x4, w2
               	strh	w4, [x3, x1, lsl #1]
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x8
               	b.lt	<addr>
               	ldrsh	x0, [x3, #0xe]
               	sxtw	x1, w0
               	sxtw	x0, w1
               	cmp	x0, #0x15
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldrsh	x0, [x0]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x10
               	ldrsh	x0, [x0, #0xe]
               	cmp	x0, #0x15
               	cset	x0, ne
               	cbz	x0, <addr>
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
