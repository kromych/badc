
quicksort.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2c0              // =704
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	ldrsw	x2, [x0]
               	ldrsw	x3, [x1]
               	str	w3, [x0]
               	str	w2, [x1]
               	mov	x0, #0x0                // =0
               	ret

<partition>:
               	mov	x3, x1
               	mov	x7, x2
               	sxtw	x3, w3
               	sxtw	x7, w7
               	ldrsw	x5, [x0, x7, lsl #2]
               	sub	x1, x3, #0x1
               	b	<addr>
               	ldrsw	x4, [x0, x2, lsl #2]
               	cmp	x4, x5
               	b.gt	<addr>
               	add	x1, x1, #0x1
               	sxtw	x4, w1
               	ldrsw	x6, [x0, x4, lsl #2]
               	ldrsw	x8, [x0, x2, lsl #2]
               	str	w8, [x0, x4, lsl #2]
               	str	w6, [x0, x2, lsl #2]
               	b	<addr>
               	b	<addr>
               	add	x3, x2, #0x1
               	sxtw	x2, w3
               	cmp	x2, x7
               	b.lt	<addr>
               	add	x2, x1, #0x1
               	sxtw	x2, w2
               	ldrsw	x3, [x0, x2, lsl #2]
               	ldrsw	x4, [x0, x7, lsl #2]
               	str	w4, [x0, x2, lsl #2]
               	str	w3, [x0, x7, lsl #2]
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret

<quicksort>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x20, x0
               	mov	x22, x2
               	mov	x8, x1
               	sxtw	x8, w8
               	sxtw	x22, w22
               	cmp	x8, x22
               	b.ge	<addr>
               	sxtw	x2, w8
               	sxtw	x6, w22
               	ldrsw	x4, [x20, x6, lsl #2]
               	sub	x0, x2, #0x1
               	b	<addr>
               	ldrsw	x3, [x20, x1, lsl #2]
               	cmp	x3, x4
               	b.gt	<addr>
               	add	x0, x0, #0x1
               	sxtw	x3, w0
               	ldrsw	x5, [x20, x3, lsl #2]
               	ldrsw	x7, [x20, x1, lsl #2]
               	str	w7, [x20, x3, lsl #2]
               	str	w5, [x20, x1, lsl #2]
               	b	<addr>
               	b	<addr>
               	add	x2, x1, #0x1
               	sxtw	x1, w2
               	cmp	x1, x6
               	b.lt	<addr>
               	add	x1, x0, #0x1
               	sxtw	x1, w1
               	ldrsw	x2, [x20, x1, lsl #2]
               	ldrsw	x3, [x20, x6, lsl #2]
               	str	w3, [x20, x1, lsl #2]
               	str	w2, [x20, x6, lsl #2]
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	sxtw	x21, w1
               	sub	x2, x21, #0x1
               	mov	x0, x20
               	mov	x1, x8
               	bl	<addr>
               	add	x1, x21, #0x1
               	mov	x0, x20
               	mov	x2, x22
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x90]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	str	x19, [sp, #0x50]
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	mov	x0, #0x14               // =20
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0xc                // =12
               	str	w0, [x20]
               	mov	x0, #0x7                // =7
               	str	w0, [x20, #0x4]
               	mov	x0, #0xf                // =15
               	str	w0, [x20, #0x8]
               	mov	x0, #0x5                // =5
               	str	w0, [x20, #0xc]
               	mov	x0, #0xa                // =10
               	str	w0, [x20, #0x10]
               	mov	x2, #0x0                // =0
               	ldrsw	x4, [x20, #0x10]
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	b	<addr>
               	ldrsw	x3, [x20, x1, lsl #2]
               	cmp	x3, x4
               	b.gt	<addr>
               	add	x0, x0, #0x1
               	sxtw	x3, w0
               	ldrsw	x5, [x20, x3, lsl #2]
               	ldrsw	x6, [x20, x1, lsl #2]
               	str	w6, [x20, x3, lsl #2]
               	str	w5, [x20, x1, lsl #2]
               	b	<addr>
               	b	<addr>
               	add	x2, x1, #0x1
               	sxtw	x1, w2
               	cmp	x1, #0x4
               	b.lt	<addr>
               	add	x1, x0, #0x1
               	sxtw	x1, w1
               	ldrsw	x2, [x20, x1, lsl #2]
               	ldrsw	x3, [x20, #0x10]
               	str	w3, [x20, x1, lsl #2]
               	str	w2, [x20, #0x10]
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	sxtw	x23, w1
               	sub	x0, x23, #0x1
               	sxtw	x0, w0
               	sxtw	x28, w0
               	cmp	x28, #0x0
               	b.le	<addr>
               	mov	x2, #0x0                // =0
               	sxtw	x6, w28
               	ldrsw	x4, [x20, x6, lsl #2]
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	b	<addr>
               	ldrsw	x3, [x20, x1, lsl #2]
               	cmp	x3, x4
               	b.gt	<addr>
               	add	x0, x0, #0x1
               	sxtw	x3, w0
               	ldrsw	x5, [x20, x3, lsl #2]
               	ldrsw	x7, [x20, x1, lsl #2]
               	str	w7, [x20, x3, lsl #2]
               	str	w5, [x20, x1, lsl #2]
               	b	<addr>
               	b	<addr>
               	add	x2, x1, #0x1
               	sxtw	x1, w2
               	cmp	x1, x6
               	b.lt	<addr>
               	add	x1, x0, #0x1
               	sxtw	x1, w1
               	ldrsw	x2, [x20, x1, lsl #2]
               	ldrsw	x3, [x20, x6, lsl #2]
               	str	w3, [x20, x1, lsl #2]
               	str	w2, [x20, x6, lsl #2]
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	sxtw	x24, w1
               	sub	x0, x24, #0x1
               	sxtw	x0, w0
               	sxtw	x16, w0
               	str	x16, [sp, #0x78]
               	ldr	x16, [sp, #0x78]
               	cmp	x16, #0x0
               	b.le	<addr>
               	mov	x2, #0x0                // =0
               	ldr	x16, [sp, #0x78]
               	sxtw	x6, w16
               	ldrsw	x4, [x20, x6, lsl #2]
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	b	<addr>
               	ldrsw	x3, [x20, x1, lsl #2]
               	cmp	x3, x4
               	b.gt	<addr>
               	add	x0, x0, #0x1
               	sxtw	x3, w0
               	ldrsw	x5, [x20, x3, lsl #2]
               	ldrsw	x7, [x20, x1, lsl #2]
               	str	w7, [x20, x3, lsl #2]
               	str	w5, [x20, x1, lsl #2]
               	b	<addr>
               	b	<addr>
               	add	x2, x1, #0x1
               	sxtw	x1, w2
               	cmp	x1, x6
               	b.lt	<addr>
               	add	x1, x0, #0x1
               	sxtw	x1, w1
               	ldrsw	x2, [x20, x1, lsl #2]
               	ldrsw	x3, [x20, x6, lsl #2]
               	str	w3, [x20, x1, lsl #2]
               	str	w2, [x20, x6, lsl #2]
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	sxtw	x25, w1
               	sub	x0, x25, #0x1
               	sxtw	x0, w0
               	sxtw	x16, w0
               	str	x16, [sp, #0x70]
               	ldr	x16, [sp, #0x70]
               	cmp	x16, #0x0
               	b.le	<addr>
               	mov	x2, #0x0                // =0
               	ldr	x16, [sp, #0x70]
               	sxtw	x6, w16
               	ldrsw	x4, [x20, x6, lsl #2]
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	b	<addr>
               	ldrsw	x3, [x20, x1, lsl #2]
               	cmp	x3, x4
               	b.gt	<addr>
               	add	x0, x0, #0x1
               	sxtw	x3, w0
               	ldrsw	x5, [x20, x3, lsl #2]
               	ldrsw	x7, [x20, x1, lsl #2]
               	str	w7, [x20, x3, lsl #2]
               	str	w5, [x20, x1, lsl #2]
               	b	<addr>
               	b	<addr>
               	add	x2, x1, #0x1
               	sxtw	x1, w2
               	cmp	x1, x6
               	b.lt	<addr>
               	add	x1, x0, #0x1
               	sxtw	x1, w1
               	ldrsw	x2, [x20, x1, lsl #2]
               	ldrsw	x3, [x20, x6, lsl #2]
               	str	w3, [x20, x1, lsl #2]
               	str	w2, [x20, x6, lsl #2]
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	sxtw	x22, w1
               	sub	x0, x22, #0x1
               	sxtw	x0, w0
               	sxtw	x21, w0
               	cmp	x21, #0x0
               	b.le	<addr>
               	mov	x2, #0x0                // =0
               	sxtw	x6, w21
               	ldrsw	x4, [x20, x6, lsl #2]
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	b	<addr>
               	ldrsw	x3, [x20, x1, lsl #2]
               	cmp	x3, x4
               	b.gt	<addr>
               	add	x0, x0, #0x1
               	sxtw	x3, w0
               	ldrsw	x5, [x20, x3, lsl #2]
               	ldrsw	x7, [x20, x1, lsl #2]
               	str	w7, [x20, x3, lsl #2]
               	str	w5, [x20, x1, lsl #2]
               	b	<addr>
               	b	<addr>
               	add	x2, x1, #0x1
               	sxtw	x1, w2
               	cmp	x1, x6
               	b.lt	<addr>
               	add	x1, x0, #0x1
               	sxtw	x1, w1
               	ldrsw	x2, [x20, x1, lsl #2]
               	ldrsw	x3, [x20, x6, lsl #2]
               	str	w3, [x20, x1, lsl #2]
               	str	w2, [x20, x6, lsl #2]
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	sxtw	x26, w1
               	sub	x0, x26, #0x1
               	sxtw	x16, w0
               	str	x16, [sp, #0x68]
               	mov	x16, #0x0               // =0
               	str	x16, [sp, #0x60]
               	ldr	x16, [sp, #0x68]
               	sxtw	x0, w16
               	cmp	x0, #0x0
               	b.le	<addr>
               	mov	x0, x20
               	ldr	x1, [sp, #0x60]
               	ldr	x2, [sp, #0x68]
               	bl	<addr>
               	mov	x27, x0
               	sub	x2, x27, #0x1
               	mov	x0, x20
               	ldr	x1, [sp, #0x60]
               	bl	<addr>
               	add	x1, x27, #0x1
               	mov	x0, x20
               	ldr	x2, [sp, #0x68]
               	bl	<addr>
               	add	x0, x26, #0x1
               	sxtw	x27, w0
               	sxtw	x0, w27
               	sxtw	x1, w21
               	cmp	x0, x1
               	b.ge	<addr>
               	mov	x0, x20
               	mov	x2, x21
               	mov	x1, x27
               	bl	<addr>
               	mov	x26, x0
               	sub	x2, x26, #0x1
               	mov	x0, x20
               	mov	x1, x27
               	bl	<addr>
               	add	x1, x26, #0x1
               	mov	x0, x20
               	mov	x2, x21
               	bl	<addr>
               	add	x0, x22, #0x1
               	sxtw	x0, w0
               	sxtw	x21, w0
               	ldr	x16, [sp, #0x70]
               	sxtw	x22, w16
               	cmp	x21, x22
               	b.ge	<addr>
               	sxtw	x2, w21
               	sxtw	x6, w22
               	ldrsw	x4, [x20, x6, lsl #2]
               	sub	x0, x2, #0x1
               	b	<addr>
               	ldrsw	x3, [x20, x1, lsl #2]
               	cmp	x3, x4
               	b.gt	<addr>
               	add	x0, x0, #0x1
               	sxtw	x3, w0
               	ldrsw	x5, [x20, x3, lsl #2]
               	ldrsw	x7, [x20, x1, lsl #2]
               	str	w7, [x20, x3, lsl #2]
               	str	w5, [x20, x1, lsl #2]
               	b	<addr>
               	b	<addr>
               	add	x2, x1, #0x1
               	sxtw	x1, w2
               	cmp	x1, x6
               	b.lt	<addr>
               	add	x1, x0, #0x1
               	sxtw	x1, w1
               	ldrsw	x2, [x20, x1, lsl #2]
               	ldrsw	x3, [x20, x6, lsl #2]
               	str	w3, [x20, x1, lsl #2]
               	str	w2, [x20, x6, lsl #2]
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	sxtw	x26, w1
               	sub	x0, x26, #0x1
               	sxtw	x16, w0
               	str	x16, [sp, #0x70]
               	sxtw	x0, w21
               	ldr	x16, [sp, #0x70]
               	sxtw	x1, w16
               	cmp	x0, x1
               	b.ge	<addr>
               	mov	x0, x20
               	mov	x1, x21
               	ldr	x2, [sp, #0x70]
               	bl	<addr>
               	mov	x27, x0
               	sub	x2, x27, #0x1
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	add	x1, x27, #0x1
               	mov	x0, x20
               	ldr	x2, [sp, #0x70]
               	bl	<addr>
               	add	x0, x26, #0x1
               	sxtw	x26, w0
               	sxtw	x0, w26
               	sxtw	x1, w22
               	cmp	x0, x1
               	b.ge	<addr>
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x26
               	bl	<addr>
               	mov	x21, x0
               	sub	x2, x21, #0x1
               	mov	x0, x20
               	mov	x1, x26
               	bl	<addr>
               	add	x1, x21, #0x1
               	mov	x0, x20
               	mov	x2, x22
               	bl	<addr>
               	add	x0, x25, #0x1
               	sxtw	x0, w0
               	sxtw	x9, w0
               	ldr	x16, [sp, #0x78]
               	sxtw	x16, w16
               	str	x16, [sp, #0x78]
               	ldr	x17, [sp, #0x78]
               	cmp	x9, x17
               	b.ge	<addr>
               	sxtw	x7, w9
               	ldr	x16, [sp, #0x78]
               	sxtw	x6, w16
               	ldrsw	x4, [x20, x6, lsl #2]
               	sub	x0, x7, #0x1
               	mov	x2, x7
               	b	<addr>
               	ldrsw	x3, [x20, x1, lsl #2]
               	cmp	x3, x4
               	b.gt	<addr>
               	add	x0, x0, #0x1
               	sxtw	x3, w0
               	ldrsw	x5, [x20, x3, lsl #2]
               	ldrsw	x8, [x20, x1, lsl #2]
               	str	w8, [x20, x3, lsl #2]
               	str	w5, [x20, x1, lsl #2]
               	b	<addr>
               	b	<addr>
               	add	x2, x1, #0x1
               	sxtw	x1, w2
               	cmp	x1, x6
               	b.lt	<addr>
               	add	x1, x0, #0x1
               	sxtw	x1, w1
               	ldrsw	x2, [x20, x1, lsl #2]
               	ldrsw	x3, [x20, x6, lsl #2]
               	str	w3, [x20, x1, lsl #2]
               	str	w2, [x20, x6, lsl #2]
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	sxtw	x22, w1
               	sub	x0, x22, #0x1
               	sxtw	x0, w0
               	sxtw	x25, w9
               	sxtw	x21, w0
               	cmp	x7, x21
               	b.ge	<addr>
               	sxtw	x2, w25
               	sxtw	x6, w21
               	ldrsw	x4, [x20, x6, lsl #2]
               	sub	x0, x2, #0x1
               	b	<addr>
               	ldrsw	x3, [x20, x1, lsl #2]
               	cmp	x3, x4
               	b.gt	<addr>
               	add	x0, x0, #0x1
               	sxtw	x3, w0
               	ldrsw	x5, [x20, x3, lsl #2]
               	ldrsw	x7, [x20, x1, lsl #2]
               	str	w7, [x20, x3, lsl #2]
               	str	w5, [x20, x1, lsl #2]
               	b	<addr>
               	b	<addr>
               	add	x2, x1, #0x1
               	sxtw	x1, w2
               	cmp	x1, x6
               	b.lt	<addr>
               	add	x1, x0, #0x1
               	sxtw	x1, w1
               	ldrsw	x2, [x20, x1, lsl #2]
               	ldrsw	x3, [x20, x6, lsl #2]
               	str	w3, [x20, x1, lsl #2]
               	str	w2, [x20, x6, lsl #2]
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	sxtw	x26, w1
               	sub	x0, x26, #0x1
               	sxtw	x16, w0
               	str	x16, [sp, #0x70]
               	sxtw	x0, w25
               	ldr	x16, [sp, #0x70]
               	sxtw	x1, w16
               	cmp	x0, x1
               	b.ge	<addr>
               	mov	x0, x20
               	mov	x1, x25
               	ldr	x2, [sp, #0x70]
               	bl	<addr>
               	mov	x27, x0
               	sub	x2, x27, #0x1
               	mov	x0, x20
               	mov	x1, x25
               	bl	<addr>
               	add	x1, x27, #0x1
               	mov	x0, x20
               	ldr	x2, [sp, #0x70]
               	bl	<addr>
               	add	x0, x26, #0x1
               	sxtw	x26, w0
               	sxtw	x0, w26
               	sxtw	x1, w21
               	cmp	x0, x1
               	b.ge	<addr>
               	mov	x0, x20
               	mov	x2, x21
               	mov	x1, x26
               	bl	<addr>
               	mov	x25, x0
               	sub	x2, x25, #0x1
               	mov	x0, x20
               	mov	x1, x26
               	bl	<addr>
               	add	x1, x25, #0x1
               	mov	x0, x20
               	mov	x2, x21
               	bl	<addr>
               	add	x0, x22, #0x1
               	sxtw	x0, w0
               	sxtw	x21, w0
               	ldr	x16, [sp, #0x78]
               	sxtw	x22, w16
               	cmp	x21, x22
               	b.ge	<addr>
               	sxtw	x2, w21
               	sxtw	x6, w22
               	ldrsw	x4, [x20, x6, lsl #2]
               	sub	x0, x2, #0x1
               	b	<addr>
               	ldrsw	x3, [x20, x1, lsl #2]
               	cmp	x3, x4
               	b.gt	<addr>
               	add	x0, x0, #0x1
               	sxtw	x3, w0
               	ldrsw	x5, [x20, x3, lsl #2]
               	ldrsw	x7, [x20, x1, lsl #2]
               	str	w7, [x20, x3, lsl #2]
               	str	w5, [x20, x1, lsl #2]
               	b	<addr>
               	b	<addr>
               	add	x2, x1, #0x1
               	sxtw	x1, w2
               	cmp	x1, x6
               	b.lt	<addr>
               	add	x1, x0, #0x1
               	sxtw	x1, w1
               	ldrsw	x2, [x20, x1, lsl #2]
               	ldrsw	x3, [x20, x6, lsl #2]
               	str	w3, [x20, x1, lsl #2]
               	str	w2, [x20, x6, lsl #2]
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	sxtw	x25, w1
               	sub	x0, x25, #0x1
               	sxtw	x27, w0
               	sxtw	x0, w21
               	sxtw	x1, w27
               	cmp	x0, x1
               	b.ge	<addr>
               	mov	x0, x20
               	mov	x2, x27
               	mov	x1, x21
               	bl	<addr>
               	mov	x26, x0
               	sub	x2, x26, #0x1
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	add	x1, x26, #0x1
               	mov	x0, x20
               	mov	x2, x27
               	bl	<addr>
               	add	x0, x25, #0x1
               	sxtw	x25, w0
               	sxtw	x0, w25
               	sxtw	x1, w22
               	cmp	x0, x1
               	b.ge	<addr>
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x25
               	bl	<addr>
               	mov	x21, x0
               	sub	x2, x21, #0x1
               	mov	x0, x20
               	mov	x1, x25
               	bl	<addr>
               	add	x1, x21, #0x1
               	mov	x0, x20
               	mov	x2, x22
               	bl	<addr>
               	add	x0, x24, #0x1
               	sxtw	x0, w0
               	sxtw	x9, w0
               	sxtw	x28, w28
               	cmp	x9, x28
               	b.ge	<addr>
               	sxtw	x7, w9
               	sxtw	x6, w28
               	ldrsw	x4, [x20, x6, lsl #2]
               	sub	x0, x7, #0x1
               	mov	x2, x7
               	b	<addr>
               	ldrsw	x3, [x20, x1, lsl #2]
               	cmp	x3, x4
               	b.gt	<addr>
               	add	x0, x0, #0x1
               	sxtw	x3, w0
               	ldrsw	x5, [x20, x3, lsl #2]
               	ldrsw	x8, [x20, x1, lsl #2]
               	str	w8, [x20, x3, lsl #2]
               	str	w5, [x20, x1, lsl #2]
               	b	<addr>
               	b	<addr>
               	add	x2, x1, #0x1
               	sxtw	x1, w2
               	cmp	x1, x6
               	b.lt	<addr>
               	add	x1, x0, #0x1
               	sxtw	x1, w1
               	ldrsw	x2, [x20, x1, lsl #2]
               	ldrsw	x3, [x20, x6, lsl #2]
               	str	w3, [x20, x1, lsl #2]
               	str	w2, [x20, x6, lsl #2]
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	sxtw	x24, w1
               	sub	x0, x24, #0x1
               	sxtw	x0, w0
               	sxtw	x9, w9
               	sxtw	x16, w0
               	str	x16, [sp, #0x78]
               	ldr	x17, [sp, #0x78]
               	cmp	x7, x17
               	b.ge	<addr>
               	sxtw	x7, w9
               	ldr	x16, [sp, #0x78]
               	sxtw	x6, w16
               	ldrsw	x4, [x20, x6, lsl #2]
               	sub	x0, x7, #0x1
               	mov	x2, x7
               	b	<addr>
               	ldrsw	x3, [x20, x1, lsl #2]
               	cmp	x3, x4
               	b.gt	<addr>
               	add	x0, x0, #0x1
               	sxtw	x3, w0
               	ldrsw	x5, [x20, x3, lsl #2]
               	ldrsw	x8, [x20, x1, lsl #2]
               	str	w8, [x20, x3, lsl #2]
               	str	w5, [x20, x1, lsl #2]
               	b	<addr>
               	b	<addr>
               	add	x2, x1, #0x1
               	sxtw	x1, w2
               	cmp	x1, x6
               	b.lt	<addr>
               	add	x1, x0, #0x1
               	sxtw	x1, w1
               	ldrsw	x2, [x20, x1, lsl #2]
               	ldrsw	x3, [x20, x6, lsl #2]
               	str	w3, [x20, x1, lsl #2]
               	str	w2, [x20, x6, lsl #2]
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	sxtw	x22, w1
               	sub	x0, x22, #0x1
               	sxtw	x0, w0
               	sxtw	x25, w9
               	sxtw	x21, w0
               	cmp	x7, x21
               	b.ge	<addr>
               	sxtw	x2, w25
               	sxtw	x6, w21
               	ldrsw	x4, [x20, x6, lsl #2]
               	sub	x0, x2, #0x1
               	b	<addr>
               	ldrsw	x3, [x20, x1, lsl #2]
               	cmp	x3, x4
               	b.gt	<addr>
               	add	x0, x0, #0x1
               	sxtw	x3, w0
               	ldrsw	x5, [x20, x3, lsl #2]
               	ldrsw	x7, [x20, x1, lsl #2]
               	str	w7, [x20, x3, lsl #2]
               	str	w5, [x20, x1, lsl #2]
               	b	<addr>
               	b	<addr>
               	add	x2, x1, #0x1
               	sxtw	x1, w2
               	cmp	x1, x6
               	b.lt	<addr>
               	add	x1, x0, #0x1
               	sxtw	x1, w1
               	ldrsw	x2, [x20, x1, lsl #2]
               	ldrsw	x3, [x20, x6, lsl #2]
               	str	w3, [x20, x1, lsl #2]
               	str	w2, [x20, x6, lsl #2]
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	sxtw	x26, w1
               	sub	x0, x26, #0x1
               	sxtw	x16, w0
               	str	x16, [sp, #0x70]
               	sxtw	x0, w25
               	ldr	x16, [sp, #0x70]
               	sxtw	x1, w16
               	cmp	x0, x1
               	b.ge	<addr>
               	mov	x0, x20
               	mov	x1, x25
               	ldr	x2, [sp, #0x70]
               	bl	<addr>
               	mov	x27, x0
               	sub	x2, x27, #0x1
               	mov	x0, x20
               	mov	x1, x25
               	bl	<addr>
               	add	x1, x27, #0x1
               	mov	x0, x20
               	ldr	x2, [sp, #0x70]
               	bl	<addr>
               	add	x0, x26, #0x1
               	sxtw	x26, w0
               	sxtw	x0, w26
               	sxtw	x1, w21
               	cmp	x0, x1
               	b.ge	<addr>
               	mov	x0, x20
               	mov	x2, x21
               	mov	x1, x26
               	bl	<addr>
               	mov	x25, x0
               	sub	x2, x25, #0x1
               	mov	x0, x20
               	mov	x1, x26
               	bl	<addr>
               	add	x1, x25, #0x1
               	mov	x0, x20
               	mov	x2, x21
               	bl	<addr>
               	add	x0, x22, #0x1
               	sxtw	x0, w0
               	sxtw	x21, w0
               	ldr	x16, [sp, #0x78]
               	sxtw	x22, w16
               	cmp	x21, x22
               	b.ge	<addr>
               	sxtw	x2, w21
               	sxtw	x6, w22
               	ldrsw	x4, [x20, x6, lsl #2]
               	sub	x0, x2, #0x1
               	b	<addr>
               	ldrsw	x3, [x20, x1, lsl #2]
               	cmp	x3, x4
               	b.gt	<addr>
               	add	x0, x0, #0x1
               	sxtw	x3, w0
               	ldrsw	x5, [x20, x3, lsl #2]
               	ldrsw	x7, [x20, x1, lsl #2]
               	str	w7, [x20, x3, lsl #2]
               	str	w5, [x20, x1, lsl #2]
               	b	<addr>
               	b	<addr>
               	add	x2, x1, #0x1
               	sxtw	x1, w2
               	cmp	x1, x6
               	b.lt	<addr>
               	add	x1, x0, #0x1
               	sxtw	x1, w1
               	ldrsw	x2, [x20, x1, lsl #2]
               	ldrsw	x3, [x20, x6, lsl #2]
               	str	w3, [x20, x1, lsl #2]
               	str	w2, [x20, x6, lsl #2]
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	sxtw	x25, w1
               	sub	x0, x25, #0x1
               	sxtw	x27, w0
               	sxtw	x0, w21
               	sxtw	x1, w27
               	cmp	x0, x1
               	b.ge	<addr>
               	mov	x0, x20
               	mov	x2, x27
               	mov	x1, x21
               	bl	<addr>
               	mov	x26, x0
               	sub	x2, x26, #0x1
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	add	x1, x26, #0x1
               	mov	x0, x20
               	mov	x2, x27
               	bl	<addr>
               	add	x0, x25, #0x1
               	sxtw	x25, w0
               	sxtw	x0, w25
               	sxtw	x1, w22
               	cmp	x0, x1
               	b.ge	<addr>
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x25
               	bl	<addr>
               	mov	x21, x0
               	sub	x2, x21, #0x1
               	mov	x0, x20
               	mov	x1, x25
               	bl	<addr>
               	add	x1, x21, #0x1
               	mov	x0, x20
               	mov	x2, x22
               	bl	<addr>
               	add	x0, x24, #0x1
               	sxtw	x0, w0
               	sxtw	x21, w0
               	sxtw	x22, w28
               	cmp	x21, x22
               	b.ge	<addr>
               	sxtw	x2, w21
               	sxtw	x6, w22
               	ldrsw	x4, [x20, x6, lsl #2]
               	sub	x0, x2, #0x1
               	b	<addr>
               	ldrsw	x3, [x20, x1, lsl #2]
               	cmp	x3, x4
               	b.gt	<addr>
               	add	x0, x0, #0x1
               	sxtw	x3, w0
               	ldrsw	x5, [x20, x3, lsl #2]
               	ldrsw	x7, [x20, x1, lsl #2]
               	str	w7, [x20, x3, lsl #2]
               	str	w5, [x20, x1, lsl #2]
               	b	<addr>
               	b	<addr>
               	add	x2, x1, #0x1
               	sxtw	x1, w2
               	cmp	x1, x6
               	b.lt	<addr>
               	add	x1, x0, #0x1
               	sxtw	x1, w1
               	ldrsw	x2, [x20, x1, lsl #2]
               	ldrsw	x3, [x20, x6, lsl #2]
               	str	w3, [x20, x1, lsl #2]
               	str	w2, [x20, x6, lsl #2]
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	sxtw	x24, w1
               	sub	x0, x24, #0x1
               	sxtw	x26, w0
               	sxtw	x0, w21
               	sxtw	x1, w26
               	cmp	x0, x1
               	b.ge	<addr>
               	mov	x0, x20
               	mov	x2, x26
               	mov	x1, x21
               	bl	<addr>
               	mov	x25, x0
               	sub	x2, x25, #0x1
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	add	x1, x25, #0x1
               	mov	x0, x20
               	mov	x2, x26
               	bl	<addr>
               	add	x0, x24, #0x1
               	sxtw	x24, w0
               	sxtw	x0, w24
               	sxtw	x1, w22
               	cmp	x0, x1
               	b.ge	<addr>
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x24
               	bl	<addr>
               	mov	x21, x0
               	sub	x2, x21, #0x1
               	mov	x0, x20
               	mov	x1, x24
               	bl	<addr>
               	add	x1, x21, #0x1
               	mov	x0, x20
               	mov	x2, x22
               	bl	<addr>
               	add	x0, x23, #0x1
               	sxtw	x0, w0
               	sxtw	x8, w0
               	cmp	x8, #0x4
               	b.ge	<addr>
               	sxtw	x6, w8
               	ldrsw	x4, [x20, #0x10]
               	sub	x0, x6, #0x1
               	mov	x2, x6
               	b	<addr>
               	ldrsw	x3, [x20, x1, lsl #2]
               	cmp	x3, x4
               	b.gt	<addr>
               	add	x0, x0, #0x1
               	sxtw	x3, w0
               	ldrsw	x5, [x20, x3, lsl #2]
               	ldrsw	x7, [x20, x1, lsl #2]
               	str	w7, [x20, x3, lsl #2]
               	str	w5, [x20, x1, lsl #2]
               	b	<addr>
               	b	<addr>
               	add	x2, x1, #0x1
               	sxtw	x1, w2
               	cmp	x1, #0x4
               	b.lt	<addr>
               	add	x1, x0, #0x1
               	sxtw	x1, w1
               	ldrsw	x2, [x20, x1, lsl #2]
               	ldrsw	x3, [x20, #0x10]
               	str	w3, [x20, x1, lsl #2]
               	str	w2, [x20, #0x10]
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	sxtw	x23, w1
               	sub	x0, x23, #0x1
               	sxtw	x0, w0
               	sxtw	x9, w8
               	sxtw	x27, w0
               	cmp	x6, x27
               	b.ge	<addr>
               	sxtw	x7, w9
               	sxtw	x6, w27
               	ldrsw	x4, [x20, x6, lsl #2]
               	sub	x0, x7, #0x1
               	mov	x2, x7
               	b	<addr>
               	ldrsw	x3, [x20, x1, lsl #2]
               	cmp	x3, x4
               	b.gt	<addr>
               	add	x0, x0, #0x1
               	sxtw	x3, w0
               	ldrsw	x5, [x20, x3, lsl #2]
               	ldrsw	x8, [x20, x1, lsl #2]
               	str	w8, [x20, x3, lsl #2]
               	str	w5, [x20, x1, lsl #2]
               	b	<addr>
               	b	<addr>
               	add	x2, x1, #0x1
               	sxtw	x1, w2
               	cmp	x1, x6
               	b.lt	<addr>
               	add	x1, x0, #0x1
               	sxtw	x1, w1
               	ldrsw	x2, [x20, x1, lsl #2]
               	ldrsw	x3, [x20, x6, lsl #2]
               	str	w3, [x20, x1, lsl #2]
               	str	w2, [x20, x6, lsl #2]
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	sxtw	x22, w1
               	sub	x0, x22, #0x1
               	sxtw	x0, w0
               	sxtw	x24, w9
               	sxtw	x21, w0
               	cmp	x7, x21
               	b.ge	<addr>
               	sxtw	x2, w24
               	sxtw	x6, w21
               	ldrsw	x4, [x20, x6, lsl #2]
               	sub	x0, x2, #0x1
               	b	<addr>
               	ldrsw	x3, [x20, x1, lsl #2]
               	cmp	x3, x4
               	b.gt	<addr>
               	add	x0, x0, #0x1
               	sxtw	x3, w0
               	ldrsw	x5, [x20, x3, lsl #2]
               	ldrsw	x7, [x20, x1, lsl #2]
               	str	w7, [x20, x3, lsl #2]
               	str	w5, [x20, x1, lsl #2]
               	b	<addr>
               	b	<addr>
               	add	x2, x1, #0x1
               	sxtw	x1, w2
               	cmp	x1, x6
               	b.lt	<addr>
               	add	x1, x0, #0x1
               	sxtw	x1, w1
               	ldrsw	x2, [x20, x1, lsl #2]
               	ldrsw	x3, [x20, x6, lsl #2]
               	str	w3, [x20, x1, lsl #2]
               	str	w2, [x20, x6, lsl #2]
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	sxtw	x25, w1
               	sub	x0, x25, #0x1
               	sxtw	x28, w0
               	sxtw	x0, w24
               	sxtw	x1, w28
               	cmp	x0, x1
               	b.ge	<addr>
               	mov	x0, x20
               	mov	x2, x28
               	mov	x1, x24
               	bl	<addr>
               	mov	x26, x0
               	sub	x2, x26, #0x1
               	mov	x0, x20
               	mov	x1, x24
               	bl	<addr>
               	add	x1, x26, #0x1
               	mov	x0, x20
               	mov	x2, x28
               	bl	<addr>
               	add	x0, x25, #0x1
               	sxtw	x25, w0
               	sxtw	x0, w25
               	sxtw	x1, w21
               	cmp	x0, x1
               	b.ge	<addr>
               	mov	x0, x20
               	mov	x2, x21
               	mov	x1, x25
               	bl	<addr>
               	mov	x24, x0
               	sub	x2, x24, #0x1
               	mov	x0, x20
               	mov	x1, x25
               	bl	<addr>
               	add	x1, x24, #0x1
               	mov	x0, x20
               	mov	x2, x21
               	bl	<addr>
               	add	x0, x22, #0x1
               	sxtw	x0, w0
               	sxtw	x21, w0
               	sxtw	x22, w27
               	cmp	x21, x22
               	b.ge	<addr>
               	sxtw	x2, w21
               	sxtw	x6, w22
               	ldrsw	x4, [x20, x6, lsl #2]
               	sub	x0, x2, #0x1
               	b	<addr>
               	ldrsw	x3, [x20, x1, lsl #2]
               	cmp	x3, x4
               	b.gt	<addr>
               	add	x0, x0, #0x1
               	sxtw	x3, w0
               	ldrsw	x5, [x20, x3, lsl #2]
               	ldrsw	x7, [x20, x1, lsl #2]
               	str	w7, [x20, x3, lsl #2]
               	str	w5, [x20, x1, lsl #2]
               	b	<addr>
               	b	<addr>
               	add	x2, x1, #0x1
               	sxtw	x1, w2
               	cmp	x1, x6
               	b.lt	<addr>
               	add	x1, x0, #0x1
               	sxtw	x1, w1
               	ldrsw	x2, [x20, x1, lsl #2]
               	ldrsw	x3, [x20, x6, lsl #2]
               	str	w3, [x20, x1, lsl #2]
               	str	w2, [x20, x6, lsl #2]
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	sxtw	x24, w1
               	sub	x0, x24, #0x1
               	sxtw	x26, w0
               	sxtw	x0, w21
               	sxtw	x1, w26
               	cmp	x0, x1
               	b.ge	<addr>
               	mov	x0, x20
               	mov	x2, x26
               	mov	x1, x21
               	bl	<addr>
               	mov	x25, x0
               	sub	x2, x25, #0x1
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	add	x1, x25, #0x1
               	mov	x0, x20
               	mov	x2, x26
               	bl	<addr>
               	add	x0, x24, #0x1
               	sxtw	x24, w0
               	sxtw	x0, w24
               	sxtw	x1, w22
               	cmp	x0, x1
               	b.ge	<addr>
               	mov	x0, x20
               	mov	x2, x22
               	mov	x1, x24
               	bl	<addr>
               	mov	x21, x0
               	sub	x2, x21, #0x1
               	mov	x0, x20
               	mov	x1, x24
               	bl	<addr>
               	add	x1, x21, #0x1
               	mov	x0, x20
               	mov	x2, x22
               	bl	<addr>
               	add	x0, x23, #0x1
               	sxtw	x0, w0
               	sxtw	x8, w0
               	cmp	x8, #0x4
               	b.ge	<addr>
               	sxtw	x6, w8
               	ldrsw	x4, [x20, #0x10]
               	sub	x0, x6, #0x1
               	mov	x2, x6
               	b	<addr>
               	ldrsw	x3, [x20, x1, lsl #2]
               	cmp	x3, x4
               	b.gt	<addr>
               	add	x0, x0, #0x1
               	sxtw	x3, w0
               	ldrsw	x5, [x20, x3, lsl #2]
               	ldrsw	x7, [x20, x1, lsl #2]
               	str	w7, [x20, x3, lsl #2]
               	str	w5, [x20, x1, lsl #2]
               	b	<addr>
               	b	<addr>
               	add	x2, x1, #0x1
               	sxtw	x1, w2
               	cmp	x1, #0x4
               	b.lt	<addr>
               	add	x1, x0, #0x1
               	sxtw	x1, w1
               	ldrsw	x2, [x20, x1, lsl #2]
               	ldrsw	x3, [x20, #0x10]
               	str	w3, [x20, x1, lsl #2]
               	str	w2, [x20, #0x10]
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	sxtw	x22, w1
               	sub	x0, x22, #0x1
               	sxtw	x0, w0
               	sxtw	x23, w8
               	sxtw	x21, w0
               	cmp	x6, x21
               	b.ge	<addr>
               	sxtw	x2, w23
               	sxtw	x6, w21
               	ldrsw	x4, [x20, x6, lsl #2]
               	sub	x0, x2, #0x1
               	b	<addr>
               	ldrsw	x3, [x20, x1, lsl #2]
               	cmp	x3, x4
               	b.gt	<addr>
               	add	x0, x0, #0x1
               	sxtw	x3, w0
               	ldrsw	x5, [x20, x3, lsl #2]
               	ldrsw	x7, [x20, x1, lsl #2]
               	str	w7, [x20, x3, lsl #2]
               	str	w5, [x20, x1, lsl #2]
               	b	<addr>
               	b	<addr>
               	add	x2, x1, #0x1
               	sxtw	x1, w2
               	cmp	x1, x6
               	b.lt	<addr>
               	add	x1, x0, #0x1
               	sxtw	x1, w1
               	ldrsw	x2, [x20, x1, lsl #2]
               	ldrsw	x3, [x20, x6, lsl #2]
               	str	w3, [x20, x1, lsl #2]
               	str	w2, [x20, x6, lsl #2]
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	sxtw	x24, w1
               	sub	x0, x24, #0x1
               	sxtw	x26, w0
               	sxtw	x0, w23
               	sxtw	x1, w26
               	cmp	x0, x1
               	b.ge	<addr>
               	mov	x0, x20
               	mov	x2, x26
               	mov	x1, x23
               	bl	<addr>
               	mov	x25, x0
               	sub	x2, x25, #0x1
               	mov	x0, x20
               	mov	x1, x23
               	bl	<addr>
               	add	x1, x25, #0x1
               	mov	x0, x20
               	mov	x2, x26
               	bl	<addr>
               	add	x0, x24, #0x1
               	sxtw	x24, w0
               	sxtw	x0, w24
               	sxtw	x1, w21
               	cmp	x0, x1
               	b.ge	<addr>
               	mov	x0, x20
               	mov	x2, x21
               	mov	x1, x24
               	bl	<addr>
               	mov	x23, x0
               	sub	x2, x23, #0x1
               	mov	x0, x20
               	mov	x1, x24
               	bl	<addr>
               	add	x1, x23, #0x1
               	mov	x0, x20
               	mov	x2, x21
               	bl	<addr>
               	add	x0, x22, #0x1
               	sxtw	x0, w0
               	sxtw	x21, w0
               	cmp	x21, #0x4
               	b.ge	<addr>
               	sxtw	x2, w21
               	ldrsw	x4, [x20, #0x10]
               	sub	x0, x2, #0x1
               	b	<addr>
               	ldrsw	x3, [x20, x1, lsl #2]
               	cmp	x3, x4
               	b.gt	<addr>
               	add	x0, x0, #0x1
               	sxtw	x3, w0
               	ldrsw	x5, [x20, x3, lsl #2]
               	ldrsw	x6, [x20, x1, lsl #2]
               	str	w6, [x20, x3, lsl #2]
               	str	w5, [x20, x1, lsl #2]
               	b	<addr>
               	b	<addr>
               	add	x2, x1, #0x1
               	sxtw	x1, w2
               	cmp	x1, #0x4
               	b.lt	<addr>
               	add	x1, x0, #0x1
               	sxtw	x1, w1
               	ldrsw	x2, [x20, x1, lsl #2]
               	ldrsw	x3, [x20, #0x10]
               	str	w3, [x20, x1, lsl #2]
               	str	w2, [x20, #0x10]
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	sxtw	x22, w1
               	sub	x0, x22, #0x1
               	sxtw	x24, w0
               	sxtw	x0, w21
               	sxtw	x1, w24
               	cmp	x0, x1
               	b.ge	<addr>
               	mov	x0, x20
               	mov	x2, x24
               	mov	x1, x21
               	bl	<addr>
               	mov	x23, x0
               	sub	x2, x23, #0x1
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	add	x1, x23, #0x1
               	mov	x0, x20
               	mov	x2, x24
               	bl	<addr>
               	add	x0, x22, #0x1
               	sxtw	x22, w0
               	sxtw	x0, w22
               	mov	x23, #0x4               // =4
               	cmp	x0, #0x4
               	b.ge	<addr>
               	mov	x0, x20
               	mov	x2, x23
               	mov	x1, x22
               	bl	<addr>
               	mov	x21, x0
               	sub	x2, x21, #0x1
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	add	x1, x21, #0x1
               	mov	x0, x20
               	mov	x2, x23
               	bl	<addr>
               	ldrsw	x0, [x20]
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x50]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	ldrsw	x0, [x20, #0x4]
               	cmp	x0, #0x7
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x50]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	ldrsw	x0, [x20, #0x8]
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x50]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	ldrsw	x0, [x20, #0xc]
               	cmp	x0, #0xc
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x50]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	ldrsw	x0, [x20, #0x10]
               	cmp	x0, #0xf
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x50]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x50]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
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
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
