
unsigned_signed_relational_compare.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	mov	x1, #0xffff             // =65535
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	mov	w2, w1
               	cmp	x0, x2
               	b.hs	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	w2, w1
               	cmp	x2, x0
               	b.hs	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	w2, w1
               	cmp	x0, x2
               	cset	x2, ls
               	cmp	x2, #0x0
               	b.ne	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	w2, w1
               	cmp	x0, x2
               	cset	x2, hs
               	cmp	x2, #0x0
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	w2, w1
               	cmp	x0, x2
               	b.ls	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x5                // =5
               	mov	x2, #0xa                // =10
               	cmp	x0, x2
               	cset	x3, lo
               	cmp	x3, #0x0
               	cset	x4, eq
               	cbnz	x4, <addr>
               	cmp	x2, x0
               	cset	x4, lo
               	cbz	x4, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0xfffb             // =65531
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x2, #0x3                // =3
               	cmp	x0, x2
               	cset	x3, lt
               	cmp	x3, #0x0
               	cset	x4, eq
               	cbnz	x4, <addr>
               	cmp	x2, x0
               	cset	x4, lt
               	cbz	x4, <addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	cmp	x0, x1
               	b.hs	<addr>
               	mov	x0, #0x8                // =8
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	b	<addr>
