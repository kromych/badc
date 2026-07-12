
pp_number_macro_token.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x0, [x1]
               	cmp	x0, #0x2
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrsw	x0, [x1, #0x4]
               	cmp	x0, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	d0, [x0]
               	mov	x0, #0x3ff0000000000000 // =4607182418800017408
               	fmov	d17, x0
               	fcmp	d0, d17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
