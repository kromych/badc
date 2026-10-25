
scanf_family_stores_c99_conversions_alike.x64:	file format elf64-x86-64

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

<v_string>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rdi, -0xd0(%rbp)
               	movq	%rsi, -0xc8(%rbp)
               	movq	%rdx, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%r8, -0xb0(%rbp)
               	movq	%r9, -0xa8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movups	%xmm0, -0xa0(%rbp)
               	movups	%xmm1, -0x90(%rbp)
               	movups	%xmm2, -0x80(%rbp)
               	movups	%xmm3, -0x70(%rbp)
               	movups	%xmm4, -0x60(%rbp)
               	movups	%xmm5, -0x50(%rbp)
               	movups	%xmm6, -0x40(%rbp)
               	movups	%xmm7, -0x30(%rbp)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xc8(%rbp), %rcx
               	movl	$0x10, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	movq	-0xd0(%rbp), %rdi
               	movq	-0xc8(%rbp), %rsi
               	leaq	-0x18(%rbp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x18(%rbp), %rcx
               	leave
               	retq

<v_stream>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rdi, -0xd0(%rbp)
               	movq	%rsi, -0xc8(%rbp)
               	movq	%rdx, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%r8, -0xb0(%rbp)
               	movq	%r9, -0xa8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movups	%xmm0, -0xa0(%rbp)
               	movups	%xmm1, -0x90(%rbp)
               	movups	%xmm2, -0x80(%rbp)
               	movups	%xmm3, -0x70(%rbp)
               	movups	%xmm4, -0x60(%rbp)
               	movups	%xmm5, -0x50(%rbp)
               	movups	%xmm6, -0x40(%rbp)
               	movups	%xmm7, -0x30(%rbp)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xc8(%rbp), %rcx
               	movl	$0x10, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	movq	-0xd0(%rbp), %rdi
               	movq	-0xc8(%rbp), %rsi
               	leaq	-0x18(%rbp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x18(%rbp), %rcx
               	leave
               	retq

<v_wide>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xd0, %rsp
               	movq	%rdi, -0xd0(%rbp)
               	movq	%rsi, -0xc8(%rbp)
               	movq	%rdx, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%r8, -0xb0(%rbp)
               	movq	%r9, -0xa8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movups	%xmm0, -0xa0(%rbp)
               	movups	%xmm1, -0x90(%rbp)
               	movups	%xmm2, -0x80(%rbp)
               	movups	%xmm3, -0x70(%rbp)
               	movups	%xmm4, -0x60(%rbp)
               	movups	%xmm5, -0x50(%rbp)
               	movups	%xmm6, -0x40(%rbp)
               	movups	%xmm7, -0x30(%rbp)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xc8(%rbp), %rcx
               	movl	$0x10, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	movq	-0xd0(%rbp), %rdi
               	movq	-0xc8(%rbp), %rsi
               	leaq	-0x18(%rbp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x18(%rbp), %rcx
               	leave
               	retq

<check>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x120, %rsp            # imm = 0x120
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r12
               	leaq	-0x100(%rbp), %rdi
               	movq	(%r12), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x80(%rbp), %rdi
               	movq	0x8(%r12), %rsi
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%ebx, %ebx
               	cmpl	$0x2, %ebx
               	je	<addr>
               	cmpl	$0x3, %ebx
               	je	<addr>
               	cmpl	$0x6, %ebx
               	jne	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r13
               	leaq	-0x110(%rbp), %rdi
               	movl	$0xaa, %esi
               	movl	$0x10, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%r13, %r13
               	je	<addr>
               	cmpl	$0x6, %ebx
               	jne	<addr>
               	leaq	-0x100(%rbp), %rdi
               	movq	%r13, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%r13, %r13
               	je	<addr>
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpl	$0x3, %ebx
               	jl	<addr>
               	cmpl	$0x5, %ebx
               	jl	<addr>
               	cmpl	$0x6, %ebx
               	jl	<addr>
               	leaq	-0x80(%rbp), %rsi
               	leaq	-0x110(%rbp), %rdx
               	movq	%r13, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %r14
               	testq	%r13, %r13
               	je	<addr>
               	movq	%r13, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x120(%rbp), %rdi
               	leaq	-0x110(%rbp), %rsi
               	movl	$0x4, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x118(%rbp), %rdi
               	leaq	-0x110(%rbp), %rsi
               	movl	$0x8, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movl	0x14(%r12), %eax
               	testl	%eax, %eax
               	jge	<addr>
               	movl	0x14(%r12), %eax
               	movq	%rax, %r13
               	negq	%r13
               	movl	0x14(%r12), %eax
               	cmpl	$-0x4, %eax
               	jne	<addr>
               	movss	-0x120(%rbp), %xmm0
               	ucomiss	%xmm0, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	leaq	-0x110(%rbp), %rcx
               	movslq	%r13d, %rsi
               	movzbq	(%rcx,%rsi), %rcx
               	movq	%rcx, %rdx
               	xorq	$0xaa, %rdx
               	movl	$0x1, %ecx
               	testl	%edx, %edx
               	je	<addr>
               	cmpl	$0x4, %ebx
               	setge	%dl
               	movzbq	%dl, %rdx
               	xorl	%ecx, %ecx
               	testq	%rdx, %rdx
               	je	<addr>
               	testl	%r13d, %r13d
               	setne	%cl
               	movzbq	%cl, %rcx
               	xorl	%edx, %edx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x110(%rbp), %rcx
               	leaq	-0x1(%r13), %rdx
               	movslq	%edx, %rdx
               	movzbq	(%rcx,%rdx), %rcx
               	testl	%ecx, %ecx
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorl	%ecx, %ecx
               	testq	%rdx, %rdx
               	je	<addr>
               	leaq	-0x110(%rbp), %rcx
               	movzbq	(%rcx,%rsi), %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	0x10(%r12), %edx
               	cmpl	%edx, %r14d
               	jne	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	jmp	<addr>
               	movl	0x14(%r12), %eax
               	cmpl	$-0x8, %eax
               	jne	<addr>
               	movsd	-0x118(%rbp), %xmm0
               	ucomisd	%xmm0, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	jmp	<addr>
               	leaq	-0x110(%rbp), %rdi
               	movq	0x18(%r12), %rsi
               	movslq	%r13d, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	jmp	<addr>
               	movl	0x14(%r12), %r13d
               	jmp	<addr>
               	leaq	-0x100(%rbp), %rdi
               	leaq	-0x80(%rbp), %rsi
               	leaq	-0x110(%rbp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %r14
               	jmp	<addr>
               	cmpl	$0x4, %ebx
               	jl	<addr>
               	leaq	-0x100(%rbp), %rdi
               	leaq	-0x80(%rbp), %rsi
               	leaq	-0x110(%rbp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %r14
               	jmp	<addr>
               	movq	0x8(%r12), %rsi
               	leaq	-0x110(%rbp), %rdx
               	movq	%r13, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %r14
               	jmp	<addr>
               	cmpl	$0x1, %ebx
               	jl	<addr>
               	cmpl	$0x2, %ebx
               	jl	<addr>
               	movq	0x8(%r12), %rsi
               	leaq	-0x110(%rbp), %rdx
               	movq	%r13, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %r14
               	jmp	<addr>
               	movq	(%r12), %rdi
               	movq	0x8(%r12), %rsi
               	leaq	-0x110(%rbp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %r14
               	jmp	<addr>
               	movq	(%r12), %rdi
               	movq	0x8(%r12), %rsi
               	leaq	-0x110(%rbp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %r14
               	jmp	<addr>
               	testq	%r13, %r13
               	je	<addr>
               	movq	(%r12), %rdi
               	movq	%r13, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	jmp	<addr>
               	xorl	%r13d, %r13d
               	jmp	<addr>
               	incq	%rbx
               	cmpl	$0x7, %ebx
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq
               	leaq	0x1(%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x78, %rsp
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	leaq	<rip>, %rax # <addr>
               	movq	%rbx, %rcx
               	shlq	$0x5, %rcx
               	leaq	(%rax,%rcx), %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x26, %ebx
               	jb	<addr>
               	movl	$0x0, -0x68(%rbp)
               	movl	$0x0, -0x60(%rbp)
               	movq	$0x0, -0x58(%rbp)
               	movl	$0x0, -0x50(%rbp)
               	leaq	-0x40(%rbp), %rdi
               	leaq	<rip>, %rsi
               	leaq	-0x68(%rbp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x40(%rbp), %rdi
               	leaq	<rip>, %rsi
               	leaq	-0x58(%rbp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movq	-0x58(%rbp), %rax
               	leaq	-0x68(%rbp), %rdx
               	cmpq	%rdx, %rax
               	je	<addr>
               	movl	$0x64, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	leaq	-0x60(%rbp), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movl	-0x68(%rbp), %eax
               	cmpl	$0x2a, %eax
               	jne	<addr>
               	movl	-0x60(%rbp), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x65, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	leaq	-0x20(%rbp), %rdx
               	leaq	-0x50(%rbp), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x50(%rbp), %eax
               	cmpl	$0x71, %eax
               	je	<addr>
               	movl	$0x66, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	leaq	-0x20(%rbp), %rdx
               	leaq	-0x50(%rbp), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x50(%rbp), %eax
               	cmpl	$0x71, %eax
               	je	<addr>
               	movl	$0x67, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	$0x0, -0x48(%rbp)
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	leaq	-0x68(%rbp), %rdx
               	leaq	-0x40(%rbp), %rcx
               	leaq	-0x48(%rbp), %r8
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movl	-0x68(%rbp), %eax
               	cmpl	$0xc, %eax
               	jne	<addr>
               	leaq	-0x40(%rbp), %rdi
               	leaq	<rip>, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movsd	-0x48(%rbp), %xmm0
               	movabsq	$0x400c000000000000, %rax # imm = 0x400C000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x68, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movl	$0x69, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rsi
               	leaq	-0x68(%rbp), %rdx
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movl	-0x68(%rbp), %eax
               	cmpl	$0xc, %eax
               	jne	<addr>
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x61, %rax
               	je	<addr>
               	movl	$0x6a, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	0x1(%rbx), %rax
               	popq	%rbx
               	leave
               	retq
