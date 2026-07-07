
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
               	mov	x20, #0x0               // =0
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #0x0                // =0
               	str	x0, [x21]
               	str	x20, [x21, #0x8]
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	mov	x22, x0
               	mov	x0, #0x1                // =1
               	str	x0, [x22]
               	str	x21, [x22, #0x8]
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #0x2                // =2
               	str	x0, [x21]
               	str	x22, [x21, #0x8]
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	mov	x22, x0
               	mov	x0, #0x3                // =3
               	str	x0, [x22]
               	str	x21, [x22, #0x8]
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	mov	x1, #0x4                // =4
               	str	x1, [x0]
               	str	x22, [x0, #0x8]
               	b	<addr>
               	ldr	x1, [x0]
               	add	x20, x20, x1
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	sxtw	x0, w20
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
