
shm_open_mode_arg.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x4a0              // =1184
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x120
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	mov	x22, #0x0               // =0
               	sub	x20, x29, #0x40
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x2, x0
               	mov	x0, x20
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	sub	x0, x29, #0x40
               	bl	<addr>
               	sxtw	x0, w0
               	sub	x0, x29, #0x40
               	mov	x1, #0xc2               // =194
               	mov	x2, #0x180              // =384
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x20, x0
               	sxtw	x0, w20
               	cmp	x0, #0x0
               	b.ge	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sxtw	x0, w20
               	sub	x1, x29, #0xc0
               	bl	<addr>
               	sxtw	x0, w0
               	cmp	x0, #0x0
               	b.eq	<addr>
               	mov	x22, #0x2               // =2
               	sxtw	x0, w20
               	bl	<addr>
               	sxtw	x0, w0
               	sub	x0, x29, #0x40
               	bl	<addr>
               	sxtw	x0, w0
               	sxtw	x0, w22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x19, [sp, #0x20]
               	add	sp, sp, #0x120
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0xc0
               	ldrsw	x0, [x0, #0x10]
               	mov	x17, #0x1ff             // =511
               	and	x0, x0, x17
               	cmp	x0, #0x180
               	b.eq	<addr>
               	mov	x22, #0x3               // =3
               	b	<addr>
               	b	<addr>
