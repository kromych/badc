
slot_coalesce_declared.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<mkq>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x16, x29, #0x28
               	str	x8, [x16]
               	mov	x0, #0x7b               // =123
               	sub	x1, x29, #0x20
               	str	x0, [x1]
               	sub	x0, x29, #0x20
               	mov	x1, #0x552e             // =21806
               	str	x1, [x0, #0x8]
               	sub	x0, x29, #0x20
               	mov	x1, #0x84               // =132
               	str	x1, [x0, #0x10]
               	sub	x0, x29, #0x20
               	mov	x1, #0x171              // =369
               	str	x1, [x0, #0x18]
               	sub	x0, x29, #0x20
               	mov	x16, x0
               	sub	x17, x29, #0x28
               	ldr	x17, [x17]
               	ldr	x0, [x16]
               	str	x0, [x17]
               	ldr	x0, [x16, #0x8]
               	str	x0, [x17, #0x8]
               	ldr	x0, [x16, #0x10]
               	str	x0, [x17, #0x10]
               	ldr	x0, [x16, #0x18]
               	str	x0, [x17, #0x18]
               	mov	x0, x17
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret

<useq>:
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x0, x29, #0x20
               	ldur	x1, [x29, #0x10]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x20
               	ldr	x1, [x0]
               	sub	x0, x29, #0x20
               	ldr	x0, [x0, #0x8]
               	add	x1, x1, x0
               	sub	x0, x29, #0x20
               	ldr	x0, [x0, #0x10]
               	add	x1, x1, x0
               	sub	x0, x29, #0x20
               	ldr	x0, [x0, #0x18]
               	add	x0, x1, x0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<sum8>:
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x0, x29, #0x40
               	ldur	x1, [x29, #0x10]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x1, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x1, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x1, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x1, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [x1, #0x30]
               	str	x10, [x0, #0x30]
               	ldr	x10, [x1, #0x38]
               	str	x10, [x0, #0x38]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x40
               	ldr	x1, [x0]
               	sub	x0, x29, #0x40
               	ldr	x0, [x0, #0x8]
               	add	x1, x1, x0
               	sub	x0, x29, #0x40
               	ldr	x0, [x0, #0x10]
               	add	x1, x1, x0
               	sub	x0, x29, #0x40
               	ldr	x0, [x0, #0x18]
               	add	x1, x1, x0
               	sub	x0, x29, #0x40
               	ldr	x0, [x0, #0x20]
               	add	x1, x1, x0
               	sub	x0, x29, #0x40
               	ldr	x0, [x0, #0x28]
               	add	x1, x1, x0
               	sub	x0, x29, #0x40
               	ldr	x0, [x0, #0x30]
               	add	x1, x1, x0
               	sub	x0, x29, #0x40
               	ldr	x0, [x0, #0x38]
               	add	x0, x1, x0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<build>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x50
               	sub	x16, x29, #0x48
               	str	x8, [x16]
               	mov	x0, #0xa                // =10
               	sub	x1, x29, #0x40
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x1]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x2, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [x2, #0x18]
               	str	x10, [x1, #0x18]
               	ldr	x10, [x2, #0x20]
               	str	x10, [x1, #0x20]
               	ldr	x10, [x2, #0x28]
               	str	x10, [x1, #0x28]
               	ldr	x10, [x2, #0x30]
               	str	x10, [x1, #0x30]
               	ldr	x10, [x2, #0x38]
               	str	x10, [x1, #0x38]
               	ldr	x10, [sp], #0x10
               	sub	x1, x29, #0x40
               	str	x0, [x1]
               	mov	x1, #0xb                // =11
               	sub	x0, x29, #0x40
               	str	x1, [x0, #0x8]
               	mov	x1, #0xc                // =12
               	sub	x0, x29, #0x40
               	str	x1, [x0, #0x10]
               	mov	x1, #0xd                // =13
               	sub	x0, x29, #0x40
               	str	x1, [x0, #0x18]
               	mov	x1, #0xe                // =14
               	sub	x0, x29, #0x40
               	str	x1, [x0, #0x20]
               	mov	x1, #0xf                // =15
               	sub	x0, x29, #0x40
               	str	x1, [x0, #0x28]
               	mov	x1, #0x10               // =16
               	sub	x0, x29, #0x40
               	str	x1, [x0, #0x30]
               	mov	x1, #0xa                // =10
               	sub	x0, x29, #0x40
               	str	x1, [x0, #0x38]
               	sub	x0, x29, #0x40
               	mov	x16, x0
               	sub	x17, x29, #0x48
               	ldr	x17, [x17]
               	ldr	x0, [x16]
               	str	x0, [x17]
               	ldr	x0, [x16, #0x8]
               	str	x0, [x17, #0x8]
               	ldr	x0, [x16, #0x10]
               	str	x0, [x17, #0x10]
               	ldr	x0, [x16, #0x18]
               	str	x0, [x17, #0x18]
               	ldr	x0, [x16, #0x20]
               	str	x0, [x17, #0x20]
               	ldr	x0, [x16, #0x28]
               	str	x0, [x17, #0x28]
               	ldr	x0, [x16, #0x30]
               	str	x0, [x17, #0x30]
               	ldr	x0, [x16, #0x38]
               	str	x0, [x17, #0x38]
               	mov	x0, x17
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x180
               	str	x20, [sp]
               	str	x19, [sp, #0x10]
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	b	<addr>
               	mov	x17, #0x3               // =3
               	mul	x2, x0, x17
               	add	x3, x2, #0x7
               	add	x1, x1, x3
               	add	x3, x0, x0
               	add	x3, x3, x0
               	sub	x2, x3, x2
               	add	x2, x1, x2
               	mov	x17, #0x9               // =9
               	mul	x1, x0, x17
               	sub	x1, x1, x1
               	add	x1, x2, x1
               	add	x0, x0, #0x1
               	cmp	x0, #0x32
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	b	<addr>
               	mov	x17, #0x3               // =3
               	mul	x3, x0, x17
               	add	x3, x3, #0x7
               	add	x2, x2, x3
               	add	x0, x0, #0x1
               	cmp	x0, #0x32
               	b.lt	<addr>
               	cmp	x1, x2
               	cset	x1, eq
               	mov	x0, #0xabcd             // =43981
               	movk	x0, #0x1234, lsl #16
               	sub	x17, x29, #0x158
               	str	x0, [x17]
               	sub	x0, x29, #0x158
               	ldr	x2, [x0]
               	mov	x17, #0xfeed            // =65261
               	eor	x2, x2, x17
               	str	x2, [x0]
               	sxtw	x1, w1
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	sub	x16, x29, #0x158
               	ldr	x0, [x16]
               	mov	x17, #0x5520            // =21792
               	movk	x17, #0x1234, lsl #16
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	mov	x20, #0x0               // =0
               	cbz	x0, <addr>
               	mov	x20, #0x1               // =1
               	mov	x0, #0x7b               // =123
               	sub	x8, x29, #0x60
               	bl	<addr>
               	sub	x0, x29, #0x60
               	sub	x1, x29, #0x100
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x1, #0x18]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sxtw	x1, w20
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	sub	x0, x29, #0x100
               	bl	<addr>
               	mov	x17, #0x579e            // =22430
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	sub	x0, x29, #0x100
               	ldr	x0, [x0]
               	cmp	x0, #0x7b
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x20, #0x0               // =0
               	cbz	x1, <addr>
               	sub	x0, x29, #0x100
               	ldr	x0, [x0, #0x18]
               	cmp	x0, #0x171
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x20, ne
               	mov	x0, #0xa                // =10
               	sub	x8, x29, #0x40
               	bl	<addr>
               	sub	x0, x29, #0x40
               	sub	x1, x29, #0xa0
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x1, #0x18]
               	ldr	x10, [x0, #0x20]
               	str	x10, [x1, #0x20]
               	ldr	x10, [x0, #0x28]
               	str	x10, [x1, #0x28]
               	ldr	x10, [x0, #0x30]
               	str	x10, [x1, #0x30]
               	ldr	x10, [x0, #0x38]
               	str	x10, [x1, #0x38]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sxtw	x1, w20
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	sub	x0, x29, #0xa0
               	bl	<addr>
               	cmp	x0, #0x65
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x0, ne
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp]
               	add	sp, sp, #0x180
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
