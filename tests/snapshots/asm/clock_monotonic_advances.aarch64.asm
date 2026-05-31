
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
               	sub	sp, sp, #0x90
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	sub	x15, x29, #0x10
               	mov	x14, #0xffff            // =65535
               	movk	x14, #0xffff, lsl #16
               	movk	x14, #0xffff, lsl #32
               	movk	x14, #0xffff, lsl #48
               	str	x14, [x15]
               	sub	x13, x29, #0x10
               	add	x13, x13, #0x8
               	str	x14, [x13]
               	mov	x20, #0x1               // =1
               	sub	x21, x29, #0x10
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x21, #0x1               // =1
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldr	x21, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x21, x17
               	cset	x21, eq
               	stur	x21, [x29, #-0x48]
               	cbz	x21, <addr>
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x8
               	ldr	x21, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x21, x17
               	cset	x21, eq
               	stur	x21, [x29, #-0x48]
               	b	<addr>
               	ldur	x21, [x29, #-0x48]
               	cbz	x21, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x21, x29, #0x10
               	ldr	x0, [x21]
               	cmp	x0, #0x0
               	b.ge	<addr>
               	mov	x21, #0x3               // =3
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x8
               	ldr	x21, [x0]
               	cmp	x21, #0x0
               	cset	x21, lt
               	stur	x21, [x29, #-0x50]
               	cbnz	x21, <addr>
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x8
               	ldr	x21, [x0]
               	mov	x17, #0xca00            // =51712
               	movk	x17, #0x3b9a, lsl #16
               	cmp	x21, x17
               	cset	x21, ge
               	stur	x21, [x29, #-0x50]
               	b	<addr>
               	ldur	x21, [x29, #-0x50]
               	cbz	x21, <addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x21, #0x0               // =0
               	stur	w21, [x29, #-0x28]
               	stur	w21, [x29, #-0x30]
               	b	<addr>
               	ldursw	x21, [x29, #-0x30]
               	mov	x17, #0x4240            // =16960
               	movk	x17, #0xf, lsl #16
               	cmp	x21, x17
               	b.ge	<addr>
               	b	<addr>
               	sub	x0, x29, #0x30
               	ldrsw	x21, [x0]
               	add	x21, x21, #0x1
               	str	w21, [x0]
               	b	<addr>
               	ldursw	x21, [x29, #-0x28]
               	add	x21, x21, #0x1
               	sxtw	x21, w21
               	stur	w21, [x29, #-0x28]
               	b	<addr>
               	mov	x22, #0x1               // =1
               	sub	x21, x29, #0x20
               	mov	x0, x22
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x21, #0x5               // =5
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x20
               	ldr	x21, [x0]
               	sub	x0, x29, #0x10
               	ldr	x22, [x0]
               	cmp	x21, x22
               	b.ge	<addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x21, x29, #0x20
               	ldr	x0, [x21]
               	sub	x21, x29, #0x10
               	ldr	x22, [x21]
               	cmp	x0, x22
               	cset	x0, eq
               	stur	x0, [x29, #-0x58]
               	cbz	x0, <addr>
               	sub	x22, x29, #0x20
               	add	x22, x22, #0x8
               	ldr	x0, [x22]
               	sub	x22, x29, #0x10
               	add	x22, x22, #0x8
               	ldr	x21, [x22]
               	cmp	x0, x21
               	cset	x0, lt
               	stur	x0, [x29, #-0x58]
               	b	<addr>
               	ldur	x0, [x29, #-0x58]
               	cbz	x0, <addr>
               	mov	x21, #0x7               // =7
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
