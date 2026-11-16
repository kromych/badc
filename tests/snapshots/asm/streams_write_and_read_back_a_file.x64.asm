
streams_write_and_read_back_a_file.x64:	file format elf64-x86-64

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
               	cmpl	$0x2, %edi
               	jl	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x170, %rsp            # imm = 0x170
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
               	leave
               	retq
               	leaq	<rip>, %rsi
               	movl	$0x2a, %edx
               	leaq	<rip>, %rcx
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movl	$0x78, %edi
               	movq	%rbx, %rsi
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x1, %esi
               	movl	$0x9, %edx
               	movq	%rbx, %rcx
               	callq	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	0x8(%r12), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	0x8(%r12), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	-0x120(%rbp), %rdi
               	movl	$0x20, %esi
               	movq	%rbx, %rdx
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x120(%rbp), %rdi
               	movl	$0x7, %esi
               	movq	%rbx, %rdx
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x120(%rbp), %rdi
               	movl	$0x20, %esi
               	movq	%rbx, %rdx
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x28(%rsp)
               	movl	$0x59, %edi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x20(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	<rip>, %rdi
               	movq	0x28(%rsp), %rsi
               	movq	0x20(%rsp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x120(%rbp), %rdi
               	movl	$0x20, %esi
               	movq	%rbx, %rdx
               	callq	<addr>
               	movq	%rax, %rsi
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$0x0, -0x148(%rbp)
               	movl	$0x0, -0x140(%rbp)
               	leaq	<rip>, %rsi
               	leaq	-0x148(%rbp), %rdx
               	leaq	-0x140(%rbp), %rcx
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x28(%rsp)
               	movsd	-0x148(%rbp), %xmm14
               	movsd	%xmm14, 0x20(%rsp)
               	movl	-0x140(%rbp), %r10d
               	movq	%r10, 0x18(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %rcx
               	leaq	<rip>, %rdi
               	movsd	0x20(%rsp), %xmm0
               	movq	0x28(%rsp), %rsi
               	movq	0x18(%rsp), %rdx
               	movb	$0x1, %al
               	callq	<addr>
               	movq	$0x0, -0x138(%rbp)
               	movq	$0x0, -0x130(%rbp)
               	leaq	-0x138(%rbp), %rdi
               	leaq	-0x130(%rbp), %rsi
               	movq	%rbx, %rdx
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x28(%rsp)
               	movq	-0x138(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	leaq	<rip>, %rdi
               	movq	0x28(%rsp), %rsi
               	movq	0x20(%rsp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x138(%rbp), %rdi
               	leaq	-0x130(%rbp), %rsi
               	movq	%rbx, %rdx
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x28(%rsp)
               	movq	-0x138(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	leaq	<rip>, %rdi
               	movq	0x28(%rsp), %rsi
               	movq	0x20(%rsp), %rdx
               	movq	0x18(%rsp), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	-0x138(%rbp), %rdi
               	callq	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	-0x128(%rbp), %rdi
               	movq	$0x0, (%rdi)
               	movl	$0x2, %esi
               	movl	$0x3, %edx
               	movq	%rbx, %rcx
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x28(%rsp)
               	movq	$-0x4, %rsi
               	movl	$0x2, %edx
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x20(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r8
               	leaq	<rip>, %rdi
               	leaq	-0x128(%rbp), %rdx
               	movq	0x28(%rsp), %rsi
               	movq	0x20(%rsp), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x28(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	movq	%rax, %rdx
               	leaq	<rip>, %rdi
               	movq	0x28(%rsp), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	callq	<addr>
               	movl	$0x0, (%rax)
               	leaq	-0x100(%rbp), %rdi
               	movl	$0x100, %esi            # imm = 0x100
               	leaq	<rip>, %rdx
               	movq	0x8(%r12), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x100(%rbp), %rdi
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
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x2, %eax
               	retq
