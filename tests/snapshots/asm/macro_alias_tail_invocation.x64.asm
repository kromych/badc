
macro_alias_tail_invocation.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rcx      # <addr>
               	cmpl	$0x0, (%rcx)
               	je	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %esi
               	incq	%rsi
               	movl	%esi, (%rax)
               	leaq	<rip>, %rax      # <addr>
               	movl	$0xb, (%rax)
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %edx
               	cmpl	$0x1, %edx
               	jne	<addr>
               	leaq	<rip>, %rdx      # <addr>
               	movl	(%rdx), %esi
               	cmpl	$0xb, %esi
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	cmpl	$0x0, (%rcx)
               	je	<addr>
               	movl	(%rax), %edi
               	incq	%rdi
               	movl	%edi, (%rax)
               	movl	$0x16, (%rdx)
               	movl	(%rax), %eax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movl	(%rdx), %eax
               	cmpl	$0x16, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpl	$0x0, (%rcx)
               	je	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movl	(%rax), %edx
               	incq	%rdx
               	movl	%edx, (%rax)
               	leaq	<rip>, %rax      # <addr>
               	movl	$0x21, (%rax)
               	leaq	<rip>, %rcx      # <addr>
               	movl	(%rcx), %eax
               	cmpl	$0x3, %eax
               	jne	<addr>
               	leaq	<rip>, %rdx      # <addr>
               	movl	(%rdx), %eax
               	cmpl	$0x21, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rsi      # <addr>
               	xorl	%eax, %eax
               	movl	%eax, (%rsi)
               	movl	(%rcx), %ecx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movl	(%rdx), %ecx
               	cmpl	$0x21, %ecx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	retq
