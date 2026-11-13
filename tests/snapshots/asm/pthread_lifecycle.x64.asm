
pthread_lifecycle.x64:	file format elf64-x86-64

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

<returns>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x1(%rbx), %rax
               	popq	%rbx
               	leave
               	retq

<exits>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	addq	$0x2, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbp
               	retq

<detached>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rbx, %rax
               	popq	%rbx
               	leave
               	retq

<deep>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x800, %rsp            # imm = 0x800
               	movb	%dil, -0x800(%rbp)
               	movb	%dil, -0x1(%rbp)
               	testl	%edi, %edi
               	je	<addr>
               	decq	%rdi
               	callq	<addr>
               	movsbq	-0x800(%rbp), %rcx
               	addq	%rcx, %rax
               	movsbq	-0x1(%rbp), %rcx
               	subq	%rcx, %rax
               	leave
               	retq
               	xorl	%eax, %eax
               	jmp	<addr>

<uses_stack>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rsi
               	movq	0x18(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x41, %eax
               	leave
               	retq
               	leaq	-0x68(%rbp), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx # <addr>
               	leaq	-0x40(%rbp), %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x42, %eax
               	leave
               	retq
               	movq	-0x68(%rbp), %rdi
               	leaq	-0x58(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x43, %eax
               	leave
               	retq
               	movq	-0x58(%rbp), %rax
               	leaq	-0x40(%rbp), %rcx
               	incq	%rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x44, %eax
               	leave
               	retq
               	movq	<rip>, %rdi # <addr>
               	movq	-0x68(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x45, %eax
               	leave
               	retq
               	movq	<rip>, %rdi # <addr>
               	movq	0x18(%rsp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x46, %eax
               	leave
               	retq
               	leaq	-0x68(%rbp), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx # <addr>
               	leaq	-0x40(%rbp), %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x47, %eax
               	leave
               	retq
               	movq	-0x68(%rbp), %rdi
               	leaq	-0x58(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x48, %eax
               	leave
               	retq
               	movq	-0x58(%rbp), %rax
               	leaq	-0x40(%rbp), %rcx
               	addq	$0x2, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x49, %eax
               	leave
               	retq
               	leaq	-0x58(%rbp), %rsi
               	movq	0x18(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x23, %rax
               	je	<addr>
               	movl	$0x4a, %eax
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4d, %eax
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdi
               	movl	$0x1, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4e, %eax
               	leave
               	retq
               	xorl	%r8d, %r8d
               	leaq	-0x68(%rbp), %rdi
               	leaq	-0x38(%rbp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	xorl	%ecx, %ecx
               	movq	%r8, 0x8(%rsp)
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	0x8(%rsp), %r8
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%r8
               	cmpl	$0x4, %r8d
               	jl	<addr>
               	leaq	-0x38(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x51, %eax
               	leave
               	retq
               	leaq	-0x68(%rbp), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx # <addr>
               	movq	%rsi, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x52, %eax
               	leave
               	retq
               	movq	-0x68(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x53, %eax
               	leave
               	retq
               	leaq	<rip>, %r10 # <addr>
               	movq	%r10, 0x18(%rsp)
               	movq	0x18(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x5, %eax
               	jge	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	0x18(%rsp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x5, %eax
               	jl	<addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x38(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5a, %eax
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdi
               	movl	$0x1000000, %esi        # imm = 0x1000000
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5b, %eax
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdi
               	leaq	-0x50(%rbp), %rsi
               	leaq	-0x48(%rbp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5c, %eax
               	leave
               	retq
               	movq	-0x48(%rbp), %rax
               	cmpq	$0x1000000, %rax        # imm = 0x1000000
               	je	<addr>
               	movl	$0x5d, %eax
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdi
               	leaq	-0x48(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5e, %eax
               	leave
               	retq
               	movq	-0x48(%rbp), %rax
               	testq	%rax, %rax
               	ja	<addr>
               	movl	$0x5f, %eax
               	leave
               	retq
               	leaq	-0x68(%rbp), %rdi
               	leaq	-0x38(%rbp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	movl	$0x1388, %ecx           # imm = 0x1388
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x60, %eax
               	leave
               	retq
               	movq	-0x68(%rbp), %rdi
               	leaq	-0x58(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x61, %eax
               	leave
               	retq
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x62, %eax
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x63, %eax
               	leave
               	retq
               	xorl	%edi, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	xorl	%edi, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x18(%rsp), %rax
               	cmpl	0x10(%rsp), %eax
               	jle	<addr>
               	movl	$0x68, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x69, %eax
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6a, %eax
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdi
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6b, %eax
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdi
               	movl	$0x1, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6c, %eax
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdi
               	xorl	%esi, %esi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6d, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %rsi
               	movq	0x18(%rsp), %rax
               	addq	0x10(%rsp), %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	sarq	%rax
               	movl	%eax, -0x60(%rbp)
               	leaq	-0x38(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6f, %eax
               	leave
               	retq
               	leaq	-0x60(%rbp), %rsi
               	movq	0x18(%rsp), %rax
               	decq	%rax
               	movl	%eax, -0x60(%rbp)
               	leaq	-0x38(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x71, %eax
               	leave
               	retq
               	movl	-0x60(%rbp), %ecx
               	movq	0x18(%rsp), %rax
               	addq	0x10(%rsp), %rax
               	movslq	%eax, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	sarq	%rax
               	cmpl	%eax, %ecx
               	je	<addr>
               	movl	$0x72, %eax
               	leave
               	retq
               	leaq	-0x68(%rbp), %rdi
               	leaq	-0x38(%rbp), %rsi
               	leaq	-<rip>, %rdx # <addr>
               	leaq	-0x40(%rbp), %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x73, %eax
               	leave
               	retq
               	movq	-0x68(%rbp), %rdi
               	leaq	-0x58(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x74, %eax
               	leave
               	retq
               	movq	-0x58(%rbp), %rax
               	leaq	-0x40(%rbp), %rcx
               	incq	%rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x75, %eax
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x76, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x50, %eax
               	leave
               	retq
