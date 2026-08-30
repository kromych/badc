
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
               	mov	x2, x0
               	mov	x6, #0x0                // =0
               	mov	x1, x6
               	b	<addr>
               	sxtw	x0, w1
               	lsl	x5, x0, #7
               	add	x3, x2, x5
               	add	x7, x3, #0x0
               	lsl	x4, x0, #4
               	add	x8, x4, #0x0
               	sxtw	x8, w8
               	str	x8, [x7]
               	add	x7, x6, x8
               	add	x6, x4, #0x1
               	sxtw	x6, w6
               	str	x6, [x3, #0x8]
               	add	x7, x7, x6
               	add	x6, x4, #0x2
               	sxtw	x6, w6
               	str	x6, [x3, #0x10]
               	add	x6, x7, x6
               	add	x4, x4, #0x3
               	sxtw	x4, w4
               	str	x4, [x3, #0x18]
               	add	x3, x2, x5
               	ldr	x3, [x3, #0x18]
               	add	x7, x6, x3
               	lsl	x5, x0, #7
               	add	x3, x2, x5
               	lsl	x4, x0, #4
               	add	x6, x4, #0x4
               	sxtw	x6, w6
               	str	x6, [x3, #0x20]
               	add	x7, x7, x6
               	add	x6, x4, #0x5
               	sxtw	x6, w6
               	str	x6, [x3, #0x28]
               	add	x7, x7, x6
               	add	x6, x4, #0x6
               	sxtw	x6, w6
               	str	x6, [x3, #0x30]
               	add	x6, x7, x6
               	add	x4, x4, #0x7
               	sxtw	x4, w4
               	str	x4, [x3, #0x38]
               	add	x7, x6, x4
               	lsl	x5, x0, #7
               	add	x3, x2, x5
               	lsl	x4, x0, #4
               	add	x6, x4, #0x8
               	sxtw	x6, w6
               	str	x6, [x3, #0x40]
               	add	x7, x7, x6
               	add	x6, x4, #0x9
               	sxtw	x6, w6
               	str	x6, [x3, #0x48]
               	add	x7, x7, x6
               	add	x6, x4, #0xa
               	sxtw	x6, w6
               	str	x6, [x3, #0x50]
               	add	x6, x7, x6
               	add	x4, x4, #0xb
               	sxtw	x4, w4
               	str	x4, [x3, #0x58]
               	add	x7, x6, x4
               	lsl	x5, x0, #7
               	add	x3, x2, x5
               	lsl	x4, x0, #4
               	add	x6, x4, #0xc
               	sxtw	x6, w6
               	str	x6, [x3, #0x60]
               	add	x7, x7, x6
               	add	x6, x4, #0xd
               	sxtw	x6, w6
               	str	x6, [x3, #0x68]
               	add	x7, x7, x6
               	add	x6, x4, #0xe
               	sxtw	x6, w6
               	str	x6, [x3, #0x70]
               	add	x6, x7, x6
               	add	x4, x4, #0xf
               	sxtw	x4, w4
               	str	x4, [x3, #0x78]
               	add	x6, x6, x4
               	add	x1, x0, #0x1
               	cmp	w1, #0x4
               	b.lt	<addr>
               	mov	x0, x6
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x220
               	str	x20, [sp]
               	mov	x0, #0x0                // =0
               	mov	x20, x0
               	b	<addr>
               	sxtw	x1, w0
               	add	x20, x20, x1
               	add	x0, x1, #0x1
               	cmp	w0, #0x40
               	b.lt	<addr>
               	sub	x0, x29, #0x200
               	bl	<addr>
               	cmp	x0, x20
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x200
               	ldr	x1, [x0]
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x1, [x0, #0x1f8]
               	cmp	x1, #0x3f
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x0, #0xb8]
               	cmp	x0, #0x17
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	add	sp, sp, #0x220
               	ldp	x29, x30, [sp], #0x10
               	ret
