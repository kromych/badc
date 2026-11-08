
int128_unary.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x0                // =0
               	sub	x3, x29, #0x50
               	stur	x0, [x29, #-0x50]
               	stur	x0, [x29, #-0x48]
               	adrp	x2, <page>
               	ldr	x1, [x2, #0x18]
               	lsl	x4, x1, #36
               	sub	x1, x29, #0x40
               	stur	x0, [x29, #-0x40]
               	stur	x4, [x29, #-0x38]
               	cbnz	x4, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x4, [x29, #-0x38]
               	neg	x4, x4
               	mov	x17, #-0x1000000000     // =-68719476736
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x4, #0x3                // =3
               	cbz	x4, <addr>
               	mov	x0, x4
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x4, [x29, #-0x38]
               	cbnz	x4, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x4, [x29, #-0x38]
               	cbz	x4, <addr>
               	ldur	x4, [x29, #-0x38]
               	cbz	x4, <addr>
               	ldur	x4, [x29, #-0x38]
               	cbnz	x4, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x4, [x2, #0x18]
               	cbz	x4, <addr>
               	mov	x3, x1
               	ldr	x4, [x3]
               	ldr	x3, [x3, #0x8]
               	cbnz	x4, <addr>
               	mov	x17, #0x1000000000      // =68719476736
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x3, #0x8                // =8
               	cbz	x3, <addr>
               	mov	x0, x3
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x3, [x2, #0x18]
               	cbz	x3, <addr>
               	ldr	x3, [x1]
               	ldr	x1, [x1, #0x8]
               	cbnz	x3, <addr>
               	mov	x17, #0x1000000000      // =68719476736
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0xc                // =12
               	cbz	x0, <addr>
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x2, #0x18]
               	cbz	x0, <addr>
               	ldur	x0, [x29, #-0x38]
               	neg	x2, x0
               	sub	x0, x29, #0x20
               	stur	xzr, [x29, #-0x20]
               	stur	x2, [x29, #-0x18]
               	ldr	x1, [x0]
               	ldr	x0, [x0, #0x8]
               	cbnz	x1, <addr>
               	mov	x17, #-0x1000000000     // =-68719476736
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	cbz	x0, <addr>
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x0
               	cset	x1, hi
               	neg	x2, x0
               	neg	x1, x1
               	asr	x3, x1, #4
               	lsr	x0, x2, #4
               	orr	x4, x0, x1, lsl #60
               	mov	x0, #-0x1               // =-1
               	cmp	x4, x0
               	b.ne	<addr>
               	cmp	w3, w0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	cbz	x0, <addr>
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x0, [x29, #-0x38]
               	cmp	x0, x1
               	cset	x3, lo
               	cmp	x0, x1
               	cset	x0, eq
               	cmp	x2, #0x0
               	cset	x1, hi
               	and	x0, x0, x1
               	orr	x0, x3, x0
               	cbnz	w0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	sub	x0, x29, #0x10
               	stur	xzr, [x29, #-0x10]
               	stur	xzr, [x29, #-0x8]
               	b	<addr>
               	sub	x1, x29, #0x30
               	stur	x0, [x29, #-0x30]
               	stur	x0, [x29, #-0x28]
               	b	<addr>
               	mov	x3, x0
               	b	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x50
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x4, x0
               	b	<addr>
