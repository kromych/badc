
inline_linkage.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	ret

<sinl>:
               	add	x0, x0, #0x2
               	sxtw	x0, w0
               	ret

<einl>:
               	add	x0, x0, #0x3
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	mov	x0, #0xa                // =10
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	cmp	x0, #0xb
               	cset	x0, eq
               	mov	x2, #0x0                // =0
               	cbz	x0, <addr>
               	mov	x0, #0xa                // =10
               	add	x0, x0, #0x2
               	sxtw	x0, w0
               	cmp	x0, #0xc
               	cset	x0, eq
               	cmp	x0, #0x0
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0xa                // =10
               	add	x0, x0, #0x3
               	sxtw	x0, w0
               	cmp	x0, #0xd
               	cset	x2, eq
               	cbz	x2, <addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x1                // =1
               	mov	x0, x1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	b	<addr>
