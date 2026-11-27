
streams_write_and_read_back_a_file.x64:	file format elf64-x86-64

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

<main>:
               	cmpl	$0x2, %edi
               	jl	<addr>
               	subq	$0x168, %rsp            # imm = 0x168
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rsi, %r12
               	movq	0x8(%r12), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movq	%rax, %rbx
               	testq	%rbx, %rbx
               	jne	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	addq	$0x168, %rsp            # imm = 0x168
               	retq
               	movq	%rbx, %rdi
               	leaq	<rip>, %rsi
               	movl	$0x2a, %edx
               	leaq	<rip>, %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rbx, %rsi
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rbx, %rsi
               	movl	$0x78, %edi
               	callq	<addr>
               	movq	%rbx, %rcx
               	leaq	<rip>, %rdi
               	movl	$0x1, %esi
               	movl	$0x9, %edx
               	callq	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	0x8(%r12), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	%rbx, %rsi
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	0x8(%r12), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movq	%rax, %rbx
               	movq	%rbx, %rdx
               	leaq	0x60(%rsp), %rdi
               	movl	$0x20, %esi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rbx, %rdx
               	leaq	0x60(%rsp), %rdi
               	movl	$0x7, %esi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rbx, %rdx
               	leaq	0x60(%rsp), %rdi
               	movl	$0x20, %esi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%rbx, %rsi
               	movl	$0x59, %edi
               	callq	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	movq	%r13, %rsi
               	movq	%r14, %rdx
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rbx, %rdx
               	leaq	0x60(%rsp), %rdi
               	movl	$0x20, %esi
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$0x0, 0x38(%rsp)
               	movl	$0x0, 0x40(%rsp)
               	movq	%rbx, %rdi
               	leaq	<rip>, %rsi
               	leaq	0x38(%rsp), %rdx
               	leaq	0x40(%rsp), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %r13
               	movsd	0x38(%rsp), %xmm14
               	movsd	%xmm14, 0x28(%rsp)
               	movl	0x40(%rsp), %r14d
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	movsd	0x28(%rsp), %xmm0
               	movq	%r13, %rsi
               	movq	%r14, %rdx
               	leaq	<rip>, %rdi
               	movb	$0x1, %al
               	callq	<addr>
               	movq	$0x0, 0x48(%rsp)
               	movq	$0x0, 0x50(%rsp)
               	movq	%rbx, %rdx
               	leaq	0x48(%rsp), %rdi
               	leaq	0x50(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	0x48(%rsp), %r14
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movq	%r13, %rsi
               	movq	%r14, %rdx
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rbx, %rdx
               	leaq	0x48(%rsp), %rdi
               	leaq	0x50(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	0x48(%rsp), %r14
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x28(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	movq	%r13, %rsi
               	movq	%r14, %rdx
               	leaq	<rip>, %rdi
               	movq	0x28(%rsp), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	0x48(%rsp), %rdi
               	callq	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	0x58(%rsp), %rdi
               	movq	$0x0, (%rdi)
               	movq	%rbx, %rcx
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%rbx, %rdi
               	movq	$-0x4, %rsi
               	movl	$0x2, %edx
               	callq	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	movq	%r13, %rsi
               	movq	%r14, %rcx
               	leaq	<rip>, %rdi
               	leaq	0x58(%rsp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r13
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %rdx
               	movq	%r13, %rsi
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	callq	<addr>
               	movl	$0x0, (%rax)
               	movq	0x8(%r12), %rcx
               	leaq	0x80(%rsp), %rdi
               	movl	$0x100, %esi            # imm = 0x100
               	leaq	<rip>, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	testq	%rax, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x2, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	movq	%rbx, %rsi
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	addq	$0x168, %rsp            # imm = 0x168
               	retq
               	movl	$0x2, %eax
               	retq
