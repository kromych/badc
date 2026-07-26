
aggregate_init_statement_expression_element.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	add	x1, x0, #0x1
               	sxtw	x2, w1
               	add	x1, x0, #0x2
               	sxtw	x3, w1
               	add	x1, x0, #0x3
               	sxtw	x1, w1
               	mov	w2, w2
               	mov	w3, w3
               	add	x2, x2, x3
               	mov	w2, w2
               	mov	w1, w1
               	add	x1, x2, x1
               	mov	w1, w1
               	mov	w2, w0
               	mov	w3, w0
               	cmp	x2, x3
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ret
               	mov	w1, w1
               	mov	x17, #0x3               // =3
               	mul	x0, x0, x17
               	add	x0, x0, #0x6
               	sxtw	x0, w0
               	mov	w0, w0
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x1, #0x1000             // =4096
               	mov	x0, #0x1000             // =4096
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x9                // =9
               	bl	<addr>
               	cmp	x0, #0x0
               	b.eq	<addr>
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
