
sizeof_member_via_null_cast.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	jmp	<addr>
               	movl	$0xb, %eax
               	retq
               	jmp	<addr>
               	movl	$0xc, %eax
               	retq
               	jmp	<addr>
               	movl	$0xd, %eax
               	retq
               	jmp	<addr>
               	movl	$0xe, %eax
               	retq
               	jmp	<addr>
               	movl	$0xf, %eax
               	retq
               	jmp	<addr>
               	movl	$0x10, %eax
               	retq
               	jmp	<addr>
               	movl	$0x11, %eax
               	retq
               	xorq	%r11, %r11
               	movq	%r11, %rax
               	retq
