
indirect_call_staged_target.x64:	file format elf64-x86-64

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

<weigh17>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rsi, %rax
               	shlq	%rax
               	addq	%rdi, %rax
               	leaq	(%rdx,%rdx,2), %rdx
               	addq	%rdx, %rax
               	shlq	$0x2, %rcx
               	addq	%rcx, %rax
               	leaq	(%r8,%r8,4), %rcx
               	addq	%rcx, %rax
               	imulq	$0x6, %r9, %rcx
               	addq	%rcx, %rax
               	movq	0x10(%rbp), %rcx
               	imulq	$0x7, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x18(%rbp), %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movq	0x20(%rbp), %rcx
               	leaq	(%rcx,%rcx,8), %rcx
               	addq	%rcx, %rax
               	movq	0x28(%rbp), %rcx
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x30(%rbp), %rcx
               	imulq	$0xb, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x38(%rbp), %rcx
               	imulq	$0xc, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x40(%rbp), %rcx
               	imulq	$0xd, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x48(%rbp), %rcx
               	imulq	$0xe, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x50(%rbp), %rcx
               	imulq	$0xf, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x58(%rbp), %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rax
               	movq	0x60(%rbp), %rcx
               	imulq	$0x11, %rcx, %rcx
               	addq	%rcx, %rax
               	popq	%rbp
               	retq

<through>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rax
               	leaq	(%rsi,%rdx), %rdi
               	movq	%rsi, %rcx
               	subq	%rdx, %rcx
               	movq	%rsi, %r8
               	imulq	%rdx, %r8
               	leaq	0x1(%rsi), %r9
               	leaq	0x1(%rdx), %rbx
               	leaq	0x2(%rsi), %r12
               	leaq	0x2(%rdx), %r13
               	leaq	0x3(%rsi), %r14
               	leaq	0x3(%rdx), %r15
               	leaq	0x4(%rsi), %r10
               	movq	%r10, 0x68(%rsp)
               	leaq	0x4(%rdx), %r10
               	movq	%r10, 0x60(%rsp)
               	leaq	0x5(%rsi), %r10
               	movq	%r10, 0x58(%rsp)
               	leaq	0x5(%rdx), %r10
               	movq	%r10, 0x50(%rsp)
               	leaq	0x6(%rsi), %r10
               	movq	%r10, 0x48(%rsp)
               	leaq	0x6(%rdx), %r10
               	movq	%r10, 0x40(%rsp)
               	subq	$0x60, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	movq	0xc8(%rsp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0xc0(%rsp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0xb8(%rsp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0xb0(%rsp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0xa8(%rsp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0xa0(%rsp), %r10
               	movq	%r10, 0x50(%rsp)
               	xchgq	%rsi, %rdi
               	xchgq	%rsi, %rdx
               	callq	*%rax
               	addq	$0x60, %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rdi
               	movl	$0x3, %esi
               	movl	$0x5, %edx
               	callq	<addr>
               	cmpq	$0x4bf, %rax            # imm = 0x4BF
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	jmp	<addr>
