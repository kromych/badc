
clock_monotonic_advances.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400298 <.text+0x18>
               	adrp	x16, 0x410000
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
               	add	x15, x13, #0x8
               	str	x14, [x15]
               	mov	x20, #0x1               // =1
               	sub	x21, x29, #0x10
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x4006e8 <clock_gettime>
               	sxtw	x0, w0
               	mov	x14, x0
               	cmp	x14, #0x0
               	b.eq	0x400320 <.text+0xa0>
               	mov	x14, #0x1               // =1
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x21, x29, #0x10
               	ldr	x14, [x21]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x14, x17
               	cset	x21, eq
               	stur	x21, [x29, #-0x48]
               	cbz	x21, 0x400374 <.text+0xf4>
               	sub	x14, x29, #0x10
               	add	x21, x14, #0x8
               	ldr	x14, [x21]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x14, x17
               	cset	x21, eq
               	stur	x21, [x29, #-0x48]
               	b	0x400374 <.text+0xf4>
               	ldur	x21, [x29, #-0x48]
               	cbz	x21, 0x4003a0 <.text+0x120>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x21, x29, #0x10
               	ldr	x14, [x21]
               	cmp	x14, #0x0
               	b.ge	0x4003d4 <.text+0x154>
               	mov	x14, #0x3               // =3
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x21, x29, #0x10
               	add	x14, x21, #0x8
               	ldr	x21, [x14]
               	cmp	x21, #0x0
               	cset	x14, lt
               	stur	x14, [x29, #-0x50]
               	cbnz	x14, 0x400414 <.text+0x194>
               	sub	x21, x29, #0x10
               	add	x14, x21, #0x8
               	ldr	x21, [x14]
               	mov	x17, #0xca00            // =51712
               	movk	x17, #0x3b9a, lsl #16
               	cmp	x21, x17
               	cset	x14, ge
               	stur	x14, [x29, #-0x50]
               	b	0x400414 <.text+0x194>
               	ldur	x14, [x29, #-0x50]
               	cbz	x14, 0x400440 <.text+0x1c0>
               	mov	x21, #0x4               // =4
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x28]
               	stur	w14, [x29, #-0x30]
               	b	0x400450 <.text+0x1d0>
               	ldursw	x14, [x29, #-0x30]
               	mov	x17, #0x4240            // =16960
               	movk	x17, #0xf, lsl #16
               	cmp	x14, x17
               	b.ge	0x400490 <.text+0x210>
               	b	0x40047c <.text+0x1fc>
               	sub	x14, x29, #0x30
               	ldrsw	x21, [x14]
               	add	x20, x21, #0x1
               	str	w20, [x14]
               	b	0x400450 <.text+0x1d0>
               	ldursw	x20, [x29, #-0x28]
               	add	x21, x20, #0x1
               	sxtw	x21, w21
               	stur	w21, [x29, #-0x28]
               	b	0x400468 <.text+0x1e8>
               	mov	x22, #0x1               // =1
               	sub	x21, x29, #0x20
               	mov	x0, x22
               	mov	x1, x21
               	bl	0x4006e8 <clock_gettime>
               	sxtw	x0, w0
               	mov	x14, x0
               	cmp	x14, #0x0
               	b.eq	0x4004d8 <.text+0x258>
               	mov	x14, #0x5               // =5
               	mov	x0, x14
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x21, x29, #0x20
               	ldr	x14, [x21]
               	sub	x21, x29, #0x10
               	ldr	x22, [x21]
               	cmp	x14, x22
               	b.ge	0x400514 <.text+0x294>
               	mov	x22, #0x6               // =6
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x21, x29, #0x20
               	ldr	x22, [x21]
               	sub	x21, x29, #0x10
               	ldr	x14, [x21]
               	cmp	x22, x14
               	cset	x21, eq
               	stur	x21, [x29, #-0x58]
               	cbz	x21, 0x40055c <.text+0x2dc>
               	sub	x14, x29, #0x20
               	add	x21, x14, #0x8
               	ldr	x14, [x21]
               	sub	x21, x29, #0x10
               	add	x22, x21, #0x8
               	ldr	x21, [x22]
               	cmp	x14, x21
               	cset	x22, lt
               	stur	x22, [x29, #-0x58]
               	b	0x40055c <.text+0x2dc>
               	ldur	x22, [x29, #-0x58]
               	cbz	x22, 0x400588 <.text+0x308>
               	mov	x21, #0x7               // =7
               	mov	x0, x21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x22, #0x0               // =0
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x90
               	ldp	x29, x30, [sp], #0x10
               	ret
