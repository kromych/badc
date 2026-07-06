
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
               	mov	x22, #0x0               // =0
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x0                // =0
               	str	x0, [x20]
               	str	x22, [x20, #0x8]
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #0x1                // =1
               	str	x0, [x21]
               	str	x20, [x21, #0x8]
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x2                // =2
               	str	x0, [x20]
               	str	x21, [x20, #0x8]
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #0x3                // =3
               	str	x0, [x21]
               	str	x20, [x21, #0x8]
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	mov	x1, x0
               	mov	x0, #0x4                // =4
               	str	x0, [x1]
               	str	x21, [x1, #0x8]
               	b	<addr>
               	ldr	x0, [x1]
               	add	x22, x22, x0
               	ldr	x1, [x1, #0x8]
               	cmp	x1, #0x0
               	b.ne	<addr>
               	sxtw	x0, w22
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
