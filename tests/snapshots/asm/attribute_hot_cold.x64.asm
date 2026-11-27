
attribute_hot_cold.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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

<fast_path>:
               	leaq	0x1(%rdi), %rax
               	retq

<error_path>:
               	movl	$0x29, %eax
               	retq

<hot_decl>:
               	shlq	%rdi
               	movq	%rdi, %rax
               	retq

<main>:
               	pushq	%rax
               	callq	<addr>
               	cmpl	$0x29, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
