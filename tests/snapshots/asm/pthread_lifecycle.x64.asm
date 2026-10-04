
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
               	leaq	<rip>, %rcx      # <addr>
               	movq	%rax, (%rcx)
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
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi      # <addr>
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
               	movslq	%edi, %rdi
               	leaq	-0x800(%rbp), %rax
               	movb	%dil, (%rax)
               	movb	%dil, 0x7ff(%rax)
               	testq	%rdi, %rdi
               	je	<addr>
               	decq	%rdi
               	callq	<addr>
               	leaq	-0x800(%rbp), %rcx
               	movsbq	(%rcx), %rdx
               	addq	%rdx, %rax
               	movsbq	0x7ff(%rcx), %rcx
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
               	subq	$0x70, %rsp
               	pushq	%r12
               	pushq	%rbx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rsi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x41, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x68(%rbp), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx      # <addr>
               	leaq	-0x40(%rbp), %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x42, %eax
               	popq	%rbx
               	popq	%r12
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
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	-0x58(%rbp), %rax
               	leaq	-0x40(%rbp), %rcx
               	incq	%rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x44, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rdi
               	movq	-0x68(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x45, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rdi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x46, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x68(%rbp), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx      # <addr>
               	leaq	-0x40(%rbp), %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x47, %eax
               	popq	%rbx
               	popq	%r12
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
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	-0x58(%rbp), %rax
               	leaq	-0x40(%rbp), %rcx
               	addq	$0x2, %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x49, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x58(%rbp), %rsi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x23, %rax
               	je	<addr>
               	movl	$0x4a, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4d, %eax
               	popq	%rbx
               	popq	%r12
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
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%ebx, %ebx
               	leaq	-0x68(%rbp), %rdi
               	leaq	-0x38(%rbp), %rsi
               	leaq	-<rip>, %rdx      # <addr>
               	xorl	%ecx, %ecx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x4, %ebx
               	jl	<addr>
               	leaq	-0x38(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x51, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x68(%rbp), %rdi
               	xorl	%esi, %esi
               	leaq	-<rip>, %rdx      # <addr>
               	movq	%rsi, %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x52, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	-0x68(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x53, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	<rip>, %rbx      # <addr>
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi      # <addr>
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movslq	(%rax), %rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	leaq	<rip>, %rdi      # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x38(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5a, %eax
               	popq	%rbx
               	popq	%r12
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
               	popq	%rbx
               	popq	%r12
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
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	-0x48(%rbp), %rax
               	cmpq	$0x1000000, %rax        # imm = 0x1000000
               	je	<addr>
               	movl	$0x5d, %eax
               	popq	%rbx
               	popq	%r12
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
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	-0x48(%rbp), %rax
               	testq	%rax, %rax
               	ja	<addr>
               	movl	$0x5f, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x68(%rbp), %rdi
               	leaq	-0x38(%rbp), %rsi
               	leaq	-<rip>, %rdx      # <addr>
               	movl	$0x1388, %ecx           # imm = 0x1388
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x60, %eax
               	popq	%rbx
               	popq	%r12
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
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	-0x58(%rbp), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x62, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x63, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%edi, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	xorl	%edi, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	cmpl	%r12d, %ebx
               	jle	<addr>
               	movl	$0x68, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x69, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6a, %eax
               	popq	%rbx
               	popq	%r12
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
               	popq	%rbx
               	popq	%r12
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
               	popq	%rbx
               	popq	%r12
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
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x60(%rbp), %rsi
               	leaq	(%rbx,%r12), %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	sarq	%rax
               	movl	%eax, (%rsi)
               	leaq	-0x38(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6f, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x60(%rbp), %rsi
               	leaq	-0x1(%rbx), %rax
               	movl	%eax, (%rsi)
               	leaq	-0x38(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x71, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movslq	-0x60(%rbp), %rcx
               	leaq	(%rbx,%r12), %rax
               	movslq	%eax, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rdx, %rax
               	sarq	%rax
               	cmpl	%eax, %ecx
               	je	<addr>
               	movl	$0x72, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x68(%rbp), %rdi
               	leaq	-0x38(%rbp), %rsi
               	leaq	-<rip>, %rdx      # <addr>
               	leaq	-0x40(%rbp), %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x73, %eax
               	popq	%rbx
               	popq	%r12
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
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movq	-0x58(%rbp), %rax
               	leaq	-0x40(%rbp), %rcx
               	incq	%rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x75, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	-0x38(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x76, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x50, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
