
typeof_row_bounds.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x30
               	sub	x3, x29, #0x30
               	mov	x0, #0x0                // =0
               	stur	w0, [x29, #-0x30]
               	mov	x1, #0x1                // =1
               	stur	w1, [x29, #-0x2c]
               	mov	x1, #0x2                // =2
               	stur	w1, [x29, #-0x28]
               	mov	x1, #0x3                // =3
               	stur	w1, [x29, #-0x24]
               	add	x1, x3, #0x10
               	mov	x2, #0xa                // =10
               	str	w2, [x1]
               	mov	x2, #0xb                // =11
               	str	w2, [x1, #0x4]
               	mov	x2, #0xc                // =12
               	str	w2, [x1, #0x8]
               	mov	x2, #0xd                // =13
               	str	w2, [x1, #0xc]
               	add	x2, x3, #0x20
               	mov	x4, #0x14               // =20
               	str	w4, [x2]
               	mov	x4, #0x15               // =21
               	str	w4, [x2, #0x4]
               	mov	x4, #0x16               // =22
               	str	w4, [x2, #0x8]
               	mov	x4, #0x17               // =23
               	str	w4, [x2, #0xc]
               	ldursw	x2, [x29, #-0x4]
               	cmp	w2, #0x17
               	b.ne	<addr>
               	ldursw	x2, [x29, #-0x20]
               	cmp	w2, #0xa
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x1, x3
               	asr	x2, x1, #63
               	lsr	x2, x2, #62
               	add	x1, x1, x2
               	asr	x1, x1, #2
               	cmp	x1, #0x4
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
