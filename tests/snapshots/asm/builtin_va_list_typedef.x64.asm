
builtin_va_list_typedef.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sum>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xe0, %rsp
               	movq	%rdi, -0xe0(%rbp)
               	movq	%rsi, -0xd8(%rbp)
               	movq	%rdx, -0xd0(%rbp)
               	movq	%rcx, -0xc8(%rbp)
               	movq	%r8, -0xc0(%rbp)
               	movq	%r9, -0xb8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movsd	%xmm0, -0xb0(%rbp,%riz)
               	movsd	%xmm1, -0xa0(%rbp,%riz)
               	movsd	%xmm2, -0x90(%rbp,%riz)
               	movsd	%xmm3, -0x80(%rbp,%riz)
               	movsd	%xmm4, -0x70(%rbp,%riz)
               	movsd	%xmm5, -0x60(%rbp,%riz)
               	movsd	%xmm6, -0x50(%rbp,%riz)
               	movsd	%xmm7, -0x40(%rbp,%riz)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xe0(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xe0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
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
               	movslq	(%rsi), %rsi
               	addq	%rsi, %rcx
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	movslq	-0xe0(%rbp), %rsi
               	cmpq	%rsi, %rdx
               	jl	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	%ecx, %rax
               	movslq	%eax, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq

<sum_twice>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x100, %rsp            # imm = 0x100
               	movq	%rdi, -0x100(%rbp)
               	movq	%rsi, -0xf8(%rbp)
               	movq	%rdx, -0xf0(%rbp)
               	movq	%rcx, -0xe8(%rbp)
               	movq	%r8, -0xe0(%rbp)
               	movq	%r9, -0xd8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movsd	%xmm0, -0xd0(%rbp,%riz)
               	movsd	%xmm1, -0xc0(%rbp,%riz)
               	movsd	%xmm2, -0xb0(%rbp,%riz)
               	movsd	%xmm3, -0xa0(%rbp,%riz)
               	movsd	%xmm4, -0x90(%rbp,%riz)
               	movsd	%xmm5, -0x80(%rbp,%riz)
               	movsd	%xmm6, -0x70(%rbp,%riz)
               	movsd	%xmm7, -0x60(%rbp,%riz)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0x100(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0x100(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	leaq	-0x30(%rbp), %rax
               	leaq	-0x18(%rbp), %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	popq	%rdx
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
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
               	movslq	(%rsi), %rsi
               	addq	%rsi, %rax
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	movslq	-0x100(%rbp), %rsi
               	cmpq	%rsi, %rdx
               	jl	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	leaq	-0x30(%rbp), %rsi
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
               	movslq	(%rsi), %rsi
               	addq	%rsi, %rax
               	leaq	0x1(%rdx), %rcx
               	movslq	%ecx, %rdx
               	movslq	-0x100(%rbp), %rsi
               	cmpq	%rsi, %rdx
               	jl	<addr>
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0x30(%rbp), %rcx
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq

<mixed>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x100, %rsp            # imm = 0x100
               	movq	%rdi, -0x100(%rbp)
               	movq	%rsi, -0xf8(%rbp)
               	movq	%rdx, -0xf0(%rbp)
               	movq	%rcx, -0xe8(%rbp)
               	movq	%r8, -0xe0(%rbp)
               	movq	%r9, -0xd8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movsd	%xmm0, -0xd0(%rbp,%riz)
               	movsd	%xmm1, -0xc0(%rbp,%riz)
               	movsd	%xmm2, -0xb0(%rbp,%riz)
               	movsd	%xmm3, -0xa0(%rbp,%riz)
               	movsd	%xmm4, -0x90(%rbp,%riz)
               	movsd	%xmm5, -0x80(%rbp,%riz)
               	movsd	%xmm6, -0x70(%rbp,%riz)
               	movsd	%xmm7, -0x60(%rbp,%riz)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0x100(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0x100(%rbp), %r10
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
               	movq	(%rax), %rcx
               	leaq	-0x18(%rbp), %rax
               	movq	%rax, %r11
               	movl	0x4(%r11), %r10d
               	cmpq	$0xb0, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x10, 0x4(%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %rax
               	movsd	(%rax,%riz), %xmm0
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
               	movslq	(%rax), %rdx
               	leaq	-0x18(%rbp), %rax
               	movq	-0x100(%rbp), %rsi
               	xorq	%rax, %rax
               	movsbq	(%rsi), %rsi
               	cmpq	$0x74, %rsi
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movsbq	(%rcx), %rax
               	cmpq	$0x78, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	xorq	%rcx, %rcx
               	testq	%rax, %rax
               	je	<addr>
               	movabsq	$0x4004000000000000, %rax # imm = 0x4004000000000000
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	sete	%al
               	movzbq	%al, %rax
               	setnp	%r10b
               	movzbq	%r10b, %r10
               	andq	%r10, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	xorq	%rax, %rax
               	testq	%rcx, %rcx
               	je	<addr>
               	cmpq	$0x7, %rdx
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	addq	$0x100, %rsp            # imm = 0x100
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<forward>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
               	movq	%rdi, -0xf0(%rbp)
               	movq	%rsi, -0xe8(%rbp)
               	movq	%rdx, -0xe0(%rbp)
               	movq	%rcx, -0xd8(%rbp)
               	movq	%r8, -0xd0(%rbp)
               	movq	%r9, -0xc8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movsd	%xmm0, -0xc0(%rbp,%riz)
               	movsd	%xmm1, -0xb0(%rbp,%riz)
               	movsd	%xmm2, -0xa0(%rbp,%riz)
               	movsd	%xmm3, -0x90(%rbp,%riz)
               	movsd	%xmm4, -0x80(%rbp,%riz)
               	movsd	%xmm5, -0x70(%rbp,%riz)
               	movsd	%xmm6, -0x60(%rbp,%riz)
               	movsd	%xmm7, -0x50(%rbp,%riz)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xf0(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xf0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	movslq	-0xf0(%rbp), %rsi
               	leaq	-0x18(%rbp), %rdi
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rdi, %r11
               	movl	(%r11), %r10d
               	cmpq	$0x30, %r10
               	jae	<addr>
               	addq	0x10(%r11), %r10
               	addl	$0x8, (%r11)
               	jmp	<addr>
               	movq	0x8(%r11), %r10
               	addq	$0x8, 0x8(%r11)
               	movq	%r10, %r8
               	movslq	(%r8), %r8
               	addq	%r8, %rcx
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	cmpq	%rsi, %rdx
               	jl	<addr>
               	movslq	%ecx, %rax
               	movslq	%eax, %rax
               	leaq	-0x18(%rbp), %rcx
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq

<macro_sum>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xe0, %rsp
               	movq	%rdi, -0xe0(%rbp)
               	movq	%rsi, -0xd8(%rbp)
               	movq	%rdx, -0xd0(%rbp)
               	movq	%rcx, -0xc8(%rbp)
               	movq	%r8, -0xc0(%rbp)
               	movq	%r9, -0xb8(%rbp)
               	testb	%al, %al
               	je	<addr>
               	movsd	%xmm0, -0xb0(%rbp,%riz)
               	movsd	%xmm1, -0xa0(%rbp,%riz)
               	movsd	%xmm2, -0x90(%rbp,%riz)
               	movsd	%xmm3, -0x80(%rbp,%riz)
               	movsd	%xmm4, -0x70(%rbp,%riz)
               	movsd	%xmm5, -0x60(%rbp,%riz)
               	movsd	%xmm6, -0x50(%rbp,%riz)
               	movsd	%xmm7, -0x40(%rbp,%riz)
               	leaq	-0x18(%rbp), %rax
               	leaq	-0xe0(%rbp), %rcx
               	movl	$0x8, (%rax)
               	movl	$0x30, 0x4(%rax)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rax)
               	leaq	-0xe0(%rbp), %r10
               	movq	%r10, 0x10(%rax)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	jmp	<addr>
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
               	movslq	(%rsi), %rsi
               	addq	%rsi, %rcx
               	leaq	0x1(%rdx), %rax
               	movslq	%eax, %rdx
               	movslq	-0xe0(%rbp), %rsi
               	cmpq	%rsi, %rdx
               	jl	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	%ecx, %rax
               	movslq	%eax, %rax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movl	$0x3, %edi
               	movl	$0xa, %esi
               	movl	$0xe, %edx
               	movl	$0x12, %ecx
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x3, %edi
               	movl	$0x1, %esi
               	movl	$0x2, %edx
               	movl	$0x4, %ecx
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	$0xe, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	movabsq	$0x4004000000000000, %rdx # imm = 0x4004000000000000
               	movl	$0x7, %ecx
               	movq	%rdx, %xmm0
               	movq	%rcx, %rdx
               	movb	$0x1, %al
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	movl	$0x1, %esi
               	movl	$0x2, %edx
               	movl	$0x3, %ecx
               	movq	%rdi, %r8
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	movl	$0x14, %esi
               	movl	$0x16, %edx
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x20(%rbp), %rax
               	movl	$0x3, %ecx
               	movl	%ecx, (%rax)
               	leaq	-0x20(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
