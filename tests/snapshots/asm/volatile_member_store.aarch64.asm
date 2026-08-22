
volatile_member_store.aarch64:	file format elf64-littleaarch64

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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x29               // =41
               	str	x1, [x0]
               	ldr	x1, [x0]
               	cmp	x1, #0x29
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	x1, [x0]
               	add	x1, x1, #0x3
               	str	x1, [x0]
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	ldr	x1, [x0]
               	add	x1, x1, #0x1
               	str	x1, [x0]
               	ldr	x1, [x0]
               	sub	x1, x1, #0x1
               	str	x1, [x0]
               	ldr	x1, [x0]
               	cmp	x1, #0x2d
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	mov	x1, #0x7                // =7
               	add	x2, x0, #0x8
               	str	x1, [x2]
               	add	x1, x0, #0x8
               	ldr	x2, [x1]
               	add	x2, x2, #0x7
               	str	x2, [x1]
               	add	x1, x0, #0x8
               	ldr	x1, [x1]
               	cmp	x1, #0xe
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x1, #0x5                // =5
               	add	x2, x0, #0x10
               	add	x2, x2, #0x8
               	str	x1, [x2]
               	add	x1, x0, #0x10
               	add	x1, x1, #0x8
               	ldr	x2, [x1]
               	add	x2, x2, #0x5
               	str	x2, [x1]
               	add	x1, x0, #0x10
               	add	x1, x1, #0x8
               	ldr	x1, [x1]
               	cmp	x1, #0xa
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	add	x1, x0, #0x20
               	ldr	w2, [x1]
               	mov	x17, #0xffe0            // =65504
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	mov	x17, #0x9               // =9
               	orr	x2, x2, x17
               	str	w2, [x1]
               	add	x1, x0, #0x20
               	ldr	w2, [x1]
               	mov	x17, #0x1f              // =31
               	and	x2, x2, x17
               	add	x2, x2, #0x1
               	mov	x17, #0x1f              // =31
               	and	x2, x2, x17
               	ldr	w3, [x1]
               	mov	x17, #0xffe0            // =65504
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x3, x3, x17
               	orr	x2, x3, x2
               	str	w2, [x1]
               	add	x0, x0, #0x20
               	ldr	w0, [x0]
               	mov	x17, #0x1f              // =31
               	and	x0, x0, x17
               	mov	x17, #0xa               // =10
               	eor	x0, x0, x17
               	mov	w0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret
