
tail_call_no_address_escape.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x230              // =560
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	ldr	x0, [x0]
               	cmp	x0, #0x11
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	mov	x0, x1
               	ret
               	mov	x1, #0x1                // =1
               	b	<addr>

<wrap>:
               	str	x0, [sp, #-0x10]!
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	stur	x0, [x29, #0x10]
               	add	x0, x29, #0x10
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x11               // =17
               	bl	<addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
