
aapcs64_variadic_host_abi.aarch64:	file format elf64-littleaarch64

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

<isum>:
               	sub	sp, sp, #0xc0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	d0, [sp, #0x40]
               	str	d1, [sp, #0x50]
               	str	d2, [sp, #0x60]
               	str	d3, [sp, #0x70]
               	str	d4, [sp, #0x80]
               	str	d5, [sp, #0x90]
               	str	d6, [sp, #0xa0]
               	str	d7, [sp, #0xb0]
               	str	x19, [sp, #-0x40]!
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x20
               	add	x1, x29, #0x10
               	mov	x16, x2
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #0xffc8            // =65480
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	str	w17, [x16, #0x18]
               	mov	x17, #0xff80            // =65408
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	str	w17, [x16, #0x1c]
               	mov	x1, x0
               	b	<addr>
               	mov	x17, x2
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x3, x16
               	ldrsw	x3, [x3]
               	add	x1, x1, x3
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	ldursw	x3, [x29, #0x10]
               	cmp	w0, w3
               	b.lt	<addr>
               	sub	x0, x29, #0x20
               	sxtw	x0, w1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp], #0x40
               	add	sp, sp, #0xc0
               	ret

<dsum>:
               	sub	sp, sp, #0xc0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	d0, [sp, #0x40]
               	str	d1, [sp, #0x50]
               	str	d2, [sp, #0x60]
               	str	d3, [sp, #0x70]
               	str	d4, [sp, #0x80]
               	str	d5, [sp, #0x90]
               	str	d6, [sp, #0xa0]
               	str	d7, [sp, #0xb0]
               	str	x19, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	sub	x17, x29, #0x28
               	str	d16, [x17]
               	sub	x1, x29, #0x20
               	add	x2, x29, #0x10
               	mov	x16, x1
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #0xffc8            // =65480
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	str	w17, [x16, #0x18]
               	mov	x17, #0xff80            // =65408
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	str	w17, [x16, #0x1c]
               	b	<addr>
               	sub	x16, x29, #0x28
               	ldr	d0, [x16]
               	mov	x17, x1
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x10]
               	add	x9, x9, x16
               	add	x16, x16, #0x10
               	str	w16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x2, x16
               	ldr	d1, [x2]
               	fadd	d0, d0, d1
               	sub	x17, x29, #0x28
               	str	d0, [x17]
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	ldursw	x2, [x29, #0x10]
               	cmp	w0, w2
               	b.lt	<addr>
               	sub	x0, x29, #0x20
               	sub	x16, x29, #0x28
               	ldr	d0, [x16]
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp], #0x50
               	add	sp, sp, #0xc0
               	ret

<mixed>:
               	sub	sp, sp, #0xc0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	d0, [sp, #0x40]
               	str	d1, [sp, #0x50]
               	str	d2, [sp, #0x60]
               	str	d3, [sp, #0x70]
               	str	d4, [sp, #0x80]
               	str	d5, [sp, #0x90]
               	str	d6, [sp, #0xa0]
               	str	d7, [sp, #0xb0]
               	str	x19, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	mov	x0, #0x0                // =0
               	fmov	d16, x0
               	sub	x17, x29, #0x28
               	str	d16, [x17]
               	sub	x1, x29, #0x20
               	add	x2, x29, #0x10
               	mov	x16, x1
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #0xffc8            // =65480
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	str	w17, [x16, #0x18]
               	mov	x17, #0xff80            // =65408
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	str	w17, [x16, #0x1c]
               	b	<addr>
               	sxtw	x2, w0
               	mov	x17, #0x1               // =1
               	and	x3, x2, x17
               	cbz	x3, <addr>
               	sub	x16, x29, #0x28
               	ldr	d0, [x16]
               	mov	x17, x1
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x10]
               	add	x9, x9, x16
               	add	x16, x16, #0x10
               	str	w16, [x17, #0x1c]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x3, x16
               	ldr	d1, [x3]
               	fadd	d0, d0, d1
               	sub	x17, x29, #0x28
               	str	d0, [x17]
               	b	<addr>
               	sub	x16, x29, #0x28
               	ldr	d0, [x16]
               	mov	x17, x1
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x3, x16
               	ldrsw	x3, [x3]
               	scvtf	d1, x3
               	fadd	d0, d0, d1
               	sub	x17, x29, #0x28
               	str	d0, [x17]
               	add	x0, x2, #0x1
               	ldursw	x2, [x29, #0x10]
               	cmp	w0, w2
               	b.lt	<addr>
               	sub	x0, x29, #0x20
               	sub	x16, x29, #0x28
               	ldr	d0, [x16]
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp], #0x50
               	add	sp, sp, #0xc0
               	ret

<icopy>:
               	sub	sp, sp, #0xc0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	d0, [sp, #0x40]
               	str	d1, [sp, #0x50]
               	str	d2, [sp, #0x60]
               	str	d3, [sp, #0x70]
               	str	d4, [sp, #0x80]
               	str	d5, [sp, #0x90]
               	str	d6, [sp, #0xa0]
               	str	d7, [sp, #0xb0]
               	str	x19, [sp, #-0x60]!
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x1, #0x0                // =0
               	sub	x2, x29, #0x40
               	add	x0, x29, #0x10
               	mov	x16, x2
               	add	x17, x29, #0xd0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #0xffc8            // =65480
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	str	w17, [x16, #0x18]
               	mov	x17, #0xff80            // =65408
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	str	w17, [x16, #0x1c]
               	sub	x3, x29, #0x20
               	str	x9, [sp, #-0x10]!
               	ldr	x9, [x2]
               	str	x9, [x3]
               	ldr	x9, [x2, #0x8]
               	str	x9, [x3, #0x8]
               	ldr	x9, [x2, #0x10]
               	str	x9, [x3, #0x10]
               	ldr	x9, [x2, #0x18]
               	str	x9, [x3, #0x18]
               	ldr	x9, [sp], #0x10
               	mov	x0, x1
               	b	<addr>
               	mov	x17, x2
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x4, x16
               	ldrsw	x4, [x4]
               	add	x0, x0, x4
               	sxtw	x1, w1
               	add	x1, x1, #0x1
               	ldursw	x4, [x29, #0x10]
               	cmp	w1, w4
               	b.lt	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x17, x3
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x2, x16
               	ldrsw	x2, [x2]
               	add	x0, x0, x2
               	sxtw	x1, w1
               	add	x1, x1, #0x1
               	ldursw	x2, [x29, #0x10]
               	cmp	w1, w2
               	b.lt	<addr>
               	sub	x1, x29, #0x20
               	sub	x1, x29, #0x40
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x19, [sp], #0x60
               	add	sp, sp, #0xc0
               	ret

<named_overflow>:
               	sub	sp, sp, #0xc0
               	str	x0, [sp]
               	str	x1, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	str	x3, [sp, #0x18]
               	str	x4, [sp, #0x20]
               	str	x5, [sp, #0x28]
               	str	x6, [sp, #0x30]
               	str	x7, [sp, #0x38]
               	str	d0, [sp, #0x40]
               	str	d1, [sp, #0x50]
               	str	d2, [sp, #0x60]
               	str	d3, [sp, #0x70]
               	str	d4, [sp, #0x80]
               	str	d5, [sp, #0x90]
               	str	d6, [sp, #0xa0]
               	str	d7, [sp, #0xb0]
               	str	x19, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	ldursw	x0, [x29, #0x10]
               	ldursw	x1, [x29, #0x18]
               	add	x0, x0, x1
               	ldursw	x1, [x29, #0x20]
               	add	x0, x0, x1
               	ldursw	x1, [x29, #0x28]
               	add	x0, x0, x1
               	ldursw	x1, [x29, #0x30]
               	add	x0, x0, x1
               	ldursw	x1, [x29, #0x38]
               	add	x0, x0, x1
               	ldursw	x1, [x29, #0x40]
               	add	x0, x0, x1
               	ldursw	x1, [x29, #0x48]
               	add	x0, x0, x1
               	ldursw	x1, [x29, #0xd0]
               	add	x0, x0, x1
               	ldursw	x1, [x29, #0xd8]
               	add	x1, x0, x1
               	sub	x0, x29, #0x20
               	add	x2, x29, #0xd8
               	mov	x16, x0
               	add	x17, x29, #0xe0
               	str	x17, [x16]
               	add	x17, x29, #0x50
               	str	x17, [x16, #0x8]
               	add	x17, x29, #0xd0
               	str	x17, [x16, #0x10]
               	mov	x17, #0x0               // =0
               	str	w17, [x16, #0x18]
               	mov	x17, #0xff80            // =65408
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	str	w17, [x16, #0x1c]
               	mov	x17, x0
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x2, x16
               	ldrsw	x2, [x2]
               	add	x1, x1, x2
               	mov	x17, x0
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x2, x16
               	ldrsw	x2, [x2]
               	add	x1, x1, x2
               	mov	x17, x0
               	str	x9, [sp, #-0x10]!
               	ldrsw	x16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.ge	<addr>
               	ldr	x9, [x17, #0x8]
               	add	x9, x9, x16
               	add	x16, x16, #0x8
               	str	w16, [x17, #0x18]
               	cmp	x16, #0x0
               	b.gt	<addr>
               	mov	x16, x9
               	b	<addr>
               	ldr	x16, [x17]
               	add	x9, x16, #0x8
               	str	x9, [x17]
               	ldr	x9, [sp], #0x10
               	mov	x0, x16
               	ldrsw	x0, [x0]
               	add	x0, x1, x0
               	sub	x1, x29, #0x20
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x19, [sp], #0x50
               	add	sp, sp, #0xc0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x20, #0x0               // =0
               	mov	x0, #0x5                // =5
               	mov	x21, #0x1               // =1
               	mov	x23, #0x2               // =2
               	mov	x3, #0x3                // =3
               	mov	x4, #0x4                // =4
               	mov	x1, x21
               	mov	x5, x0
               	mov	x2, x23
               	bl	<addr>
               	cmp	x0, #0xf
               	b.eq	<addr>
               	mov	x20, x21
               	mov	x0, #0xc                // =12
               	mov	x3, #0x3                // =3
               	mov	x22, #0x4               // =4
               	mov	x5, #0x5                // =5
               	mov	x6, #0x6                // =6
               	mov	x7, #0x7                // =7
               	mov	x1, #0x8                // =8
               	mov	x2, #0x9                // =9
               	mov	x24, #0xa               // =10
               	mov	x4, #0xb                // =11
               	sub	sp, sp, #0x30
               	str	x1, [sp]
               	str	x2, [sp, #0x8]
               	str	x24, [sp, #0x10]
               	str	x4, [sp, #0x18]
               	str	x0, [sp, #0x20]
               	mov	x1, x21
               	mov	x4, x22
               	mov	x2, x23
               	bl	<addr>
               	add	sp, sp, #0x30
               	cmp	x0, #0x4e
               	b.eq	<addr>
               	mov	x17, #0x2               // =2
               	orr	x20, x20, x17
               	mov	x1, #0x3ff8000000000000 // =4609434218613702656
               	mov	x2, #0x4004000000000000 // =4612811918334230528
               	mov	x21, #0x4008000000000000 // =4613937818241073152
               	mov	x23, #0x4010000000000000 // =4616189618054758400
               	fmov	d0, x1
               	fmov	d1, x2
               	fmov	d2, x21
               	fmov	d3, x23
               	mov	x0, x22
               	bl	<addr>
               	mov	x0, #0x4026000000000000 // =4622382067542392832
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x17, #0x4               // =4
               	orr	x20, x20, x17
               	mov	x1, #0x3ff0000000000000 // =4607182418800017408
               	mov	x2, #0x4000000000000000 // =4611686018427387904
               	mov	x5, #0x4014000000000000 // =4617315517961601024
               	mov	x6, #0x4018000000000000 // =4618441417868443648
               	mov	x7, #0x401c000000000000 // =4619567317775286272
               	mov	x0, #0x4020000000000000 // =4620693217682128896
               	mov	x3, #0x4022000000000000 // =4621256167635550208
               	mov	x4, #0x4024000000000000 // =4621819117588971520
               	sub	sp, sp, #0x10
               	str	x3, [sp]
               	str	x4, [sp, #0x8]
               	fmov	d0, x1
               	fmov	d1, x2
               	fmov	d2, x21
               	fmov	d3, x23
               	fmov	d4, x5
               	fmov	d5, x6
               	fmov	d6, x7
               	fmov	d7, x0
               	mov	x0, x24
               	bl	<addr>
               	add	sp, sp, #0x10
               	mov	x0, #0x800000000000     // =140737488355328
               	movk	x0, #0x404b, lsl #48
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x17, #0x8               // =8
               	orr	x20, x20, x17
               	mov	x21, #0xa               // =10
               	mov	x2, #0x3ff8000000000000 // =4609434218613702656
               	mov	x3, #0x14               // =20
               	mov	x4, #0x4004000000000000 // =4612811918334230528
               	fmov	d0, x2
               	fmov	d1, x4
               	mov	x0, x22
               	mov	x2, x3
               	mov	x1, x21
               	bl	<addr>
               	mov	x0, #0x4041000000000000 // =4629981891913580544
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x17, #0x10              // =16
               	orr	x20, x20, x17
               	mov	x22, #0x5               // =5
               	mov	x23, #0x2               // =2
               	mov	x24, #0x4               // =4
               	mov	x3, #0x6                // =6
               	mov	x4, #0x8                // =8
               	mov	x0, x22
               	mov	x5, x21
               	mov	x2, x24
               	mov	x1, x23
               	bl	<addr>
               	cmp	x0, #0x3c
               	b.eq	<addr>
               	mov	x17, #0x20              // =32
               	orr	x20, x20, x17
               	mov	x0, #0x1                // =1
               	mov	x2, #0x3                // =3
               	mov	x5, #0x6                // =6
               	mov	x6, #0x7                // =7
               	mov	x7, #0x8                // =8
               	mov	x1, #0x9                // =9
               	mov	x3, #0xa                // =10
               	mov	x4, #0x64               // =100
               	mov	x8, #0xc8               // =200
               	mov	x9, #0x12c              // =300
               	sub	sp, sp, #0x30
               	str	x1, [sp]
               	str	x3, [sp, #0x8]
               	str	x4, [sp, #0x10]
               	str	x8, [sp, #0x18]
               	str	x9, [sp, #0x20]
               	mov	x1, x23
               	mov	x4, x22
               	mov	x3, x24
               	bl	<addr>
               	add	sp, sp, #0x30
               	cmp	x0, #0x28f
               	b.eq	<addr>
               	mov	x17, #0x40              // =64
               	orr	x20, x20, x17
               	sxtw	x0, w20
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
