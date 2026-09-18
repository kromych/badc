
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
               	mov	x1, #0x0                // =0
               	sub	x0, x29, #0x70
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x0, [x2]
               	lsl	x3, x0, #36
               	sub	x0, x29, #0x60
               	str	x1, [x0]
               	str	x3, [x0, #0x8]
               	ldr	x3, [x0, #0x8]
               	mov	x17, #0x0               // =0
               	eor	x3, x3, x17
               	mov	x17, #0x0               // =0
               	orr	x3, x3, x17
               	cmp	x3, #0x0
               	cset	x3, eq
               	cbz	x3, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x3, x1
               	mov	x3, x1
               	ldr	x3, [x0, #0x8]
               	sub	x3, x1, x3
               	sub	x3, x3, #0x0
               	mov	x17, #-0x1000000000     // =-68719476736
               	cmp	x3, x17
               	cset	x3, ne
               	cbz	x3, <addr>
               	mov	x3, #0x3                // =3
               	cbz	x3, <addr>
               	sxtw	x0, w3
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x3, [x0, #0x8]
               	mov	x17, #0x0               // =0
               	eor	x3, x3, x17
               	mov	x17, #0x0               // =0
               	orr	x3, x3, x17
               	cbnz	x3, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x0, #0x8]
               	mov	x17, #0x0               // =0
               	orr	x0, x0, x17
               	cbz	x0, <addr>
               	mov	x1, #0x1                // =1
               	cmp	x1, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x60
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0x0               // =0
               	orr	x3, x1, x17
               	mov	x1, #0x0                // =0
               	cbz	x3, <addr>
               	mov	x3, #0x1                // =1
               	cmp	x3, #0x0
               	cset	x3, eq
               	cbnz	x3, <addr>
               	mov	x3, x1
               	ldr	x3, [x0, #0x8]
               	mov	x17, #0x0               // =0
               	orr	x4, x3, x17
               	mov	x3, #0x1                // =1
               	cbnz	x4, <addr>
               	mov	x3, x1
               	cmp	x3, #0x0
               	cset	x3, eq
               	cbz	x3, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x3, [x2]
               	cbz	x3, <addr>
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x8]
               	cbnz	x3, <addr>
               	mov	x17, #0x1000000000      // =68719476736
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x2]
               	cmp	x0, #0x0
               	cset	x3, hi
               	sub	x2, x1, x0
               	sub	x0, x1, x3
               	asr	x3, x0, #4
               	lsr	x1, x2, #4
               	lsl	x4, x0, #60
               	orr	x4, x1, x4
               	mov	x1, #-0x1               // =-1
               	cmp	x4, x1
               	b.ne	<addr>
               	cmp	x3, x1
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x1, #0x9                // =9
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x60
               	ldr	x1, [x1, #0x8]
               	cmp	x1, x0
               	cset	x3, lo
               	cmp	x1, x0
               	cset	x0, eq
               	cmp	x2, #0x0
               	cset	x1, hi
               	and	x0, x0, x1
               	orr	x0, x3, x0
               	cbnz	x0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x0, x1
               	b	<addr>
               	sub	x0, x29, #0x70
               	b	<addr>
               	b	<addr>
               	mov	x3, x1
               	b	<addr>
               	b	<addr>
               	mov	x3, x1
               	b	<addr>
