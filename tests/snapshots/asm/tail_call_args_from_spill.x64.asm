
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
               	leaq	0x1(%rdi), %rax
               	addq	%rdi, %rax
               	leaq	0x3(%rdi), %rcx
               	addq	%rcx, %rax
               	leaq	0x4(%rdi), %rcx
               	addq	%rcx, %rax
               	leaq	0x6(%rdi), %rcx
               	addq	%rcx, %rax
               	leaq	0x7(%rdi), %rcx
               	addq	%rcx, %rax
               	leaq	0x8(%rdi), %rcx
               	addq	%rax, %rcx
               	leaq	0x9(%rdi), %rax
               	addq	%rax, %rcx
               	leaq	0xa(%rdi), %rdx
               	addq	%rdx, %rcx
               	leaq	0xb(%rdi), %rdx
               	addq	%rdx, %rcx
               	leaq	0xc(%rdi), %rdx
               	addq	%rdx, %rcx
               	leaq	0xe(%rdi), %rdx
               	addq	%rdx, %rcx
               	leaq	0xf(%rdi), %rdx
               	leaq	(%rcx,%rdx), %rsi
               	leaq	0x2(%rdi), %r8
               	leaq	0x5(%rdi), %rcx
               	leaq	0xd(%rdi), %rdx
               	testl	%esi, %esi
               	jne	<addr>
               	movq	$-0x1, %rax
               	retq
               	shlq	%rcx
               	addq	%r8, %rcx
               	leaq	(%rax,%rax,2), %rax
               	addq	%rcx, %rax
               	shlq	$0x2, %rdx
               	addq	%rdx, %rax
               	retq

<main>:
               	subq	$0x20, %rsp
               	pushq	%rbx
               	movl	$0xa, 0x18(%rsp)
               	movl	0x18(%rsp), %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	%rbx, %rsi
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	movl	$0x1, %ecx
               	cmpl	$0xbf, %ebx
               	cmovneq	%rcx, %rax
               	popq	%rbx
               	addq	$0x20, %rsp
               	retq
