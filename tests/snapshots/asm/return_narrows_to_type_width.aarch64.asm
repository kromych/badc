
return_narrows_to_type_width.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	sxtw	x0, w0
               	mov	x17, #0x92000000        // =2449473536
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	orr	x0, x0, x17
               	mov	w0, w0
               	ret

<sret>:
               	mov	w0, w0
               	sxtw	x0, w0
               	ret

<hret>:
               	sxtw	x0, w0
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	ret

<main>:
               	mov	x0, #0x0                // =0
               	ret
