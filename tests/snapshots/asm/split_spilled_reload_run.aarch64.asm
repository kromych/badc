
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
               	mov	x1, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0]
               	add	x1, x2, x1
               	str	x1, [x0]
               	mov	x0, #0x0                // =0
               	ret

<hot>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x22, x23, [sp, #0x10]
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
               	add	x10, x8, #0x7
               	ldr	x8, [x0, #0x38]
               	add	x11, x8, #0x8
               	ldr	x9, [x0]
               	ldr	x12, [x0, #0x18]
               	eor	x12, x9, x12
               	ldr	x9, [x0, #0x8]
               	ldr	x13, [x0, #0x28]
               	eor	x13, x9, x13
               	ldr	x9, [x0, #0x10]
               	ldr	x14, [x0, #0x30]
               	eor	x14, x9, x14
               	ldr	x9, [x0, #0x18]
               	eor	x15, x9, x8
               	ldr	x8, [x0, #0x20]
               	ldr	x9, [x0]
               	add	x20, x8, x9
               	ldr	x8, [x0, #0x28]
               	ldr	x9, [x0, #0x8]
               	add	x21, x8, x9
               	ldr	x8, [x0, #0x30]
               	ldr	x9, [x0, #0x10]
               	add	x22, x8, x9
               	ldr	x8, [x0, #0x38]
               	ldr	x0, [x0, #0x18]
               	add	x23, x8, x0
               	mov	x8, x1
               	b	<addr>
               	add	x9, x2, x0
               	eor	x8, x8, x9
               	mov	x17, #0x3               // =3
               	mul	x9, x2, x17
               	add	x8, x8, x9
               	lsr	x9, x8, #3
               	eor	x9, x2, x9
               	sub	x8, x8, x9
               	add	x9, x3, x0
               	eor	x8, x8, x9
               	mov	x17, #0x3               // =3
               	mul	x9, x3, x17
               	add	x8, x8, x9
               	lsr	x9, x8, #3
               	eor	x9, x3, x9
               	sub	x8, x8, x9
               	add	x9, x4, x0
               	eor	x8, x8, x9
               	mov	x17, #0x3               // =3
               	mul	x9, x4, x17
               	add	x8, x8, x9
               	lsr	x9, x8, #3
               	eor	x9, x4, x9
               	sub	x8, x8, x9
               	add	x9, x5, x0
               	eor	x8, x8, x9
               	mov	x17, #0x3               // =3
               	mul	x9, x5, x17
               	add	x8, x8, x9
               	lsr	x9, x8, #3
               	eor	x9, x5, x9
               	sub	x8, x8, x9
               	add	x9, x6, x0
               	eor	x8, x8, x9
               	mov	x17, #0x3               // =3
               	mul	x9, x6, x17
               	add	x8, x8, x9
               	lsr	x9, x8, #3
               	eor	x9, x6, x9
               	sub	x8, x8, x9
               	add	x9, x7, x0
               	eor	x8, x8, x9
               	mov	x17, #0x3               // =3
               	mul	x9, x7, x17
               	add	x8, x8, x9
               	lsr	x9, x8, #3
               	eor	x9, x7, x9
               	sub	x8, x8, x9
               	add	x1, x0, #0x1
               	mov	w0, w1
               	cmp	x0, #0x64
               	b.lo	<addr>
               	eor	x0, x2, x3
               	eor	x0, x0, x4
               	eor	x0, x0, x5
               	eor	x0, x0, x6
               	eor	x0, x0, x7
               	eor	x0, x0, x10
               	eor	x0, x0, x11
               	eor	x0, x0, x12
               	eor	x0, x0, x13
               	eor	x0, x0, x14
               	eor	x0, x0, x15
               	eor	x0, x0, x20
               	eor	x0, x0, x21
               	eor	x0, x0, x22
               	eor	x0, x0, x23
               	eor	x0, x8, x0
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

<weird>:
               	stp	x20, x21, [sp, #-0xc0]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	str	x19, [sp, #0x50]
               	stp	x29, x30, [sp, #0xb0]
               	add	x29, sp, #0xb0
               	str	x1, [sp, #0xa8]
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
               	str	x16, [sp, #0xa0]
               	ldr	x2, [x0]
               	ldr	x3, [x0, #0x18]
               	eor	x16, x2, x3
               	str	x16, [sp, #0x90]
               	ldr	x2, [x0, #0x8]
               	ldr	x3, [x0, #0x28]
               	eor	x16, x2, x3
               	str	x16, [sp, #0x88]
               	ldr	x2, [x0, #0x10]
               	ldr	x3, [x0, #0x30]
               	eor	x16, x2, x3
               	str	x16, [sp, #0x80]
               	ldr	x2, [x0, #0x18]
               	eor	x16, x2, x1
               	str	x16, [sp, #0x78]
               	ldr	x1, [x0, #0x20]
               	ldr	x2, [x0]
               	add	x16, x1, x2
               	str	x16, [sp, #0x70]
               	ldr	x1, [x0, #0x28]
               	ldr	x2, [x0, #0x8]
               	add	x16, x1, x2
               	str	x16, [sp, #0x68]
               	ldr	x1, [x0, #0x30]
               	ldr	x2, [x0, #0x10]
               	add	x16, x1, x2
               	str	x16, [sp, #0x60]
               	ldr	x1, [x0, #0x38]
               	ldr	x0, [x0, #0x18]
               	add	x16, x1, x0
               	str	x16, [sp, #0x98]
               	ldr	x16, [sp, #0xa8]
               	mov	w20, w16
               	cbnz	x20, <addr>
               	ldr	x17, [sp, #0x98]
               	eor	x1, x22, x17
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	ldr	x16, [sp, #0xa8]
               	mov	w0, w16
               	mov	x17, #0x1               // =1
               	and	x0, x0, x17
               	cbz	x0, <addr>
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
               	ldr	x1, [sp, #0xa0]
               	add	x3, x1, x0
               	eor	x2, x2, x3
               	mov	x17, #0x3               // =3
               	mul	x3, x1, x17
               	add	x2, x2, x3
               	lsr	x3, x2, #3
               	eor	x1, x1, x3
               	sub	x1, x2, x1
               	add	x21, x0, #0x1
               	mov	w0, w20
               	sub	x20, x0, #0x1
               	mov	w0, w20
               	cbnz	x0, <addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
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
               	ldr	x17, [sp, #0xa0]
               	eor	x0, x0, x17
               	ldr	x17, [sp, #0x90]
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
               	ldr	x17, [sp, #0x98]
               	eor	x0, x0, x17
               	eor	x0, x1, x0
               	ldp	x29, x30, [sp, #0xb0]
               	ldr	x19, [sp, #0x50]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xc0
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x70]!
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	sub	x20, x29, #0x40
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x20]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x20, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x20, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x20, #0x18]
               	ldr	x10, [x0, #0x20]
               	str	x10, [x20, #0x20]
               	ldr	x10, [x0, #0x28]
               	str	x10, [x20, #0x28]
               	ldr	x10, [x0, #0x30]
               	str	x10, [x20, #0x30]
               	ldr	x10, [x0, #0x38]
               	str	x10, [x20, #0x38]
               	ldr	x10, [sp], #0x10
               	mov	x0, x20
               	mov	x1, #0x64               // =100
               	mov	x0, x20
               	bl	<addr>
               	mov	x21, x0
               	mov	x1, #0x29               // =41
               	mov	x0, x20
               	bl	<addr>
               	eor	x21, x21, x0
               	mov	x1, #0x28               // =40
               	mov	x0, x20
               	bl	<addr>
               	eor	x1, x21, x0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
               	mov	x17, #0xff              // =255
               	and	x0, x1, x17
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x60]
               	ldp	x20, x21, [sp], #0x70
               	ret
