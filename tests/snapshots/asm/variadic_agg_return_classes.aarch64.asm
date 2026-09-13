
variadic_agg_return_classes.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	mov	x1, #0x3ff8000000000000 // =4609434218613702656
               	mov	x0, #0x2                // =2
               	scvtf	d0, x0
               	fmov	d16, x1
               	fmul	d0, d16, d0
               	mov	x1, #0x4002000000000000 // =4612248968380809216
               	mov	x2, #0x4008000000000000 // =4613937818241073152
               	fmov	d17, x2
               	fcmp	d0, d17
               	b.ne	<addr>
               	fmov	d16, x1
               	fmov	d17, x1
               	fcmp	d16, d17
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x1, #0x3fe0000000000000 // =4602678819172646912
               	fmov	d16, x1
               	fmov	d17, x1
               	fcmp	d16, d17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	mov	x1, x0
               	ret
               	ret
