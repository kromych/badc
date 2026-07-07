
func_name_array.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	add	x3, x2, x1
               	ldrb	w3, [x3]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	add	x4, x4, x1
               	ldrsb	x4, [x4]
               	eor	x3, x3, x4
               	mov	w3, w3
               	cmp	x3, #0x0
               	b.ne	<addr>
               	add	x0, x1, #0x1
               	sxtw	x1, w0
               	cmp	x1, #0x5
               	b.lt	<addr>
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x1                // =1
               	ret
               	b	<addr>
