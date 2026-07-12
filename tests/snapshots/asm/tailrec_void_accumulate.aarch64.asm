
tailrec_void_accumulate.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	b	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	add	x2, x2, x0
               	str	x2, [x1]
               	sub	x0, x0, #0x1
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x64               // =100
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x17, #0x13ba            // =5050
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
