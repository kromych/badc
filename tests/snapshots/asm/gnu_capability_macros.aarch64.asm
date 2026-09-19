
gnu_capability_macros.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x50
               	mov	x1, #0x0                // =0
               	sturb	w1, [x29, #-0x48]
               	sub	x2, x29, #0x48
               	mov	x0, #0x1                // =1
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x2
               	mov	x10, x0
               	ldaxrb	w16, [x9]
               	stlxrb	w12, w10, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x3, x16
               	and	x3, x3, #0xff
               	cbz	x3, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldurb	w3, [x29, #-0x48]
               	eor	x3, x3, #0x1
               	cmp	w3, #0x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x2
               	mov	x10, x0
               	ldaxrb	w16, [x9]
               	stlxrb	w12, w10, [x9]
               	cbnz	x12, <addr>
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x3, x16
               	and	x3, x3, #0xff
               	cbnz	x3, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stlrb	w1, [x2]
               	ldurb	w2, [x29, #-0x48]
               	cbz	x2, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sturb	w0, [x29, #-0x40]
               	sturh	w0, [x29, #-0x38]
               	stur	w0, [x29, #-0x30]
               	stur	x0, [x29, #-0x28]
               	sub	x4, x29, #0x40
               	mov	x2, #0x2                // =2
               	sub	x3, x29, #0x20
               	strb	w0, [x3]
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x4
               	mov	x10, x3
               	mov	x11, x2
               	ldrb	w12, [x10]
               	ldaxrb	w16, [x9]
               	cmp	x16, x12
               	b.ne	<addr>
               	stlxrb	w17, w11, [x9]
               	cbnz	x17, <addr>
               	mov	x16, #0x1               // =1
               	b	<addr>
               	strb	w16, [x10]
               	mov	x16, #0x0               // =0
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x3, x16
               	cbz	x3, <addr>
               	ldurb	w3, [x29, #-0x40]
               	eor	x3, x3, #0x2
               	cmp	w3, #0x0
               	cset	x3, ne
               	cbz	x3, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x38
               	sub	x3, x29, #0x18
               	strh	w0, [x3]
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x4
               	mov	x10, x3
               	mov	x11, x2
               	ldrh	w12, [x10]
               	ldaxrh	w16, [x9]
               	cmp	x16, x12
               	b.ne	<addr>
               	stlxrh	w17, w11, [x9]
               	cbnz	x17, <addr>
               	mov	x16, #0x1               // =1
               	b	<addr>
               	strh	w16, [x10]
               	mov	x16, #0x0               // =0
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x3, x16
               	cbz	x3, <addr>
               	ldursh	x3, [x29, #-0x38]
               	cmp	w3, #0x2
               	cset	x3, ne
               	cbz	x3, <addr>
               	mov	x0, #0x8                // =8
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x30
               	sub	x3, x29, #0x10
               	str	w0, [x3]
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x4
               	mov	x10, x3
               	mov	x11, x2
               	ldr	w12, [x10]
               	ldaxr	w16, [x9]
               	cmp	x16, x12
               	b.ne	<addr>
               	stlxr	w17, w11, [x9]
               	cbnz	x17, <addr>
               	mov	x16, #0x1               // =1
               	b	<addr>
               	str	w16, [x10]
               	mov	x16, #0x0               // =0
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x3, x16
               	cbz	x3, <addr>
               	ldursw	x3, [x29, #-0x30]
               	cmp	w3, #0x2
               	cset	x3, ne
               	cbz	x3, <addr>
               	mov	x0, #0x9                // =9
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x4, x29, #0x28
               	sub	x3, x29, #0x8
               	str	x0, [x3]
               	stp	x9, x10, [sp, #-0x20]!
               	stp	x11, x12, [sp, #0x10]
               	mov	x9, x4
               	mov	x10, x3
               	mov	x11, x2
               	ldr	x12, [x10]
               	ldaxr	x16, [x9]
               	cmp	x16, x12
               	b.ne	<addr>
               	stlxr	w17, x11, [x9]
               	cbnz	x17, <addr>
               	mov	x16, #0x1               // =1
               	b	<addr>
               	str	x16, [x10]
               	mov	x16, #0x0               // =0
               	ldp	x11, x12, [sp, #0x10]
               	ldp	x9, x10, [sp], #0x20
               	mov	x0, x16
               	cbz	x0, <addr>
               	ldur	x0, [x29, #-0x28]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, x1
               	mov	x0, x1
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
