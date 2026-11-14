
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
               	ldr	x2, [x1, #0x30]
               	add	x0, x2, x0
               	str	x0, [x1, #0x30]
               	ret

<hot>:
               	stp	x20, x21, [sp, #-0x60]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	mov	x1, #0x0                // =0
               	ldr	x8, [x0]
               	add	x2, x8, #0x1
               	ldr	x3, [x0, #0x8]
               	add	x3, x3, #0x2
               	ldr	x4, [x0, #0x10]
               	add	x4, x4, #0x3
               	ldr	x9, [x0, #0x18]
               	add	x5, x9, #0x4
               	ldr	x6, [x0, #0x20]
               	add	x6, x6, #0x5
               	ldr	x10, [x0, #0x28]
               	add	x7, x10, #0x6
               	ldr	x11, [x0, #0x30]
               	add	x15, x11, #0x7
               	ldr	x12, [x0, #0x38]
               	add	x20, x12, #0x8
               	eor	x21, x8, x9
               	ldr	x8, [x0, #0x8]
               	eor	x22, x8, x10
               	ldr	x9, [x0, #0x10]
               	eor	x23, x9, x11
               	ldr	x10, [x0, #0x18]
               	eor	x24, x10, x12
               	ldr	x11, [x0, #0x20]
               	ldr	x12, [x0]
               	add	x25, x11, x12
               	ldr	x11, [x0, #0x28]
               	add	x26, x11, x8
               	ldr	x8, [x0, #0x30]
               	add	x27, x8, x9
               	ldr	x0, [x0, #0x38]
               	add	x28, x0, x10
               	add	x8, x2, x2, lsl #1
               	add	x9, x3, x3, lsl #1
               	add	x10, x4, x4, lsl #1
               	add	x11, x5, x5, lsl #1
               	add	x12, x6, x6, lsl #1
               	add	x13, x7, x7, lsl #1
               	mov	x0, x1
               	add	x14, x2, x1
               	eor	x0, x0, x14
               	add	x0, x0, x8
               	eor	x14, x2, x0, lsr #3
               	sub	x0, x0, x14
               	add	x14, x3, x1
               	eor	x0, x0, x14
               	add	x0, x0, x9
               	eor	x14, x3, x0, lsr #3
               	sub	x0, x0, x14
               	add	x14, x4, x1
               	eor	x0, x0, x14
               	add	x0, x0, x10
               	eor	x14, x4, x0, lsr #3
               	sub	x0, x0, x14
               	add	x14, x5, x1
               	eor	x0, x0, x14
               	add	x0, x0, x11
               	eor	x14, x5, x0, lsr #3
               	sub	x0, x0, x14
               	add	x14, x6, x1
               	eor	x0, x0, x14
               	add	x0, x0, x12
               	eor	x14, x6, x0, lsr #3
               	sub	x0, x0, x14
               	add	x14, x7, x1
               	eor	x0, x0, x14
               	add	x0, x0, x13
               	eor	x14, x7, x0, lsr #3
               	sub	x0, x0, x14
               	add	x1, x1, #0x1
               	cmp	w1, #0x64
               	b.lo	<addr>
               	eor	x1, x2, x3
               	eor	x1, x1, x4
               	eor	x1, x1, x5
               	eor	x1, x1, x6
               	eor	x1, x1, x7
               	eor	x1, x1, x15
               	eor	x1, x1, x20
               	eor	x1, x1, x21
               	eor	x1, x1, x22
               	eor	x1, x1, x23
               	eor	x1, x1, x24
               	eor	x1, x1, x25
               	eor	x1, x1, x26
               	eor	x1, x1, x27
               	eor	x1, x1, x28
               	eor	x0, x0, x1
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret

<weird>:
               	stp	x20, x21, [sp, #-0xa0]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	stp	x29, x30, [sp, #0x90]
               	add	x29, sp, #0x90
               	mov	x20, x1
               	ldr	x1, [x0]
               	add	x21, x1, #0x1
               	ldr	x2, [x0, #0x8]
               	add	x22, x2, #0x2
               	ldr	x2, [x0, #0x10]
               	add	x23, x2, #0x3
               	ldr	x2, [x0, #0x18]
               	add	x24, x2, #0x4
               	ldr	x3, [x0, #0x20]
               	add	x25, x3, #0x5
               	ldr	x3, [x0, #0x28]
               	add	x26, x3, #0x6
               	ldr	x4, [x0, #0x30]
               	add	x27, x4, #0x7
               	ldr	x5, [x0, #0x38]
               	add	x28, x5, #0x8
               	eor	x6, x1, x2
               	ldr	x1, [x0, #0x8]
               	eor	x7, x1, x3
               	ldr	x2, [x0, #0x10]
               	eor	x8, x2, x4
               	ldr	x3, [x0, #0x18]
               	eor	x5, x3, x5
               	ldr	x4, [x0, #0x20]
               	ldr	x9, [x0]
               	add	x9, x4, x9
               	ldr	x4, [x0, #0x28]
               	add	x10, x4, x1
               	ldr	x1, [x0, #0x30]
               	add	x11, x1, x2
               	ldr	x0, [x0, #0x38]
               	add	x4, x0, x3
               	cbnz	w20, <addr>
               	eor	x0, x21, x4
               	adrp	x1, <page>
               	ldr	x1, [x1, <lo12>]
               	str	x6, [sp, #0x88]
               	str	x7, [sp, #0x80]
               	str	x8, [sp, #0x78]
               	str	x5, [sp, #0x70]
               	str	x9, [sp, #0x68]
               	str	x10, [sp, #0x60]
               	str	x11, [sp, #0x58]
               	str	x4, [sp, #0x50]
               	blr	x1
               	ldr	x6, [sp, #0x88]
               	ldr	x7, [sp, #0x80]
               	ldr	x8, [sp, #0x78]
               	ldr	x5, [sp, #0x70]
               	ldr	x9, [sp, #0x68]
               	ldr	x10, [sp, #0x60]
               	ldr	x11, [sp, #0x58]
               	ldr	x4, [sp, #0x50]
               	tbz	w20, #0x0, <addr>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	mov	w0, w0
               	add	x2, x25, x0
               	eor	x1, x1, x2
               	add	x2, x25, x25, lsl #1
               	add	x1, x1, x2
               	eor	x2, x25, x1, lsr #3
               	sub	x1, x1, x2
               	add	x2, x26, x0
               	eor	x1, x1, x2
               	add	x2, x26, x26, lsl #1
               	add	x1, x1, x2
               	eor	x2, x26, x1, lsr #3
               	sub	x1, x1, x2
               	add	x2, x27, x0
               	eor	x1, x1, x2
               	add	x2, x27, x27, lsl #1
               	add	x1, x1, x2
               	eor	x2, x27, x1, lsr #3
               	sub	x1, x1, x2
               	add	x2, x28, x0
               	eor	x1, x1, x2
               	add	x2, x28, x28, lsl #1
               	add	x1, x1, x2
               	eor	x2, x28, x1, lsr #3
               	sub	x2, x1, x2
               	add	x0, x0, #0x1
               	subs	w20, w20, #0x1
               	b.ne	<addr>
               	eor	x0, x21, x22
               	eor	x0, x0, x23
               	eor	x0, x0, x24
               	eor	x0, x0, x25
               	eor	x0, x0, x26
               	eor	x0, x0, x27
               	eor	x0, x0, x28
               	eor	x0, x0, x6
               	eor	x0, x0, x7
               	eor	x0, x0, x8
               	eor	x0, x0, x5
               	eor	x0, x0, x9
               	eor	x0, x0, x10
               	eor	x0, x0, x11
               	eor	x0, x0, x4
               	eor	x0, x2, x0
               	ldp	x29, x30, [sp, #0x90]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0xa0
               	ret
               	mov	w1, w0
               	add	x3, x21, x1
               	eor	x2, x2, x3
               	add	x3, x21, x21, lsl #1
               	add	x2, x2, x3
               	eor	x3, x21, x2, lsr #3
               	sub	x2, x2, x3
               	add	x3, x22, x1
               	eor	x2, x2, x3
               	add	x3, x22, x22, lsl #1
               	add	x2, x2, x3
               	eor	x3, x22, x2, lsr #3
               	sub	x2, x2, x3
               	add	x3, x23, x1
               	eor	x2, x2, x3
               	add	x3, x23, x23, lsl #1
               	add	x2, x2, x3
               	eor	x3, x23, x2, lsr #3
               	sub	x2, x2, x3
               	add	x1, x24, x1
               	eor	x1, x2, x1
               	add	x2, x24, x24, lsl #1
               	add	x1, x1, x2
               	eor	x2, x24, x1, lsr #3
               	sub	x1, x1, x2
               	b	<addr>
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	b	<addr>

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
               	ldr	x1, [x1, <lo12>]
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
               	and	x0, x0, #0xff
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x20, [sp], #0x60
               	ret
