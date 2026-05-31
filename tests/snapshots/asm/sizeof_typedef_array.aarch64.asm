
sizeof_typedef_array.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x15, #0x200             // =512
               	sxtw	x15, w15
               	cmp	x15, #0x200
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x15, #0x28              // =40
               	sxtw	x15, w15
               	cmp	x15, #0x28
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x4                // =4
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x15, #0x0               // =0
               	cbz	x15, <addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x15, #0x0               // =0
               	mov	x0, x15
               	ret
