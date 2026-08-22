
mmap_anonymous.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0x40]!
               	str	x22, [sp, #0x10]
               	str	x19, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x21, #0x4000            // =16384
               	mov	x20, #0x0               // =0
               	mov	x22, #0x3               // =3
               	mov	x3, #0x22               // =34
               	mov	x4, #0xffff             // =65535
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	mov	x0, x20
               	mov	x5, x20
               	mov	x2, x22
               	mov	x1, x21
               	bl	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	add	x1, x0, #0x0
               	mov	x2, #0x1                // =1
               	strb	w2, [x1]
               	mov	x17, #0x1000            // =4096
               	add	x1, x0, x17
               	mov	x2, #0x2                // =2
               	strb	w2, [x1]
               	mov	x17, #0x2000            // =8192
               	add	x1, x0, x17
               	strb	w22, [x1]
               	mov	x17, #0x3000            // =12288
               	add	x1, x0, x17
               	mov	x2, #0x4                // =4
               	strb	w2, [x1]
               	mov	x1, #0xff               // =255
               	mov	x2, #0x1000             // =4096
               	b	<addr>
               	add	x3, x0, x20
               	ldrb	w3, [x3]
               	lsr	x4, x20, #12
               	add	x4, x4, #0x1
               	and	x4, x4, x1
               	cmp	x3, x4
               	b.ne	<addr>
               	add	x20, x20, x2
               	cmp	x20, x21
               	b.lo	<addr>
               	mov	x1, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldr	x19, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
