
aggregate_argument_bounds.x64:	file format elf64-x86-64

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

<page_end>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	movl	$0x1e, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	xorl	%edi, %edi
               	movq	%rbx, %rsi
               	shlq	%rsi
               	movl	$0x3, %edx
               	movl	$0x22, %ecx
               	movq	$-0x1, %r8
               	movq	%rdi, %r9
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	cmpq	$-0x1, %r12
               	je	<addr>
               	leaq	(%r12,%rbx), %rdi
               	xorl	%edx, %edx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	(%r12,%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq

<back7>:
               	movzbq	(%rdi), %rax
               	movzbq	0x1(%rdi), %rcx
               	shlq	$0x8, %rcx
               	orq	%rcx, %rax
               	movzbq	0x2(%rdi), %rcx
               	shlq	$0x10, %rcx
               	orq	%rcx, %rax
               	movzbq	0x3(%rdi), %rcx
               	shlq	$0x18, %rcx
               	orq	%rcx, %rax
               	movzbq	0x4(%rdi), %rcx
               	shlq	$0x20, %rcx
               	orq	%rcx, %rax
               	movzbq	0x5(%rdi), %rcx
               	shlq	$0x28, %rcx
               	orq	%rcx, %rax
               	movzbq	0x6(%rdi), %rcx
               	shlq	$0x30, %rcx
               	orq	%rcx, %rax
               	retq

<backf3>:
               	movq	%rdi, %rax
               	movq	%rax, %rcx
               	movsd	(%rcx), %xmm0
               	movss	0x8(%rcx), %xmm1
               	retq

<va>:
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
               	leaq	-0xd0(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rax
               	movzbq	0x2(%rax), %rax
               	leaq	-0x18(%rbp), %rcx
               	movq	%rcx, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rcx
               	movzbq	0x4(%rcx), %rcx
               	leaq	-0x18(%rbp), %rdx
               	movq	%rdx, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rdx
               	movzwq	0x4(%rdx), %rdx
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rsi
               	movzbq	0x6(%rsi), %rsi
               	leaq	-0x18(%rbp), %rdi
               	movq	%rdi, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x28, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x10, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x10, 0x8(%r11)
               	movq	%r10, %rdi
               	movzbq	0xa(%rdi), %rdi
               	leaq	-0x18(%rbp), %r8
               	movslq	-0xd0(%rbp), %r8
               	movsbq	%al, %rax
               	addq	%r8, %rax
               	movsbq	%cl, %rcx
               	addq	%rcx, %rax
               	movswq	%dx, %rcx
               	addq	%rcx, %rax
               	movsbq	%sil, %rcx
               	addq	%rcx, %rax
               	movsbq	%dil, %rcx
               	addq	%rcx, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x48, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	-0x30(%rbp), %rsi
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rsi)
               	movl	0x8(%rcx), %r10d
               	movl	%r10d, 0x8(%rsi)
               	leaq	-0x3(%rax), %r13
               	leaq	-0x5(%rax), %r14
               	leaq	-0x6(%rax), %r15
               	leaq	-0x7(%rax), %rbx
               	leaq	-0xb(%rax), %r10
               	movq	%r10, 0x38(%rsp)
               	leaq	-0xc(%rax), %r12
               	movl	$0xc, %edx
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movsbq	(%r13), %rax
               	movsbq	0x2(%r13), %rcx
               	addq	%rcx, %rax
               	cmpl	$0x16, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movsbq	(%r14), %rax
               	movsbq	0x4(%r14), %rcx
               	addq	%rcx, %rax
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movswq	(%r15), %rax
               	movswq	0x4(%r15), %rcx
               	addq	%rcx, %rax
               	cmpl	$0x1412, %eax           # imm = 0x1412
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movsbq	(%rbx), %rax
               	movsbq	0x6(%rbx), %rcx
               	addq	%rcx, %rax
               	cmpl	$0x12, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	0x38(%rsp), %rax
               	movsbq	(%rax), %rcx
               	movsbq	0xa(%rax), %rax
               	addq	%rcx, %rax
               	cmpl	$0xe, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	%rbx, %rdi
               	callq	<addr>
               	movl	%eax, -0x8(%rbp)
               	movq	%rax, %rdx
               	shrq	$0x20, %rdx
               	leaq	-0x8(%rbp), %rcx
               	movw	%dx, 0x4(%rcx)
               	shrq	$0x30, %rax
               	movb	%al, 0x6(%rcx)
               	leaq	-0x8(%rbp), %rax
               	movsbq	0x6(%rax), %rax
               	cmpl	$0xc, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x1, %edi
               	movzwq	(%r13), %rax
               	movzbq	0x2(%r13), %rcx
               	shlq	$0x10, %rcx
               	movq	%rax, %rsi
               	orq	%rcx, %rsi
               	movl	(%r14), %eax
               	movzbq	0x4(%r14), %rcx
               	shlq	$0x20, %rcx
               	movq	%rax, %rdx
               	orq	%rcx, %rdx
               	movl	(%r15), %eax
               	movzwq	0x4(%r15), %rcx
               	shlq	$0x20, %rcx
               	orq	%rax, %rcx
               	movl	(%rbx), %eax
               	movzwq	0x4(%rbx), %r8
               	shlq	$0x20, %r8
               	orq	%r8, %rax
               	movzbq	0x6(%rbx), %r8
               	shlq	$0x30, %r8
               	orq	%rax, %r8
               	subq	$0x10, %rsp
               	movq	0x48(%rsp), %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movzbq	0x8(%r10), %r11
               	movb	%r11b, 0x8(%rsp)
               	movzbq	0x9(%r10), %r11
               	movb	%r11b, 0x9(%rsp)
               	movzbq	0xa(%r10), %r11
               	movb	%r11b, 0xa(%rsp)
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x10, %rsp
               	cmpl	$0xc3c, %eax            # imm = 0xC3C
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	-0x20(%rbp), %rsi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rsi)
               	movl	0x8(%rax), %r10d
               	movl	%r10d, 0x8(%rsi)
               	movl	$0xc, %edx
               	movq	%r12, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movss	(%r12), %xmm0
               	movss	0x8(%r12), %xmm1
               	addss	%xmm1, %xmm0
               	movl	$0x40a00000, %eax       # imm = 0x40A00000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	%r12, %rdi
               	callq	<addr>
               	movsd	%xmm0, -0x10(%rbp)
               	movsd	%xmm1, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movss	0x8(%rax), %xmm0
               	movl	$0x40600000, %eax       # imm = 0x40600000
               	movq	%rax, %xmm15
               	ucomiss	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0xa, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
