
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
               	sub	sp, sp, #0x40
               	sub	x5, x29, #0x40
               	mov	x0, #0x1                // =1
               	str	w0, [x5]
               	sub	x3, x29, #0x20
               	mov	x0, #0xa                // =10
               	str	w0, [x3]
               	mov	x0, #0x2                // =2
               	str	w0, [x5, #0x4]
               	mov	x0, #0x14               // =20
               	str	w0, [x3, #0x4]
               	mov	x0, #0x3                // =3
               	str	w0, [x5, #0x8]
               	mov	x0, #0x1e               // =30
               	str	w0, [x3, #0x8]
               	mov	x0, #0x4                // =4
               	str	w0, [x5, #0xc]
               	mov	x0, #0x28               // =40
               	str	w0, [x3, #0xc]
               	mov	x0, #0x5                // =5
               	str	w0, [x5, #0x10]
               	mov	x0, #0x32               // =50
               	str	w0, [x3, #0x10]
               	mov	x0, #0x6                // =6
               	str	w0, [x5, #0x14]
               	mov	x0, #0x3c               // =60
               	str	w0, [x3, #0x14]
               	mov	x0, #0x7                // =7
               	str	w0, [x5, #0x18]
               	mov	x0, #0x46               // =70
               	str	w0, [x3, #0x18]
               	mov	x0, #0x8                // =8
               	str	w0, [x5, #0x1c]
               	mov	x0, #0x50               // =80
               	str	w0, [x3, #0x1c]
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	lsl	x4, x0, #2
               	add	x2, x5, x4
               	ldrsw	x6, [x2]
               	add	x6, x6, #0x3
               	add	x4, x3, x4
               	ldrsw	x7, [x4]
               	sub	x7, x7, #0x3
               	str	w7, [x2]
               	str	w6, [x3, x0, lsl #2]
               	ldrsw	x2, [x2]
               	ldrsw	x4, [x4]
               	madd	x1, x2, x4, x1
               	add	x0, x0, #0x1
               	cmp	w0, #0x8
               	b.lt	<addr>
               	cmp	w1, #0xb7c
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
