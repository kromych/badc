
typeof_addr_of_array.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	ldrsw	x4, [x2, x1, lsl #2]
               	mov	x17, #0xa               // =10
               	mul	x3, x1, x17
               	add	x3, x3, #0xa
               	sxtw	x3, w3
               	cmp	x4, x3
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	ldrsw	x4, [x2, x1, lsl #2]
               	mov	x17, #0xa               // =10
               	mul	x3, x1, x17
               	add	x3, x3, #0xa
               	sxtw	x3, w3
               	cmp	x4, x3
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x4
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x3                // =3
               	ret
               	b	<addr>
               	b	<addr>
