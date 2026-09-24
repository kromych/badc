
split_spilled_reload_run.aarch64:	file format elf64-littleaarch64

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

<cold>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	add	x0, x2, x0
               	str	x0, [x1]
               	ret

<hot>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x1, #0x0                // =0
               	ldr	x2, [x0]
               	add	x2, x2, #0x1
               	ldr	x3, [x0, #0x8]
               	add	x3, x3, #0x2
               	ldr	x4, [x0, #0x10]
               	add	x4, x4, #0x3
               	ldr	x5, [x0, #0x18]
               	add	x5, x5, #0x4
               	ldr	x6, [x0, #0x20]
               	add	x6, x6, #0x5
               	ldr	x7, [x0, #0x28]
               	add	x7, x7, #0x6
               	ldr	x8, [x0, #0x30]
               	add	x9, x8, #0x7
               	ldr	x8, [x0, #0x38]
               	add	x10, x8, #0x8
               	ldr	x11, [x0]
               	ldr	x12, [x0, #0x18]
               	eor	x11, x11, x12
               	ldr	x12, [x0, #0x8]
               	ldr	x13, [x0, #0x28]
               	eor	x12, x12, x13
               	ldr	x13, [x0, #0x10]
               	ldr	x14, [x0, #0x30]
               	eor	x13, x13, x14
               	ldr	x14, [x0, #0x18]
               	eor	x14, x14, x8
               	ldr	x8, [x0, #0x20]
               	ldr	x15, [x0]
               	add	x15, x8, x15
               	ldr	x8, [x0, #0x28]
               	ldr	x20, [x0, #0x8]
               	add	x20, x8, x20
               	ldr	x8, [x0, #0x30]
               	ldr	x21, [x0, #0x10]
               	add	x21, x8, x21
               	ldr	x8, [x0, #0x38]
               	ldr	x0, [x0, #0x18]
               	add	x22, x8, x0
               	mov	x0, x1
               	add	x8, x2, x1
               	eor	x0, x0, x8
               	mov	x17, #0x3               // =3
               	mul	x8, x2, x17
               	add	x0, x0, x8
               	lsr	x8, x0, #3
               	eor	x8, x2, x8
               	sub	x0, x0, x8
               	add	x8, x3, x1
               	eor	x0, x0, x8
               	mov	x17, #0x3               // =3
               	mul	x8, x3, x17
               	add	x0, x0, x8
               	lsr	x8, x0, #3
               	eor	x8, x3, x8
               	sub	x0, x0, x8
               	add	x8, x4, x1
               	eor	x0, x0, x8
               	mov	x17, #0x3               // =3
               	mul	x8, x4, x17
               	add	x0, x0, x8
               	lsr	x8, x0, #3
               	eor	x8, x4, x8
               	sub	x0, x0, x8
               	add	x8, x5, x1
               	eor	x0, x0, x8
               	mov	x17, #0x3               // =3
               	mul	x8, x5, x17
               	add	x0, x0, x8
               	lsr	x8, x0, #3
               	eor	x8, x5, x8
               	sub	x0, x0, x8
               	add	x8, x6, x1
               	eor	x0, x0, x8
               	mov	x17, #0x3               // =3
               	mul	x8, x6, x17
               	add	x0, x0, x8
               	lsr	x8, x0, #3
               	eor	x8, x6, x8
               	sub	x0, x0, x8
               	add	x8, x7, x1
               	eor	x0, x0, x8
               	mov	x17, #0x3               // =3
               	mul	x8, x7, x17
               	add	x0, x0, x8
               	lsr	x8, x0, #3
               	eor	x8, x7, x8
               	sub	x0, x0, x8
               	add	x1, x1, #0x1
               	cmp	w1, #0x64
               	b.lo	<addr>
               	eor	x1, x2, x3
               	eor	x1, x1, x4
               	eor	x1, x1, x5
               	eor	x1, x1, x6
               	eor	x1, x1, x7
               	eor	x1, x1, x9
               	eor	x1, x1, x10
               	eor	x1, x1, x11
               	eor	x1, x1, x12
               	eor	x1, x1, x13
               	eor	x1, x1, x14
               	eor	x1, x1, x15
               	eor	x1, x1, x20
               	eor	x1, x1, x21
               	eor	x1, x1, x22
               	eor	x0, x0, x1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

<weird>:
               	stp	x20, x21, [sp, #-0xb0]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	stp	x29, x30, [sp, #0xa0]
               	add	x29, sp, #0xa0
               	mov	x20, x1
               	mov	x21, #0x0               // =0
               	ldr	x1, [x0]
               	add	x22, x1, #0x1
               	ldr	x1, [x0, #0x8]
               	add	x23, x1, #0x2
               	ldr	x1, [x0, #0x10]
               	add	x24, x1, #0x3
               	ldr	x1, [x0, #0x18]
               	add	x25, x1, #0x4
               	ldr	x1, [x0, #0x20]
               	add	x26, x1, #0x5
               	ldr	x1, [x0, #0x28]
               	add	x27, x1, #0x6
               	ldr	x1, [x0, #0x30]
               	add	x28, x1, #0x7
               	ldr	x1, [x0, #0x38]
               	add	x16, x1, #0x8
               	str	x16, [sp, #0x98]
               	ldr	x2, [x0]
               	ldr	x3, [x0, #0x18]
               	eor	x16, x2, x3
               	str	x16, [sp, #0x88]
               	ldr	x2, [x0, #0x8]
               	ldr	x3, [x0, #0x28]
               	eor	x16, x2, x3
               	str	x16, [sp, #0x80]
               	ldr	x2, [x0, #0x10]
               	ldr	x3, [x0, #0x30]
               	eor	x16, x2, x3
               	str	x16, [sp, #0x78]
               	ldr	x2, [x0, #0x18]
               	eor	x16, x2, x1
               	str	x16, [sp, #0x70]
               	ldr	x1, [x0, #0x20]
               	ldr	x2, [x0]
               	add	x16, x1, x2
               	str	x16, [sp, #0x68]
               	ldr	x1, [x0, #0x28]
               	ldr	x2, [x0, #0x8]
               	add	x16, x1, x2
               	str	x16, [sp, #0x60]
               	ldr	x1, [x0, #0x30]
               	ldr	x2, [x0, #0x10]
               	add	x16, x1, x2
               	str	x16, [sp, #0x58]
               	ldr	x1, [x0, #0x38]
               	ldr	x0, [x0, #0x18]
               	add	x16, x1, x0
               	str	x16, [sp, #0x90]
               	cbnz	w20, <addr>
               	ldr	x17, [sp, #0x90]
               	eor	x0, x22, x17
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	blr	x1
               	tbz	w20, #0x0, <addr>
               	mov	x1, x21
               	b	<addr>
               	mov	x1, x21
               	b	<addr>
               	mov	w0, w21
               	add	x2, x26, x0
               	eor	x1, x1, x2
               	mov	x17, #0x3               // =3
               	mul	x2, x26, x17
               	add	x1, x1, x2
               	lsr	x2, x1, #3
               	eor	x2, x26, x2
               	sub	x1, x1, x2
               	add	x2, x27, x0
               	eor	x1, x1, x2
               	mov	x17, #0x3               // =3
               	mul	x2, x27, x17
               	add	x1, x1, x2
               	lsr	x2, x1, #3
               	eor	x2, x27, x2
               	sub	x1, x1, x2
               	add	x2, x28, x0
               	eor	x1, x1, x2
               	mov	x17, #0x3               // =3
               	mul	x2, x28, x17
               	add	x1, x1, x2
               	lsr	x2, x1, #3
               	eor	x2, x28, x2
               	sub	x2, x1, x2
               	ldr	x1, [sp, #0x98]
               	add	x3, x1, x0
               	eor	x2, x2, x3
               	mov	x17, #0x3               // =3
               	mul	x3, x1, x17
               	add	x2, x2, x3
               	lsr	x3, x2, #3
               	eor	x1, x1, x3
               	sub	x1, x2, x1
               	add	x21, x0, #0x1
               	sub	x20, x20, #0x1
               	cbz	w20, <addr>
               	mov	w0, w21
               	add	x2, x22, x0
               	eor	x1, x1, x2
               	mov	x17, #0x3               // =3
               	mul	x2, x22, x17
               	add	x1, x1, x2
               	lsr	x2, x1, #3
               	eor	x2, x22, x2
               	sub	x1, x1, x2
               	add	x2, x23, x0
               	eor	x1, x1, x2
               	mov	x17, #0x3               // =3
               	mul	x2, x23, x17
               	add	x1, x1, x2
               	lsr	x2, x1, #3
               	eor	x2, x23, x2
               	sub	x1, x1, x2
               	add	x2, x24, x0
               	eor	x1, x1, x2
               	mov	x17, #0x3               // =3
               	mul	x2, x24, x17
               	add	x1, x1, x2
               	lsr	x2, x1, #3
               	eor	x2, x24, x2
               	sub	x1, x1, x2
               	add	x0, x25, x0
               	eor	x0, x1, x0
               	mov	x17, #0x3               // =3
               	mul	x1, x25, x17
               	add	x0, x0, x1
               	lsr	x1, x0, #3
               	eor	x1, x25, x1
               	sub	x1, x0, x1
               	b	<addr>
               	eor	x0, x22, x23
               	eor	x0, x0, x24
               	eor	x0, x0, x25
               	eor	x0, x0, x26
               	eor	x0, x0, x27
               	eor	x0, x0, x28
               	ldr	x17, [sp, #0x98]
               	eor	x0, x0, x17
               	ldr	x17, [sp, #0x88]
               	eor	x0, x0, x17
               	ldr	x17, [sp, #0x80]
               	eor	x0, x0, x17
               	ldr	x17, [sp, #0x78]
               	eor	x0, x0, x17
               	ldr	x17, [sp, #0x70]
               	eor	x0, x0, x17
               	ldr	x17, [sp, #0x68]
               	eor	x0, x0, x17
               	ldr	x17, [sp, #0x60]
               	eor	x0, x0, x17
               	ldr	x17, [sp, #0x58]
               	eor	x0, x0, x17
               	ldr	x17, [sp, #0x90]
               	eor	x0, x0, x17
               	eor	x0, x1, x0
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xb0
               	ret

<main>:
               	str	x20, [sp, #-0x60]!
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	sub	x0, x29, #0x40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x1, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x1, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x1, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	mov	x1, #0x64               // =100
               	bl	<addr>
               	mov	x20, x0
               	sub	x0, x29, #0x40
               	mov	x1, #0x29               // =41
               	bl	<addr>
               	eor	x20, x20, x0
               	sub	x0, x29, #0x40
               	mov	x1, #0x28               // =40
               	bl	<addr>
               	eor	x0, x20, x0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	and	x0, x0, #0xff
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
