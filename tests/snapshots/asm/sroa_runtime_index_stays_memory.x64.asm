
sroa_runtime_index_stays_memory.x64:	file format elf64-x86-64

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

<pick>:
               	subq	$0x48, %rsp
               	movq	(%rdi), %rax
               	leaq	(%rax,%rax,2), %rax
               	incq	%rax
               	movq	%rax, (%rsp)
               	movq	0x8(%rdi), %rax
               	leaq	(%rax,%rax,2), %rax
               	incq	%rax
               	movq	%rax, 0x8(%rsp)
               	movq	0x10(%rdi), %rax
               	leaq	(%rax,%rax,2), %rax
               	incq	%rax
               	movq	%rax, 0x10(%rsp)
               	movq	0x18(%rdi), %rax
               	leaq	(%rax,%rax,2), %rax
               	incq	%rax
               	movq	%rax, 0x18(%rsp)
               	movq	0x20(%rdi), %rax
               	leaq	(%rax,%rax,2), %rax
               	incq	%rax
               	movq	%rax, 0x20(%rsp)
               	movq	0x28(%rdi), %rax
               	leaq	(%rax,%rax,2), %rax
               	incq	%rax
               	movq	%rax, 0x28(%rsp)
               	movq	0x30(%rdi), %rax
               	leaq	(%rax,%rax,2), %rax
               	incq	%rax
               	movq	%rax, 0x30(%rsp)
               	movq	0x38(%rdi), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	incq	%rcx
               	movq	%rcx, 0x38(%rsp)
               	movq	%rsi, %rcx
               	andq	$0x7, %rcx
               	movq	(%rsp,%rcx,8), %rdx
               	leaq	0x5(%rsi), %rcx
               	andq	$0x7, %rcx
               	movq	(%rsp,%rcx,8), %rax
               	addq	%rdx, %rax
               	addq	$0x48, %rsp
               	retq

<main>:
               	xorl	%eax, %eax
               	retq
