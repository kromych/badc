
extern_incomplete_struct_completion.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movslq	0x4(%rax), %rcx
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rcx      # <addr>
               	movslq	(%rcx), %rdx
               	cmpl	$0x7, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rdx      # <addr>
               	movslq	(%rdx), %rdx
               	cmpl	$0xb, %edx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	cmpq	%rcx, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	retq
               	xorl	%eax, %eax
               	retq
