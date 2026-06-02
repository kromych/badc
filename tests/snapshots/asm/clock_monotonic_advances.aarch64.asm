
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
               	sub	sp, sp, #0x70
               	str	x19, [sp]
               	sub	x15, x29, #0x10
               	mov	x14, #0xffff            // =65535
               	movk	x14, #0xffff, lsl #16
               	movk	x14, #0xffff, lsl #32
               	movk	x14, #0xffff, lsl #48
               	str	x14, [x15]
               	sub	x13, x29, #0x10
               	add	x13, x13, #0x8
               	str	x14, [x13]
               	mov	x0, #0x1                // =1
               	sub	x1, x29, #0x10
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x14, x0
               	cmp	x14, #0x0
               	b.eq	<addr>
               	mov	x1, #0x1                // =1
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x14, x29, #0x10
               	ldr	x14, [x14]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x14, x17
               	cset	x14, eq
               	stur	x14, [x29, #-0x48]
               	cbz	x14, <addr>
               	sub	x1, x29, #0x10
               	add	x1, x1, #0x8
               	ldr	x1, [x1]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x1, x17
               	cset	x1, eq
               	stur	x1, [x29, #-0x48]
               	b	<addr>
               	ldur	x1, [x29, #-0x48]
               	cbz	x1, <addr>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x10
               	ldr	x1, [x1]
               	cmp	x1, #0x0
               	b.ge	<addr>
               	mov	x14, #0x3               // =3
               	mov	x0, x14
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x10
               	add	x1, x1, #0x8
               	ldr	x1, [x1]
               	cmp	x1, #0x0
               	cset	x1, lt
               	stur	x1, [x29, #-0x50]
               	cbnz	x1, <addr>
               	sub	x14, x29, #0x10
               	add	x14, x14, #0x8
               	ldr	x14, [x14]
               	mov	x17, #0xca00            // =51712
               	movk	x17, #0x3b9a, lsl #16
               	cmp	x14, x17
               	cset	x14, ge
               	stur	x14, [x29, #-0x50]
               	b	<addr>
               	ldur	x14, [x29, #-0x50]
               	cbz	x14, <addr>
               	mov	x1, #0x4                // =4
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x28]
               	stur	w14, [x29, #-0x30]
               	b	<addr>
               	ldursw	x14, [x29, #-0x30]
               	mov	x17, #0x4240            // =16960
               	movk	x17, #0xf, lsl #16
               	cmp	x14, x17
               	b.ge	<addr>
               	b	<addr>
               	sub	x1, x29, #0x30
               	ldrsw	x14, [x1]
               	add	x14, x14, #0x1
               	str	w14, [x1]
               	b	<addr>
               	ldursw	x14, [x29, #-0x28]
               	add	x14, x14, #0x1
               	sxtw	x14, w14
               	stur	w14, [x29, #-0x28]
               	b	<addr>
               	mov	x14, #0x1               // =1
               	sub	x1, x29, #0x20
               	mov	x0, x14
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x1, #0x5                // =5
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	ldr	x0, [x0]
               	sub	x1, x29, #0x10
               	ldr	x1, [x1]
               	cmp	x0, x1
               	b.ge	<addr>
               	mov	x1, #0x6                // =6
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	ldr	x0, [x0]
               	sub	x1, x29, #0x10
               	ldr	x1, [x1]
               	cmp	x0, x1
               	cset	x0, eq
               	stur	x0, [x29, #-0x58]
               	cbz	x0, <addr>
               	sub	x1, x29, #0x20
               	add	x1, x1, #0x8
               	ldr	x1, [x1]
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x8
               	ldr	x0, [x0]
               	cmp	x1, x0
               	cset	x1, lt
               	stur	x1, [x29, #-0x58]
               	b	<addr>
               	ldur	x1, [x29, #-0x58]
               	cbz	x1, <addr>
               	mov	x0, #0x7                // =7
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldr	x19, [sp]
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
