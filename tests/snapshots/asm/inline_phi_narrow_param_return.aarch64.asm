
inline_phi_narrow_param_return.aarch64:	file format elf64-littleaarch64

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
               	mov	x1, #0x1                // =1
               	mov	x0, #0x0                // =0
               	mov	x2, #0x4243             // =16963
               	movk	x2, #0xf, lsl #16
               	b	<addr>
               	mul	x1, x1, x2
               	add	x1, x1, x0
               	sxtw	x1, w1
               	add	x1, x1, #0x1
               	sxtw	x0, w0
               	add	x0, x0, #0x1
               	cmp	x0, #0x32
               	b.lt	<addr>
               	mov	x17, #0x2046            // =8262
               	movk	x17, #0xb8d7, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x1, x17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
