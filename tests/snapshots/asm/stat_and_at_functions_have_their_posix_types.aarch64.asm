
stat_and_at_functions_have_their_posix_types.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xf0
               	str	x20, [sp]
               	sub	x0, x29, #0xb8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	ldr	w16, [x1, #0x10]
               	str	w16, [x0, #0x10]
               	sub	x1, x29, #0xa0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldp	x16, x17, [x2]
               	stp	x16, x17, [x1]
               	ldp	x16, x17, [x2, #0x10]
               	stp	x16, x17, [x1, #0x10]
               	bl	<addr>
               	cbnz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xb8
               	mov	x1, #0x0                // =0
               	bl	<addr>
               	mov	x20, x0
               	cmp	w20, #0x0
               	b.lt	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x1c0              // =448
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x180              // =384
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x41               // =65
               	mov	x3, #0x180              // =384
               	mov	x0, x20
               	bl	<addr>
               	mov	x2, x0
               	cmp	w2, #0x0
               	b.lt	<addr>
               	sub	x1, x29, #0xa0
               	str	x2, [sp, #0x10]
               	mov	x0, x2
               	bl	<addr>
               	sxtw	x0, w0
               	ldr	x2, [sp, #0x10]
               	cbnz	x0, <addr>
               	mov	x1, #0x1a0              // =416
               	str	x2, [sp, #0x10]
               	mov	x0, x2
               	bl	<addr>
               	sxtw	x0, w0
               	ldr	x2, [sp, #0x10]
               	cbnz	x0, <addr>
               	mov	x0, x2
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x80
               	mov	x3, #0x0                // =0
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldur	w0, [x29, #-0x70]
               	and	x0, x0, #0x1ff
               	cmp	w0, #0x1a0
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x28]
               	mov	x17, #0xca00            // =51712
               	movk	x17, #0x3b9a, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0xa0
               	mov	x3, #0x0                // =0
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x1e8              // =488
               	mov	x3, #0x0                // =0
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x4                // =4
               	mov	x3, #0x0                // =0
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0xc8
               	mov	x3, #0x10               // =16
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0x4
               	b.ne	<addr>
               	sub	x0, x29, #0xc8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x4                // =4
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x4, #0x0                // =0
               	mov	x0, x20
               	mov	x2, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	mov	x0, x20
               	mov	x2, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sub	x2, x29, #0x80
               	mov	x3, #0x0                // =0
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	ldur	w0, [x29, #-0x6c]
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	str	x0, [sp, #0x18]
               	bl	<addr>
               	mov	x3, x0
               	mov	x4, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x20
               	ldr	x2, [sp, #0x18]
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	x1, [x0, #0x10]
               	mov	x2, #0x0                // =0
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0, #0x8]
               	mov	x2, #0x0                // =0
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0, #0x10]
               	mov	x2, #0x0                // =0
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0, #0x18]
               	mov	x2, #0x0                // =0
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, #0x12               // =18
               	bl	<addr>
               	bl	<addr>
               	cmp	w0, #0x12
               	b.ne	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x200              // =512
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xb8
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x1, #0xb                // =11
               	mov	x2, #0x0                // =0
               	cmp	x0, #0x0
               	csel	x0, x1, x2, ne
               	ldr	x20, [sp]
               	add	sp, sp, #0xf0
               	ldp	x29, x30, [sp], #0x10
               	ret
