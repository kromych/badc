
asm_multiple_outputs.aarch64:	file format elf64-littleaarch64

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

<pair>:
               	mov	w0, #0x5678             // =22136
               	movk	w0, #0x1234, lsl #16
               	mov	w1, #0x9abc             // =39612
               	mov	w1, w1
               	lsl	x1, x1, #32
               	mov	w0, w0
               	orr	x0, x1, x0
               	ret

<four>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	w4, w0
               	str	x4, [sp]
               	ldr	x4, [sp]
               	mov	w9, w4
               	add	w0, w9, #0x0
               	add	w1, w9, #0x1
               	add	w2, w9, #0x2
               	add	w3, w9, #0x3
               	mov	x17, #0x3e8             // =1000
               	mul	x0, x0, x17
               	mov	x17, #0x64              // =100
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	mov	x17, #0xa               // =10
               	mul	x1, x2, x17
               	add	x0, x0, x1
               	add	x0, x0, x3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<dead>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x0, [sp]
               	ldr	x3, [sp]
               	add	x2, x3, #0x5
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x0, x2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<dead_bound>:
               	add	x0, x0, #0x3
               	mov	x16, #0x7               // =7
               	ret

<cas>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x5, x1
               	ldr	x6, [x5]
               	str	x0, [sp]
               	str	x6, [sp, #0x8]
               	str	x2, [sp, #0x10]
               	ldr	x2, [sp]
               	ldr	x3, [sp, #0x8]
               	ldr	x4, [sp, #0x10]
               	ldxr	x0, [x2]
               	cmp	x0, x3
               	b.ne	<addr>
               	stxr	w1, x4, [x2]
               	cbnz	w1, <addr>
               	cmp	x0, x6
               	cset	x1, eq
               	cbnz	w1, <addr>
               	str	x0, [x5]
               	mov	x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret

<sumdiff>:
               	add	x9, x0, x1
               	sub	x10, x0, x1
               	mov	x0, x9
               	mov	x1, x10
               	mov	x17, #0x64              // =100
               	mul	x0, x0, x17
               	add	x0, x0, x1
               	ret

<sink>:
               	add	x0, x0, #0x1
               	ret

<across>:
               	stp	x20, x21, [sp, #-0x50]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	str	x26, [sp, #0x30]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	mov	x20, x0
               	mov	x24, x4
               	mov	x23, x3
               	mov	x22, x2
               	mov	x21, x1
               	mov	x0, x20
               	bl	<addr>
               	mov	x25, x0
               	mov	x0, x21
               	bl	<addr>
               	mov	x26, x0
               	mov	x0, x22
               	bl	<addr>
               	mov	x22, x0
               	mov	x0, x23
               	bl	<addr>
               	mov	x23, x0
               	mov	x0, x24
               	bl	<addr>
               	mov	x24, x0
               	add	x9, x20, x21
               	sub	x10, x20, x21
               	mov	x20, x9
               	mov	x21, x10
               	mov	x0, x20
               	bl	<addr>
               	add	x1, x25, x26
               	add	x1, x1, x22
               	add	x1, x1, x23
               	add	x1, x1, x24
               	mov	x17, #0x3               // =3
               	mul	x2, x20, x17
               	add	x1, x1, x2
               	add	x1, x1, x21
               	add	x0, x1, x0
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x21, [x0]
               	ldr	x20, [x0, #0x8]
               	ldr	x22, [x0, #0x10]
               	ldr	x23, [x0, #0x18]
               	bl	<addr>
               	mov	x17, #0x5678            // =22136
               	movk	x17, #0x1234, lsl #16
               	movk	x17, #0x9abc, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, x21
               	bl	<addr>
               	mov	x17, #0x4d2             // =1234
               	eor	x0, x0, x17
               	cbz	w0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0xc
               	b.ne	<addr>
               	mov	x0, x20
               	bl	<addr>
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x5                // =5
               	stur	x0, [x29, #-0x10]
               	stur	x0, [x29, #-0x8]
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x8
               	mov	x2, #0x9                // =9
               	bl	<addr>
               	cbz	w0, <addr>
               	ldur	x0, [x29, #-0x10]
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x5                // =5
               	stur	x0, [x29, #-0x8]
               	sub	x0, x29, #0x10
               	sub	x1, x29, #0x8
               	mov	x2, #0xb                // =11
               	bl	<addr>
               	cbnz	w0, <addr>
               	ldur	x0, [x29, #-0x10]
               	cmp	x0, #0x9
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x8]
               	cmp	x0, #0x9
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, x20
               	mov	x1, x22
               	bl	<addr>
               	cmp	x0, #0x4b2
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, x21
               	mov	x4, x21
               	mov	x3, x23
               	mov	x2, x22
               	mov	x1, x20
               	bl	<addr>
               	cmp	x0, #0x37
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
