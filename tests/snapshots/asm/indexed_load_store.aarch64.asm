
indexed_load_store.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x90
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
               	sub	x6, x29, #0x20
               	sub	x3, x29, #0x40
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	b	<addr>
               	lsl	x5, x1, #2
               	add	x7, x6, x5
               	ldrsw	x4, [x7]
               	add	x4, x4, #0x3
               	add	x5, x3, x5
               	ldrsw	x5, [x5]
               	sub	x5, x5, #0x3
               	str	w5, [x7]
               	str	w4, [x3, x1, lsl #2]
               	lsl	x4, x1, #2
               	add	x5, x6, x4
               	ldrsw	x5, [x5]
               	add	x4, x3, x4
               	ldrsw	x4, [x4]
               	mul	x4, x5, x4
               	add	x2, x2, x4
               	sxtw	x2, w2
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x8
               	b.lt	<addr>
               	sxtw	x0, w2
               	sxtw	x0, w0
               	cmp	x0, #0xb7c
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
