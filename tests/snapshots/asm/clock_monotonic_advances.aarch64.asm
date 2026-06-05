
clock_monotonic_advances.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xd8]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x80
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	sub	x0, x29, #0x10
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	str	x1, [x0]
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x8
               	str	x1, [x0]
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x10
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x20, eq
               	cbz	x20, <addr>
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x8
               	ldr	x0, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x20, eq
               	b	<addr>
               	cbz	x20, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	x0, [x0]
               	cmp	x0, #0x0
               	b.ge	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x8
               	ldr	x0, [x0]
               	cmp	x0, #0x0
               	cset	x20, lt
               	cbnz	x20, <addr>
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x8
               	ldr	x0, [x0]
               	mov	x17, #0xca00            // =51712
               	movk	x17, #0x3b9a, lsl #16
               	cmp	x0, x17
               	cset	x20, ge
               	b	<addr>
               	cbz	x20, <addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	stur	w1, [x29, #-0x30]
               	b	<addr>
               	ldursw	x0, [x29, #-0x30]
               	mov	x17, #0x4240            // =16960
               	movk	x17, #0xf, lsl #16
               	cmp	x0, x17
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x30
               	ldrsw	x2, [x0]
               	add	x2, x2, #0x1
               	str	w2, [x0]
               	b	<addr>
               	sxtw	x0, w1
               	add	x0, x0, #0x1
               	sxtw	x1, w0
               	b	<addr>
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x20
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	ldr	x0, [x0]
               	sub	x1, x29, #0x10
               	ldr	x1, [x1]
               	cmp	x0, x1
               	b.ge	<addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	ldr	x0, [x0]
               	sub	x1, x29, #0x10
               	ldr	x1, [x1]
               	cmp	x0, x1
               	cset	x1, eq
               	cbz	x1, <addr>
               	sub	x0, x29, #0x20
               	add	x0, x0, #0x8
               	ldr	x0, [x0]
               	sub	x1, x29, #0x10
               	add	x1, x1, #0x8
               	ldr	x1, [x1]
               	cmp	x0, x1
               	cset	x1, lt
               	b	<addr>
               	cbz	x1, <addr>
               	mov	x0, #0x7                // =7
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x19, [sp, #0x10]
               	add	sp, sp, #0x80
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
