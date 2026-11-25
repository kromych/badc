
int128_unary.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	mov	x0, #0x0                // =0
               	adrp	x3, <page>
               	ldr	x1, [x3, #0x10]
               	lsl	x1, x1, #36
               	orr	x2, x0, x1
               	cbnz	x2, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	neg	x5, x1
               	mov	x17, #-0x1000000000     // =-68719476736
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x4, #0x3                // =3
               	cbz	x4, <addr>
               	mov	x0, x4
               	ret
               	cbz	x2, <addr>
               	cbz	x2, <addr>
               	cbnz	x2, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	ldr	x2, [x3, #0x10]
               	cbz	x2, <addr>
               	mov	x17, #0x1000000000      // =68719476736
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x2, #0x8                // =8
               	cbz	x2, <addr>
               	mov	x0, x2
               	ret
               	ldr	x2, [x3, #0x10]
               	cbz	x2, <addr>
               	mov	x17, #0x1000000000      // =68719476736
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x2, #0xc                // =12
               	cbz	x2, <addr>
               	mov	x0, x2
               	ret
               	ldr	x2, [x3, #0x10]
               	cbz	x2, <addr>
               	mov	x17, #-0x1000000000     // =-68719476736
               	cmp	x5, x17
               	b.eq	<addr>
               	mov	x0, #0xd                // =13
               	cbz	x0, <addr>
               	ret
               	adrp	x0, <page>
               	ldr	x0, [x0, <lo12>]
               	cmp	x0, #0x0
               	cset	x2, hi
               	neg	x3, x0
               	neg	x2, x2
               	asr	x4, x2, #4
               	lsr	x0, x3, #4
               	orr	x5, x0, x2, lsl #60
               	mov	x0, #-0x1               // =-1
               	cmp	x5, x0
               	b.ne	<addr>
               	cmp	w4, w0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	cbz	x0, <addr>
               	ret
               	cmp	x1, x2
               	cset	x0, lo
               	cmp	x1, x2
               	cset	x1, eq
               	cmp	x3, #0x0
               	cset	x2, hi
               	and	x1, x1, x2
               	orr	x0, x0, x1
               	cbnz	w0, <addr>
               	mov	x0, #0xa                // =10
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x4, x0
               	b	<addr>
