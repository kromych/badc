
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
               	testl	%edx, %edx
               	jle	<addr>
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
               	movq	%rdi, %rax
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
               	testq	%rdi, %rdi
               	jle	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	xorl	%ecx, %ecx
               	movabsq	$0x6666666666666667, %rsi # imm = 0x6666666666666667
               	movq	%rdi, %rax
               	imulq	%rsi
               	sarq	$0x2, %rdx
               	movq	%rdx, %rax
               	shrq	$0x3f, %rax
               	leaq	(%rdx,%rax), %rbx
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
               	xorl	%eax, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%rbx
               	movq	<rip>, %rbx # <addr>
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x38(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x30(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x20(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x18(%rsp)
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x28(%rsp)
               	movq	%rbx, %rdi
               	movq	0x38(%rsp), %rsi
               	movq	0x30(%rsp), %rdx
               	callq	<addr>
               	cmpq	$0x45, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	negq	%rdi
               	movq	0x38(%rsp), %rsi
               	movq	0x30(%rsp), %rdx
               	callq	<addr>
               	cmpq	$-0x39, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x3, %edx
               	movq	%rbx, %rdi
               	movq	0x38(%rsp), %rsi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	jne	<addr>
               	xorl	%edx, %edx
               	movq	%rbx, %rdi
               	movq	0x38(%rsp), %rsi
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rax
               	addq	0x38(%rsp), %rax
               	addq	0x30(%rsp), %rax
               	addq	0x20(%rsp), %rax
               	addq	0x18(%rsp), %rax
               	addq	0x28(%rsp), %rax
               	leaq	(%rax,%rax,2), %rax
               	leaq	0x1(%rax), %rcx
               	movq	%rcx, 0x10(%rsp)
               	movq	%rbx, %rdi
               	movq	0x38(%rsp), %rsi
               	movq	0x30(%rsp), %rdx
               	movq	0x20(%rsp), %rcx
               	movq	0x18(%rsp), %r8
               	movq	0x28(%rsp), %r9
               	callq	<addr>
               	movq	0x10(%rsp), %rcx
               	imulq	$0x64, %rcx, %rdx
               	leaq	(%rcx,%rcx,2), %rcx
               	incq	%rcx
               	addq	%rdx, %rcx
               	addq	%rbx, %rcx
               	addq	0x30(%rsp), %rcx
               	addq	0x28(%rsp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movl	$0xd89e, %ecx           # imm = 0xD89E
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movq	<rip>, %rdi # <addr>
               	callq	<addr>
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$0xd89e, <rip> # imm = 0xD89E
                                                # <addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
