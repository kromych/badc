
inline_one_word_struct.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	sub	x1, x29, #0x28
               	add	x0, x1, #0x0
               	mov	x2, #0x64               // =100
               	str	x2, [x0]
               	mov	x0, #0xc8               // =200
               	str	x0, [x1, #0x8]
               	mov	x0, #0x12c              // =300
               	str	x0, [x1, #0x10]
               	mov	x0, #0x190              // =400
               	str	x0, [x1, #0x18]
               	mov	x0, #0x1f4              // =500
               	str	x0, [x1, #0x20]
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	b	<addr>
               	sxtw	x3, w0
               	ldr	x3, [x1, x3, lsl #3]
               	add	x2, x2, x3
               	add	x0, x0, #0x1
               	cmp	w0, #0x5
               	b.lt	<addr>
               	cmp	x2, #0x5dc
               	b.ne	<addr>
               	mov	x0, #0x0                // =0
               	sxtw	x0, w0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	b	<addr>
