
static_locals.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movq	%rcx, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdx
               	movl	%edx, (%rax)
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rsi
               	addq	%rsi, %rdx
               	movl	%edx, (%rcx)
               	movslq	(%rax), %rsi
               	addq	%rsi, %rdx
               	cmpl	$0xca, %edx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	movslq	(%rcx), %rsi
               	addq	%rsi, %rdx
               	movl	%edx, (%rcx)
               	movslq	(%rax), %rsi
               	addq	%rsi, %rdx
               	cmpl	$0x131, %edx            # imm = 0x131
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movl	$0x64, (%rax)
               	xorl	%edx, %edx
               	movl	%edx, (%rcx)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rsi
               	movslq	(%rsi), %rdi
               	addq	%rdi, %rcx
               	movl	%ecx, (%rsi)
               	movslq	(%rax), %rax
               	addq	%rcx, %rax
               	cmpl	$0xca, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rsi
               	incq	%rsi
               	movl	%esi, (%rcx)
               	cmpl	$0x3e9, %esi            # imm = 0x3E9
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	movslq	(%rcx), %rsi
               	incq	%rsi
               	movl	%esi, (%rcx)
               	movq	%rsi, %rcx
               	cmpl	$0x3ea, %ecx            # imm = 0x3EA
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movq	%rcx, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movq	%rdx, %rax
               	retq
