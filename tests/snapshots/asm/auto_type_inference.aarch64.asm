
auto_type_inference.aarch64:	file format elf64-littleaarch64

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
               	mov	x0, #0x3ff8000000000000 // =4609434218613702656
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1, #0x4]
               	cmp	w1, #0x2
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x1, #0x4000000000000000 // =4611686018427387904
               	fmov	d16, x0
               	fmov	d17, x1
               	fmul	d0, d16, d17
               	mov	x0, #0x4008000000000000 // =4613937818241073152
               	fmov	d17, x0
               	fcmp	d0, d17
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cmp	w0, #0x2a
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ret
               	mov	x0, #0x0                // =0
               	ret
