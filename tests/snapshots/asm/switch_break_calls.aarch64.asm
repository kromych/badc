
switch_break_calls.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0x64               // =100
               	ret

<f2>:
               	mov	x0, #0xc8               // =200
               	ret

<f3>:
               	mov	x0, #0x12c              // =300
               	ret

<f4>:
               	mov	x0, #0x190              // =400
               	ret

<driver>:
               	sxtw	x0, w0
               	cmp	x0, #0x1
               	b.lt	<addr>
               	cmp	x0, #0x2
               	b.lt	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x190              // =400
               	sxtw	x0, w0
               	ret
               	mov	x0, #0x12c              // =300
               	b	<addr>
               	cmp	x0, #0x1
               	b.ne	<addr>
               	mov	x0, #0xc8               // =200
               	b	<addr>
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x64               // =100
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
