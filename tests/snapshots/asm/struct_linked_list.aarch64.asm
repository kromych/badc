
struct_linked_list.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2c0              // =704
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x21, #0x0               // =0
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x0                // =0
               	str	w0, [x20]
               	str	x21, [x20, #0x8]
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #0x1                // =1
               	str	w0, [x21]
               	str	x20, [x21, #0x8]
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x2                // =2
               	str	w0, [x20]
               	str	x21, [x20, #0x8]
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #0x3                // =3
               	str	w0, [x21]
               	str	x20, [x21, #0x8]
               	mov	x0, #0x10               // =16
               	bl	<addr>
               	mov	x1, #0x4                // =4
               	str	w1, [x0]
               	str	x21, [x0, #0x8]
               	mov	x1, #0x0                // =0
               	b	<addr>
               	ldrsw	x2, [x0]
               	add	x1, x1, x2
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x0
               	b.ne	<addr>
               	sxtw	x0, w1
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
