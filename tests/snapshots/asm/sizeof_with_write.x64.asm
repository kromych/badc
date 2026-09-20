
sizeof_with_write.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x10, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rsi
               	movl	$0x1, %edi
               	movl	%edi, (%rsi)
               	movl	$0x2, 0x4(%rsi)
               	leaq	<rip>, %rax
               	movq	%rax, 0x8(%rsi)
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	$0x10, %eax
               	popq	%rbp
               	retq
