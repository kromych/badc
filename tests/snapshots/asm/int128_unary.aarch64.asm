
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
               	sub	x2, x29, #0x70
               	str	x1, [x2]
               	str	x1, [x2, #0x8]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x0, [x3]
               	lsl	x4, x0, #36
               	sub	x0, x29, #0x60
               	str	x1, [x0]
               	str	x4, [x0, #0x8]
               	mov	x17, #0x0               // =0
               	eor	x4, x4, x17
               	mov	x17, #0x0               // =0
               	orr	x4, x4, x17
               	cbnz	x4, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x4, [x0, #0x8]
               	sub	x4, x1, x4
               	sub	x4, x4, #0x0
               	mov	x17, #-0x1000000000     // =-68719476736
               	cmp	x4, x17
               	b.eq	<addr>
               	mov	x4, #0x3                // =3
               	cbz	x4, <addr>
               	sxtw	x0, w4
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x4, [x0, #0x8]
               	mov	x17, #0x0               // =0
               	eor	x4, x4, x17
               	mov	x17, #0x0               // =0
               	orr	x4, x4, x17
               	cbnz	x4, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x4, [x0, #0x8]
               	mov	x17, #0x0               // =0
               	orr	x4, x4, x17
               	cbz	x4, <addr>
               	mov	x4, #0x1                // =1
               	cmp	x4, #0x1
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x4, [x0, #0x8]
               	mov	x17, #0x0               // =0
               	orr	x4, x4, x17
               	cbz	x4, <addr>
               	ldr	x4, [x0, #0x8]
               	mov	x17, #0x0               // =0
               	orr	x4, x4, x17
               	cbnz	x4, <addr>
               	mov	x0, #0x7                // =7
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x4, [x3]
               	cbz	x4, <addr>
               	mov	x2, x0
               	ldr	x4, [x2]
               	ldr	x2, [x2, #0x8]
               	cbnz	x4, <addr>
               	mov	x17, #0x1000000000      // =68719476736
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x2, #0x8                // =8
               	cbz	x2, <addr>
               	sxtw	x0, w2
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x2, [x3]
               	cmp	x2, #0x0
               	cset	x4, hi
               	sub	x3, x1, x2
               	sub	x2, x1, x4
               	asr	x5, x2, #4
               	lsr	x4, x3, #4
               	lsl	x6, x2, #60
               	orr	x6, x4, x6
               	mov	x4, #-0x1               // =-1
               	cmp	x6, x4
               	b.ne	<addr>
               	cmp	x5, x4
               	b.eq	<addr>
               	mov	x1, #0x9                // =9
               	cbz	x1, <addr>
               	sxtw	x0, w1
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x0, #0x8]
               	cmp	x0, x2
               	cset	x1, lo
               	cmp	x0, x2
               	cset	x0, eq
               	cmp	x3, #0x0
               	cset	x2, hi
               	and	x0, x0, x2
               	orr	x0, x1, x0
               	cbnz	x0, <addr>
               	mov	x0, #0xa                // =10
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x70
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, x1
               	b	<addr>
               	mov	x4, x1
               	b	<addr>
               	mov	x4, x1
               	b	<addr>
