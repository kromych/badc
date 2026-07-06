
indexed_load_store.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x2, w2
               	mov	x5, #0x0                // =0
               	mov	x4, x5
               	b	<addr>
               	lsl	x7, x6, #2
               	add	x8, x0, x7
               	ldrsw	x9, [x8]
               	add	x9, x9, x3
               	add	x7, x1, x7
               	ldrsw	x7, [x7]
               	sub	x7, x7, x3
               	str	w7, [x8]
               	str	w9, [x1, x6, lsl #2]
               	lsl	x7, x6, #2
               	add	x8, x0, x7
               	ldrsw	x8, [x8]
               	add	x7, x1, x7
               	ldrsw	x7, [x7]
               	mul	x7, x8, x7
               	add	x5, x5, x7
               	sxtw	x5, w5
               	add	x4, x6, #0x1
               	sxtw	x6, w4
               	cmp	x6, x2
               	b.lt	<addr>
               	sxtw	x0, w5
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x70
               	sub	x0, x29, #0x20
               	add	x0, x0, #0x0
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	sub	x0, x29, #0x40
               	add	x0, x0, #0x0
               	mov	x1, #0xa                // =10
               	str	w1, [x0]
               	sub	x0, x29, #0x20
               	mov	x1, #0x2                // =2
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x40
               	mov	x1, #0x14               // =20
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x20
               	mov	x1, #0x3                // =3
               	str	w1, [x0, #0x8]
               	sub	x0, x29, #0x40
               	mov	x1, #0x1e               // =30
               	str	w1, [x0, #0x8]
               	sub	x0, x29, #0x20
               	mov	x1, #0x4                // =4
               	str	w1, [x0, #0xc]
               	sub	x0, x29, #0x40
               	mov	x1, #0x28               // =40
               	str	w1, [x0, #0xc]
               	sub	x0, x29, #0x20
               	mov	x1, #0x5                // =5
               	str	w1, [x0, #0x10]
               	sub	x0, x29, #0x40
               	mov	x1, #0x32               // =50
               	str	w1, [x0, #0x10]
               	sub	x0, x29, #0x20
               	mov	x1, #0x6                // =6
               	str	w1, [x0, #0x14]
               	sub	x0, x29, #0x40
               	mov	x1, #0x3c               // =60
               	str	w1, [x0, #0x14]
               	sub	x0, x29, #0x20
               	mov	x1, #0x7                // =7
               	str	w1, [x0, #0x18]
               	sub	x0, x29, #0x40
               	mov	x1, #0x46               // =70
               	str	w1, [x0, #0x18]
               	sub	x0, x29, #0x20
               	mov	x1, #0x8                // =8
               	str	w1, [x0, #0x1c]
               	sub	x0, x29, #0x40
               	mov	x1, #0x50               // =80
               	str	w1, [x0, #0x1c]
               	sub	x0, x29, #0x20
               	sub	x1, x29, #0x40
               	mov	x2, #0x8                // =8
               	mov	x3, #0x3                // =3
               	bl	<addr>
               	cmp	x0, #0xb7c
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x1                // =1
               	b	<addr>
