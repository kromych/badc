
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
               	add	x13, x13, #0x8
               	str	x14, [x13]
               	mov	x20, #0x1               // =1
               	sub	x21, x29, #0x10
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x4006d8 <clock_gettime>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	0x40031c <.text+0x9c>
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
               	cbz	x21, 0x400370 <.text+0xf0>
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
               	b	0x400370 <.text+0xf0>
               	ldur	x21, [x29, #-0x48]
               	cbz	x21, 0x400398 <.text+0x118>
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
               	b.ge	0x4003cc <.text+0x14c>
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
               	cbnz	x21, 0x40040c <.text+0x18c>
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x8
               	ldr	x21, [x0]
               	mov	x17, #0xca00            // =51712
               	movk	x17, #0x3b9a, lsl #16
               	cmp	x21, x17
               	cset	x21, ge
               	stur	x21, [x29, #-0x50]
               	b	0x40040c <.text+0x18c>
               	ldur	x21, [x29, #-0x50]
               	cbz	x21, 0x400434 <.text+0x1b4>
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
               	b	0x400444 <.text+0x1c4>
               	ldursw	x21, [x29, #-0x30]
               	mov	x17, #0x4240            // =16960
               	movk	x17, #0xf, lsl #16
               	cmp	x21, x17
               	b.ge	0x400484 <.text+0x204>
               	b	0x400470 <.text+0x1f0>
               	sub	x0, x29, #0x30
               	ldrsw	x21, [x0]
               	add	x21, x21, #0x1
               	str	w21, [x0]
               	b	0x400444 <.text+0x1c4>
               	ldursw	x21, [x29, #-0x28]
               	add	x21, x21, #0x1
               	sxtw	x21, w21
               	stur	w21, [x29, #-0x28]
               	b	0x40045c <.text+0x1dc>
               	mov	x22, #0x1               // =1
               	sub	x21, x29, #0x20
               	mov	x0, x22
               	mov	x1, x21
               	bl	0x4006d8 <clock_gettime>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	0x4004c8 <.text+0x248>
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
               	b.ge	0x400504 <.text+0x284>
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
               	ldr	x0, [x21]
               	cmp	x22, x0
               	cset	x22, eq
               	stur	x22, [x29, #-0x58]
               	cbz	x22, 0x40054c <.text+0x2cc>
               	sub	x0, x29, #0x20
               	add	x0, x0, #0x8
               	ldr	x22, [x0]
               	sub	x0, x29, #0x10
               	add	x0, x0, #0x8
               	ldr	x21, [x0]
               	cmp	x22, x21
               	cset	x22, lt
               	stur	x22, [x29, #-0x58]
               	b	0x40054c <.text+0x2cc>
               	ldur	x22, [x29, #-0x58]
               	cbz	x22, 0x400578 <.text+0x2f8>
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
