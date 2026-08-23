
struct_member_copy_from_global.aarch64:	file format elf64-littleaarch64

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

<new_client>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w2, [x0]
               	mov	x1, #0x9                // =9
               	str	w1, [x0]
               	ldr	w1, [x0]
               	mov	x0, #0x1                // =1
               	mov	x3, x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	w2, w17
               	b.lt	<addr>
               	mov	x2, x0
               	sxtw	x2, w2
               	add	x2, x2, #0x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	w1, w17
               	b.lt	<addr>
               	sxtw	x0, w0
               	add	x0, x2, x0
               	cmp	w1, #0x9
               	b.ne	<addr>
               	mov	x1, #0x0                // =0
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ret
               	mov	x1, #0x64               // =100
               	b	<addr>
               	mov	x0, #0xff9c             // =65436
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	b	<addr>
               	mov	x2, #0xff9c             // =65436
               	movk	x2, #0xffff, lsl #16
               	movk	x2, #0xffff, lsl #32
               	movk	x2, #0xffff, lsl #48
               	b	<addr>

<main>:
               	mov	x2, #0x0                // =0
               	mov	x0, x2
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w3, [x0]
               	mov	x1, #0x9                // =9
               	str	w1, [x0]
               	ldr	w1, [x0]
               	mov	x0, #0x1                // =1
               	mov	x4, x0
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	w3, w17
               	b.lt	<addr>
               	mov	x3, x0
               	sxtw	x3, w3
               	add	x3, x3, #0x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	w1, w17
               	b.lt	<addr>
               	sxtw	x0, w0
               	add	x0, x3, x0
               	cmp	w1, #0x9
               	b.ne	<addr>
               	mov	x1, x2
               	add	x0, x0, x1
               	sxtw	x0, w0
               	cmp	w0, #0x0
               	b.ge	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w1, [x0]
               	cmp	w1, #0x9
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	mov	x0, x2
               	ret
               	mov	x1, #0x64               // =100
               	b	<addr>
               	mov	x0, #0xff9c             // =65436
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	b	<addr>
               	mov	x3, #0xff9c             // =65436
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	b	<addr>
