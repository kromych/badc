
by_reference_arguments.x64:	file format elf64-x86-64

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

<write_big>:
               	movq	0x10(%rsp), %rax
               	addq	%rdi, %rax
               	movq	$-0x1, 0x8(%rsp)
               	retq

<keep>:
               	retq

<va_mixed>:
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
               	xorl	%eax, %eax
               	leaq	-0x18(%rbp), %rcx
               	leaq	-0xd0(%rbp), %rdx
               	movl	$0x8, (%rcx)
               	movl	$0x30, 0x4(%rcx)
               	leaq	0x10(%rbp), %r10
               	movq	%r10, 0x8(%rcx)
               	leaq	-0xd0(%rbp), %r10
               	movq	%r10, 0x10(%rcx)
               	movq	%rax, %rcx
               	movslq	-0xd0(%rbp), %rdx
               	cmpl	%edx, %eax
               	jge	<addr>
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
               	movzbq	(%rdx), %rsi
               	movzbq	0x2(%rdx), %rdx
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
               	movl	0x8(%rdi), %edi
               	leaq	-0x18(%rbp), %r8
               	movq	%r8, %r11
               	movq	0x8(%r11), %r10
               	addq	$0x18, 0x8(%r11)
               	movq	%r10, %r8
               	movq	0x8(%r8), %r8
               	imulq	$0x3e8, %rcx, %rcx      # imm = 0x3E8
               	movsbq	%sil, %rsi
               	imulq	$0x64, %rsi, %rsi
               	movslq	%esi, %rsi
               	addq	%rsi, %rcx
               	movsbq	%dl, %rdx
               	imulq	$0xa, %rdx, %rdx
               	movslq	%edx, %rdx
               	addq	%rdx, %rcx
               	movslq	%edi, %rdx
               	addq	%rdx, %rcx
               	addq	%r8, %rcx
               	incq	%rax
               	movslq	-0xd0(%rbp), %rdx
               	cmpl	%edx, %eax
               	jl	<addr>
               	leaq	-0x18(%rbp), %rax
               	movq	%rcx, %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x68, %rsp
               	pushq	%rbx
               	leaq	-0x60(%rbp), %r9
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movq	0x10(%rax), %r10
               	movq	%r10, 0x10(%r9)
               	movl	$0x4, %edi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x6, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x60(%rbp), %rax
               	movq	(%rax), %rcx
               	cmpq	$0x1, %rcx
               	jne	<addr>
               	movq	0x8(%rax), %rcx
               	cmpq	$0x2, %rcx
               	jne	<addr>
               	movq	0x10(%rax), %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x18(%rbp), %r9
               	movq	$0x5, (%r9)
               	movq	$0x6, 0x8(%r9)
               	movq	$0x7, 0x10(%r9)
               	movl	$0x1, %edi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	-0x18(%rbp), %rax
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x30(%rbp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movq	$0x0, 0x10(%r9)
               	movq	$0xa, (%r9)
               	movq	$0xb, 0x8(%r9)
               	movq	$0xc, 0x10(%r9)
               	movl	$0x1, %edi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	cmpq	$0xc, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x60(%rbp), %rcx
               	leaq	-0x48(%rbp), %rdi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdi)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rdi)
               	leaq	-0x30(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rcx), %r10
               	movq	%r10, 0x10(%rax)
               	movq	(%rdi), %rcx
               	imulq	$0xa, %rcx, %rcx
               	movq	0x10(%rax), %rdx
               	leaq	(%rcx,%rdx), %rbx
               	movq	$-0x1, (%rax)
               	movq	$-0x1, (%rdi)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	leaq	-0x30(%rbp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	cmpq	$0xd, %rbx
               	jne	<addr>
               	leaq	-0x60(%rbp), %rax
               	movq	(%rax), %rcx
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x30(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movq	0x10(%rax), %r10
               	movq	%r10, 0x10(%rdi)
               	movq	(%rdi), %rax
               	imulq	$0x64, %rax, %rax
               	movq	0x8(%rdi), %rcx
               	imulq	$0xa, %rcx, %rcx
               	addq	%rcx, %rax
               	movq	0x10(%rdi), %rcx
               	addq	%rcx, %rax
               	incq	%rax
               	leaq	0x8(%rax), %rbx
               	movq	$-0x1, (%rdi)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	callq	*%rax
               	leaq	0x2(%rbx), %rax
               	addq	$0x3, %rax
               	addq	$0x4, %rax
               	addq	$0x5, %rax
               	addq	$0x6, %rax
               	addq	$0x7, %rax
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	leaq	-0x60(%rbp), %r9
               	movq	(%r9), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x38(%rbp), %rax
               	leaq	<rip>, %rcx
               	movzwq	(%rcx), %r10
               	movw	%r10w, (%rax)
               	movzbq	0x2(%rcx), %r10
               	movb	%r10b, 0x2(%rax)
               	leaq	-0x28(%rbp), %rdx
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdx)
               	movl	0x8(%rax), %r10d
               	movl	%r10d, 0x8(%rdx)
               	movl	$0x2, %edi
               	movl	$0x30201, %esi          # imm = 0x30201
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	%rdx, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movzbq	0x8(%r10), %r11
               	movb	%r11b, 0x20(%rsp)
               	movzbq	0x9(%r10), %r11
               	movb	%r11b, 0x21(%rsp)
               	movzbq	0xa(%r10), %r11
               	movb	%r11b, 0x22(%rsp)
               	movzbq	0xb(%r10), %r11
               	movb	%r11b, 0x23(%rsp)
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rsi, %r8
               	movl	0x8(%rdx), %ecx
               	movq	(%rdx), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	addq	$0x40, %rsp
               	cmpq	$0x21b9a, %rax          # imm = 0x21B9A
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%rbx
               	leave
               	retq
               	movsbq	-0x38(%rbp), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movslq	-0x28(%rbp), %rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movq	-0x60(%rbp), %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
