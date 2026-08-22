
int128_scalar_result.x64:	file format elf64-x86-64

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

<via_variadic>:
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
               	movsd	%xmm0, -0xa0(%rbp,%riz)
               	movsd	%xmm1, -0x90(%rbp,%riz)
               	movsd	%xmm2, -0x80(%rbp,%riz)
               	movsd	%xmm3, -0x70(%rbp,%riz)
               	movsd	%xmm4, -0x60(%rbp,%riz)
               	movsd	%xmm5, -0x50(%rbp,%riz)
               	movsd	%xmm6, -0x40(%rbp,%riz)
               	movsd	%xmm7, -0x30(%rbp,%riz)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xd0(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
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
               	movslq	(%rax), %rax
               	leaq	<rip>, %rcx
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
               	movslq	(%rdx), %rdx
               	movl	%edx, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	addq	$0xd0, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1a0, %rsp            # imm = 0x1A0
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movq	%r14, 0x18(%rsp)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	xorq	%rax, %rax
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	movq	%rax, %r13
               	orq	%rdx, %r13
               	movq	%rcx, %rbx
               	orq	%rax, %rbx
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	movq	%rax, %r14
               	orq	%rdx, %r14
               	movq	%rcx, %r12
               	orq	%rax, %r12
               	movl	$0x2, %edi
               	cmpq	%rbx, %r12
               	setb	%al
               	movzbq	%al, %rax
               	cmpq	%rbx, %r12
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	%r13, %r14
               	setb	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rcx
               	movq	%rax, %rsi
               	orq	%rcx, %rsi
               	movl	$0x4d, %edx
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x4d, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x1a0, %rsp            # imm = 0x1A0
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	cmpq	%r12, %rbx
               	setb	%al
               	movzbq	%al, %rax
               	cmpq	%r12, %rbx
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	%r14, %r13
               	setb	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rcx
               	movq	%rax, %rsi
               	orq	%rcx, %rsi
               	movl	$0x4d, %edx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %rcx
               	testq	%rcx, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x4d, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x1a0, %rsp            # imm = 0x1A0
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	movq	%r13, %rax
               	xorq	%r13, %rax
               	movq	%rbx, %rcx
               	xorq	%rbx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	movl	$0x4d, %edx
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x4d, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x1a0, %rsp            # imm = 0x1A0
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	movq	%r13, %rax
               	xorq	%r13, %rax
               	movq	%rbx, %rcx
               	xorq	%rbx, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	setne	%sil
               	movzbq	%sil, %rsi
               	movl	$0x4d, %edx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %rcx
               	testq	%rcx, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x4d, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x1a0, %rsp            # imm = 0x1A0
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	movl	$0x1, %esi
               	movl	$0x4d, %edx
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x4d, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x1a0, %rsp            # imm = 0x1A0
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	cmpq	%r12, %rbx
               	setb	%al
               	movzbq	%al, %rax
               	cmpq	%r12, %rbx
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	%r14, %r13
               	setb	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rcx
               	orq	%rcx, %rax
               	movq	%rax, %rsi
               	xorq	$0x1, %rsi
               	movl	$0x4d, %edx
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpq	$0x4d, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x1a0, %rsp            # imm = 0x1A0
               	popq	%rbp
               	retq
               	cmpq	%rbx, %r12
               	setb	%dl
               	movzbq	%dl, %rdx
               	cmpq	%rbx, %r12
               	sete	%sil
               	movzbq	%sil, %rsi
               	cmpq	%r13, %r14
               	setb	%al
               	movzbq	%al, %rax
               	andq	%rsi, %rax
               	orq	%rdx, %rax
               	leaq	(%rax,%rax,2), %rax
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	%r13, %rax
               	xorq	%r14, %rax
               	movq	%rbx, %rcx
               	xorq	%r12, %rcx
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	leaq	(%rax,%rax,2), %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x1a0, %rsp            # imm = 0x1A0
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%r13, %rcx
               	xorq	%rax, %rcx
               	movq	%rbx, %rdi
               	xorq	%rax, %rdi
               	orq	%rcx, %rdi
               	testq	%rdi, %rdi
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%r13, %rcx
               	subq	%r13, %rcx
               	movq	%rbx, %rdi
               	subq	%rbx, %rdi
               	subq	$0x0, %rdi
               	xorq	%rax, %rcx
               	xorq	%rdi, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x1, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x8, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x1a0, %rsp            # imm = 0x1A0
               	popq	%rbp
               	retq
               	cmpq	%r13, %r14
               	setb	%cl
               	movzbq	%cl, %rcx
               	movq	%rsi, %rax
               	andq	%rcx, %rax
               	orq	%rax, %rdx
               	xorq	%rax, %rax
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x1, %eax
               	testq	%rax, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rax, %rax
               	je	<addr>
               	cmpq	%r12, %rbx
               	setb	%al
               	movzbq	%al, %rax
               	cmpq	%r12, %rbx
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	%r14, %r13
               	setb	%sil
               	movzbq	%sil, %rsi
               	andq	%rdx, %rsi
               	orq	%rax, %rsi
               	movl	$0x1, %eax
               	testq	%rsi, %rsi
               	jne	<addr>
               	cmpq	%rbx, %r12
               	setb	%al
               	movzbq	%al, %rax
               	andq	%rcx, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	cmpq	$0x1, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x9, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x1a0, %rsp            # imm = 0x1A0
               	popq	%rbp
               	retq
               	cmpq	%rbx, %r12
               	setb	%al
               	movzbq	%al, %rax
               	cmpq	%rbx, %r12
               	sete	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rcx
               	movq	%rax, %rdi
               	orq	%rcx, %rdi
               	movq	%r13, %rcx
               	xorq	%r13, %rcx
               	movq	%rbx, %rdx
               	xorq	%rbx, %rdx
               	movq	%rcx, %rsi
               	orq	%rdx, %rsi
               	testq	%rsi, %rsi
               	sete	%r8b
               	movzbq	%r8b, %r8
               	movslq	%edi, %rax
               	cmpq	$0x1, %rax
               	movl	$0x1, %eax
               	jne	<addr>
               	movslq	%r8d, %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	testq	%rsi, %rsi
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x1a0, %rsp            # imm = 0x1A0
               	popq	%rbp
               	retq
               	leaq	-0xe0(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movq	%rax, %rcx
               	cmpq	%rbx, %r12
               	setb	%cl
               	movzbq	%cl, %rcx
               	cmpq	%rbx, %r12
               	sete	%dl
               	movzbq	%dl, %rdx
               	cmpq	%r13, %r14
               	setb	%sil
               	movzbq	%sil, %rsi
               	andq	%rdx, %rsi
               	orq	%rcx, %rsi
               	movslq	(%rax,%rsi,4), %rax
               	cmpq	$0x14, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0xe0(%rbp), %rsi
               	cmpq	%r13, %r14
               	setb	%al
               	movzbq	%al, %rax
               	andq	%rdx, %rax
               	orq	%rax, %rcx
               	movq	%r13, %rax
               	xorq	%r14, %rax
               	movq	%rbx, %rdx
               	xorq	%r12, %rdx
               	orq	%rdx, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movslq	(%rsi,%rax,4), %rax
               	cmpq	$0x1e, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x1a0, %rsp            # imm = 0x1A0
               	popq	%rbp
               	retq
               	cmpq	%rbx, %r12
               	setb	%al
               	movzbq	%al, %rax
               	cmpq	%rbx, %r12
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	%r13, %r14
               	setb	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rcx
               	orq	%rcx, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x1a0, %rsp            # imm = 0x1A0
               	popq	%rbp
               	retq
               	movl	$0x6f, %eax
               	xorq	%rdx, %rdx
               	leaq	-0xe0(%rbp), %rax
               	movq	%rdx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	leaq	-0x100(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rax), %rdx
               	movq	%rdx, (%rcx)
               	movq	0x8(%rax), %rdx
               	movq	%rdx, 0x8(%rcx)
               	popq	%rdx
               	movq	%rcx, %rax
               	jmp	<addr>
               	leaq	-0x100(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rdi
               	leaq	0x1(%rcx), %rsi
               	cmpq	%rcx, %rsi
               	setb	%cl
               	movzbq	%cl, %rcx
               	addq	$0x0, %rdi
               	addq	%rcx, %rdi
               	leaq	-0xe0(%rbp), %rcx
               	movq	%rsi, (%rcx)
               	movq	%rdi, 0x8(%rcx)
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	movslq	%edx, %rax
               	leaq	0x1(%rax), %rdx
               	leaq	-0x100(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	testq	%rax, %rax
               	setb	%sil
               	movzbq	%sil, %rsi
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x5, %rcx
               	setb	%cl
               	movzbq	%cl, %rcx
               	andq	%rcx, %rax
               	orq	%rsi, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movslq	%edx, %rax
               	cmpq	$0x5, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x100(%rbp), %rax
               	movq	(%rax), %rcx
               	movq	0x8(%rax), %rax
               	xorq	$0x5, %rcx
               	xorq	$0x0, %rax
               	orq	%rcx, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x1a0, %rsp            # imm = 0x1A0
               	popq	%rbp
               	retq
               	cmpq	%r12, %rbx
               	setb	%al
               	movzbq	%al, %rax
               	cmpq	%r12, %rbx
               	sete	%cl
               	movzbq	%cl, %rcx
               	cmpq	%r14, %r13
               	setb	%dl
               	movzbq	%dl, %rdx
               	andq	%rdx, %rcx
               	orq	%rax, %rcx
               	movslq	%ecx, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x1a0, %rsp            # imm = 0x1A0
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	movq	0x18(%rsp), %r14
               	addq	$0x1a0, %rsp            # imm = 0x1A0
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
