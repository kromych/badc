
indirect_call_ten_scalar_args.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	0x1(%rax), %rcx
               	leaq	0x2(%rax), %rdx
               	leaq	0x3(%rax), %rsi
               	leaq	0x4(%rax), %rdi
               	leaq	0x5(%rax), %r8
               	leaq	0x6(%rax), %r9
               	leaq	0x7(%rax), %rbx
               	leaq	0x8(%rax), %r12
               	leaq	0x9(%rax), %r13
               	shlq	%rcx
               	addq	%rax, %rcx
               	leaq	(%rdx,%rdx,2), %rdx
               	addq	%rdx, %rcx
               	movq	%rsi, %rdx
               	shlq	$0x2, %rdx
               	addq	%rdx, %rcx
               	leaq	(%rdi,%rdi,4), %rdx
               	addq	%rdx, %rcx
               	imulq	$0x6, %r8, %rdx
               	addq	%rdx, %rcx
               	imulq	$0x7, %r9, %rdx
               	addq	%rdx, %rcx
               	movq	%rbx, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	leaq	(%r12,%r12,8), %rdx
               	addq	%rdx, %rcx
               	imulq	$0xa, %r13, %rdx
               	addq	%rdx, %rcx
               	cmpq	$0x181, %rcx            # imm = 0x181
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
