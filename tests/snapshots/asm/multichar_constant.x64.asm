
multichar_constant.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	movl	$0x1, %edx
               	xorq	%rdx, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	xorq	%rdx, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	jmp	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x2, %eax
               	retq
               	movl	$0x3, %eax
               	retq
               	movl	$0x5, %eax
               	retq
               	movl	$0x6, %eax
               	retq
               	addb	%al, 0x41(%rdx)
