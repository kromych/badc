
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

<fill_and_sum>:
               	mov	x1, x0
               	mov	x5, #0x0                // =0
               	mov	x0, x5
               	cmp	w0, #0x4
               	b.ge	<addr>
               	lsl	x4, x0, #7
               	add	x2, x1, x4
               	lsl	x3, x0, #4
               	str	x3, [x2]
               	add	x6, x5, x3
               	add	x5, x3, #0x1
               	str	x5, [x2, #0x8]
               	add	x6, x6, x5
               	add	x5, x3, #0x2
               	str	x5, [x2, #0x10]
               	add	x5, x6, x5
               	add	x3, x3, #0x3
               	str	x3, [x2, #0x18]
               	add	x5, x5, x3
               	add	x4, x1, x4
               	lsl	x3, x0, #4
               	add	x2, x3, #0x4
               	str	x2, [x4, #0x20]
               	lsl	x4, x0, #7
               	add	x2, x1, x4
               	ldr	x6, [x2, #0x20]
               	add	x6, x5, x6
               	add	x5, x3, #0x5
               	str	x5, [x2, #0x28]
               	add	x6, x6, x5
               	add	x5, x3, #0x6
               	str	x5, [x2, #0x30]
               	add	x6, x6, x5
               	add	x5, x3, #0x7
               	str	x5, [x2, #0x38]
               	add	x5, x6, x5
               	add	x3, x3, #0x8
               	str	x3, [x2, #0x40]
               	add	x2, x1, x4
               	ldr	x2, [x2, #0x40]
               	add	x6, x5, x2
               	lsl	x4, x0, #7
               	add	x2, x1, x4
               	lsl	x3, x0, #4
               	add	x5, x3, #0x9
               	str	x5, [x2, #0x48]
               	add	x6, x6, x5
               	add	x5, x3, #0xa
               	str	x5, [x2, #0x50]
               	add	x6, x6, x5
               	add	x5, x3, #0xb
               	str	x5, [x2, #0x58]
               	add	x5, x6, x5
               	add	x3, x3, #0xc
               	str	x3, [x2, #0x60]
               	add	x5, x5, x3
               	add	x4, x1, x4
               	lsl	x3, x0, #4
               	add	x2, x3, #0xd
               	str	x2, [x4, #0x68]
               	lsl	x4, x0, #7
               	add	x2, x1, x4
               	ldr	x6, [x2, #0x68]
               	add	x6, x5, x6
               	add	x5, x3, #0xe
               	str	x5, [x2, #0x70]
               	add	x5, x6, x5
               	add	x3, x3, #0xf
               	str	x3, [x2, #0x78]
               	add	x5, x5, x3
               	add	x0, x0, #0x1
               	cmp	w0, #0x4
               	b.lt	<addr>
               	mov	x0, x5
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x210
               	str	x20, [sp]
               	mov	x0, #0x0                // =0
               	mov	x20, x0
               	cmp	w0, #0x40
               	b.ge	<addr>
               	add	x20, x20, x0
               	add	x0, x0, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	sub	x0, x29, #0x200
               	bl	<addr>
               	cmp	x0, x20
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x200
               	ldr	x1, [x0]
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x1, [x0, #0x1f8]
               	cmp	x1, #0x3f
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x0, #0xb8]
               	cmp	x0, #0x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	add	sp, sp, #0x210
               	ldp	x29, x30, [sp], #0x10
               	ret
