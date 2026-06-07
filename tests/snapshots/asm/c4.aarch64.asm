
c4.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xf8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x19, [sp, #0x10]
               	mov	x20, x0
               	sxtw	x20, w20
               	adrp	x21, <page>
               	add	x21, x21, #0x138
               	ldr	x0, [x21, x20, lsl #3]
               	cbz	x0, <addr>
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, #0x150
               	str	x2, [x0]
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, #0x156
               	str	x2, [x0, #0x8]
               	sub	x0, x29, #0x18
               	adrp	x2, <page>
               	add	x2, x2, #0x15d
               	str	x2, [x0, #0x10]
               	sub	x0, x29, #0x18
               	ldr	x0, [x0, x20, lsl #3]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	cbz	x0, <addr>
               	ldr	x0, [x0]
               	str	x0, [x21, x20, lsl #3]
               	b	<addr>
               	ldr	x0, [x21, x20, lsl #3]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x170
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	adrp	x1, <page>
               	add	x1, x1, #0x170
               	ldr	x1, [x1]
               	ldrb	w1, [x1]
               	str	x1, [x0]
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0xa
               	b.ne	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x1d0
               	ldr	x0, [x0]
               	cbz	x0, <addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x23
               	b.ne	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1e0
               	adrp	x1, <page>
               	add	x1, x1, #0x1c8
               	ldr	x1, [x1]
               	adrp	x20, <page>
               	add	x20, x20, #0x170
               	ldr	x2, [x20]
               	adrp	x21, <page>
               	add	x21, x21, #0x178
               	ldr	x3, [x21]
               	sub	x2, x2, x3
               	ldr	x3, [x21]
               	bl	<addr>
               	sxtw	x0, w0
               	ldr	x0, [x20]
               	str	x0, [x21]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1c8
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x190
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, #0x188
               	ldr	x1, [x1]
               	cmp	x0, x1
               	b.ge	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1e9
               	adrp	x1, <page>
               	add	x1, x1, #0x1ef
               	adrp	x20, <page>
               	add	x20, x20, #0x190
               	ldr	x2, [x20]
               	add	x2, x2, #0x8
               	str	x2, [x20]
               	ldr	x2, [x2]
               	mov	x17, #0x5               // =5
               	mul	x2, x2, x17
               	add	x1, x1, x2
               	bl	<addr>
               	sxtw	x0, w0
               	ldr	x0, [x20]
               	ldr	x0, [x0]
               	cmp	x0, #0x7
               	b.gt	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x2b3
               	adrp	x1, <page>
               	add	x1, x1, #0x190
               	ldr	x2, [x1]
               	add	x2, x2, #0x8
               	str	x2, [x1]
               	ldr	x1, [x2]
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x2b8
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x61
               	cset	x0, ge
               	mov	x20, #0x0               // =0
               	cbz	x0, <addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	cmp	x0, #0x0
               	cset	x20, ne
               	cbz	x20, <addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0xa               // =10
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x20, ne
               	b	<addr>
               	cbz	x20, <addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x7a
               	cset	x0, le
               	cmp	x0, #0x0
               	cset	x20, ne
               	b	<addr>
               	mov	x21, #0x1               // =1
               	cbnz	x20, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x41
               	cset	x0, ge
               	mov	x20, #0x0               // =0
               	cbz	x0, <addr>
               	b	<addr>
               	cbnz	x21, <addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x5a
               	cset	x0, le
               	cmp	x0, #0x0
               	cset	x20, ne
               	b	<addr>
               	cmp	x20, #0x0
               	cset	x21, ne
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x5f
               	cset	x21, eq
               	b	<addr>
               	cbz	x21, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x0, [x0]
               	sub	x20, x0, #0x1
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x30
               	cset	x1, ge
               	cbz	x1, <addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	cmp	x0, #0x61
               	cset	x0, ge
               	mov	x21, #0x0               // =0
               	cbz	x0, <addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x1, [x0]
               	mov	x17, #0x93              // =147
               	mul	x1, x1, x17
               	adrp	x2, <page>
               	add	x2, x2, #0x170
               	ldr	x3, [x2]
               	add	x4, x3, #0x1
               	str	x4, [x2]
               	ldrb	w2, [x3]
               	add	x1, x1, x2
               	str	x1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x1, [x0]
               	lsl	x1, x1, #6
               	adrp	x2, <page>
               	add	x2, x2, #0x170
               	ldr	x2, [x2]
               	sub	x2, x2, x20
               	add	x1, x1, x2
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x198
               	adrp	x1, <page>
               	add	x1, x1, #0x1a0
               	ldr	x1, [x1]
               	str	x1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	cmp	x0, #0x7a
               	cset	x0, le
               	cmp	x0, #0x0
               	cset	x21, ne
               	b	<addr>
               	mov	x22, #0x1               // =1
               	cbnz	x21, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	cmp	x0, #0x41
               	cset	x0, ge
               	mov	x21, #0x0               // =0
               	cbz	x0, <addr>
               	b	<addr>
               	mov	x21, #0x1               // =1
               	cbnz	x22, <addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	cmp	x0, #0x5a
               	cset	x0, le
               	cmp	x0, #0x0
               	cset	x21, ne
               	b	<addr>
               	cmp	x21, #0x0
               	cset	x22, ne
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	cmp	x0, #0x30
               	cset	x0, ge
               	mov	x21, #0x0               // =0
               	cbz	x0, <addr>
               	b	<addr>
               	cbnz	x21, <addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	cmp	x0, #0x39
               	cset	x0, le
               	cmp	x0, #0x0
               	cset	x21, ne
               	b	<addr>
               	cmp	x21, #0x0
               	cset	x21, ne
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x5f              // =95
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x21, eq
               	b	<addr>
               	cbz	x21, <addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x198
               	ldr	x0, [x0]
               	ldr	x0, [x0]
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, #0x198
               	ldr	x1, [x1]
               	ldr	x1, [x1, #0x8]
               	cmp	x0, x1
               	cset	x1, eq
               	cbz	x1, <addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x198
               	ldr	x1, [x0]
               	str	x20, [x1, #0x10]
               	ldr	x1, [x0]
               	adrp	x2, <page>
               	add	x2, x2, #0x1a8
               	ldr	x3, [x2]
               	str	x3, [x1, #0x8]
               	ldr	x0, [x0]
               	mov	x1, #0x0                // =0
               	mov	x3, #0x85               // =133
               	str	x3, [x0]
               	str	x3, [x2]
               	mov	x0, x1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x198
               	ldr	x0, [x0]
               	ldr	x0, [x0, #0x10]
               	adrp	x1, <page>
               	add	x1, x1, #0x170
               	ldr	x1, [x1]
               	sub	x2, x1, x20
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x1, eq
               	b	<addr>
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	adrp	x1, <page>
               	add	x1, x1, #0x198
               	ldr	x1, [x1]
               	mov	x2, #0x0                // =0
               	ldr	x1, [x1]
               	str	x1, [x0]
               	mov	x0, x2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x198
               	ldr	x1, [x0]
               	add	x1, x1, #0x48
               	str	x1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x39
               	cset	x1, le
               	b	<addr>
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1b0
               	adrp	x1, <page>
               	add	x1, x1, #0x1a8
               	ldr	x1, [x1]
               	sub	x1, x1, #0x30
               	str	x1, [x0]
               	cbz	x1, <addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x2f
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	mov	x1, #0x80               // =128
               	str	x1, [x0]
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x78              // =120
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x1, eq
               	cbnz	x1, <addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	cmp	x0, #0x30
               	cset	x1, ge
               	cbz	x1, <addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1b0
               	ldr	x1, [x0]
               	mov	x17, #0xa               // =10
               	mul	x1, x1, x17
               	adrp	x2, <page>
               	add	x2, x2, #0x170
               	ldr	x3, [x2]
               	add	x4, x3, #0x1
               	str	x4, [x2]
               	ldrb	w2, [x3]
               	add	x1, x1, x2
               	sub	x1, x1, #0x30
               	str	x1, [x0]
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	cmp	x0, #0x39
               	cset	x1, le
               	b	<addr>
               	cbz	x1, <addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x58              // =88
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x1, eq
               	b	<addr>
               	cbz	x1, <addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	adrp	x1, <page>
               	add	x1, x1, #0x170
               	ldr	x2, [x1]
               	add	x2, x2, #0x1
               	str	x2, [x1]
               	ldrb	w1, [x2]
               	str	x1, [x0]
               	cbz	x1, <addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1b0
               	ldr	x1, [x0]
               	lsl	x1, x1, #4
               	adrp	x2, <page>
               	add	x2, x2, #0x1a8
               	ldr	x3, [x2]
               	mov	x17, #0xf               // =15
               	and	x3, x3, x17
               	add	x1, x1, x3
               	ldr	x2, [x2]
               	cmp	x2, #0x41
               	b.lt	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x30
               	cset	x0, ge
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	b	<addr>
               	cbz	x1, <addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x39
               	cset	x0, le
               	cmp	x0, #0x0
               	cset	x2, ne
               	b	<addr>
               	mov	x3, #0x1                // =1
               	cbnz	x2, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x61
               	cset	x0, ge
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	b	<addr>
               	mov	x1, #0x1                // =1
               	cbnz	x3, <addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x66
               	cset	x0, le
               	cmp	x0, #0x0
               	cset	x2, ne
               	b	<addr>
               	cmp	x2, #0x0
               	cset	x3, ne
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x41
               	cset	x0, ge
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x46
               	cset	x0, le
               	cmp	x0, #0x0
               	cset	x2, ne
               	b	<addr>
               	cmp	x2, #0x0
               	cset	x1, ne
               	b	<addr>
               	mov	x3, #0x9                // =9
               	b	<addr>
               	mov	x3, #0x0                // =0
               	b	<addr>
               	add	x1, x1, x3
               	str	x1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	cmp	x0, #0x30
               	cset	x1, ge
               	cbz	x1, <addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1b0
               	ldr	x1, [x0]
               	lsl	x1, x1, #3
               	adrp	x2, <page>
               	add	x2, x2, #0x170
               	ldr	x3, [x2]
               	add	x4, x3, #0x1
               	str	x4, [x2]
               	ldrb	w2, [x3]
               	add	x1, x1, x2
               	sub	x1, x1, #0x30
               	str	x1, [x0]
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	cmp	x0, #0x37
               	cset	x1, le
               	b	<addr>
               	cbz	x1, <addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x2f              // =47
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x27
               	cset	x1, eq
               	cbnz	x1, <addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	mov	x1, #0xa0               // =160
               	str	x1, [x0]
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	cmp	x0, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0xa               // =10
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x1, ne
               	b	<addr>
               	cbz	x1, <addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x22
               	cset	x1, eq
               	b	<addr>
               	cbz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x180
               	ldr	x0, [x0]
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x3d
               	b.ne	<addr>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x170
               	ldr	x1, [x1]
               	ldrb	w1, [x1]
               	cmp	x1, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x1b0
               	adrp	x2, <page>
               	add	x2, x2, #0x170
               	ldr	x3, [x2]
               	add	x4, x3, #0x1
               	str	x4, [x2]
               	ldrb	w2, [x3]
               	str	x2, [x1]
               	cmp	x2, #0x5c
               	b.ne	<addr>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x170
               	ldr	x2, [x1]
               	add	x2, x2, #0x1
               	str	x2, [x1]
               	adrp	x1, <page>
               	add	x1, x1, #0x1a8
               	ldr	x1, [x1]
               	cmp	x1, #0x22
               	b.ne	<addr>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x170
               	ldr	x1, [x1]
               	ldrb	w1, [x1]
               	adrp	x2, <page>
               	add	x2, x2, #0x1a8
               	ldr	x2, [x2]
               	cmp	x1, x2
               	cset	x2, ne
               	b	<addr>
               	cbz	x2, <addr>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x1b0
               	adrp	x2, <page>
               	add	x2, x2, #0x170
               	ldr	x3, [x2]
               	add	x4, x3, #0x1
               	str	x4, [x2]
               	ldrb	w2, [x3]
               	str	x2, [x1]
               	cmp	x2, #0x6e
               	b.ne	<addr>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x1a8
               	ldr	x1, [x1]
               	cmp	x1, #0x22
               	b.ne	<addr>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x1b0
               	mov	x2, #0xa                // =10
               	str	x2, [x1]
               	b	<addr>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x180
               	ldr	x2, [x1]
               	add	x3, x2, #0x1
               	str	x3, [x1]
               	adrp	x1, <page>
               	add	x1, x1, #0x1b0
               	ldr	x1, [x1]
               	strb	w1, [x2]
               	b	<addr>
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, #0x1b0
               	str	x0, [x1]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	mov	x1, #0x80               // =128
               	str	x1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x3d              // =61
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x2b
               	b.ne	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	mov	x1, #0x95               // =149
               	str	x1, [x0]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	mov	x1, #0x8e               // =142
               	str	x1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x2b              // =43
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x2d
               	b.ne	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	mov	x1, #0xa2               // =162
               	str	x1, [x0]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	mov	x1, #0x9d               // =157
               	str	x1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x2d              // =45
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x21
               	b.ne	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	mov	x1, #0xa3               // =163
               	str	x1, [x0]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	mov	x1, #0x9e               // =158
               	str	x1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x3d              // =61
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x3c
               	b.ne	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	mov	x1, #0x96               // =150
               	str	x1, [x0]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x3d              // =61
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x3e
               	b.ne	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	mov	x1, #0x99               // =153
               	str	x1, [x0]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x3c              // =60
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	mov	x1, #0x9b               // =155
               	str	x1, [x0]
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	mov	x1, #0x97               // =151
               	str	x1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x3d              // =61
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x7c
               	b.ne	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	mov	x1, #0x9a               // =154
               	str	x1, [x0]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x3e              // =62
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	mov	x1, #0x9c               // =156
               	str	x1, [x0]
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	mov	x1, #0x98               // =152
               	str	x1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x7c              // =124
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x26
               	b.ne	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	mov	x1, #0x90               // =144
               	str	x1, [x0]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	mov	x1, #0x92               // =146
               	str	x1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x0, [x0]
               	ldrb	w0, [x0]
               	mov	x17, #0x26              // =38
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x5e
               	b.ne	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	mov	x1, #0x91               // =145
               	str	x1, [x0]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	mov	x1, #0x94               // =148
               	str	x1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	mov	x1, #0x93               // =147
               	str	x1, [x0]
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x25
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	mov	x1, #0xa1               // =161
               	str	x1, [x0]
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x2a
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	mov	x1, #0x9f               // =159
               	str	x1, [x0]
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x5b
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	mov	x1, #0xa4               // =164
               	str	x1, [x0]
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x3f
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	mov	x1, #0x8f               // =143
               	str	x1, [x0]
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x7e
               	cset	x0, eq
               	mov	x2, #0x1                // =1
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x3b
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	b	<addr>
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x7b
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	b	<addr>
               	mov	x2, #0x1                // =1
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x7d
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	b	<addr>
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x28
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	b	<addr>
               	mov	x2, #0x1                // =1
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x29
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	b	<addr>
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x5d
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	b	<addr>
               	mov	x2, #0x1                // =1
               	cbnz	x1, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x2c
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	b	<addr>
               	cbnz	x2, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x3a
               	cset	x2, eq
               	b	<addr>
               	cbz	x2, <addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x170
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x100
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x19, [sp, #0x20]
               	mov	x20, x0
               	adrp	x21, <page>
               	add	x21, x21, #0x1a8
               	ldr	x0, [x21]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x2ba
               	adrp	x1, <page>
               	add	x1, x1, #0x1c8
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x80
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x22, #0x1               // =1
               	str	x22, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1b0
               	ldr	x0, [x0]
               	str	x0, [x1]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	str	x22, [x0]
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x22
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1b0
               	ldr	x0, [x0]
               	str	x0, [x1]
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x8c
               	b.ne	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x22
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x180
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x1, x1, x17
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	mov	x1, #0x2                // =2
               	str	x1, [x0]
               	b	<addr>
               	bl	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x28
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x85
               	b.ne	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	ldr	x0, [x21]
               	cmp	x0, #0x8a
               	b.ne	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x2dc
               	adrp	x1, <page>
               	add	x1, x1, #0x1c8
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x86
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x9f
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	ldr	x1, [x0]
               	add	x1, x1, #0x2
               	str	x1, [x0]
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x29
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x22, x1, #0x8
               	str	x22, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	ldr	x0, [x0]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x2ff
               	adrp	x1, <page>
               	add	x1, x1, #0x1c8
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	mov	x1, #0x1                // =1
               	b	<addr>
               	mov	x1, #0x8                // =8
               	b	<addr>
               	str	x1, [x22]
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x198
               	ldr	x22, [x0]
               	bl	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x28
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x28
               	b.ne	<addr>
               	b	<addr>
               	bl	<addr>
               	mov	x23, #0x0               // =0
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x22, #0x18]
               	cmp	x0, #0x80
               	b.ne	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x29
               	b.eq	<addr>
               	mov	x0, #0x8e               // =142
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0xd                // =13
               	str	x0, [x1]
               	add	x23, x23, #0x1
               	ldr	x0, [x21]
               	cmp	x0, #0x2c
               	b.ne	<addr>
               	b	<addr>
               	bl	<addr>
               	ldr	x0, [x22, #0x18]
               	cmp	x0, #0x82
               	b.ne	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	ldr	x0, [x22, #0x28]
               	str	x0, [x1]
               	b	<addr>
               	cbz	x23, <addr>
               	b	<addr>
               	ldr	x0, [x22, #0x18]
               	cmp	x0, #0x81
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x3                // =3
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	ldr	x0, [x22, #0x28]
               	str	x0, [x1]
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x323
               	adrp	x1, <page>
               	add	x1, x1, #0x1c8
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x7                // =7
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	str	x23, [x1]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	ldr	x1, [x22, #0x20]
               	str	x1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	ldr	x0, [x22, #0x28]
               	str	x0, [x1]
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	str	x2, [x0]
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x22, #0x18]
               	cmp	x0, #0x84
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x0                // =0
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1c0
               	ldr	x0, [x0]
               	ldr	x2, [x22, #0x28]
               	sub	x0, x0, x2
               	str	x0, [x1]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x23, x1, #0x8
               	str	x23, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	ldr	x1, [x22, #0x20]
               	str	x1, [x0]
               	cmp	x1, #0x0
               	b.ne	<addr>
               	b	<addr>
               	ldr	x0, [x22, #0x18]
               	cmp	x0, #0x83
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	ldr	x0, [x22, #0x28]
               	str	x0, [x1]
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x33a
               	adrp	x1, <page>
               	add	x1, x1, #0x1c8
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	mov	x1, #0xa                // =10
               	b	<addr>
               	mov	x1, #0x9                // =9
               	b	<addr>
               	str	x1, [x23]
               	b	<addr>
               	bl	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x8a
               	cset	x22, eq
               	cbnz	x22, <addr>
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x9f
               	b.ne	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x86
               	cset	x22, eq
               	b	<addr>
               	cbz	x22, <addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x8a
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x8e               // =142
               	bl	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x29
               	b.ne	<addr>
               	b	<addr>
               	mov	x22, #0x1               // =1
               	b	<addr>
               	mov	x22, #0x0               // =0
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x9f
               	b.ne	<addr>
               	bl	<addr>
               	add	x22, x22, #0x2
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x29
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	str	x22, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x352
               	adrp	x1, <page>
               	add	x1, x1, #0x1c8
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x360
               	adrp	x1, <page>
               	add	x1, x1, #0x1c8
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	bl	<addr>
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	ldr	x0, [x0]
               	cmp	x0, #0x1
               	b.le	<addr>
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x94
               	b.ne	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	ldr	x1, [x0]
               	sub	x1, x1, #0x2
               	str	x1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x22, x1, #0x8
               	str	x22, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	ldr	x0, [x0]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x37a
               	adrp	x1, <page>
               	add	x1, x1, #0x1c8
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	mov	x1, #0xa                // =10
               	b	<addr>
               	mov	x1, #0x9                // =9
               	b	<addr>
               	str	x1, [x22]
               	b	<addr>
               	bl	<addr>
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x0, [x0]
               	ldr	x0, [x0]
               	cmp	x0, #0xa
               	cset	x22, eq
               	cbnz	x22, <addr>
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x21
               	b.ne	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x0, [x0]
               	ldr	x0, [x0]
               	cmp	x0, #0x9
               	cset	x22, eq
               	b	<addr>
               	cbz	x22, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x1, x1, x17
               	str	x1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	ldr	x1, [x0]
               	add	x1, x1, #0x2
               	str	x1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x38f
               	adrp	x1, <page>
               	add	x1, x1, #0x1c8
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	bl	<addr>
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0xd                // =13
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x3, #0x0                // =0
               	str	x3, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0x11               // =17
               	str	x0, [x1]
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	str	x2, [x0]
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x7e
               	b.ne	<addr>
               	bl	<addr>
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0xd                // =13
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	str	x3, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0xf                // =15
               	str	x0, [x1]
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	str	x2, [x0]
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x9d
               	b.ne	<addr>
               	bl	<addr>
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x9e
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0x1                // =1
               	str	x0, [x1]
               	ldr	x0, [x21]
               	cmp	x0, #0x80
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0xa2
               	cset	x22, eq
               	cbnz	x22, <addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1b0
               	ldr	x0, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	mul	x0, x0, x17
               	str	x0, [x1]
               	bl	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	adrp	x22, <page>
               	add	x22, x22, #0x188
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	str	x1, [x0]
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0x1b               // =27
               	str	x1, [x0]
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0xa3
               	cset	x22, eq
               	b	<addr>
               	cbz	x22, <addr>
               	ldr	x22, [x21]
               	bl	<addr>
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x0, [x0]
               	ldr	x0, [x0]
               	cmp	x0, #0xa
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x3c4
               	adrp	x1, <page>
               	add	x1, x1, #0x1c8
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	mov	x2, #0xd                // =13
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0xa                // =10
               	str	x0, [x1]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0xd                // =13
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x23, x1, #0x8
               	str	x23, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	ldr	x0, [x0]
               	cmp	x0, #0x2
               	b.le	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x0, [x0]
               	ldr	x0, [x0]
               	cmp	x0, #0x9
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	mov	x2, #0xd                // =13
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0x9                // =9
               	str	x0, [x1]
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x3a3
               	adrp	x1, <page>
               	add	x1, x1, #0x1c8
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	mov	x1, #0x8                // =8
               	b	<addr>
               	mov	x1, #0x1                // =1
               	b	<addr>
               	str	x1, [x23]
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	cmp	x22, #0xa2
               	b.ne	<addr>
               	mov	x2, #0x19               // =25
               	b	<addr>
               	mov	x2, #0x1a               // =26
               	b	<addr>
               	str	x2, [x1]
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	ldr	x0, [x0]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x2, #0xc                // =12
               	b	<addr>
               	mov	x2, #0xb                // =11
               	b	<addr>
               	str	x2, [x1]
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, x20
               	b.lt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	ldr	x22, [x0]
               	ldr	x0, [x21]
               	cmp	x0, #0x8e
               	b.ne	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x100
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x0, [x0]
               	ldr	x0, [x0]
               	cmp	x0, #0xa
               	cset	x23, eq
               	cbnz	x23, <addr>
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x8f
               	b.ne	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x0, [x0]
               	ldr	x0, [x0]
               	cmp	x0, #0x9
               	cset	x23, eq
               	b	<addr>
               	cbz	x23, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x0, [x0]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	b	<addr>
               	mov	x0, #0x8e               // =142
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x23, x1, #0x8
               	str	x23, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	str	x22, [x0]
               	cmp	x22, #0x0
               	b.ne	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x3d8
               	adrp	x1, <page>
               	add	x1, x1, #0x1c8
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	mov	x1, #0xc                // =12
               	b	<addr>
               	mov	x1, #0xb                // =11
               	b	<addr>
               	str	x1, [x23]
               	b	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x4                // =4
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x22, x1, #0x8
               	str	x22, [x0]
               	mov	x0, #0x8e               // =142
               	bl	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x3a
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x90
               	b.ne	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x23, <page>
               	add	x23, x23, #0x188
               	ldr	x0, [x23]
               	add	x0, x0, #0x18
               	str	x0, [x22]
               	ldr	x0, [x23]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	mov	x1, #0x2                // =2
               	str	x1, [x0]
               	ldr	x0, [x23]
               	add	x22, x0, #0x8
               	str	x22, [x23]
               	mov	x0, #0x8f               // =143
               	bl	<addr>
               	ldr	x0, [x23]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x3f6
               	adrp	x1, <page>
               	add	x1, x1, #0x1c8
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, #0x188
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0x5                // =5
               	str	x1, [x0]
               	ldr	x0, [x22]
               	add	x23, x0, #0x8
               	str	x23, [x22]
               	mov	x0, #0x91               // =145
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x91
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, #0x188
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0x4                // =4
               	str	x1, [x0]
               	ldr	x0, [x22]
               	add	x23, x0, #0x8
               	str	x23, [x22]
               	mov	x0, #0x92               // =146
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x23]
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x92
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, #0x188
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	mov	x0, #0x93               // =147
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xe                // =14
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x93
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, #0x188
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	mov	x0, #0x94               // =148
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xf                // =15
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x94
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, #0x188
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	mov	x0, #0x95               // =149
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0x10               // =16
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x95
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, #0x188
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	mov	x0, #0x97               // =151
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0x11               // =17
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x96
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, #0x188
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	mov	x0, #0x97               // =151
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0x12               // =18
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x97
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, #0x188
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	mov	x0, #0x9b               // =155
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0x13               // =19
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x98
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, #0x188
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	mov	x0, #0x9b               // =155
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0x14               // =20
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x99
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, #0x188
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	mov	x0, #0x9b               // =155
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0x15               // =21
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x9a
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, #0x188
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	mov	x0, #0x9b               // =155
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0x16               // =22
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x9b
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, #0x188
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	mov	x0, #0x9d               // =157
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0x17               // =23
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x9c
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, #0x188
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	mov	x0, #0x9d               // =157
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0x18               // =24
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x9d
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0xd                // =13
               	str	x0, [x1]
               	mov	x0, #0x9f               // =159
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	str	x22, [x0]
               	cmp	x22, #0x2
               	b.le	<addr>
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x9e
               	b.ne	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0xd                // =13
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x8                // =8
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0x1b               // =27
               	str	x0, [x1]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0x19               // =25
               	str	x0, [x1]
               	b	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0xd                // =13
               	str	x0, [x1]
               	mov	x0, #0x9f               // =159
               	bl	<addr>
               	cmp	x22, #0x2
               	cset	x23, gt
               	cbz	x23, <addr>
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x9f
               	b.ne	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	ldr	x0, [x0]
               	cmp	x22, x0
               	cset	x23, eq
               	b	<addr>
               	cbz	x23, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x1a               // =26
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0xd                // =13
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x3, #0x8                // =8
               	str	x3, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0x1c               // =28
               	str	x0, [x1]
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	str	x2, [x0]
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	str	x22, [x0]
               	cmp	x22, #0x2
               	b.le	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0xd                // =13
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x8                // =8
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x1b               // =27
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0x1a               // =26
               	str	x0, [x1]
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0x1a               // =26
               	str	x0, [x1]
               	b	<addr>
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, #0x188
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0x1b               // =27
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0xa0
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, #0x188
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0x1c               // =28
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0xa1
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x22, <page>
               	add	x22, x22, #0x188
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	mov	x0, #0xa2               // =162
               	bl	<addr>
               	ldr	x0, [x22]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	mov	x1, #0x1d               // =29
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0xa2
               	cset	x23, eq
               	cbnz	x23, <addr>
               	ldr	x0, [x21]
               	cmp	x0, #0xa3
               	cset	x23, eq
               	b	<addr>
               	cbz	x23, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x0, [x0]
               	ldr	x0, [x0]
               	cmp	x0, #0xa
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0xa4
               	b.ne	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	mov	x2, #0xd                // =13
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0xa                // =10
               	str	x0, [x1]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0xd                // =13
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x22, x1, #0x8
               	str	x22, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	ldr	x0, [x0]
               	cmp	x0, #0x2
               	b.le	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x0, [x0]
               	ldr	x0, [x0]
               	cmp	x0, #0x9
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	mov	x2, #0xd                // =13
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0x9                // =9
               	str	x0, [x1]
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x415
               	adrp	x1, <page>
               	add	x1, x1, #0x1c8
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	mov	x1, #0x8                // =8
               	b	<addr>
               	mov	x1, #0x1                // =1
               	b	<addr>
               	str	x1, [x22]
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	ldr	x0, [x21]
               	cmp	x0, #0xa2
               	b.ne	<addr>
               	mov	x2, #0x19               // =25
               	b	<addr>
               	mov	x2, #0x1a               // =26
               	b	<addr>
               	str	x2, [x1]
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	ldr	x0, [x0]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x2, #0xc                // =12
               	b	<addr>
               	mov	x2, #0xb                // =11
               	b	<addr>
               	str	x2, [x1]
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0xd                // =13
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	ldr	x0, [x0]
               	cmp	x0, #0x2
               	b.le	<addr>
               	mov	x2, #0x8                // =8
               	b	<addr>
               	mov	x2, #0x1                // =1
               	b	<addr>
               	str	x2, [x1]
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	ldr	x0, [x21]
               	cmp	x0, #0xa2
               	b.ne	<addr>
               	mov	x2, #0x1a               // =26
               	b	<addr>
               	mov	x2, #0x19               // =25
               	b	<addr>
               	str	x2, [x1]
               	bl	<addr>
               	b	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0xd                // =13
               	str	x0, [x1]
               	mov	x0, #0x8e               // =142
               	bl	<addr>
               	ldr	x0, [x21]
               	cmp	x0, #0x5d
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x46e
               	adrp	x1, <page>
               	add	x1, x1, #0x1c8
               	ldr	x1, [x1]
               	ldr	x2, [x21]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	cmp	x22, #0x2
               	b.le	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x437
               	adrp	x1, <page>
               	add	x1, x1, #0x1c8
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0xd                // =13
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x8                // =8
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0x1b               // =27
               	str	x0, [x1]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x19               // =25
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x23, x1, #0x8
               	str	x23, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1b8
               	sub	x1, x22, #0x2
               	str	x1, [x0]
               	cmp	x1, #0x0
               	b.ne	<addr>
               	b	<addr>
               	cmp	x22, #0x2
               	b.ge	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x453
               	adrp	x1, <page>
               	add	x1, x1, #0x1c8
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	mov	x1, #0xa                // =10
               	b	<addr>
               	mov	x1, #0x9                // =9
               	b	<addr>
               	str	x1, [x23]
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	adrp	x20, <page>
               	add	x20, x20, #0x1a8
               	ldr	x0, [x20]
               	cmp	x0, #0x89
               	b.ne	<addr>
               	bl	<addr>
               	ldr	x0, [x20]
               	cmp	x0, #0x28
               	b.ne	<addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x20]
               	cmp	x0, #0x8d
               	b.ne	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	mov	x0, #0x8e               // =142
               	bl	<addr>
               	ldr	x0, [x20]
               	cmp	x0, #0x29
               	b.ne	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x488
               	adrp	x1, <page>
               	add	x1, x1, #0x1c8
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x4                // =4
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x21, x1, #0x8
               	str	x21, [x0]
               	bl	<addr>
               	ldr	x0, [x20]
               	cmp	x0, #0x87
               	b.ne	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x4a1
               	adrp	x1, <page>
               	add	x1, x1, #0x1c8
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x18
               	str	x1, [x21]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x2                // =2
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x21, x1, #0x8
               	str	x21, [x0]
               	bl	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x0, [x0]
               	add	x0, x0, #0x8
               	str	x0, [x21]
               	b	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x0, [x0]
               	add	x21, x0, #0x8
               	ldr	x0, [x20]
               	cmp	x0, #0x28
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x20]
               	cmp	x0, #0x8b
               	b.ne	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	mov	x0, #0x8e               // =142
               	bl	<addr>
               	ldr	x0, [x20]
               	cmp	x0, #0x29
               	b.ne	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x4bb
               	adrp	x1, <page>
               	add	x1, x1, #0x1c8
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x20, <page>
               	add	x20, x20, #0x188
               	ldr	x0, [x20]
               	add	x0, x0, #0x8
               	str	x0, [x20]
               	mov	x1, #0x4                // =4
               	str	x1, [x0]
               	ldr	x0, [x20]
               	add	x22, x0, #0x8
               	str	x22, [x20]
               	bl	<addr>
               	ldr	x0, [x20]
               	add	x0, x0, #0x8
               	str	x0, [x20]
               	mov	x1, #0x2                // =2
               	str	x1, [x0]
               	ldr	x0, [x20]
               	add	x0, x0, #0x8
               	str	x0, [x20]
               	str	x21, [x0]
               	ldr	x0, [x20]
               	add	x0, x0, #0x8
               	str	x0, [x22]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x4d4
               	adrp	x1, <page>
               	add	x1, x1, #0x1c8
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	bl	<addr>
               	ldr	x0, [x20]
               	cmp	x0, #0x3b
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x20]
               	cmp	x0, #0x7b
               	b.ne	<addr>
               	b	<addr>
               	mov	x0, #0x8e               // =142
               	bl	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0x8                // =8
               	str	x0, [x1]
               	ldr	x0, [x20]
               	cmp	x0, #0x3b
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x4ee
               	adrp	x1, <page>
               	add	x1, x1, #0x1c8
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	ldr	x0, [x20]
               	cmp	x0, #0x3b
               	b.ne	<addr>
               	b	<addr>
               	ldr	x0, [x20]
               	cmp	x0, #0x7d
               	b.eq	<addr>
               	bl	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x8e               // =142
               	bl	<addr>
               	ldr	x0, [x20]
               	cmp	x0, #0x3b
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x506
               	adrp	x1, <page>
               	add	x1, x1, #0x1c8
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x130
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	str	x27, [sp, #0x38]
               	str	x19, [sp, #0x40]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x21, x0, x17
               	add	x22, x1, #0x8
               	cmp	x21, #0x0
               	cset	x0, gt
               	mov	x20, #0x0               // =0
               	cbz	x0, <addr>
               	ldr	x0, [x22]
               	ldrb	w0, [x0]
               	mov	x17, #0x2d              // =45
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x20, ne
               	b	<addr>
               	cbz	x20, <addr>
               	ldr	x0, [x22]
               	ldrb	w0, [x0, #0x1]
               	mov	x17, #0x73              // =115
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x20, eq
               	b	<addr>
               	cbz	x20, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1d0
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x21, x21, x17
               	add	x22, x22, #0x8
               	b	<addr>
               	cmp	x21, #0x0
               	cset	x0, gt
               	mov	x20, #0x0               // =0
               	cbz	x0, <addr>
               	ldr	x0, [x22]
               	ldrb	w0, [x0]
               	mov	x17, #0x2d              // =45
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x20, ne
               	b	<addr>
               	cbz	x20, <addr>
               	ldr	x0, [x22]
               	ldrb	w0, [x0, #0x1]
               	mov	x17, #0x64              // =100
               	eor	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	and	x0, x0, x17
               	cmp	x0, #0x0
               	cset	x20, eq
               	b	<addr>
               	cbz	x20, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1d8
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x21, x21, x17
               	add	x22, x22, #0x8
               	b	<addr>
               	cmp	x21, #0x1
               	b.ge	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x51e
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x22]
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	cmp	x20, #0x0
               	b.ge	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x53c
               	ldr	x1, [x22]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x23, #0x40000           // =262144
               	adrp	x24, <page>
               	add	x24, x24, #0x1a0
               	mov	x0, x23
               	bl	<addr>
               	str	x0, [x24]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x550
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x24, <page>
               	add	x24, x24, #0x190
               	adrp	x25, <page>
               	add	x25, x25, #0x188
               	mov	x0, x23
               	bl	<addr>
               	str	x0, [x25]
               	str	x0, [x24]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x572
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x24, <page>
               	add	x24, x24, #0x180
               	mov	x0, x23
               	bl	<addr>
               	str	x0, [x24]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x592
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, x23
               	bl	<addr>
               	mov	x24, x0
               	cmp	x24, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x5b2
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x1a0
               	ldr	x0, [x0]
               	mov	x25, #0x0               // =0
               	mov	x1, x25
               	mov	x2, x23
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x0, [x0]
               	mov	x1, x25
               	mov	x2, x23
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x180
               	ldr	x0, [x0]
               	mov	x1, x25
               	mov	x2, x23
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	adrp	x1, <page>
               	add	x1, x1, #0x5d3
               	str	x1, [x0]
               	mov	x25, #0x86              // =134
               	b	<addr>
               	cmp	x25, #0x8d
               	b.gt	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x198
               	ldr	x0, [x0]
               	add	x1, x25, #0x1
               	str	x25, [x0]
               	mov	x25, x1
               	b	<addr>
               	mov	x25, #0x1e              // =30
               	b	<addr>
               	cmp	x25, #0x26
               	b.gt	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x198
               	ldr	x1, [x0]
               	mov	x2, #0x82               // =130
               	str	x2, [x1, #0x18]
               	ldr	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1, #0x20]
               	ldr	x0, [x0]
               	add	x1, x25, #0x1
               	str	x25, [x0, #0x28]
               	mov	x25, x1
               	b	<addr>
               	bl	<addr>
               	adrp	x25, <page>
               	add	x25, x25, #0x198
               	ldr	x0, [x25]
               	mov	x1, #0x86               // =134
               	str	x1, [x0]
               	bl	<addr>
               	ldr	x25, [x25]
               	adrp	x26, <page>
               	add	x26, x26, #0x178
               	adrp	x27, <page>
               	add	x27, x27, #0x170
               	mov	x0, x23
               	bl	<addr>
               	str	x0, [x27]
               	str	x0, [x26]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x63d
               	mov	x1, x23
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x1, [x0]
               	sub	x2, x23, #0x1
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x26, x0
               	cmp	x26, #0x0
               	b.gt	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x65f
               	mov	x1, x26
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x170
               	ldr	x0, [x0]
               	add	x0, x0, x26
               	mov	x1, #0x0                // =0
               	strb	w1, [x0]
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	adrp	x0, <page>
               	add	x0, x0, #0x1c8
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	bl	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cbz	x0, <addr>
               	mov	x20, #0x1               // =1
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x8a
               	b.ne	<addr>
               	b	<addr>
               	ldr	x25, [x25, #0x28]
               	cmp	x25, #0x0
               	b.ne	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x86
               	b.ne	<addr>
               	bl	<addr>
               	mov	x20, #0x0               // =0
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x88
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x7b
               	b.eq	<addr>
               	b	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x7b
               	b.ne	<addr>
               	bl	<addr>
               	mov	x26, #0x0               // =0
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x7d
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x85
               	b.eq	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x673
               	adrp	x1, <page>
               	add	x1, x1, #0x1c8
               	ldr	x1, [x1]
               	adrp	x2, <page>
               	add	x2, x2, #0x1a8
               	ldr	x2, [x2]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x8e
               	b.ne	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x80
               	b.eq	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x198
               	ldr	x1, [x0]
               	mov	x2, #0x80               // =128
               	str	x2, [x1, #0x18]
               	ldr	x1, [x0]
               	mov	x2, #0x1                // =1
               	str	x2, [x1, #0x20]
               	ldr	x0, [x0]
               	add	x26, x27, #0x1
               	str	x27, [x0, #0x28]
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x2c
               	b.ne	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x68f
               	adrp	x1, <page>
               	add	x1, x1, #0x1c8
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x1b0
               	ldr	x27, [x0]
               	bl	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x3b
               	cset	x26, ne
               	cbz	x26, <addr>
               	b	<addr>
               	mov	x26, x20
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x7d
               	cset	x26, ne
               	b	<addr>
               	cbz	x26, <addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x9f
               	b.ne	<addr>
               	bl	<addr>
               	add	x26, x26, #0x2
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x85
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x6a9
               	adrp	x1, <page>
               	add	x1, x1, #0x1c8
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x198
               	ldr	x0, [x0]
               	ldr	x0, [x0, #0x18]
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x6c5
               	adrp	x1, <page>
               	add	x1, x1, #0x1c8
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x198
               	ldr	x0, [x0]
               	str	x26, [x0, #0x20]
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x28
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x198
               	ldr	x1, [x0]
               	mov	x2, #0x81               // =129
               	str	x2, [x1, #0x18]
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, #0x188
               	ldr	x1, [x1]
               	add	x1, x1, #0x8
               	str	x1, [x0, #0x28]
               	bl	<addr>
               	mov	x26, #0x0               // =0
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x2c
               	b.ne	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x198
               	ldr	x1, [x0]
               	mov	x2, #0x83               // =131
               	str	x2, [x1, #0x18]
               	ldr	x0, [x0]
               	adrp	x1, <page>
               	add	x1, x1, #0x180
               	ldr	x2, [x1]
               	str	x2, [x0, #0x28]
               	ldr	x0, [x1]
               	add	x0, x0, #0x8
               	str	x0, [x1]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x29
               	b.eq	<addr>
               	mov	x27, #0x1               // =1
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x8a
               	b.ne	<addr>
               	b	<addr>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x7b
               	b.eq	<addr>
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x86
               	b.ne	<addr>
               	bl	<addr>
               	mov	x27, #0x0               // =0
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x9f
               	b.ne	<addr>
               	bl	<addr>
               	add	x27, x27, #0x2
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x85
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x6e6
               	adrp	x1, <page>
               	add	x1, x1, #0x1c8
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x198
               	ldr	x0, [x0]
               	ldr	x0, [x0, #0x18]
               	cmp	x0, #0x84
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x705
               	adrp	x1, <page>
               	add	x1, x1, #0x1c8
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x198
               	ldr	x1, [x0]
               	ldr	x2, [x0]
               	ldr	x2, [x2, #0x18]
               	str	x2, [x1, #0x30]
               	ldr	x1, [x0]
               	mov	x2, #0x84               // =132
               	str	x2, [x1, #0x18]
               	ldr	x1, [x0]
               	ldr	x2, [x0]
               	ldr	x2, [x2, #0x20]
               	str	x2, [x1, #0x38]
               	ldr	x1, [x0]
               	str	x27, [x1, #0x20]
               	ldr	x1, [x0]
               	ldr	x2, [x0]
               	ldr	x2, [x2, #0x28]
               	str	x2, [x1, #0x40]
               	ldr	x0, [x0]
               	add	x27, x26, #0x1
               	str	x26, [x0, #0x28]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x2c
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	mov	x26, x27
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x729
               	adrp	x1, <page>
               	add	x1, x1, #0x1c8
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x1c0
               	add	x26, x26, #0x1
               	str	x26, [x0]
               	bl	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x8a
               	cset	x27, eq
               	cbnz	x27, <addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x8a
               	b.ne	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x2, #0x6                // =6
               	str	x2, [x1]
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0x1c0
               	ldr	x0, [x0]
               	sub	x0, x26, x0
               	str	x0, [x1]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x86
               	cset	x27, eq
               	b	<addr>
               	cbz	x27, <addr>
               	b	<addr>
               	mov	x20, #0x1               // =1
               	b	<addr>
               	mov	x20, #0x0               // =0
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x3b
               	b.eq	<addr>
               	mov	x27, x20
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x9f
               	b.ne	<addr>
               	bl	<addr>
               	add	x27, x27, #0x2
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x85
               	b.eq	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x746
               	adrp	x1, <page>
               	add	x1, x1, #0x1c8
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x198
               	ldr	x0, [x0]
               	ldr	x0, [x0, #0x18]
               	cmp	x0, #0x84
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x761
               	adrp	x1, <page>
               	add	x1, x1, #0x1c8
               	ldr	x1, [x1]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x198
               	ldr	x1, [x0]
               	ldr	x2, [x0]
               	ldr	x2, [x2, #0x18]
               	str	x2, [x1, #0x30]
               	ldr	x1, [x0]
               	mov	x2, #0x84               // =132
               	str	x2, [x1, #0x18]
               	ldr	x1, [x0]
               	ldr	x2, [x0]
               	ldr	x2, [x2, #0x20]
               	str	x2, [x1, #0x38]
               	ldr	x1, [x0]
               	str	x27, [x1, #0x20]
               	ldr	x1, [x0]
               	ldr	x2, [x0]
               	ldr	x2, [x2, #0x28]
               	str	x2, [x1, #0x40]
               	ldr	x0, [x0]
               	add	x26, x26, #0x1
               	str	x26, [x0, #0x28]
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x2c
               	b.ne	<addr>
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x1a8
               	ldr	x0, [x0]
               	cmp	x0, #0x7d
               	b.eq	<addr>
               	bl	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x188
               	ldr	x1, [x0]
               	add	x1, x1, #0x8
               	str	x1, [x0]
               	mov	x0, #0x8                // =8
               	str	x0, [x1]
               	adrp	x0, <page>
               	add	x0, x0, #0x198
               	adrp	x1, <page>
               	add	x1, x1, #0x1a0
               	ldr	x1, [x1]
               	str	x1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x198
               	ldr	x0, [x0]
               	ldr	x0, [x0]
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x198
               	ldr	x0, [x0]
               	ldr	x0, [x0, #0x18]
               	cmp	x0, #0x84
               	b.ne	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x198
               	ldr	x1, [x0]
               	ldr	x2, [x0]
               	ldr	x2, [x2, #0x30]
               	str	x2, [x1, #0x18]
               	ldr	x1, [x0]
               	ldr	x2, [x0]
               	ldr	x2, [x2, #0x38]
               	str	x2, [x1, #0x20]
               	ldr	x1, [x0]
               	ldr	x0, [x0]
               	ldr	x0, [x0, #0x40]
               	str	x0, [x1, #0x28]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x198
               	ldr	x1, [x0]
               	add	x1, x1, #0x48
               	str	x1, [x0]
               	b	<addr>
               	bl	<addr>
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x781
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x1d0
               	ldr	x0, [x0]
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x23, x24, x23
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x0, x23, x17
               	mov	x1, #0x26               // =38
               	str	x1, [x0]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x0, x0, x17
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x1, x0, x17
               	str	x21, [x1]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x1, x1, x17
               	str	x22, [x1]
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x22, x1, x17
               	str	x0, [x22]
               	mov	x20, #0x0               // =0
               	b	<addr>
               	b	<addr>
               	add	x24, x25, #0x8
               	ldr	x25, [x25]
               	add	x20, x20, #0x1
               	adrp	x0, <page>
               	add	x0, x0, #0x1d8
               	ldr	x0, [x0]
               	cbz	x0, <addr>
               	b	<addr>
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x795
               	adrp	x1, <page>
               	add	x1, x1, #0x79e
               	mov	x17, #0x5               // =5
               	mul	x2, x25, x17
               	add	x2, x1, x2
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x25, #0x7
               	b.gt	<addr>
               	b	<addr>
               	cmp	x25, #0x0
               	b.ne	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x862
               	ldr	x1, [x24]
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x867
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	add	x25, x24, #0x8
               	ldr	x0, [x24]
               	lsl	x0, x0, #3
               	add	x21, x23, x0
               	stur	x21, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0x1
               	b.ne	<addr>
               	add	x25, x24, #0x8
               	ldr	x21, [x24]
               	stur	x21, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0x2
               	b.ne	<addr>
               	ldr	x25, [x24]
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0x3
               	b.ne	<addr>
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x22, x22, x17
               	add	x0, x24, #0x8
               	str	x0, [x22]
               	ldr	x25, [x24]
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0x4
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x48]
               	cbz	x0, <addr>
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0x5
               	b.ne	<addr>
               	b	<addr>
               	add	x25, x24, #0x8
               	b	<addr>
               	ldr	x25, [x24]
               	b	<addr>
               	b	<addr>
               	ldur	x0, [x29, #-0x48]
               	cbz	x0, <addr>
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0x6
               	b.ne	<addr>
               	b	<addr>
               	ldr	x25, [x24]
               	b	<addr>
               	add	x25, x24, #0x8
               	b	<addr>
               	b	<addr>
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x0, x22, x17
               	str	x23, [x0]
               	add	x25, x24, #0x8
               	ldr	x1, [x24]
               	lsl	x1, x1, #3
               	sub	x22, x0, x1
               	mov	x23, x0
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0x7
               	b.ne	<addr>
               	add	x25, x24, #0x8
               	ldr	x0, [x24]
               	lsl	x0, x0, #3
               	add	x22, x22, x0
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0x8
               	b.ne	<addr>
               	add	x0, x23, #0x8
               	ldr	x23, [x23]
               	add	x22, x0, #0x8
               	ldr	x25, [x0]
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0x9
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x48]
               	ldr	x21, [x0]
               	stur	x21, [x29, #-0x48]
               	b	<addr>
               	mov	x25, x24
               	b	<addr>
               	cmp	x25, #0xa
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x48]
               	ldrb	w21, [x0]
               	stur	x21, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0xb
               	b.ne	<addr>
               	add	x0, x22, #0x8
               	ldr	x1, [x22]
               	ldur	x2, [x29, #-0x48]
               	str	x2, [x1]
               	mov	x22, x0
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0xc
               	b.ne	<addr>
               	add	x0, x22, #0x8
               	ldr	x1, [x22]
               	ldur	x21, [x29, #-0x48]
               	strb	w21, [x1]
               	stur	x21, [x29, #-0x48]
               	mov	x22, x0
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0xd
               	b.ne	<addr>
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x22, x22, x17
               	ldur	x0, [x29, #-0x48]
               	str	x0, [x22]
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0xe
               	b.ne	<addr>
               	add	x0, x22, #0x8
               	ldr	x1, [x22]
               	ldur	x2, [x29, #-0x48]
               	orr	x21, x1, x2
               	stur	x21, [x29, #-0x48]
               	mov	x22, x0
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0xf
               	b.ne	<addr>
               	add	x0, x22, #0x8
               	ldr	x1, [x22]
               	ldur	x2, [x29, #-0x48]
               	eor	x21, x1, x2
               	stur	x21, [x29, #-0x48]
               	mov	x22, x0
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0x10
               	b.ne	<addr>
               	add	x0, x22, #0x8
               	ldr	x1, [x22]
               	ldur	x2, [x29, #-0x48]
               	and	x21, x1, x2
               	stur	x21, [x29, #-0x48]
               	mov	x22, x0
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0x11
               	b.ne	<addr>
               	add	x0, x22, #0x8
               	ldr	x1, [x22]
               	ldur	x2, [x29, #-0x48]
               	cmp	x1, x2
               	cset	x21, eq
               	stur	x21, [x29, #-0x48]
               	mov	x22, x0
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0x12
               	b.ne	<addr>
               	add	x0, x22, #0x8
               	ldr	x1, [x22]
               	ldur	x2, [x29, #-0x48]
               	cmp	x1, x2
               	cset	x21, ne
               	stur	x21, [x29, #-0x48]
               	mov	x22, x0
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0x13
               	b.ne	<addr>
               	add	x0, x22, #0x8
               	ldr	x1, [x22]
               	ldur	x2, [x29, #-0x48]
               	cmp	x1, x2
               	cset	x21, lt
               	stur	x21, [x29, #-0x48]
               	mov	x22, x0
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0x14
               	b.ne	<addr>
               	add	x0, x22, #0x8
               	ldr	x1, [x22]
               	ldur	x2, [x29, #-0x48]
               	cmp	x1, x2
               	cset	x21, gt
               	stur	x21, [x29, #-0x48]
               	mov	x22, x0
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0x15
               	b.ne	<addr>
               	add	x0, x22, #0x8
               	ldr	x1, [x22]
               	ldur	x2, [x29, #-0x48]
               	cmp	x1, x2
               	cset	x21, le
               	stur	x21, [x29, #-0x48]
               	mov	x22, x0
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0x16
               	b.ne	<addr>
               	add	x0, x22, #0x8
               	ldr	x1, [x22]
               	ldur	x2, [x29, #-0x48]
               	cmp	x1, x2
               	cset	x21, ge
               	stur	x21, [x29, #-0x48]
               	mov	x22, x0
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0x17
               	b.ne	<addr>
               	add	x0, x22, #0x8
               	ldr	x1, [x22]
               	ldur	x2, [x29, #-0x48]
               	lsl	x21, x1, x2
               	stur	x21, [x29, #-0x48]
               	mov	x22, x0
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0x18
               	b.ne	<addr>
               	add	x0, x22, #0x8
               	ldr	x1, [x22]
               	ldur	x2, [x29, #-0x48]
               	asr	x21, x1, x2
               	stur	x21, [x29, #-0x48]
               	mov	x22, x0
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0x19
               	b.ne	<addr>
               	add	x0, x22, #0x8
               	ldr	x1, [x22]
               	ldur	x2, [x29, #-0x48]
               	add	x21, x1, x2
               	stur	x21, [x29, #-0x48]
               	mov	x22, x0
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0x1a
               	b.ne	<addr>
               	add	x0, x22, #0x8
               	ldr	x1, [x22]
               	ldur	x2, [x29, #-0x48]
               	sub	x21, x1, x2
               	stur	x21, [x29, #-0x48]
               	mov	x22, x0
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0x1b
               	b.ne	<addr>
               	add	x0, x22, #0x8
               	ldr	x1, [x22]
               	ldur	x2, [x29, #-0x48]
               	mul	x21, x1, x2
               	stur	x21, [x29, #-0x48]
               	mov	x22, x0
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0x1c
               	b.ne	<addr>
               	add	x0, x22, #0x8
               	ldr	x1, [x22]
               	ldur	x2, [x29, #-0x48]
               	sdiv	x21, x1, x2
               	stur	x21, [x29, #-0x48]
               	mov	x22, x0
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0x1d
               	b.ne	<addr>
               	add	x0, x22, #0x8
               	ldr	x1, [x22]
               	ldur	x2, [x29, #-0x48]
               	sdiv	x17, x1, x2
               	msub	x21, x17, x2, x1
               	stur	x21, [x29, #-0x48]
               	mov	x22, x0
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0x1e
               	b.ne	<addr>
               	ldr	x0, [x22, #0x8]
               	ldr	x1, [x22]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x21, x0
               	stur	x21, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0x1f
               	b.ne	<addr>
               	ldr	x0, [x22, #0x10]
               	ldr	x1, [x22, #0x8]
               	ldr	x2, [x22]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x21, x0
               	stur	x21, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0x20
               	b.ne	<addr>
               	ldr	x0, [x22]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x21, x0
               	stur	x21, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0x21
               	b.ne	<addr>
               	ldr	x0, [x24, #0x8]
               	lsl	x0, x0, #3
               	add	x0, x22, x0
               	mov	x17, #0xfff8            // =65528
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x1, x0, x17
               	ldr	x1, [x1]
               	mov	x17, #0xfff0            // =65520
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x2, x0, x17
               	ldr	x2, [x2]
               	mov	x17, #0xffe8            // =65512
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x3, x0, x17
               	ldr	x3, [x3]
               	mov	x17, #0xffe0            // =65504
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x4, x0, x17
               	ldr	x4, [x4]
               	mov	x17, #0xffd8            // =65496
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x5, x0, x17
               	ldr	x5, [x5]
               	mov	x17, #0xffd0            // =65488
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	add	x0, x0, x17
               	ldr	x0, [x0]
               	mov	x16, x1
               	mov	x1, x2
               	mov	x2, x3
               	mov	x3, x4
               	mov	x4, x5
               	mov	x5, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x21, x0
               	stur	x21, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0x22
               	b.ne	<addr>
               	ldr	x0, [x22]
               	bl	<addr>
               	mov	x21, x0
               	stur	x21, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0x23
               	b.ne	<addr>
               	ldr	x0, [x22]
               	bl	<addr>
               	sxtw	x0, w0
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0x24
               	b.ne	<addr>
               	ldr	x0, [x22, #0x10]
               	ldr	x1, [x22, #0x8]
               	ldr	x2, [x22]
               	bl	<addr>
               	mov	x21, x0
               	stur	x21, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0x25
               	b.ne	<addr>
               	ldr	x0, [x22, #0x10]
               	ldr	x1, [x22, #0x8]
               	ldr	x2, [x22]
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x21, x0
               	stur	x21, [x29, #-0x48]
               	b	<addr>
               	b	<addr>
               	cmp	x25, #0x26
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x869
               	ldr	x1, [x22]
               	mov	x2, x20
               	bl	<addr>
               	sxtw	x0, w0
               	ldr	x0, [x22]
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0x87e
               	mov	x1, x25
               	mov	x2, x20
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x19, [sp, #0x40]
               	add	sp, sp, #0x130
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x27, x26
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
