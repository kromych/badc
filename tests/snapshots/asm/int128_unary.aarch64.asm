
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
               	sub	sp, sp, #0x20
               	mov	x0, #0x0                // =0
               	sub	x4, x29, #0x20
               	stur	x0, [x29, #-0x20]
               	stur	x0, [x29, #-0x18]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	lsl	x3, x2, #36
               	sub	x2, x29, #0x10
               	stur	x0, [x29, #-0x10]
               	stur	x3, [x29, #-0x8]
               	cbnz	x3, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x3, [x29, #-0x8]
               	neg	x3, x3
               	mov	x17, #-0x1000000000     // =-68719476736
               	cmp	x3, x17
               	b.eq	<addr>
               	mov	x3, #0x3                // =3
               	cbz	x3, <addr>
               	mov	x0, x3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x3, [x29, #-0x8]
               	cbnz	x3, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x3, [x29, #-0x8]
               	cbz	x3, <addr>
               	ldur	x3, [x29, #-0x8]
               	cbz	x3, <addr>
               	ldur	x3, [x29, #-0x8]
               	cbnz	x3, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x3, [x1]
               	cbz	x3, <addr>
               	ldr	x3, [x2]
               	ldr	x2, [x2, #0x8]
               	cbnz	x3, <addr>
               	mov	x17, #0x1000000000      // =68719476736
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x2, #0x8                // =8
               	cbz	x2, <addr>
               	mov	x0, x2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x1, [x1]
               	cmp	x1, #0x0
               	cset	x2, hi
               	neg	x3, x1
               	neg	x1, x2
               	asr	x4, x1, #4
               	lsr	x2, x3, #4
               	lsl	x5, x1, #60
               	orr	x5, x2, x5
               	mov	x2, #-0x1               // =-1
               	cmp	x5, x2
               	b.ne	<addr>
               	cmp	w4, w2
               	b.eq	<addr>
               	mov	x2, #0x9                // =9
               	cbz	x2, <addr>
               	mov	x0, x2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x2, [x29, #-0x8]
               	cmp	x2, x1
               	cset	x4, lo
               	cmp	x2, x1
               	cset	x1, eq
               	cmp	x3, #0x0
               	cset	x2, hi
               	and	x1, x1, x2
               	orr	x1, x4, x1
               	cbnz	w1, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x2, x4
               	b	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, x0
               	b	<addr>
