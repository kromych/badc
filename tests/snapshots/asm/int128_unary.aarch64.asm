
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
               	sub	sp, sp, #0x70
               	mov	x0, #0x0                // =0
               	sub	x2, x29, #0x70
               	str	x0, [x2]
               	str	x0, [x2, #0x8]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x1, [x3]
               	lsl	x4, x1, #36
               	sub	x1, x29, #0x60
               	str	x0, [x1]
               	str	x4, [x1, #0x8]
               	cbnz	x4, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x4, [x1, #0x8]
               	neg	x4, x4
               	mov	x17, #-0x1000000000     // =-68719476736
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x4, #0x3                // =3
               	cbz	x4, <addr>
               	mov	x0, x4
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x4, [x1, #0x8]
               	cbnz	x4, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x4, [x1, #0x8]
               	cbz	x4, <addr>
               	ldr	x4, [x1, #0x8]
               	cbz	x4, <addr>
               	ldr	x4, [x1, #0x8]
               	cbnz	x4, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x4, [x3]
               	cbz	x4, <addr>
               	mov	x2, x1
               	ldr	x4, [x2]
               	ldr	x2, [x2, #0x8]
               	cbnz	x4, <addr>
               	mov	x17, #0x1000000000      // =68719476736
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x2, #0x8                // =8
               	cbz	x2, <addr>
               	mov	x0, x2
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x2, [x3]
               	cmp	x2, #0x0
               	cset	x3, hi
               	neg	x4, x2
               	neg	x2, x3
               	asr	x5, x2, #4
               	lsr	x3, x4, #4
               	lsl	x6, x2, #60
               	orr	x6, x3, x6
               	mov	x3, #-0x1               // =-1
               	cmp	x6, x3
               	b.ne	<addr>
               	cmp	w5, w3
               	b.eq	<addr>
               	mov	x3, #0x9                // =9
               	cbz	x3, <addr>
               	mov	x0, x3
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x1, [x1, #0x8]
               	cmp	x1, x2
               	cset	x3, lo
               	cmp	x1, x2
               	cset	x1, eq
               	cmp	x4, #0x0
               	cset	x2, hi
               	and	x1, x1, x2
               	orr	x1, x3, x1
               	cbnz	w1, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x4, x0
               	b	<addr>
