
pthread_lifecycle.x64:	file format elf64-x86-64

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

<returns>:
               	pushq	%rbx
               	movq	%rdi, %rbx
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	leaq	0x1(%rbx), %rax
               	popq	%rbx
               	retq

<exits>:
               	pushq	%rax
               	addq	$0x2, %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%r11
               	retq

<detached>:
               	pushq	%rbx
               	movq	%rdi, %rbx
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	incq	%rax
               	movl	%eax, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rbx, %rax
               	popq	%rbx
               	retq

<deep>:
               	subq	$0x808, %rsp            # imm = 0x808
               	movb	%dil, (%rsp)
               	movb	%dil, 0x7ff(%rsp)
               	testl	%edi, %edi
               	je	<addr>
               	decq	%rdi
               	callq	<addr>
               	movsbq	(%rsp), %rcx
               	addq	%rcx, %rax
               	movsbq	0x7ff(%rsp), %rcx
               	subq	%rcx, %rax
               	addq	$0x808, %rsp            # imm = 0x808
               	retq
               	xorl	%eax, %eax
               	nopl	(%rax)
               	jmp	<addr>

<uses_stack>:
               	pushq	%rax
               	callq	<addr>
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	popq	%r11
               	retq

<main>:
               	subq	$0x98, %rsp
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	callq	<addr>
               	movq	%rax, %rsi
               	movq	0x18(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x41, %eax
               	addq	$0x98, %rsp
               	retq
               	leaq	-<rip>, %rdx # <addr>
               	leaq	0x28(%rsp), %rdi
               	xorl	%esi, %esi
               	leaq	0x50(%rsp), %rcx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x42, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	0x28(%rsp), %rdi
               	leaq	0x38(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x43, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	0x38(%rsp), %rax
               	leaq	0x50(%rsp), %rcx
               	incq	%rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x44, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	<rip>, %rdi # <addr>
               	movq	0x28(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x45, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	<rip>, %rdi # <addr>
               	movq	0x18(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x46, %eax
               	addq	$0x98, %rsp
               	retq
               	leaq	-<rip>, %rdx # <addr>
               	leaq	0x28(%rsp), %rdi
               	xorl	%esi, %esi
               	leaq	0x50(%rsp), %rcx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x47, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	0x28(%rsp), %rdi
               	leaq	0x38(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x48, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	0x38(%rsp), %rax
               	leaq	0x50(%rsp), %rcx
               	addq	$0x2, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x49, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	0x18(%rsp), %rdi
               	leaq	0x38(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x23, %rax
               	je	<addr>
               	movl	$0x4a, %eax
               	addq	$0x98, %rsp
               	retq
               	leaq	0x58(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4d, %eax
               	addq	$0x98, %rsp
               	retq
               	leaq	0x58(%rsp), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4e, %eax
               	addq	$0x98, %rsp
               	retq
               	xorl	%r8d, %r8d
               	leaq	-<rip>, %rdx # <addr>
               	movq	%r8, 0x8(%rsp)
               	leaq	0x28(%rsp), %rdi
               	leaq	0x58(%rsp), %rsi
               	xorl	%ecx, %ecx
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	0x8(%rsp), %r8
               	nopl	(%rax,%rax)
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%r8
               	cmpl	$0x4, %r8d
               	jl	<addr>
               	leaq	0x58(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x51, %eax
               	addq	$0x98, %rsp
               	retq
               	leaq	-<rip>, %rdx # <addr>
               	leaq	0x28(%rsp), %rdi
               	xorl	%esi, %esi
               	xorl	%ecx, %ecx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x52, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	0x28(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x53, %eax
               	addq	$0x98, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movq	%rdi, 0x18(%rsp)
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x5, %eax
               	jge	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	0x18(%rsp), %rsi
               	callq	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x5, %eax
               	jl	<addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	leaq	0x58(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5a, %eax
               	addq	$0x98, %rsp
               	retq
               	leaq	0x58(%rsp), %rdi
               	movl	$0x1000000, %esi        # imm = 0x1000000
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5b, %eax
               	addq	$0x98, %rsp
               	retq
               	leaq	0x58(%rsp), %rdi
               	leaq	0x40(%rsp), %rsi
               	leaq	0x48(%rsp), %rdx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5c, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	0x48(%rsp), %rax
               	cmpq	$0x1000000, %rax        # imm = 0x1000000
               	je	<addr>
               	movl	$0x5d, %eax
               	addq	$0x98, %rsp
               	retq
               	leaq	0x58(%rsp), %rdi
               	leaq	0x48(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5e, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	0x48(%rsp), %rax
               	testq	%rax, %rax
               	ja	<addr>
               	movl	$0x5f, %eax
               	addq	$0x98, %rsp
               	retq
               	leaq	-<rip>, %rdx # <addr>
               	leaq	0x28(%rsp), %rdi
               	leaq	0x58(%rsp), %rsi
               	movl	$0x1388, %ecx           # imm = 0x1388
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x60, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	0x28(%rsp), %rdi
               	leaq	0x38(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x61, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	0x38(%rsp), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x62, %eax
               	addq	$0x98, %rsp
               	retq
               	leaq	0x58(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x63, %eax
               	addq	$0x98, %rsp
               	retq
               	xorl	%edi, %edi
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x18(%rsp)
               	xorl	%edi, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, 0x10(%rsp)
               	movq	%rax, %r10
               	movq	0x18(%rsp), %rax
               	cmpl	%r10d, %eax
               	jle	<addr>
               	movl	$0x68, %eax
               	addq	$0x98, %rsp
               	retq
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x69, %eax
               	addq	$0x98, %rsp
               	retq
               	leaq	0x58(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6a, %eax
               	addq	$0x98, %rsp
               	retq
               	leaq	0x58(%rsp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6b, %eax
               	addq	$0x98, %rsp
               	retq
               	leaq	0x58(%rsp), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6c, %eax
               	addq	$0x98, %rsp
               	retq
               	leaq	0x58(%rsp), %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6d, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	0x18(%rsp), %rax
               	addq	0x10(%rsp), %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	sarq	%rax
               	movl	%eax, 0x30(%rsp)
               	leaq	0x58(%rsp), %rdi
               	leaq	0x30(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6f, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	0x18(%rsp), %rax
               	decq	%rax
               	movl	%eax, 0x30(%rsp)
               	leaq	0x58(%rsp), %rdi
               	leaq	0x30(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x71, %eax
               	addq	$0x98, %rsp
               	retq
               	movl	0x30(%rsp), %ecx
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
               	addq	$0x98, %rsp
               	retq
               	leaq	-<rip>, %rdx # <addr>
               	leaq	0x28(%rsp), %rdi
               	leaq	0x58(%rsp), %rsi
               	leaq	0x50(%rsp), %rcx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x73, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	0x28(%rsp), %rdi
               	leaq	0x38(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x74, %eax
               	addq	$0x98, %rsp
               	retq
               	movq	0x38(%rsp), %rax
               	leaq	0x50(%rsp), %rcx
               	incq	%rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x75, %eax
               	addq	$0x98, %rsp
               	retq
               	leaq	0x58(%rsp), %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x76, %eax
               	addq	$0x98, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x98, %rsp
               	retq
               	movl	$0x50, %eax
               	addq	$0x98, %rsp
               	retq
