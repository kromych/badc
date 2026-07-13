
tail_call_args_from_spill.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sink>:
               	movq	%rcx, %r8
               	movq	%rsi, %rax
               	shlq	$0x1, %rax
               	addq	%rdi, %rax
               	leaq	(%rdx,%rdx,2), %rcx
               	addq	%rcx, %rax
               	movq	%r8, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq

<forward>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	leaq	0x1(%rdi), %rdx
               	leaq	0x2(%rdi), %rax
               	leaq	0x3(%rdi), %rsi
               	leaq	0x4(%rdi), %r8
               	leaq	0x5(%rdi), %r9
               	leaq	0x6(%rdi), %rbx
               	leaq	0x7(%rdi), %r12
               	leaq	0x8(%rdi), %r13
               	leaq	0x9(%rdi), %rcx
               	leaq	0xa(%rdi), %r14
               	leaq	0xb(%rdi), %r15
               	leaq	0xc(%rdi), %r10
               	movq	%r10, 0x78(%rsp)
               	leaq	0xd(%rdi), %r10
               	movq	%r10, 0x70(%rsp)
               	leaq	0xe(%rdi), %r10
               	movq	%r10, 0x68(%rsp)
               	leaq	0xf(%rdi), %r10
               	movq	%r10, 0x60(%rsp)
               	addq	%rdi, %rdx
               	addq	%rsi, %rdx
               	addq	%r8, %rdx
               	addq	%rbx, %rdx
               	addq	%r12, %rdx
               	addq	%r13, %rdx
               	addq	%rcx, %rdx
               	addq	%r14, %rdx
               	addq	%r15, %rdx
               	addq	0x78(%rsp), %rdx
               	addq	0x68(%rsp), %rdx
               	addq	0x60(%rsp), %rdx
               	movslq	%edx, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	movabsq	$-0x1, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movq	%r9, %rdx
               	shlq	$0x1, %rdx
               	addq	%rdx, %rax
               	leaq	(%rcx,%rcx,2), %rcx
               	addq	%rcx, %rax
               	movq	0x70(%rsp), %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0xa, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rdi
               	movslq	%ebx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%ebx, %rax
               	cmpq	$0xbf, %rax
               	jne	<addr>
               	xorq	%rax, %rax
               	movslq	%eax, %rax
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
               	addb	%al, (%rax)
