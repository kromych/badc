
inline_nested_aggregate_return.x64:	file format elf64-x86-64

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

<make_pair>:
               	movq	%rdi, %rax
               	leaq	(%rax,%rax,2), %rcx
               	leaq	0x1(%rcx), %rdx
               	movl	<rip>, %ecx # <addr>
               	incq	%rcx
               	movl	%ecx, <rip> # <addr>
               	retq

<make_wide>:
               	subq	$0x48, %rsp
               	movq	%rdi, (%rsp)
               	leaq	0x10(%rsp), %rcx
               	movq	%rsi, 0x10(%rsp)
               	leaq	0x1(%rsi), %rax
               	movq	%rax, 0x18(%rsp)
               	leaq	0x2(%rsi), %rax
               	movq	%rax, 0x20(%rsp)
               	leaq	0x3(%rsi), %rax
               	movq	%rax, 0x28(%rsp)
               	leaq	0x4(%rsi), %rax
               	movq	%rax, 0x30(%rsp)
               	leaq	0x5(%rsi), %rax
               	movq	%rax, 0x38(%rsp)
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	movq	(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	addq	$0x48, %rsp
               	retq

<main>:
               	subq	$0x40, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x4, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	%rdx, %r12
               	movq	%rbx, 0x40(%rsp)
               	movq	%r12, 0x48(%rsp)
               	leaq	0x20(%rsp), %rdi
               	movl	$0x4, %esi
               	callq	<addr>
               	movq	0x20(%rsp), %rax
               	movq	0x28(%rsp), %rcx
               	movq	0x30(%rsp), %rdx
               	movq	0x38(%rsp), %rsi
               	movq	0x40(%rsp), %rdi
               	movq	0x48(%rsp), %r8
               	leaq	(%rbx,%r12), %r9
               	addq	%r9, %rax
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	addq	%rsi, %rax
               	addq	%rdi, %rax
               	addq	%r8, %rax
               	movl	$0x1, %ebx
               	xorl	%ecx, %ecx
               	cmpq	$0x38, %rax
               	cmoveq	%rcx, %rbx
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, %r12
               	movq	%rdx, %r13
               	movq	%r12, 0x40(%rsp)
               	movq	%r13, 0x48(%rsp)
               	leaq	0x20(%rsp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	movq	0x20(%rsp), %rax
               	movq	0x28(%rsp), %rcx
               	movq	0x30(%rsp), %rdx
               	movq	0x38(%rsp), %rsi
               	movq	0x40(%rsp), %rdi
               	movq	0x48(%rsp), %r8
               	leaq	(%r12,%r13), %r9
               	addq	%r9, %rax
               	addq	%rcx, %rax
               	addq	%rdx, %rax
               	addq	%rsi, %rax
               	addq	%rdi, %rax
               	addq	%r8, %rax
               	movq	%rbx, %rcx
               	orq	$0x2, %rcx
               	cmpq	$0x10, %rax
               	cmovneq	%rcx, %rbx
               	movl	$0x4, %edi
               	callq	<addr>
               	movq	%rdx, %r12
               	movq	%rax, 0x40(%rsp)
               	movq	%r12, 0x48(%rsp)
               	leaq	0x20(%rsp), %rdi
               	movq	%rax, %rsi
               	callq	<addr>
               	movq	0x48(%rsp), %rax
               	addq	%r12, %rax
               	movq	%rbx, %rcx
               	orq	$0x4, %rcx
               	cmpq	$0x16, %rax
               	cmovneq	%rcx, %rbx
               	movl	$0x5, %edi
               	callq	<addr>
               	movq	%rdx, %r12
               	movq	%rax, 0x40(%rsp)
               	movq	%r12, 0x48(%rsp)
               	leaq	0x20(%rsp), %rdi
               	movq	%rax, %rsi
               	callq	<addr>
               	movq	0x48(%rsp), %rax
               	addq	%r12, %rax
               	movq	%rbx, %rcx
               	orq	$0x8, %rcx
               	cmpq	$0x1a, %rax
               	cmovneq	%rcx, %rbx
               	movl	$0x5, %edi
               	callq	<addr>
               	movq	%rax, 0x40(%rsp)
               	movq	%rdx, 0x48(%rsp)
               	shlq	%rax
               	addq	%rdx, %rax
               	movq	%rbx, %rcx
               	orq	$0x10, %rcx
               	cmpq	$0x1a, %rax
               	cmovneq	%rcx, %rbx
               	movl	$0xa, %esi
               	leaq	0x20(%rsp), %rdi
               	callq	<addr>
               	movq	0x38(%rsp), %rax
               	movq	%rbx, %rcx
               	orq	$0x40, %rcx
               	cmpq	$0xd, %rax
               	cmovneq	%rcx, %rbx
               	movq	%rbx, %rax
               	orq	$0x80, %rax
               	movl	<rip>, %ecx # <addr>
               	cmpl	$0xa, %ecx
               	cmoveq	%rbx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	addq	$0x40, %rsp
               	retq
