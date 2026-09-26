
int128_struct_member.aarch64:	file format elf64-littleaarch64

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

<read_wide>:
               	add	x1, x0, #0x10
               	ldr	x0, [x1]
               	ldr	x1, [x1, #0x8]
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x60]!
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x20, [x0]
               	mov	x0, #0x0                // =0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	orr	x21, x0, x1
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x1
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x20]
               	cmp	w1, #0x2
               	b.ne	<addr>
               	ldr	x1, [x0, #0x10]
               	ldr	x0, [x0, #0x18]
               	eor	x1, x1, x21
               	eor	x0, x0, x20
               	orr	x0, x1, x0
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x1, x1, x21
               	eor	x0, x0, x20
               	orr	x0, x1, x0
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldr	x2, [x0, #0x8]
               	eor	x2, x2, #0x1000000000
               	orr	x1, x1, x2
               	cbnz	x1, <addr>
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0x1000000000      // =68719476736
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	eor	x0, x21, #0x4
               	mov	x17, #0x9               // =9
               	eor	x1, x20, x17
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	eor	x0, x21, x21
               	eor	x1, x20, x20
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	sub	x0, x29, #0x40
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	add	x1, x0, #0x10
               	str	x21, [x1]
               	str	x20, [x1, #0x8]
               	ldr	x2, [x1]
               	ldr	x4, [x0, #0x18]
               	add	x3, x2, #0x3
               	cmp	x3, x2
               	cset	x2, lo
               	add	x4, x4, #0x1
               	add	x2, x4, x2
               	str	x3, [x1]
               	str	x2, [x1, #0x8]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	str	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	eor	x0, x0, #0x7
               	mov	x17, #0xa               // =10
               	eor	x1, x1, x17
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	sub	x0, x29, #0x40
               	add	x1, x0, #0x10
               	str	xzr, [x1]
               	str	xzr, [x1, #0x8]
               	str	x21, [x1]
               	str	x20, [x1, #0x8]
               	bl	<addr>
               	stur	x0, [x29, #-0x10]
               	sub	x0, x29, #0x10
               	str	x1, [x0, #0x8]
               	ldr	x0, [x0]
               	eor	x0, x0, x21
               	eor	x1, x1, x20
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x50]
               	ldp	x20, x21, [sp], #0x60
               	ret
