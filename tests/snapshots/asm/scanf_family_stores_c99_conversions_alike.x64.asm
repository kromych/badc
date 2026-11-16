
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
               	callq	<addr>
               	leaq	-0x18(%rbp), %rcx
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x138, %rsp            # imm = 0x138
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	xorl	%r15d, %r15d
               	leaq	<rip>, %rax # <addr>
               	movq	%r15, %rcx
               	shlq	$0x5, %rcx
               	leaq	(%rax,%rcx), %r13
               	leaq	-0x100(%rbp), %rdi
               	movq	(%r13), %rsi
               	movl	$0x20, %edx
               	callq	<addr>
               	leaq	-0x80(%rbp), %rdi
               	movq	0x8(%r13), %rsi
               	movl	$0x20, %edx
               	callq	<addr>
               	xorl	%ebx, %ebx
               	cmpl	$0x2, %ebx
               	je	<addr>
               	cmpl	$0x3, %ebx
               	je	<addr>
               	cmpl	$0x6, %ebx
               	jne	<addr>
               	callq	<addr>
               	movq	%rax, %r12
               	movabsq	$-0x5555555555555556, %rax # imm = 0xAAAAAAAAAAAAAAAA
               	movq	%rax, -0x110(%rbp)
               	movq	%rax, -0x108(%rbp)
               	testq	%r12, %r12
               	je	<addr>
               	cmpl	$0x6, %ebx
               	jne	<addr>
               	leaq	-0x100(%rbp), %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	testq	%r12, %r12
               	je	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
               	cmpl	$0x3, %ebx
               	jl	<addr>
               	cmpl	$0x5, %ebx
               	jl	<addr>
               	cmpl	$0x6, %ebx
               	jl	<addr>
               	leaq	-0x80(%rbp), %rsi
               	leaq	-0x110(%rbp), %rdx
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %r14
               	testq	%r12, %r12
               	je	<addr>
               	movq	%r12, %rdi
               	callq	<addr>
               	leaq	-0x120(%rbp), %rax
               	leaq	-0x110(%rbp), %rdi
               	movl	(%rdi), %r10d
               	movl	%r10d, (%rax)
               	leaq	-0x118(%rbp), %rax
               	movq	(%rdi), %r10
               	movq	%r10, (%rax)
               	movslq	0x14(%r13), %r12
               	movq	%r12, %rax
               	negq	%rax
               	testl	%r12d, %r12d
               	cmovlq	%rax, %r12
               	movl	0x14(%r13), %eax
               	cmpl	$-0x4, %eax
               	jne	<addr>
               	movss	-0x120(%rbp), %xmm0
               	ucomiss	%xmm0, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	movslq	%r12d, %rsi
               	movzbq	-0x110(%rbp,%rsi), %rcx
               	cmpl	$0xaa, %ecx
               	movl	$0x1, %ecx
               	je	<addr>
               	xorl	%ecx, %ecx
               	testl	%r12d, %r12d
               	setne	%dl
               	movzbq	%dl, %rdx
               	cmpl	$0x4, %ebx
               	cmovgeq	%rdx, %rcx
               	xorl	%edx, %edx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	-0x1(%r12), %rdx
               	movslq	%edx, %rdx
               	movzbq	-0x110(%rbp,%rdx), %rcx
               	testl	%ecx, %ecx
               	sete	%dl
               	movzbq	%dl, %rdx
               	xorl	%ecx, %ecx
               	testq	%rdx, %rdx
               	je	<addr>
               	movzbq	-0x110(%rbp,%rsi), %rcx
               	testl	%ecx, %ecx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movl	0x10(%r13), %edx
               	cmpl	%edx, %r14d
               	jne	<addr>
               	testl	%eax, %eax
               	je	<addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	jmp	<addr>
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
               	movq	0x18(%r13), %rsi
               	movslq	%r12d, %rdx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
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
               	movq	0x8(%r13), %rsi
               	leaq	-0x110(%rbp), %rdx
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %r14
               	jmp	<addr>
               	cmpl	$0x1, %ebx
               	jl	<addr>
               	cmpl	$0x2, %ebx
               	jl	<addr>
               	movq	0x8(%r13), %rsi
               	leaq	-0x110(%rbp), %rdx
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %r14
               	jmp	<addr>
               	movq	(%r13), %rdi
               	movq	0x8(%r13), %rsi
               	leaq	-0x110(%rbp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %r14
               	jmp	<addr>
               	movq	(%r13), %rdi
               	movq	0x8(%r13), %rsi
               	leaq	-0x110(%rbp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %r14
               	jmp	<addr>
               	testq	%r12, %r12
               	je	<addr>
               	movq	(%r13), %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	jmp	<addr>
               	xorl	%r12d, %r12d
               	jmp	<addr>
               	incq	%rbx
               	cmpl	$0x7, %ebx
               	jl	<addr>
               	incq	%r15
               	cmpl	$0x26, %r15d
               	jb	<addr>
               	movl	$0x0, -0x130(%rbp)
               	movl	$0x0, -0x128(%rbp)
               	movq	$0x0, -0x120(%rbp)
               	movl	$0x0, -0x118(%rbp)
               	leaq	-0xa0(%rbp), %rdi
               	leaq	<rip>, %rsi
               	leaq	-0x130(%rbp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	leaq	<rip>, %rsi
               	leaq	-0x120(%rbp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movq	-0x120(%rbp), %rax
               	leaq	-0x130(%rbp), %rdx
               	cmpq	%rdx, %rax
               	je	<addr>
               	movl	$0x64, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	leaq	-0x128(%rbp), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movl	-0x130(%rbp), %eax
               	cmpl	$0x2a, %eax
               	jne	<addr>
               	movl	-0x128(%rbp), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x65, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	leaq	-0x20(%rbp), %rdx
               	leaq	-0x118(%rbp), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x118(%rbp), %eax
               	cmpl	$0x71, %eax
               	je	<addr>
               	movl	$0x66, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	leaq	-0x20(%rbp), %rdx
               	leaq	-0x118(%rbp), %rcx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	jne	<addr>
               	leaq	-0x20(%rbp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	-0x118(%rbp), %eax
               	cmpl	$0x71, %eax
               	je	<addr>
               	movl	$0x67, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	$0x0, -0x108(%rbp)
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	leaq	-0x130(%rbp), %rdx
               	leaq	-0xa0(%rbp), %rcx
               	leaq	-0x108(%rbp), %r8
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	movl	-0x130(%rbp), %eax
               	cmpl	$0xc, %eax
               	jne	<addr>
               	leaq	-0xa0(%rbp), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movsd	-0x108(%rbp), %xmm0
               	movsd	<rip>, %xmm1
               	ucomisd	%xmm1, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x68, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	callq	<addr>
               	movq	%rax, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jge	<addr>
               	movl	$0x69, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	leaq	<rip>, %rsi
               	leaq	-0x130(%rbp), %rdx
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movl	-0x130(%rbp), %eax
               	cmpl	$0xc, %eax
               	jne	<addr>
               	movq	%rbx, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x61, %rax
               	je	<addr>
               	movl	$0x6a, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	0x1(%r15), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
