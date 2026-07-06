
inline_phi_narrow_param_return.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	ret

<phi_accumulate>:
               	sxtw	x0, w0
               	mov	x3, #0x1                // =1
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x17, #0x4243            // =16963
               	movk	x17, #0xf, lsl #16
               	mul	x3, x3, x17
               	add	x3, x3, x2
               	sxtw	x3, w3
               	add	x3, x3, #0x1
               	add	x2, x1, #0x1
               	sxtw	x1, w2
               	cmp	x1, x0
               	b.lt	<addr>
               	mov	x0, x3
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x32               // =50
               	bl	<addr>
               	mov	x17, #0x2046            // =8262
               	movk	x17, #0xb8d7, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x1                // =1
               	b	<addr>
