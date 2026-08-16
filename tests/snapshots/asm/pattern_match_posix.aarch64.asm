
pattern_match_posix.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x20, x21, [sp, #-0x90]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	mov	x20, #0x0               // =0
               	b	<addr>
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	sxtw	x0, w20
               	mov	x17, #0x18              // =24
               	mul	x0, x0, x17
               	add	x0, x21, x0
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	ldrsw	x0, [x0, #0x10]
               	mov	x16, x1
               	mov	x1, x2
               	mov	x2, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	sxtw	x1, w0
               	sxtw	x0, w20
               	mov	x17, #0x18              // =24
               	mul	x0, x0, x17
               	add	x0, x21, x0
               	ldrsw	x0, [x0, #0x14]
               	cmp	x1, x0
               	b.ne	<addr>
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	sxtw	x0, w20
               	cmp	x0, #0x37
               	b.lt	<addr>
               	mov	x20, #0x0               // =0
               	b	<addr>
               	sub	x1, x29, #0x40
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x2, w20
               	mov	x17, #0x30              // =48
               	mul	x2, x2, x17
               	add	x0, x0, x2
               	ldr	x2, [x0]
               	ldrsw	x0, [x0, #0x8]
               	mov	x16, x1
               	mov	x1, x2
               	mov	x2, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	sub	x1, x29, #0x50
               	mov	x0, #0xfffe             // =65534
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	str	w0, [x1]
               	sub	x1, x29, #0x50
               	str	w0, [x1, #0x4]
               	sub	x1, x29, #0x50
               	str	w0, [x1, #0x8]
               	sub	x1, x29, #0x50
               	str	w0, [x1, #0xc]
               	sub	x2, x29, #0x40
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x1, w20
               	mov	x17, #0x30              // =48
               	mul	x1, x1, x17
               	add	x1, x0, x1
               	ldr	x1, [x1, #0x10]
               	mov	x3, #0x2                // =2
               	sub	x4, x29, #0x50
               	sxtw	x5, w20
               	mov	x17, #0x30              // =48
               	mul	x5, x5, x17
               	add	x0, x0, x5
               	ldrsw	x0, [x0, #0x18]
               	mov	x16, x2
               	mov	x2, x3
               	mov	x3, x4
               	mov	x4, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x2, w0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sxtw	x3, w20
               	mov	x17, #0x30              // =48
               	mul	x3, x3, x17
               	add	x1, x1, x3
               	ldrsw	x1, [x1, #0x1c]
               	cmp	x2, x1
               	b.ne	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	sub	x0, x29, #0x50
               	ldrsw	x1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x2, w20
               	mov	x17, #0x30              // =48
               	mul	x2, x2, x17
               	add	x0, x0, x2
               	ldrsw	x0, [x0, #0x20]
               	cmp	x1, x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x50
               	ldrsw	x1, [x0, #0x4]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x2, w20
               	mov	x17, #0x30              // =48
               	mul	x2, x2, x17
               	add	x0, x0, x2
               	ldrsw	x0, [x0, #0x24]
               	cmp	x1, x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	mov	x1, #0x1                // =1
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x50
               	ldrsw	x1, [x0, #0x8]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x2, w20
               	mov	x17, #0x30              // =48
               	mul	x2, x2, x17
               	add	x0, x0, x2
               	ldrsw	x0, [x0, #0x28]
               	cmp	x1, x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x1, ne
               	mov	x0, #0x1                // =1
               	cbnz	x1, <addr>
               	sub	x0, x29, #0x50
               	ldrsw	x1, [x0, #0xc]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sxtw	x2, w20
               	mov	x17, #0x30              // =48
               	mul	x2, x2, x17
               	add	x0, x0, x2
               	ldrsw	x0, [x0, #0x2c]
               	cmp	x1, x0
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x40
               	bl	<addr>
               	uxtb	w0, w0
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	b	<addr>
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	sxtw	x0, w20
               	cmp	x0, #0x2f
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	sub	x0, x29, #0x40
               	bl	<addr>
               	uxtb	w0, w0
               	add	x0, x20, #0x38
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	sub	x0, x29, #0x40
               	bl	<addr>
               	uxtb	w0, w0
               	add	x0, x20, #0x38
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	add	x0, x20, #0x38
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	add	x0, x20, #0x1
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x80]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x90
               	ret
