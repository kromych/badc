
size_t_is_unsigned.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0x80000000         // =2147483648
               	mov	x2, x0
               	mov	w1, w2
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x3                // =3
               	ret
               	mov	x2, #0x3333             // =13107
               	movk	x2, #0x3333, lsl #16
               	b	<addr>
