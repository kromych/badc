
linked_list.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	mov	x21, #0x0               // =0
               	mov	x20, x21
               	mov	x22, x21
               	b	<addr>
               	sxtw	x0, w20
               	cmp	x0, #0x5
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	mov	x22, x1
               	b	<addr>
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	mov	x1, x0
               	sxtw	x0, w20
               	str	x0, [x1]
               	str	x22, [x1, #0x8]
               	b	<addr>
               	b	<addr>
               	cmp	x22, #0x0
               	b.eq	<addr>
               	sxtw	x0, w21
               	ldr	x1, [x22]
               	add	x21, x0, x1
               	ldr	x22, [x22, #0x8]
               	b	<addr>
               	sxtw	x0, w21
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
