
vector_casts_keep_the_bits.aarch64:	file format elf64-littleaarch64

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
               	mov	x16, #0x5               // =5
               	movk	x16, #0x7, lsl #32
               	fmov	d0, x16
               	smov	x0, v0.s[0]
               	cmp	x0, #0x5
               	b.ne	<addr>
               	smov	x0, v0.s[1]
               	cmp	x0, #0x7
               	b.ne	<addr>
               	smov	x0, v0.h[0]
               	cmp	x0, #0x5
               	b.ne	<addr>
               	smov	x0, v0.h[1]
               	cbnz	x0, <addr>
               	smov	x0, v0.h[2]
               	cmp	x0, #0x7
               	b.ne	<addr>
               	smov	x0, v0.h[3]
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x1                // =1
               	ret
