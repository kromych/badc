
sroa_runtime_index_stays_memory.x64:	file format elf64-x86-64

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

<pick>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	(%rdi), %rax
               	leaq	(%rax,%rax,2), %rax
               	incq	%rax
               	movq	%rax, -0x40(%rbp)
               	movq	0x8(%rdi), %rax
               	leaq	(%rax,%rax,2), %rax
               	incq	%rax
               	movq	%rax, -0x38(%rbp)
               	movq	0x10(%rdi), %rax
               	leaq	(%rax,%rax,2), %rax
               	incq	%rax
               	movq	%rax, -0x30(%rbp)
               	movq	0x18(%rdi), %rax
               	leaq	(%rax,%rax,2), %rax
               	incq	%rax
               	movq	%rax, -0x28(%rbp)
               	movq	0x20(%rdi), %rax
               	leaq	(%rax,%rax,2), %rax
               	incq	%rax
               	movq	%rax, -0x20(%rbp)
               	leaq	-0x40(%rbp), %rax
               	movq	0x28(%rdi), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	incq	%rcx
               	movq	%rcx, -0x18(%rbp)
               	movq	0x30(%rdi), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	incq	%rcx
               	movq	%rcx, -0x10(%rbp)
               	movq	0x38(%rdi), %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	incq	%rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	%rsi, %rcx
               	andq	$0x7, %rcx
               	movq	(%rax,%rcx,8), %rcx
               	leaq	0x5(%rsi), %rdx
               	andq	$0x7, %rdx
               	movq	(%rax,%rdx,8), %rax
               	addq	%rcx, %rax
               	leave
               	retq

<main>:
               	xorl	%eax, %eax
               	retq
