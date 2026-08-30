
struct_member_copy_from_global.x64:	file format elf64-x86-64

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

<new_client>:
               	leaq	<rip>, %rax
               	movl	(%rax), %edx
               	movl	$0x9, %ecx
               	movl	%ecx, (%rax)
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	cmpl	$-0x1, %edx
               	jl	<addr>
               	movq	%rcx, %rax
               	movslq	%eax, %rax
               	incq	%rax
               	incq	%rax
               	xorq	%rcx, %rcx
               	addq	$0x0, %rax
               	movslq	%eax, %rax
               	retq
               	movabsq	$-0x64, %rax
               	jmp	<addr>

<main>:
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	leaq	<rip>, %rax
               	movl	(%rax), %edx
               	movl	$0x9, %esi
               	movl	%esi, (%rax)
               	movl	$0x1, %eax
               	movq	%rax, %rsi
               	cmpl	$-0x1, %edx
               	jl	<addr>
               	movq	%rax, %rdx
               	movslq	%edx, %rdx
               	incq	%rdx
               	leaq	0x1(%rdx), %rax
               	movq	%rcx, %rdx
               	addq	$0x0, %rax
               	movslq	%eax, %rax
               	testl	%eax, %eax
               	jge	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	movl	(%rax), %edx
               	cmpl	$0x9, %edx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	%rcx, %rax
               	retq
               	movabsq	$-0x64, %rdx
               	jmp	<addr>
