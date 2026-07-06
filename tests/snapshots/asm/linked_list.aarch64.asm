
linked_list.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x20, x21, [sp, #-0x40]!
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x21, #0x0               // =0
               	mov	x20, x21
               	mov	x22, x21
               	b	<addr>
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	mov	x1, x0
               	sxtw	x0, w20
               	str	x0, [x1]
               	str	x22, [x1, #0x8]
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	mov	x22, x1
               	sxtw	x0, w20
               	cmp	x0, #0x5
               	b.lt	<addr>
               	b	<addr>
               	ldr	x0, [x22]
               	add	x21, x21, x0
               	ldr	x22, [x22, #0x8]
               	cmp	x22, #0x0
               	b.ne	<addr>
               	sxtw	x0, w21
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
