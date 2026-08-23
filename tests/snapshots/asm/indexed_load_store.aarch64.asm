
indexed_load_store.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x50
               	sub	x5, x29, #0x40
               	add	x0, x5, #0x0
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	sub	x1, x29, #0x20
               	add	x0, x1, #0x0
               	mov	x2, #0xa                // =10
               	str	w2, [x0]
               	mov	x0, #0x2                // =2
               	str	w0, [x5, #0x4]
               	mov	x0, #0x14               // =20
               	str	w0, [x1, #0x4]
               	mov	x0, #0x3                // =3
               	str	w0, [x5, #0x8]
               	mov	x0, #0x1e               // =30
               	str	w0, [x1, #0x8]
               	mov	x0, #0x4                // =4
               	str	w0, [x5, #0xc]
               	mov	x0, #0x28               // =40
               	str	w0, [x1, #0xc]
               	mov	x0, #0x5                // =5
               	str	w0, [x5, #0x10]
               	mov	x0, #0x32               // =50
               	str	w0, [x1, #0x10]
               	mov	x0, #0x6                // =6
               	str	w0, [x5, #0x14]
               	mov	x0, #0x3c               // =60
               	str	w0, [x1, #0x14]
               	mov	x0, #0x7                // =7
               	str	w0, [x5, #0x18]
               	mov	x0, #0x46               // =70
               	str	w0, [x1, #0x18]
               	mov	x0, #0x8                // =8
               	str	w0, [x5, #0x1c]
               	mov	x0, #0x50               // =80
               	str	w0, [x1, #0x1c]
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	b	<addr>
               	sxtw	x3, w0
               	lsl	x4, x3, #2
               	add	x6, x5, x4
               	ldrsw	x7, [x6]
               	add	x7, x7, #0x3
               	add	x8, x1, x4
               	ldrsw	x9, [x8]
               	sub	x9, x9, #0x3
               	str	w9, [x6]
               	str	w7, [x1, x3, lsl #2]
               	ldrsw	x6, [x6]
               	ldrsw	x4, [x8]
               	madd	x2, x6, x4, x2
               	sxtw	x2, w2
               	add	x0, x3, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	sxtw	x0, w2
               	cmp	w0, #0xb7c
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
