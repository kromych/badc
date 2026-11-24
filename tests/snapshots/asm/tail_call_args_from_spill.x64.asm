
tail_call_args_from_spill.x64:	file format elf64-x86-64

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

<forward>:
               	subq	$0x58, %rsp
               	leaq	0x1(%rdi), %rcx
               	leaq	0x2(%rdi), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	0x3(%rdi), %rdx
               	leaq	0x4(%rdi), %rsi
               	leaq	0x5(%rdi), %r10
               	movq	%r10, 0x10(%rsp)
               	leaq	0x6(%rdi), %r8
               	leaq	0x7(%rdi), %r9
               	leaq	0x8(%rdi), %r10
               	movq	%r10, 0x48(%rsp)
               	leaq	0x9(%rdi), %rax
               	leaq	0xa(%rdi), %r10
               	movq	%r10, 0x40(%rsp)
               	leaq	0xb(%rdi), %r10
               	movq	%r10, 0x38(%rsp)
               	leaq	0xc(%rdi), %r10
               	movq	%r10, 0x30(%rsp)
               	leaq	0xd(%rdi), %r10
               	movq	%r10, 0x8(%rsp)
               	leaq	0xe(%rdi), %r10
               	movq	%r10, 0x28(%rsp)
               	leaq	0xf(%rdi), %r10
               	movq	%r10, 0x20(%rsp)
               	addq	%rdi, %rcx
               	addq	%rdx, %rcx
               	addq	%rsi, %rcx
               	addq	%r8, %rcx
               	addq	%r9, %rcx
               	addq	0x48(%rsp), %rcx
               	addq	%rax, %rcx
               	addq	0x40(%rsp), %rcx
               	addq	0x38(%rsp), %rcx
               	addq	0x30(%rsp), %rcx
               	addq	0x28(%rsp), %rcx
               	addq	0x20(%rsp), %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movq	$-0x1, %rax
               	addq	$0x58, %rsp
               	retq
               	movq	0x10(%rsp), %rcx
               	shlq	%rcx
               	movq	%rcx, %r10
               	movq	0x18(%rsp), %rcx
               	addq	%r10, %rcx
               	leaq	(%rax,%rax,2), %rax
               	addq	%rcx, %rax
               	movq	0x8(%rsp), %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	addq	$0x58, %rsp
               	retq

<main>:
               	subq	$0x20, %rsp
               	pushq	%rbx
               	movl	$0xa, 0x18(%rsp)
               	movl	0x18(%rsp), %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	movl	$0x1, %ecx
               	cmpl	$0xbf, %ebx
               	cmovneq	%rcx, %rax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
