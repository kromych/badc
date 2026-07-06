
size_t_is_unsigned.aarch64:	file format elf64-littleaarch64

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
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x1, #0x9                // =9
               	udiv	x1, x0, x1
               	cmp	x1, #0x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x1, #0x9                // =9
               	udiv	x1, x0, x1
               	mov	x17, #0x1c71            // =7281
               	movk	x17, #0x71c7, lsl #16
               	movk	x17, #0xc71c, lsl #32
               	movk	x17, #0x1c71, lsl #48
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	cmp	x0, #0x3e8
               	b.hs	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x1, #0x80000000         // =2147483648
               	mov	x2, #0x5                // =5
               	udiv	x0, x0, x2
               	cmp	x1, x0
               	b.hs	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	w2, w0
               	mov	w0, w2
               	cmp	x0, x1
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
