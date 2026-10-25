
call_conv_across_scopes.x64:	file format elf64-x86-64

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

<block_first>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	leaq	0xe(%rax), %rcx
               	subq	$0x20, %rsp
               	callq	<addr>
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<block_plain>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x2, %ecx
               	subq	$0x20, %rsp
               	callq	<addr>
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<hidden_by_local>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movl	$0x5, %ecx
               	subq	$0x20, %rsp
               	callq	<addr>
               	addq	$0x20, %rsp
               	movq	%rax, %rbx
               	xorl	%ecx, %ecx
               	subq	$0x20, %rsp
               	callq	<addr>
               	addq	$0x20, %rsp
               	movq	%rbx, %rax
               	popq	%rbx
               	leave
               	retq

<names_foreign>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x1, %ecx
               	subq	$0x20, %rsp
               	callq	<addr>
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq

<keeps_values>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rbx
               	movq	0x8(%rax), %r12
               	movq	0x10(%rax), %r13
               	movq	0x18(%rax), %r14
               	movq	0x20(%rax), %r15
               	movq	0x28(%rax), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x30(%rax), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x38(%rax), %r10
               	movq	%r10, 0x38(%rsp)
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	subq	$0x20, %rsp
               	callq	<addr>
               	addq	$0x20, %rsp
               	movslq	%eax, %rax
               	addq	%rbx, %rax
               	shlq	%r12
               	addq	%r12, %rax
               	leaq	(%r13,%r13,2), %rcx
               	addq	%rcx, %rax
               	shlq	$0x2, %r14
               	addq	%r14, %rax
               	leaq	(%r15,%r15,4), %rcx
               	addq	%rcx, %rax
               	movq	0x48(%rsp), %rcx
               	imulq	$0x6, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x40(%rsp), %rcx
               	imulq	$0x7, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x38(%rsp), %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<add100>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%rdi
               	pushq	%rsi
               	movq	$-0x1, %rsi
               	movq	$-0x1, %rdi
               	leaq	0x64(%rcx), %rax
               	popq	%rsi
               	popq	%rdi
               	popq	%rbp
               	retq

<twice>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%rdi
               	pushq	%rsi
               	movq	$-0x1, %rsi
               	movq	$-0x1, %rdi
               	movq	%rcx, %rax
               	shlq	%rax
               	popq	%rsi
               	popq	%rdi
               	popq	%rbp
               	retq

<times3>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%rdi
               	pushq	%rsi
               	movq	$-0x1, %rsi
               	movq	$-0x1, %rdi
               	leaq	(%rcx,%rcx,2), %rax
               	popq	%rsi
               	popq	%rdi
               	popq	%rbp
               	retq

<fcl>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%rdi
               	pushq	%rsi
               	movq	$-0x1, %rsi
               	movq	$-0x1, %rdi
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %edx
               	movl	(%rcx), %ecx
               	addq	%rdx, %rcx
               	movl	%ecx, (%rax)
               	popq	%rsi
               	popq	%rdi
               	popq	%rbp
               	retq

<cleanup_hidden>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movl	$0x2, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rcx
               	subq	$0x20, %rsp
               	callq	<addr>
               	addq	$0x20, %rsp
               	movl	$0x9, %eax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movl	$0xe, %edi
               	callq	<addr>
               	cmpl	$0x79, %eax
               	setne	%bl
               	movzbq	%bl, %rbx
               	callq	<addr>
               	cmpl	$0x66, %eax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	%rax
               	orq	%rax, %rbx
               	callq	<addr>
               	cmpl	$0xa, %eax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x2, %rax
               	orq	%rax, %rbx
               	callq	<addr>
               	cmpl	$0x3, %eax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x5, %rax
               	orq	%rax, %rbx
               	callq	<addr>
               	cmpq	$0x247, %rax            # imm = 0x247
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x3, %rax
               	orq	%rax, %rbx
               	movl	$0x1, %ecx
               	subq	$0x20, %rsp
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpl	$0x65, %eax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x4, %rax
               	orq	%rax, %rbx
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0x9, %eax
               	movl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x2, %eax
               	setne	%al
               	movzbq	%al, %rax
               	shlq	$0x6, %rax
               	orq	%rbx, %rax
               	testl	%eax, %eax
               	setne	%al
               	movzbq	%al, %rax
               	popq	%rbx
               	leave
               	retq
