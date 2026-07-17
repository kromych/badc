
inline_phi_narrow_param_return.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x1, #0x1                // =1
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x1, x1, x17
               	add	x1, x1, x0
               	sxtw	x3, w1
               	sxtw	x1, w3
               	add	x1, x1, #0x1
               	add	x0, x2, #0x1
               	sxtw	x2, w0
               	cmp	x2, #0x32
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
