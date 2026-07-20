
indirect_call_ten_scalar_args.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<weight10>:
               	popq	%r10
               	subq	$0xa0, %rsp
               	movq	0xa0(%rsp), %rax
               	movq	%rax, 0x60(%rsp)
               	movq	0xa8(%rsp), %rax
               	movq	%rax, 0x70(%rsp)
               	movq	0xb0(%rsp), %rax
               	movq	%rax, 0x80(%rsp)
               	movq	0xb8(%rsp), %rax
               	movq	%rax, 0x90(%rsp)
               	pushq	%r10
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
               	movq	0x70(%rbp), %rcx
               	imulq	$0x7, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x80(%rbp), %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movq	0x90(%rbp), %rcx
               	leaq	(%rcx,%rcx,8), %rcx
               	addq	%rcx, %rax
               	movq	0xa0(%rbp), %rcx
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	popq	%rbp
               	popq	%r11
               	addq	$0xa0, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%r15, 0x20(%rsp)
               	leaq	-<rip>, %rax       # <addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rbx
               	leaq	0x1(%rbx), %rsi
               	leaq	0x2(%rbx), %rdx
               	leaq	0x3(%rbx), %rcx
               	leaq	0x4(%rbx), %r8
               	leaq	0x5(%rbx), %r9
               	leaq	0x6(%rbx), %rdi
               	leaq	0x7(%rbx), %r12
               	leaq	0x8(%rbx), %r13
               	leaq	0x9(%rbx), %r14
               	subq	$0x20, %rsp
               	movq	%rdi, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%rbx, %rdi
               	callq	*%rax
               	addq	$0x20, %rsp
               	movq	%rax, %r12
               	cmpq	$0x181, %r12            # imm = 0x181
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	0x1(%rbx), %rsi
               	leaq	0x2(%rbx), %rdx
               	leaq	0x3(%rbx), %rcx
               	leaq	0x4(%rbx), %r8
               	leaq	0x5(%rbx), %r9
               	leaq	0x6(%rbx), %rax
               	leaq	0x7(%rbx), %rdi
               	leaq	0x8(%rbx), %r13
               	leaq	0x9(%rbx), %r14
               	subq	$0x20, %rsp
               	movq	%rax, (%rsp)
               	movq	%rdi, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	movq	%rbx, %rdi
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	%rax, %r12
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	movq	0x20(%rsp), %r15
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
