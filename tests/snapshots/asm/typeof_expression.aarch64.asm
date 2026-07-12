
typeof_expression.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0x3                // =3
               	cmp	x0, #0x3
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0x7                // =7
               	cmp	x0, #0x7
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x4                // =4
               	cmp	x0, #0x4
               	cset	x0, ne
               	cbnz	x0, <addr>
               	mov	x0, #0xa                // =10
               	cmp	x0, #0xa
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	b	<addr>
