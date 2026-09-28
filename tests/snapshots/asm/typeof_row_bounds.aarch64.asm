
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
               	sub	x1, x29, #0x30
               	mov	x0, #0x0                // =0
               	str	w0, [x1]
               	mov	x2, #0x1                // =1
               	str	w2, [x1, #0x4]
               	mov	x2, #0x2                // =2
               	str	w2, [x1, #0x8]
               	mov	x2, #0x3                // =3
               	str	w2, [x1, #0xc]
               	add	x2, x1, #0x10
               	mov	x3, #0xa                // =10
               	str	w3, [x2]
               	mov	x3, #0xb                // =11
               	str	w3, [x2, #0x4]
               	mov	x3, #0xc                // =12
               	str	w3, [x2, #0x8]
               	mov	x3, #0xd                // =13
               	str	w3, [x2, #0xc]
               	add	x3, x1, #0x20
               	mov	x4, #0x14               // =20
               	str	w4, [x3]
               	mov	x4, #0x15               // =21
               	str	w4, [x3, #0x4]
               	mov	x4, #0x16               // =22
               	str	w4, [x3, #0x8]
               	mov	x4, #0x17               // =23
               	str	w4, [x3, #0xc]
               	ldrsw	x3, [x1, #0x2c]
               	cmp	w3, #0x17
               	b.ne	<addr>
               	ldrsw	x3, [x1, #0x10]
               	cmp	w3, #0xa
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x2, x1
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
