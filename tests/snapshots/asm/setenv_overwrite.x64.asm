
setenv_overwrite.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x1, %edx
               	callq	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	xorl	%edx, %edx
               	callq	<addr>
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x66, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x1, %edx
               	callq	<addr>
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x74, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
