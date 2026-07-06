
typedef_struct_carrier_reset.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x1, #0x0                // =0
               	add	x2, x0, #0x0
               	str	w1, [x2]
               	add	x1, x0, #0x28
               	add	x1, x1, #0x0
               	mov	x2, #0x1                // =1
               	str	w2, [x1]
               	add	x1, x0, #0x0
               	ldrsw	x1, [x1]
               	add	x2, x0, #0x28
               	add	x2, x2, #0x0
               	ldrsw	x2, [x2]
               	add	x1, x1, x2
               	add	x1, x1, #0x0
               	mov	x2, #0x1                // =1
               	str	w2, [x0, #0x4]
               	add	x2, x0, #0x28
               	mov	x3, #0x2                // =2
               	str	w3, [x2, #0x4]
               	ldrsw	x3, [x0, #0x4]
               	add	x2, x0, #0x28
               	ldrsw	x2, [x2, #0x4]
               	add	x2, x3, x2
               	add	x1, x1, x2
               	mov	x2, #0x2                // =2
               	str	w2, [x0, #0x8]
               	add	x2, x0, #0x28
               	mov	x3, #0x3                // =3
               	str	w3, [x2, #0x8]
               	ldrsw	x3, [x0, #0x8]
               	add	x2, x0, #0x28
               	ldrsw	x2, [x2, #0x8]
               	add	x2, x3, x2
               	add	x1, x1, x2
               	mov	x2, #0x3                // =3
               	str	w2, [x0, #0xc]
               	add	x2, x0, #0x28
               	mov	x3, #0x4                // =4
               	str	w3, [x2, #0xc]
               	ldrsw	x3, [x0, #0xc]
               	add	x2, x0, #0x28
               	ldrsw	x2, [x2, #0xc]
               	add	x2, x3, x2
               	add	x1, x1, x2
               	mov	x2, #0x4                // =4
               	str	w2, [x0, #0x10]
               	add	x2, x0, #0x28
               	mov	x3, #0x5                // =5
               	str	w3, [x2, #0x10]
               	ldrsw	x3, [x0, #0x10]
               	add	x2, x0, #0x28
               	ldrsw	x2, [x2, #0x10]
               	add	x2, x3, x2
               	add	x1, x1, x2
               	mov	x2, #0x5                // =5
               	str	w2, [x0, #0x14]
               	add	x2, x0, #0x28
               	mov	x3, #0x6                // =6
               	str	w3, [x2, #0x14]
               	ldrsw	x3, [x0, #0x14]
               	add	x2, x0, #0x28
               	ldrsw	x2, [x2, #0x14]
               	add	x2, x3, x2
               	add	x1, x1, x2
               	mov	x2, #0x6                // =6
               	str	w2, [x0, #0x18]
               	add	x2, x0, #0x28
               	mov	x3, #0x7                // =7
               	str	w3, [x2, #0x18]
               	ldrsw	x3, [x0, #0x18]
               	add	x2, x0, #0x28
               	ldrsw	x2, [x2, #0x18]
               	add	x2, x3, x2
               	add	x1, x1, x2
               	mov	x2, #0x7                // =7
               	str	w2, [x0, #0x1c]
               	add	x2, x0, #0x28
               	mov	x3, #0x8                // =8
               	str	w3, [x2, #0x1c]
               	ldrsw	x3, [x0, #0x1c]
               	add	x2, x0, #0x28
               	ldrsw	x2, [x2, #0x1c]
               	add	x2, x3, x2
               	add	x1, x1, x2
               	mov	x2, #0x8                // =8
               	str	w2, [x0, #0x20]
               	add	x2, x0, #0x28
               	mov	x3, #0x9                // =9
               	str	w3, [x2, #0x20]
               	ldrsw	x3, [x0, #0x20]
               	add	x2, x0, #0x28
               	ldrsw	x2, [x2, #0x20]
               	add	x2, x3, x2
               	add	x1, x1, x2
               	mov	x2, #0x9                // =9
               	str	w2, [x0, #0x24]
               	add	x2, x0, #0x28
               	mov	x3, #0xa                // =10
               	str	w3, [x2, #0x24]
               	ldrsw	x3, [x0, #0x24]
               	add	x2, x0, #0x28
               	ldrsw	x2, [x2, #0x24]
               	add	x2, x3, x2
               	add	x1, x1, x2
               	str	w1, [x0, #0xa0]
               	sxtw	x0, w1
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
