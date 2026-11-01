
typedef_array_outer_dim.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x200
               	mov	x0, #0x0                // =0
               	mov	x5, x0
               	add	x5, x5, x0
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	sub	x3, x29, #0x200
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	add	x4, x3, x0, lsl #7
               	lsl	x1, x0, #4
               	str	x1, [x4]
               	add	x6, x2, x1
               	add	x2, x1, #0x1
               	str	x2, [x4, #0x8]
               	add	x6, x6, x2
               	add	x2, x1, #0x2
               	str	x2, [x4, #0x10]
               	add	x2, x6, x2
               	add	x1, x1, #0x3
               	str	x1, [x4, #0x18]
               	add	x6, x2, x1
               	add	x1, x3, x0, lsl #7
               	lsl	x2, x0, #4
               	add	x4, x2, #0x4
               	str	x4, [x1, #0x20]
               	add	x6, x6, x4
               	add	x4, x2, #0x5
               	str	x4, [x1, #0x28]
               	add	x6, x6, x4
               	add	x4, x2, #0x6
               	str	x4, [x1, #0x30]
               	add	x4, x6, x4
               	add	x2, x2, #0x7
               	str	x2, [x1, #0x38]
               	add	x6, x4, x2
               	add	x1, x3, x0, lsl #7
               	lsl	x2, x0, #4
               	add	x4, x2, #0x8
               	str	x4, [x1, #0x40]
               	add	x6, x6, x4
               	add	x4, x2, #0x9
               	str	x4, [x1, #0x48]
               	add	x6, x6, x4
               	add	x4, x2, #0xa
               	str	x4, [x1, #0x50]
               	add	x4, x6, x4
               	add	x2, x2, #0xb
               	str	x2, [x1, #0x58]
               	add	x6, x4, x2
               	add	x1, x3, x0, lsl #7
               	lsl	x2, x0, #4
               	add	x4, x2, #0xc
               	str	x4, [x1, #0x60]
               	add	x6, x6, x4
               	add	x4, x2, #0xd
               	str	x4, [x1, #0x68]
               	add	x6, x6, x4
               	add	x4, x2, #0xe
               	str	x4, [x1, #0x70]
               	add	x4, x6, x4
               	add	x2, x2, #0xf
               	str	x2, [x1, #0x78]
               	add	x2, x4, x2
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	cmp	x2, x5
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [sp]
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x3f
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [sp, #0xb8]
               	cmp	x0, #0x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x200
               	ldp	x29, x30, [sp], #0x10
               	ret
