
tailrec_narrow_param.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtb	x0, w0
               	mov	x1, #0x0                // =0
               	b	<addr>
               	sub	x2, x0, #0x1
               	sxtw	x2, w2
               	sxtb	x2, w2
               	add	x1, x1, x0
               	mov	x0, x2
               	cmp	x0, #0x0
               	b.gt	<addr>
               	add	x0, x1, #0x0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x64               // =100
               	bl	<addr>
               	mov	x17, #0x13ba            // =5050
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
