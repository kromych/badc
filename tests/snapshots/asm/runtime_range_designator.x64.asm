
runtime_range_designator.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<check_once_eval>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movslq	%edi, %rdi
               	leaq	<rip>, %rcx
               	xorq	%rax, %rax
               	movl	%eax, (%rcx)
               	leaq	-0x48(%rbp), %rax
               	leaq	<rip>, %rdx
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	0x10(%rdx), %rcx
               	movq	%rcx, 0x10(%rax)
               	movq	0x18(%rdx), %rcx
               	movq	%rcx, 0x18(%rax)
               	movq	0x20(%rdx), %rcx
               	movq	%rcx, 0x20(%rax)
               	movq	0x28(%rdx), %rcx
               	movq	%rcx, 0x28(%rax)
               	movq	0x30(%rdx), %rcx
               	movq	%rcx, 0x30(%rax)
               	movq	0x38(%rdx), %rcx
               	movq	%rcx, 0x38(%rax)
               	movzbq	0x40(%rdx), %rcx
               	movb	%cl, 0x40(%rax)
               	movzbq	0x41(%rdx), %rcx
               	movb	%cl, 0x41(%rax)
               	movzbq	0x42(%rdx), %rcx
               	movb	%cl, 0x42(%rax)
               	movzbq	0x43(%rdx), %rcx
               	movb	%cl, 0x43(%rax)
               	popq	%rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	%edi, (%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %edx
               	movl	%edx, 0x4(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %edx
               	movl	%edx, 0x8(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %edx
               	movl	%edx, 0xc(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %edx
               	movl	%edx, 0x10(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %edx
               	movl	%edx, 0x14(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %edx
               	movl	%edx, 0x18(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %edx
               	movl	%edx, 0x1c(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %edx
               	movl	%edx, 0x20(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %edx
               	movl	%edx, 0x24(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %edx
               	movl	%edx, 0x28(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %edx
               	movl	%edx, 0x2c(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %edx
               	movl	%edx, 0x30(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %edx
               	movl	%edx, 0x34(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %edx
               	movl	%edx, 0x38(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %edx
               	movl	%edx, 0x3c(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %edx
               	movl	%edx, 0x40(%rax)
               	movslq	(%rcx), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x65, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x48(%rbp), %rdx
               	movslq	(%rdx,%rcx,4), %rdx
               	cmpq	%rdi, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x11, %rcx
               	jl	<addr>
               	xorq	%rax, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %eax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>

<check_resume_and_gap>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movslq	%edi, %rdi
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	popq	%rdx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	%edi, 0x4(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	0x4(%rax), %ecx
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	0x4(%rax), %ecx
               	movl	%ecx, 0xc(%rax)
               	movl	$0x2a, %ecx
               	leaq	-0x18(%rbp), %rax
               	movl	%ecx, 0x10(%rax)
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	0x14(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	%rdi, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	0x8(%rax), %rax
               	cmpq	%rdi, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	cmpq	%rdi, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movslq	0x10(%rax), %rax
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<check_override>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movslq	%edi, %rdi
               	leaq	<rip>, %rcx
               	xorq	%rax, %rax
               	movl	%eax, (%rcx)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rdx
               	pushq	%rcx
               	movq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rdx), %rcx
               	movq	%rcx, 0x8(%rax)
               	movzbq	0x10(%rdx), %rcx
               	movb	%cl, 0x10(%rax)
               	movzbq	0x11(%rdx), %rcx
               	movb	%cl, 0x11(%rax)
               	movzbq	0x12(%rdx), %rcx
               	movb	%cl, 0x12(%rax)
               	movzbq	0x13(%rdx), %rcx
               	movb	%cl, 0x13(%rax)
               	popq	%rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	%edi, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %edx
               	movl	%edx, 0x4(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %edx
               	movl	%edx, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %edx
               	movl	%edx, 0xc(%rax)
               	leaq	-0x18(%rbp), %rax
               	movl	(%rax), %edx
               	movl	%edx, 0x10(%rax)
               	leaq	0x7(%rdi), %rax
               	leaq	<rip>, %rdx
               	movslq	(%rdx), %r8
               	incq	%r8
               	movl	%r8d, (%rdx)
               	leaq	-0x18(%rbp), %rdx
               	movl	%eax, 0x8(%rdx)
               	movslq	(%rcx), %rax
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x66, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	%rdi, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	%rdi, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	0xc(%rax), %rax
               	cmpq	%rdi, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	movslq	0x10(%rax), %rax
               	cmpq	%rdi, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movslq	0x8(%rax), %rcx
               	leaq	0x7(%rdi), %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	popq	%rdx
               	leaq	-0x30(%rbp), %rax
               	movl	%edi, (%rax)
               	leaq	-0x30(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x30(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x30(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	%ecx, 0xc(%rax)
               	leaq	0x1(%rdi), %rax
               	leaq	-0x30(%rbp), %rcx
               	movl	%eax, 0x8(%rcx)
               	leaq	-0x30(%rbp), %rax
               	movl	0x8(%rax), %ecx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x30(%rbp), %rax
               	movl	0x8(%rax), %ecx
               	movl	%ecx, 0x10(%rax)
               	leaq	-0x30(%rbp), %rax
               	movl	0x8(%rax), %ecx
               	movl	%ecx, 0x14(%rax)
               	leaq	-0x30(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	%rdi, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	movslq	0x4(%rax), %rax
               	cmpq	%rdi, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movslq	0x8(%rax), %rcx
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	movslq	0xc(%rax), %rcx
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	movslq	0x14(%rax), %rcx
               	leaq	0x1(%rdi), %rax
               	movslq	%eax, %rax
               	cmpq	%rax, %rcx
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x60, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<check_widths>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xe0, %rsp
               	movslq	%edi, %rdi
               	leaq	<rip>, %rdx
               	xorq	%rax, %rax
               	movl	%eax, (%rdx)
               	leaq	-0x8(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	popq	%rdx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	movl	%ecx, (%rax)
               	movl	$0x41, %ecx
               	leaq	-0x8(%rbp), %rax
               	movb	%cl, 0x2(%rax)
               	leaq	-0x8(%rbp), %rax
               	movzbq	0x2(%rax), %rcx
               	movb	%cl, 0x3(%rax)
               	leaq	-0x8(%rbp), %rax
               	movzbq	0x2(%rax), %rcx
               	movb	%cl, 0x4(%rax)
               	leaq	-0x8(%rbp), %rax
               	movzbq	0x2(%rax), %rcx
               	movb	%cl, 0x5(%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movzbq	0x8(%rcx), %rdx
               	movb	%dl, 0x8(%rax)
               	movzbq	0x9(%rcx), %rdx
               	movb	%dl, 0x9(%rax)
               	popq	%rdx
               	movslq	%edi, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	movslq	%ecx, %rax
               	leaq	-0x18(%rbp), %rcx
               	movw	%ax, (%rcx)
               	leaq	-0x18(%rbp), %rax
               	movzwq	(%rax), %rcx
               	movw	%cx, 0x2(%rax)
               	leaq	-0x18(%rbp), %rax
               	movzwq	(%rax), %rcx
               	movw	%cx, 0x4(%rax)
               	leaq	-0x18(%rbp), %rax
               	movzwq	(%rax), %rcx
               	movw	%cx, 0x6(%rax)
               	leaq	-0x18(%rbp), %rax
               	movzwq	(%rax), %rcx
               	movw	%cx, 0x8(%rax)
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	popq	%rdx
               	movslq	%edi, %rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rsi
               	incq	%rsi
               	movl	%esi, (%rax)
               	movslq	%ecx, %rcx
               	imulq	$0x3b9aca00, %rcx, %rax # imm = 0x3B9ACA00
               	leaq	-0x30(%rbp), %rsi
               	movq	%rax, (%rsi)
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	%rsi, 0x8(%rax)
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rsi
               	movq	%rsi, 0x10(%rax)
               	leaq	-0x50(%rbp), %rax
               	leaq	<rip>, %rsi
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movq	0x8(%rsi), %rcx
               	movq	%rcx, 0x8(%rax)
               	movq	0x10(%rsi), %rcx
               	movq	%rcx, 0x10(%rax)
               	movq	0x18(%rsi), %rcx
               	movq	%rcx, 0x18(%rax)
               	popq	%rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %r8
               	incq	%r8
               	movl	%r8d, (%rax)
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rcx, %xmm0
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm0
               	leaq	-0x50(%rbp), %rax
               	movsd	%xmm0, 0x8(%rax,%riz)
               	leaq	-0x50(%rbp), %rax
               	movq	0x8(%rax), %rsi
               	movq	%rsi, 0x10(%rax)
               	leaq	-0x68(%rbp), %rax
               	leaq	<rip>, %rsi
               	pushq	%rcx
               	movq	(%rsi), %rcx
               	movq	%rcx, (%rax)
               	movzbq	0x8(%rsi), %rcx
               	movb	%cl, 0x8(%rax)
               	movzbq	0x9(%rsi), %rcx
               	movb	%cl, 0x9(%rax)
               	movzbq	0xa(%rsi), %rcx
               	movb	%cl, 0xa(%rax)
               	movzbq	0xb(%rsi), %rcx
               	movb	%cl, 0xb(%rax)
               	popq	%rcx
               	leaq	<rip>, %rax
               	movslq	(%rax), %r8
               	incq	%r8
               	movl	%r8d, (%rax)
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rcx, %xmm0
               	movl	$0x40800000, %eax       # imm = 0x40800000
               	movq	%rax, %xmm15
               	divss	%xmm15, %xmm0
               	leaq	-0x68(%rbp), %rax
               	movss	%xmm0, (%rax,%riz)
               	leaq	-0x68(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x68(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	%ecx, 0x8(%rax)
               	movslq	(%rdx), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x67, %eax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x8(%rbp), %rax
               	movsbq	(%rax), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	movsbq	0x1(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	movsbq	0x2(%rax), %rax
               	cmpq	$0x41, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	movsbq	0x5(%rax), %rax
               	cmpq	$0x41, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x8(%rbp), %rax
               	movsbq	0x6(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	movswq	(%rax), %rax
               	cmpq	%rdi, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x18(%rbp), %rax
               	movswq	0x8(%rax), %rax
               	cmpq	%rdi, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rax
               	imulq	$0x3b9aca00, %rdi, %rcx # imm = 0x3B9ACA00
               	cmpq	%rcx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x30(%rbp), %rax
               	movq	0x10(%rax), %rax
               	imulq	$0x3b9aca00, %rdi, %rcx # imm = 0x3B9ACA00
               	cmpq	%rcx, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x50(%rbp), %rax
               	xorq	%rcx, %rcx
               	movsd	(%rax,%riz), %xmm0
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	movl	$0x1, %ecx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x50(%rbp), %rax
               	movsd	0x8(%rax,%riz), %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rdi, %xmm1
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %eax
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x50(%rbp), %rax
               	movsd	0x10(%rax,%riz), %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2sd	%rdi, %xmm1
               	movabsq	$0x4000000000000000, %rax # imm = 0x4000000000000000
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm1
               	ucomisd	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x50(%rbp), %rax
               	movsd	0x18(%rax,%riz), %xmm0
               	xorq	%rax, %rax
               	movq	%rax, %xmm15
               	ucomisd	%xmm15, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x68(%rbp), %rax
               	movss	(%rax,%riz), %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rdi, %xmm1
               	movl	$0x40800000, %eax       # imm = 0x40800000
               	movq	%rax, %xmm15
               	divss	%xmm15, %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x68(%rbp), %rax
               	movss	0x8(%rax,%riz), %xmm0
               	xorps	%xmm1, %xmm1
               	cvtsi2ss	%rdi, %xmm1
               	movl	$0x40800000, %eax       # imm = 0x40800000
               	movq	%rax, %xmm15
               	divss	%xmm15, %xmm1
               	ucomiss	%xmm1, %xmm0
               	setne	%al
               	movzbq	%al, %rax
               	setp	%r10b
               	movzbq	%r10b, %r10
               	orq	%r10, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0xe0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xe0, %rsp
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

<check_deferred>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	movslq	%edi, %rdi
               	leaq	<rip>, %r8
               	xorq	%rax, %rax
               	movl	%eax, (%r8)
               	leaq	-0x48(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	movq	0x20(%rcx), %rdx
               	movq	%rdx, 0x20(%rax)
               	movq	0x28(%rcx), %rdx
               	movq	%rdx, 0x28(%rax)
               	movq	0x30(%rcx), %rdx
               	movq	%rdx, 0x30(%rax)
               	movq	0x38(%rcx), %rdx
               	movq	%rdx, 0x38(%rax)
               	movzbq	0x40(%rcx), %rdx
               	movb	%dl, 0x40(%rax)
               	movzbq	0x41(%rcx), %rdx
               	movb	%dl, 0x41(%rax)
               	movzbq	0x42(%rcx), %rdx
               	movb	%dl, 0x42(%rax)
               	movzbq	0x43(%rcx), %rdx
               	movb	%dl, 0x43(%rax)
               	popq	%rdx
               	leaq	<rip>, %rax
               	movslq	(%rax), %rdx
               	incq	%rdx
               	movl	%edx, (%rax)
               	movl	%edi, %eax
               	leaq	-0x48(%rbp), %rcx
               	movl	%eax, (%rcx)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	%ecx, 0x4(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	%ecx, 0x8(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	%ecx, 0xc(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	%ecx, 0x10(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	%ecx, 0x14(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	%ecx, 0x18(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	%ecx, 0x1c(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	%ecx, 0x20(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	%ecx, 0x24(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	%ecx, 0x28(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	%ecx, 0x2c(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	%ecx, 0x30(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	%ecx, 0x34(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	%ecx, 0x38(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	%ecx, 0x3c(%rax)
               	leaq	-0x48(%rbp), %rax
               	movl	(%rax), %ecx
               	movl	%ecx, 0x40(%rax)
               	movslq	(%r8), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x69, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	jmp	<addr>
               	leaq	-0x48(%rbp), %rdx
               	movl	(%rdx,%rcx,4), %edx
               	movl	%edi, %esi
               	cmpq	%rsi, %rdx
               	jne	<addr>
               	leaq	0x1(%rcx), %rax
               	movslq	%eax, %rcx
               	cmpq	$0x11, %rcx
               	jl	<addr>
               	leaq	-0x70(%rbp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	movq	0x10(%rcx), %rdx
               	movq	%rdx, 0x10(%rax)
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x18(%rax)
               	popq	%rdx
               	movl	$0x1, %ecx
               	leaq	-0x70(%rbp), %rax
               	movl	%ecx, (%rax)
               	movslq	(%r8), %rdx
               	incq	%rdx
               	movl	%edx, (%r8)
               	leaq	-0x70(%rbp), %rax
               	movl	%edi, 0x14(%rax)
               	leaq	-0x70(%rbp), %rax
               	movl	0x14(%rax), %edx
               	movl	%edx, 0x18(%rax)
               	movl	$0x3, %edx
               	leaq	-0x70(%rbp), %rax
               	movl	%edx, 0x1c(%rax)
               	leaq	-0x70(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpq	$0x1, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x70(%rbp), %rax
               	movslq	0x10(%rax), %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %edx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	-0x70(%rbp), %rax
               	movslq	0x14(%rax), %rax
               	cmpq	%rdi, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %eax
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	-0x70(%rbp), %rax
               	movslq	0x18(%rax), %rax
               	cmpq	%rdi, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x70(%rbp), %rax
               	movslq	0x1c(%rax), %rax
               	cmpq	$0x3, %rax
               	setne	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xf, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0xe, %eax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0xb, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	popq	%rbp
               	retq
               	movl	$0x17, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	popq	%rbp
               	retq
               	movl	$0x1f, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	popq	%rbp
               	retq
               	movl	$0xc, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	popq	%rbp
               	retq
               	movl	$0x13, %edi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
