
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
               	movslq	%ecx, %rcx
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movslq	%ecx, %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movslq	%ecx, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rsi
               	movslq	%ecx, %rcx
               	addq	%rsi, %rcx
               	movl	%ecx, (%rdx)
               	movslq	(%rax), %rax
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpl	$0xca, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rsi
               	movslq	%ecx, %rcx
               	addq	%rsi, %rcx
               	movl	%ecx, (%rdx)
               	movslq	(%rax), %rax
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpl	$0x131, %eax            # imm = 0x131
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	leaq	<rip>, %rax
               	movl	$0x64, %ecx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax
               	xorq	%rcx, %rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %rsi
               	movslq	%ecx, %rcx
               	addq	%rsi, %rcx
               	movl	%ecx, (%rdx)
               	movslq	(%rax), %rax
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	cmpl	$0xca, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rax
               	incq	%rax
               	movl	%eax, (%rcx)
               	movslq	%eax, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rax
               	incq	%rax
               	movl	%eax, (%rcx)
               	movslq	%eax, %rax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rax
               	incq	%rax
               	movl	%eax, (%rcx)
               	movslq	%eax, %rax
               	cmpl	$0x3e9, %eax            # imm = 0x3E9
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rax
               	incq	%rax
               	movl	%eax, (%rcx)
               	movslq	%eax, %rax
               	cmpl	$0x3ea, %eax            # imm = 0x3EA
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	(%rcx), %rax
               	incq	%rax
               	movl	%eax, (%rcx)
               	movslq	%eax, %rax
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	xorq	%rax, %rax
               	retq
