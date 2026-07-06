
wide_string_literal_size.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	cmp	x1, #0x61
               	cset	x1, ne
               	mov	x3, #0x1                // =1
               	cbnz	x1, <addr>
               	ldrsw	x1, [x0, #0x4]
               	cmp	x1, #0x62
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x3, ne
               	cbnz	x3, <addr>
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x0
               	cset	x3, ne
               	cbz	x3, <addr>
               	mov	x0, #0x9                // =9
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	b	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, #0x4                // =4
               	ret
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x7                // =7
               	ret
               	mov	x0, #0x8                // =8
               	ret
