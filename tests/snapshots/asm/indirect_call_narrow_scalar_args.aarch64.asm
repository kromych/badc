
indirect_call_narrow_scalar_args.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x4, [x0]
               	sxtw	x0, w4
               	sxtb	x6, w0
               	sxth	x7, w0
               	mov	x17, #0x86a0            // =34464
               	movk	x17, #0x1, lsl #16
               	mul	x1, x6, x17
               	mov	x17, #0xa               // =10
               	mul	x2, x7, x17
               	add	x3, x1, x2
               	add	x0, x3, x4
               	cmp	w0, w0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	mov	x17, #0xcd17            // =52503
               	movk	x17, #0x6b, lsl #16
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x0, #0x0                // =0
               	ret
