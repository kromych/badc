
typedef_in_function_body.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0x7                // =7
               	sxtw	x0, w0
               	ret

<k>:
               	mov	x0, #0x5                // =5
               	ret

<main>:
               	mov	x0, #0x2                // =2
               	mov	x1, #0x1                // =1
               	mov	x2, #0x7                // =7
               	sxtw	x2, w2
               	cmp	x2, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x2, #0x5                // =5
               	cmp	x2, #0x5
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldrsw	x2, [x2]
               	cmp	x2, #0x64
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	add	x1, x0, x1
               	add	x0, x1, x0
               	sub	x0, x0, #0x5
               	sxtw	x0, w0
               	ret
