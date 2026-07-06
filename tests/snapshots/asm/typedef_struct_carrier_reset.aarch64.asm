
typedef_struct_carrier_reset.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x2, #0x0                // =0
               	mov	x1, x2
               	b	<addr>
               	sxtw	x3, w1
               	str	w1, [x0, x3, lsl #2]
               	add	x3, x0, #0x28
               	sxtw	x4, w1
               	add	x5, x4, #0x1
               	str	w5, [x3, x4, lsl #2]
               	sxtw	x3, w1
               	lsl	x3, x3, #2
               	add	x4, x0, x3
               	ldrsw	x4, [x4]
               	add	x5, x0, #0x28
               	add	x3, x5, x3
               	ldrsw	x3, [x3]
               	add	x3, x4, x3
               	add	x2, x2, x3
               	sxtw	x1, w1
               	add	x1, x1, #0x1
               	sxtw	x3, w1
               	cmp	x3, #0xa
               	b.lt	<addr>
               	str	w2, [x0, #0xa0]
               	sxtw	x0, w2
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xc0
               	sub	x0, x29, #0xa8
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa8
               	ldrsw	x0, [x0, #0x14]
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa8
               	ldrsw	x0, [x0, #0x3c]
               	cmp	x0, #0x6
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xa8
               	ldrsw	x0, [x0, #0xa0]
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0xc0
               	ldp	x29, x30, [sp], #0x10
               	ret
