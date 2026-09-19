
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
               	add	x0, x0, #0x10
               	mov	x16, x0
               	ldr	x1, [x16, #0x8]
               	ldr	x0, [x16]
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x140]!
               	stp	x29, x30, [sp, #0x130]
               	add	x29, sp, #0x130
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	mov	x0, #0x0                // =0
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	orr	x20, x0, x2
               	orr	x21, x1, x0
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
               	eor	x1, x1, x20
               	eor	x0, x0, x21
               	orr	x0, x1, x0
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x130]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x1, x1, x20
               	eor	x0, x0, x21
               	orr	x0, x1, x0
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x130]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0x0               // =0
               	eor	x1, x1, x17
               	eor	x0, x0, #0x1000000000
               	orr	x0, x1, x0
               	cbnz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0x1000000000      // =68719476736
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x130]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	eor	x0, x20, #0x4
               	mov	x17, #0x9               // =9
               	eor	x1, x21, x17
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x130]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	eor	x0, x20, x20
               	eor	x1, x21, x21
               	orr	x0, x0, x1
               	cbz	x0, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x130]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	sub	x0, x29, #0xb0
               	stp	xzr, xzr, [x0]
               	stp	xzr, xzr, [x0, #0x10]
               	stp	xzr, xzr, [x0, #0x20]
               	mov	x1, #0x1                // =1
               	str	w1, [x0]
               	add	x1, x0, #0x10
               	str	x20, [x1]
               	str	x21, [x1, #0x8]
               	mov	x2, #0x2                // =2
               	str	w2, [x0, #0x20]
               	ldr	x2, [x1]
               	ldr	x4, [x0, #0x18]
               	add	x3, x2, #0x3
               	cmp	x3, x2
               	cset	x2, lo
               	add	x4, x4, #0x1
               	add	x2, x4, x2
               	str	x3, [x1]
               	str	x2, [x1, #0x8]
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	str	w1, [x0]
               	cmp	w1, #0x2
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x20]
               	cmp	w1, #0x2
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp, #0x130]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	bl	<addr>
               	stur	x0, [x29, #-0x40]
               	stur	x1, [x29, #-0x38]
               	sub	x0, x29, #0x40
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x1, x1, #0x7
               	mov	x17, #0xa               // =10
               	eor	x0, x0, x17
               	orr	x0, x1, x0
               	cbz	x0, <addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp, #0x130]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	sub	x0, x29, #0xb0
               	add	x1, x0, #0x10
               	mov	x2, #0x0                // =0
               	str	x2, [x1]
               	str	x2, [x1, #0x8]
               	ldrsw	x2, [x0]
               	cmp	w2, #0x2
               	b.ne	<addr>
               	ldrsw	x2, [x0, #0x20]
               	cmp	w2, #0x2
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	ldp	x29, x30, [sp, #0x130]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	str	x20, [x1]
               	str	x21, [x1, #0x8]
               	bl	<addr>
               	stur	x0, [x29, #-0x40]
               	stur	x1, [x29, #-0x38]
               	sub	x0, x29, #0x40
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	eor	x1, x1, x20
               	eor	x0, x0, x21
               	orr	x0, x1, x0
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	ldp	x29, x30, [sp, #0x130]
               	ldp	x20, x21, [sp], #0x140
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x130]
               	ldp	x20, x21, [sp], #0x140
               	ret
