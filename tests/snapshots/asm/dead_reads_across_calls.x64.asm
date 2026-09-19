
dead_reads_across_calls.x64:	file format elf64-x86-64

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

<ext>:
               	leaq	(%rdi,%rdi,2), %rax
               	incq	%rax
               	retq

<unread_after_call>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	%rsi, %rbx
               	imulq	%rdx, %rdi
               	callq	<addr>
               	addq	%rbx, %rax
               	popq	%rbx
               	leave
               	retq

<unread_in_loop>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r13
               	movq	%rdx, %r14
               	xorl	%ebx, %ebx
               	movq	%rbx, %r12
               	cmpl	%r14d, %ebx
               	jge	<addr>
               	leaq	(%r13,%rbx), %rdi
               	callq	<addr>
               	addq	%rax, %r12
               	incq	%rbx
               	cmpl	%r14d, %ebx
               	jl	<addr>
               	leaq	(%r12,%r13), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq

<six>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %rbx
               	movq	%r9, %r13
               	movq	%rdx, %r12
               	leaq	(%rbx,%rsi), %rax
               	addq	%r12, %rax
               	addq	%rcx, %rax
               	addq	%r8, %rax
               	leaq	(%rax,%r13), %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	movq	%r14, %rdi
               	callq	<addr>
               	imulq	$0x64, %r14, %rcx
               	addq	%rcx, %rax
               	addq	%rbx, %rax
               	addq	%r12, %rax
               	addq	%r13, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%rbp
               	retq

<digit_calls>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	xorl	%ecx, %ecx
               	testq	%rdi, %rdi
               	jle	<addr>
               	movabsq	$0x6666666666666667, %rsi # imm = 0x6666666666666667
               	movq	%rdi, %rax
               	imulq	%rsi
               	movq	%rdx, %rax
               	sarq	$0x2, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	leaq	(%rax,%rdx), %rbx
               	imulq	$0xa, %rbx, %rax
               	subq	%rax, %rdi
               	imulq	$0x7, %rcx, %r12
               	callq	<addr>
               	leaq	(%r12,%rax), %rcx
               	movq	%rbx, %rdi
               	testq	%rdi, %rdi
               	jg	<addr>
               	movq	%rcx, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %rbx
               	movq	0x8(%rax), %r12
               	movq	0x10(%rax), %r13
               	movq	0x18(%rax), %r15
               	movq	0x20(%rax), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	0x28(%rax), %r14
               	movq	%rbx, %rdi
               	movq	%r13, %rdx
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	$0x45, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	imulq	$-0x1, %rbx, %rdi
               	movq	%r12, %rsi
               	movq	%r13, %rdx
               	callq	<addr>
               	cmpq	$-0x39, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x3, %edx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	jne	<addr>
               	xorl	%edx, %edx
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	(%rbx,%r12), %rax
               	addq	%r13, %rax
               	addq	%r15, %rax
               	addq	0x38(%rsp), %rax
               	addq	%r14, %rax
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x1(%rax), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	%rbx, %rdi
               	movq	%r14, %r9
               	movq	%r15, %rcx
               	movq	%r13, %rdx
               	movq	%r12, %rsi
               	movq	0x38(%rsp), %r8
               	callq	<addr>
               	movq	0x30(%rsp), %rcx
               	imulq	$0x64, %rcx, %rdx
               	leaq	(%rcx,%rcx,2), %rcx
               	incq	%rcx
               	addq	%rdx, %rcx
               	addq	%rbx, %rcx
               	addq	%r13, %rcx
               	addq	%r14, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0xd89e, %ebx           # imm = 0xD89E
               	leaq	<rip>, %rax
               	movq	0x30(%rax), %rdi
               	callq	<addr>
               	cmpq	%rbx, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	0x38(%rax), %rdi
               	callq	<addr>
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rax
               	movq	%rbx, (%rax)
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
