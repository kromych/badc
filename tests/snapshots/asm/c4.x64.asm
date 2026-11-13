
c4.x64:	file format elf64-x86-64

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

<next>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	incq	%rax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rax
               	movq	%rax, <rip> # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	leaq	0x1(%rax), %rdx
               	movq	%rdx, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0xa, %rax
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rcx # <addr>
               	subq	%rcx, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	jae	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rcx
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	(%rax), %rax
               	leaq	(%rax,%rax,4), %rax
               	leaq	(%rcx,%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rcx
               	cmpq	$0x7, %rcx
               	jg	<addr>
               	leaq	<rip>, %rdi
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	jb	<addr>
               	jmp	<addr>
               	cmpq	$0x23, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movsbq	(%rax), %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	incq	%rax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x61, %rax
               	jl	<addr>
               	cmpq	$0x7a, %rax
               	jle	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x41, %rax
               	jl	<addr>
               	cmpq	$0x5a, %rax
               	jle	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x5f, %rax
               	je	<addr>
               	cmpq	$0x30, %rax
               	jl	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x39, %rax
               	jle	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x2f, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rcx
               	cmpl	$0x2f, %ecx
               	jne	<addr>
               	incq	%rax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movsbq	(%rax), %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	incq	%rax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x27, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x22, %rax
               	je	<addr>
               	cmpq	$0x3d, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x2b, %rax
               	je	<addr>
               	cmpq	$0x2d, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x21, %rax
               	je	<addr>
               	cmpq	$0x3c, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x3e, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x7c, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x26, %rax
               	je	<addr>
               	cmpq	$0x5e, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x25, %rax
               	je	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	cmpq	$0x5b, %rax
               	je	<addr>
               	cmpq	$0x3f, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x7e, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x3b, %rax
               	je	<addr>
               	cmpq	$0x7b, %rax
               	je	<addr>
               	cmpq	$0x7d, %rax
               	je	<addr>
               	cmpq	$0x28, %rax
               	je	<addr>
               	cmpq	$0x29, %rax
               	je	<addr>
               	cmpq	$0x5d, %rax
               	je	<addr>
               	cmpq	$0x2c, %rax
               	je	<addr>
               	cmpq	$0x3a, %rax
               	jne	<addr>
               	popq	%rbx
               	leave
               	retq
               	movq	$0x8f, <rip> # <addr>
               	popq	%rbx
               	leave
               	retq
               	movq	$0xa4, <rip> # <addr>
               	popq	%rbx
               	leave
               	retq
               	movq	$0x9f, <rip> # <addr>
               	popq	%rbx
               	leave
               	retq
               	movq	$0xa1, <rip> # <addr>
               	popq	%rbx
               	leave
               	retq
               	movq	$0x93, <rip> # <addr>
               	popq	%rbx
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rcx
               	cmpl	$0x26, %ecx
               	jne	<addr>
               	incq	%rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x91, <rip> # <addr>
               	popq	%rbx
               	leave
               	retq
               	movq	$0x94, <rip> # <addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rcx
               	cmpl	$0x7c, %ecx
               	jne	<addr>
               	incq	%rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x90, <rip> # <addr>
               	popq	%rbx
               	leave
               	retq
               	movq	$0x92, <rip> # <addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rcx
               	cmpl	$0x3d, %ecx
               	jne	<addr>
               	incq	%rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x9a, <rip> # <addr>
               	popq	%rbx
               	leave
               	retq
               	movsbq	(%rax), %rcx
               	cmpl	$0x3e, %ecx
               	jne	<addr>
               	incq	%rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x9c, <rip> # <addr>
               	jmp	<addr>
               	movq	$0x98, <rip> # <addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rcx
               	cmpl	$0x3d, %ecx
               	jne	<addr>
               	incq	%rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x99, <rip> # <addr>
               	popq	%rbx
               	leave
               	retq
               	movsbq	(%rax), %rcx
               	cmpl	$0x3c, %ecx
               	jne	<addr>
               	incq	%rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x9b, <rip> # <addr>
               	jmp	<addr>
               	movq	$0x97, <rip> # <addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rcx
               	cmpl	$0x3d, %ecx
               	jne	<addr>
               	incq	%rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x96, <rip> # <addr>
               	popq	%rbx
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rcx
               	cmpl	$0x2d, %ecx
               	jne	<addr>
               	incq	%rax
               	movq	%rax, <rip> # <addr>
               	movq	$0xa3, <rip> # <addr>
               	popq	%rbx
               	leave
               	retq
               	movq	$0x9e, <rip> # <addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rcx
               	cmpl	$0x2b, %ecx
               	jne	<addr>
               	incq	%rax
               	movq	%rax, <rip> # <addr>
               	movq	$0xa2, <rip> # <addr>
               	popq	%rbx
               	leave
               	retq
               	movq	$0x9d, <rip> # <addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rcx
               	cmpl	$0x3d, %ecx
               	jne	<addr>
               	incq	%rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x95, <rip> # <addr>
               	popq	%rbx
               	leave
               	retq
               	movq	$0x8e, <rip> # <addr>
               	jmp	<addr>
               	movq	<rip>, %rdx # <addr>
               	movq	<rip>, %rax # <addr>
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rax
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rcx, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	incq	%rax
               	movq	%rax, <rip> # <addr>
               	movsbq	-0x1(%rax), %rax
               	movq	%rax, <rip> # <addr>
               	cmpl	$0x5c, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	incq	%rax
               	movq	%rax, <rip> # <addr>
               	movsbq	-0x1(%rax), %rax
               	movq	%rax, <rip> # <addr>
               	cmpl	$0x6e, %eax
               	jne	<addr>
               	movq	$0xa, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x22, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	incq	%rax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rcx # <addr>
               	movb	%cl, -0x1(%rax)
               	movq	<rip>, %rax # <addr>
               	cmpb	$0x0, (%rax)
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	incq	%rax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x22, %rax
               	jne	<addr>
               	movq	%rdx, <rip> # <addr>
               	popq	%rbx
               	leave
               	retq
               	movq	$0x80, <rip> # <addr>
               	jmp	<addr>
               	movq	$0xa0, <rip> # <addr>
               	popq	%rbx
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	subq	$0x30, %rax
               	movq	%rax, <rip> # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rcx
               	cmpl	$0x30, %ecx
               	jl	<addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x39, %eax
               	jg	<addr>
               	movq	<rip>, %rax # <addr>
               	imulq	$0xa, %rax, %rcx
               	movq	<rip>, %rax # <addr>
               	incq	%rax
               	movq	%rax, <rip> # <addr>
               	movsbq	-0x1(%rax), %rax
               	addq	%rcx, %rax
               	subq	$0x30, %rax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rcx
               	cmpl	$0x30, %ecx
               	jge	<addr>
               	movq	$0x80, <rip> # <addr>
               	popq	%rbx
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x78, %eax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x58, %eax
               	jne	<addr>
               	jmp	<addr>
               	cmpq	$0x30, %rax
               	jl	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x39, %rax
               	jle	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x61, %rax
               	jl	<addr>
               	cmpq	$0x66, %rax
               	jle	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x41, %rax
               	jl	<addr>
               	cmpq	$0x46, %rax
               	jg	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rdx
               	andq	$0xf, %rdx
               	addq	%rdx, %rcx
               	movl	$0x9, %edx
               	xorl	%esi, %esi
               	cmpq	$0x41, %rax
               	cmovlq	%rsi, %rdx
               	leaq	(%rcx,%rdx), %rax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	incq	%rax
               	movq	%rax, <rip> # <addr>
               	movsbq	(%rax), %rax
               	movq	%rax, <rip> # <addr>
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x37, %eax
               	jg	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	movq	<rip>, %rax # <addr>
               	incq	%rax
               	movq	%rax, <rip> # <addr>
               	movsbq	-0x1(%rax), %rax
               	addq	%rcx, %rax
               	subq	$0x30, %rax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rcx
               	cmpl	$0x30, %ecx
               	jge	<addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	leaq	-0x1(%rax), %rbx
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x61, %eax
               	jl	<addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x7a, %eax
               	jle	<addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rcx
               	cmpl	$0x41, %ecx
               	jl	<addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x5a, %eax
               	jle	<addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rcx
               	cmpl	$0x30, %ecx
               	jl	<addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x39, %eax
               	jle	<addr>
               	movq	<rip>, %rax # <addr>
               	movsbq	(%rax), %rax
               	cmpl	$0x5f, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	imulq	$0x93, %rax, %rcx
               	movq	<rip>, %rax # <addr>
               	incq	%rax
               	movq	%rax, <rip> # <addr>
               	movsbq	-0x1(%rax), %rax
               	addq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	shlq	$0x6, %rax
               	movq	<rip>, %rcx # <addr>
               	subq	%rbx, %rcx
               	addq	%rcx, %rax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	movq	%rax, <rip> # <addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x48, %rax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x0, (%rax)
               	je	<addr>
               	movq	<rip>, %rcx # <addr>
               	movq	0x8(%rax), %rax
               	cmpq	%rax, %rcx
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	0x10(%rax), %rdi
               	movq	<rip>, %rdx # <addr>
               	subq	%rbx, %rdx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rax
               	movq	%rax, <rip> # <addr>
               	popq	%rbx
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	movq	%rbx, 0x10(%rax)
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, 0x8(%rax)
               	movq	<rip>, %rcx # <addr>
               	movq	$0x85, (%rcx)
               	movq	$0x85, <rip> # <addr>
               	popq	%rbx
               	leave
               	retq
               	popq	%rbx
               	leave
               	retq

<expr>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r13
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	cmpq	$0x80, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x1, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, (%rax)
               	callq	<addr>
               	movq	$0x1, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	%r13, %rax
               	jl	<addr>
               	movq	<rip>, %rbx # <addr>
               	cmpq	$0x8e, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rcx
               	cmpq	$0xa, %rcx
               	je	<addr>
               	movq	(%rax), %rax
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	$0xd, (%rax)
               	movl	$0x8e, %edi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rbx, <rip> # <addr>
               	movl	$0xc, %ecx
               	movl	$0xb, %edx
               	testq	%rbx, %rbx
               	cmovneq	%rdx, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	cmpq	$0x8f, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x4, (%rax)
               	movq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rbx
               	movq	%rbx, <rip> # <addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x3a, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x18, %rax
               	movq	%rax, (%rbx)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x2, (%rax)
               	movq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rbx
               	movq	%rbx, <rip> # <addr>
               	movl	$0x8f, %edi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x90, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x5, (%rax)
               	movq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rbx
               	movq	%rbx, <rip> # <addr>
               	movl	$0x91, %edi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0x1, <rip> # <addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x91, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x4, (%rax)
               	movq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rbx
               	movq	%rbx, <rip> # <addr>
               	movl	$0x92, %edi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0x1, <rip> # <addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x92, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0xd, (%rax)
               	movl	$0x93, %edi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0xe, (%rax)
               	movq	$0x1, <rip> # <addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x93, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0xd, (%rax)
               	movl	$0x94, %edi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0xf, (%rax)
               	movq	$0x1, <rip> # <addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x94, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0xd, (%rax)
               	movl	$0x95, %edi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x10, (%rax)
               	movq	$0x1, <rip> # <addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x95, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0xd, (%rax)
               	movl	$0x97, %edi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x11, (%rax)
               	movq	$0x1, <rip> # <addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x96, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0xd, (%rax)
               	movl	$0x97, %edi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x12, (%rax)
               	movq	$0x1, <rip> # <addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x97, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0xd, (%rax)
               	movl	$0x9b, %edi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x13, (%rax)
               	movq	$0x1, <rip> # <addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x98, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0xd, (%rax)
               	movl	$0x9b, %edi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x14, (%rax)
               	movq	$0x1, <rip> # <addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x99, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0xd, (%rax)
               	movl	$0x9b, %edi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x15, (%rax)
               	movq	$0x1, <rip> # <addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9a, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0xd, (%rax)
               	movl	$0x9b, %edi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x16, (%rax)
               	movq	$0x1, <rip> # <addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9b, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0xd, (%rax)
               	movl	$0x9d, %edi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x17, (%rax)
               	movq	$0x1, <rip> # <addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9c, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0xd, (%rax)
               	movl	$0x9d, %edi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x18, (%rax)
               	movq	$0x1, <rip> # <addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9d, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0xd, (%rax)
               	movl	$0x9f, %edi
               	callq	<addr>
               	movq	%rbx, <rip> # <addr>
               	cmpq	$0x2, %rbx
               	jle	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0xd, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x1, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x8, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x1b, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x19, (%rax)
               	jmp	<addr>
               	cmpq	$0x9e, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0xd, (%rax)
               	movl	$0x9f, %edi
               	callq	<addr>
               	cmpq	$0x2, %rbx
               	jle	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	%rax, %rbx
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x1a, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0xd, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x1, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x8, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x1c, (%rax)
               	movq	$0x1, <rip> # <addr>
               	jmp	<addr>
               	movq	%rbx, <rip> # <addr>
               	cmpq	$0x2, %rbx
               	jle	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0xd, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x1, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x8, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x1b, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x1a, (%rax)
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x1a, (%rax)
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0xd, (%rax)
               	movl	$0xa2, %edi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x1b, (%rax)
               	movq	$0x1, <rip> # <addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0xa0, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0xd, (%rax)
               	movl	$0xa2, %edi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x1c, (%rax)
               	movq	$0x1, <rip> # <addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0xa1, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0xd, (%rax)
               	movl	$0xa2, %edi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x1d, (%rax)
               	movq	$0x1, <rip> # <addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0xa2, %rax
               	je	<addr>
               	cmpq	$0xa3, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rcx
               	cmpq	$0xa, %rcx
               	jne	<addr>
               	movq	$0xd, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0xa, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0xd, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movl	$0x1, %edx
               	movq	%rdx, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movl	$0x8, %esi
               	movq	<rip>, %rdi # <addr>
               	cmpq	$0x2, %rdi
               	cmovgq	%rsi, %rdx
               	movq	%rdx, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movl	$0x19, %edx
               	movl	$0x1a, %esi
               	movq	<rip>, %rdi # <addr>
               	cmpq	$0xa2, %rdi
               	cmovneq	%rsi, %rdx
               	movq	%rdx, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movl	$0xc, %edx
               	movl	$0xb, %esi
               	cmpq	$0x0, <rip> # <addr>
               	cmovneq	%rsi, %rdx
               	movq	%rdx, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0xd, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movl	$0x8, %edx
               	movq	<rip>, %rsi # <addr>
               	cmpq	$0x2, %rsi
               	cmovgq	%rdx, %rcx
               	movq	%rcx, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movl	$0x1a, %ecx
               	movl	$0x19, %edx
               	movq	<rip>, %rsi # <addr>
               	cmpq	$0xa2, %rsi
               	cmovneq	%rdx, %rcx
               	movq	%rcx, (%rax)
               	callq	<addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rcx
               	cmpq	$0x9, %rcx
               	jne	<addr>
               	movq	$0xd, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x9, (%rax)
               	jmp	<addr>
               	cmpq	$0xa4, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0xd, (%rax)
               	movl	$0x8e, %edi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x5d, %rax
               	jne	<addr>
               	callq	<addr>
               	cmpq	$0x2, %rbx
               	jle	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0xd, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x1, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x8, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x1b, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x19, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	leaq	-0x2(%rbx), %rcx
               	movq	%rcx, <rip> # <addr>
               	movl	$0xa, %edx
               	movl	$0x9, %esi
               	testq	%rcx, %rcx
               	cmovneq	%rsi, %rdx
               	jmp	<addr>
               	cmpq	$0x2, %rbx
               	jge	<addr>
               	jmp	<addr>
               	movq	%rdx, (%rax)
               	movq	<rip>, %rax # <addr>
               	cmpq	%r13, %rax
               	jge	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x22, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x1, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, (%rax)
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x22, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x22, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	andq	$-0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x2, <rip> # <addr>
               	jmp	<addr>
               	cmpq	$0x8c, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x28, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	$0x1, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x8a, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x2, %rax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9f, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x29, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rcx
               	movq	%rcx, <rip> # <addr>
               	movl	$0x1, %eax
               	movq	%rax, (%rcx)
               	movq	<rip>, %rcx # <addr>
               	addq	$0x8, %rcx
               	movq	%rcx, <rip> # <addr>
               	movl	$0x8, %edx
               	cmpq	$0x0, <rip> # <addr>
               	cmoveq	%rax, %rdx
               	movq	%rdx, (%rcx)
               	movq	%rax, <rip> # <addr>
               	jmp	<addr>
               	cmpq	$0x86, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	$0x0, <rip> # <addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x85, %rax
               	jne	<addr>
               	movq	<rip>, %r12 # <addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x28, %rax
               	jne	<addr>
               	callq	<addr>
               	xorl	%ebx, %ebx
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x29, %rax
               	je	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0xd, (%rax)
               	incq	%rbx
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x29, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	0x18(%r12), %rax
               	cmpq	$0x82, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	0x28(%r12), %rcx
               	movq	%rcx, (%rax)
               	testq	%rbx, %rbx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x7, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%rbx, (%rax)
               	movq	0x20(%r12), %rax
               	movq	%rax, <rip> # <addr>
               	jmp	<addr>
               	cmpq	$0x81, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x3, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	0x28(%r12), %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	0x18(%r12), %rax
               	cmpq	$0x80, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x1, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	0x28(%r12), %rdx
               	movq	%rdx, (%rax)
               	movq	$0x1, <rip> # <addr>
               	jmp	<addr>
               	movq	0x18(%r12), %rax
               	cmpq	$0x84, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x0, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	0x28(%r12), %rdx
               	subq	%rdx, %rcx
               	movq	%rcx, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	0x20(%r12), %rcx
               	movq	%rcx, <rip> # <addr>
               	movl	$0xa, %edx
               	movl	$0x9, %esi
               	testq	%rcx, %rcx
               	cmovneq	%rsi, %rdx
               	movq	%rdx, (%rax)
               	jmp	<addr>
               	movq	0x18(%r12), %rax
               	cmpq	$0x83, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x1, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	0x28(%r12), %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x28, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x8a, %rax
               	je	<addr>
               	cmpq	$0x86, %rax
               	jne	<addr>
               	movl	$0x1, %ebx
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x8a, %rcx
               	cmovneq	%rax, %rbx
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	callq	<addr>
               	addq	$0x2, %rbx
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9f, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x29, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	movq	%rbx, <rip> # <addr>
               	jmp	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x29, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x1, %rax
               	jle	<addr>
               	subq	$0x2, %rax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movl	$0xa, %ecx
               	movl	$0x9, %edx
               	cmpq	$0x0, <rip> # <addr>
               	cmovneq	%rdx, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x94, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rcx
               	cmpq	$0xa, %rcx
               	je	<addr>
               	movq	(%rax), %rax
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$-0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x2, %rax
               	movq	%rax, <rip> # <addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x21, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0xd, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x1, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x0, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x11, (%rax)
               	movq	$0x1, <rip> # <addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x7e, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0xd, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x1, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$-0x1, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0xf, (%rax)
               	movq	$0x1, <rip> # <addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9d, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	movq	$0x1, <rip> # <addr>
               	jmp	<addr>
               	cmpq	$0x9e, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x1, (%rax)
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x80, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rcx # <addr>
               	negq	%rcx
               	movq	%rcx, (%rax)
               	callq	<addr>
               	movq	$0x1, <rip> # <addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$-0x1, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0xd, (%rax)
               	movl	$0xa2, %edi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x1b, (%rax)
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0xa2, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0xa3, %rax
               	jne	<addr>
               	movq	<rip>, %rbx # <addr>
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rcx
               	cmpq	$0xa, %rcx
               	jne	<addr>
               	movq	$0xd, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0xa, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0xd, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movl	$0x8, %edx
               	movq	<rip>, %rsi # <addr>
               	cmpq	$0x2, %rsi
               	cmovgq	%rdx, %rcx
               	movq	%rcx, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movl	$0x19, %ecx
               	movl	$0x1a, %edx
               	cmpq	$0xa2, %rbx
               	cmovneq	%rdx, %rcx
               	movq	%rcx, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movl	$0xc, %ecx
               	movl	$0xb, %edx
               	cmpq	$0x0, <rip> # <addr>
               	cmovneq	%rdx, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	(%rax), %rcx
               	cmpq	$0x9, %rcx
               	jne	<addr>
               	movq	$0xd, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x9, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdx # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2

<stmt>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	%r12
               	pushq	%rbx
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x89, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x28, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x29, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x4, (%rax)
               	movq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rbx
               	movq	%rbx, <rip> # <addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x87, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x18, %rax
               	movq	%rax, (%rbx)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x2, (%rax)
               	movq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rbx
               	movq	%rbx, <rip> # <addr>
               	callq	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	cmpq	$0x8d, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %r12
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x28, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x29, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x4, (%rax)
               	movq	<rip>, %rax # <addr>
               	leaq	0x8(%rax), %rbx
               	movq	%rbx, <rip> # <addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x2, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	%r12, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x8b, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x3b, %rax
               	je	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x8, (%rax)
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x3b, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x7b, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x7d, %rax
               	je	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x7d, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x3b, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x3b, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	-0x1(%rdi), %r10
               	movq	%r10, 0x38(%rsp)
               	leaq	0x8(%rsi), %r14
               	movq	0x38(%rsp), %rax
               	testq	%rax, %rax
               	jle	<addr>
               	movq	(%r14), %rcx
               	movsbq	(%rcx), %rdx
               	cmpl	$0x2d, %edx
               	jne	<addr>
               	movsbq	0x1(%rcx), %rcx
               	cmpl	$0x73, %ecx
               	jne	<addr>
               	movq	$0x1, <rip> # <addr>
               	leaq	-0x1(%rax), %r10
               	movq	%r10, 0x38(%rsp)
               	addq	$0x8, %r14
               	movq	0x38(%rsp), %rax
               	testq	%rax, %rax
               	jle	<addr>
               	movq	(%r14), %rcx
               	movsbq	(%rcx), %rdx
               	cmpl	$0x2d, %edx
               	jne	<addr>
               	movsbq	0x1(%rcx), %rcx
               	cmpl	$0x64, %ecx
               	jne	<addr>
               	movq	$0x1, <rip> # <addr>
               	leaq	-0x1(%rax), %r10
               	movq	%r10, 0x38(%rsp)
               	addq	$0x8, %r14
               	movq	0x38(%rsp), %rax
               	cmpq	$0x1, %rax
               	jge	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	(%r14), %rdi
               	xorl	%esi, %esi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	testq	%rbx, %rbx
               	jge	<addr>
               	leaq	<rip>, %rdi
               	movq	(%r14), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x40000, %edi          # imm = 0x40000
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x40000, %esi          # imm = 0x40000
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x40000, %edi          # imm = 0x40000
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x40000, %esi          # imm = 0x40000
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x40000, %edi          # imm = 0x40000
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x40000, %esi          # imm = 0x40000
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x40000, %edi          # imm = 0x40000
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r15
               	testq	%r15, %r15
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x40000, %esi          # imm = 0x40000
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	<rip>, %rdi # <addr>
               	xorl	%esi, %esi
               	movl	$0x40000, %edx          # imm = 0x40000
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	<rip>, %rdi # <addr>
               	xorl	%esi, %esi
               	movl	$0x40000, %edx          # imm = 0x40000
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	<rip>, %rdi # <addr>
               	xorl	%esi, %esi
               	movl	$0x40000, %edx          # imm = 0x40000
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	%rax, <rip> # <addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	$0x86, (%rax)
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	$0x87, (%rax)
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	$0x88, (%rax)
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	$0x89, (%rax)
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	$0x8a, (%rax)
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	$0x8b, (%rax)
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	$0x8c, (%rax)
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	$0x8d, (%rax)
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	$0x82, 0x18(%rax)
               	movq	<rip>, %rax # <addr>
               	movq	$0x1, 0x20(%rax)
               	movq	<rip>, %rax # <addr>
               	movq	$0x1e, 0x28(%rax)
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	$0x82, 0x18(%rax)
               	movq	<rip>, %rax # <addr>
               	movq	$0x1, 0x20(%rax)
               	movq	<rip>, %rax # <addr>
               	movq	$0x1f, 0x28(%rax)
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	$0x82, 0x18(%rax)
               	movq	<rip>, %rax # <addr>
               	movq	$0x1, 0x20(%rax)
               	movq	<rip>, %rax # <addr>
               	movq	$0x20, 0x28(%rax)
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	$0x82, 0x18(%rax)
               	movq	<rip>, %rax # <addr>
               	movq	$0x1, 0x20(%rax)
               	movq	<rip>, %rax # <addr>
               	movq	$0x21, 0x28(%rax)
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	$0x82, 0x18(%rax)
               	movq	<rip>, %rax # <addr>
               	movq	$0x1, 0x20(%rax)
               	movq	<rip>, %rax # <addr>
               	movq	$0x22, 0x28(%rax)
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	$0x82, 0x18(%rax)
               	movq	<rip>, %rax # <addr>
               	movq	$0x1, 0x20(%rax)
               	movq	<rip>, %rax # <addr>
               	movq	$0x23, 0x28(%rax)
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	$0x82, 0x18(%rax)
               	movq	<rip>, %rax # <addr>
               	movq	$0x1, 0x20(%rax)
               	movq	<rip>, %rax # <addr>
               	movq	$0x24, 0x28(%rax)
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	$0x82, 0x18(%rax)
               	movq	<rip>, %rax # <addr>
               	movq	$0x1, 0x20(%rax)
               	movq	<rip>, %rax # <addr>
               	movq	$0x25, 0x28(%rax)
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	$0x82, 0x18(%rax)
               	movq	<rip>, %rax # <addr>
               	movq	$0x1, 0x20(%rax)
               	movq	<rip>, %rax # <addr>
               	movq	$0x26, 0x28(%rax)
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	$0x86, (%rax)
               	callq	<addr>
               	movq	<rip>, %r10 # <addr>
               	movq	%r10, 0x30(%rsp)
               	movl	$0x40000, %edi          # imm = 0x40000
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, <rip> # <addr>
               	movq	%rax, <rip> # <addr>
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movl	$0x40000, %esi          # imm = 0x40000
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	<rip>, %rsi # <addr>
               	movl	$0x3ffff, %edx          # imm = 0x3FFFF
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jg	<addr>
               	leaq	<rip>, %rdi
               	movq	%rax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	<rip>, %rcx # <addr>
               	movb	$0x0, (%rcx,%rax)
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	$0x1, <rip> # <addr>
               	callq	<addr>
               	jmp	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %r12d
               	cmpq	$0x8a, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x3b, %rax
               	je	<addr>
               	cmpq	$0x7d, %rax
               	je	<addr>
               	movq	%r12, %rbx
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	callq	<addr>
               	addq	$0x2, %rbx
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9f, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x85, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x0, 0x18(%rax)
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	%rbx, 0x20(%rax)
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x28, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	$0x81, 0x18(%rax)
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	addq	$0x8, %rcx
               	movq	%rcx, 0x28(%rax)
               	callq	<addr>
               	xorl	%r13d, %r13d
               	jmp	<addr>
               	movq	%rbx, %r13
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x29, %rax
               	je	<addr>
               	movl	$0x1, %ebx
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x8a, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	callq	<addr>
               	addq	$0x2, %rbx
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9f, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x85, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	0x18(%rax), %rax
               	cmpq	$0x84, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x30(%rax)
               	movq	<rip>, %rax # <addr>
               	movq	$0x84, 0x18(%rax)
               	movq	<rip>, %rax # <addr>
               	movq	0x20(%rax), %rcx
               	movq	%rcx, 0x38(%rax)
               	movq	<rip>, %rax # <addr>
               	movq	%rbx, 0x20(%rax)
               	movq	<rip>, %rax # <addr>
               	movq	0x28(%rax), %rcx
               	movq	%rcx, 0x40(%rax)
               	movq	<rip>, %rax # <addr>
               	leaq	0x1(%r13), %rbx
               	movq	%r13, 0x28(%rax)
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x86, %rax
               	jne	<addr>
               	callq	<addr>
               	xorl	%ebx, %ebx
               	jmp	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x7b, %rax
               	jne	<addr>
               	incq	%r13
               	movq	%r13, <rip> # <addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x8a, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x86, %rax
               	jne	<addr>
               	movl	$0x1, %r12d
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	cmpq	$0x8a, %rcx
               	cmovneq	%rax, %r12
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x3b, %rax
               	je	<addr>
               	movq	%r12, %rbx
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	callq	<addr>
               	addq	$0x2, %rbx
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9f, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x85, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	0x18(%rax), %rax
               	cmpq	$0x84, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	0x18(%rax), %rcx
               	movq	%rcx, 0x30(%rax)
               	movq	<rip>, %rax # <addr>
               	movq	$0x84, 0x18(%rax)
               	movq	<rip>, %rax # <addr>
               	movq	0x20(%rax), %rcx
               	movq	%rcx, 0x38(%rax)
               	movq	<rip>, %rax # <addr>
               	movq	%rbx, 0x20(%rax)
               	movq	<rip>, %rax # <addr>
               	movq	0x28(%rax), %rcx
               	movq	%rcx, 0x40(%rax)
               	movq	<rip>, %rax # <addr>
               	incq	%r13
               	movq	%r13, 0x28(%rax)
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x3b, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x6, (%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	%r13, %rdx
               	subq	%rcx, %rdx
               	movq	%rdx, (%rax)
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x7d, %rax
               	je	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x7d, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	movq	$0x8, (%rax)
               	movq	<rip>, %rax # <addr>
               	movq	%rax, <rip> # <addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	addq	$0x48, %rax
               	movq	%rax, <rip> # <addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x0, (%rax)
               	je	<addr>
               	movq	0x18(%rax), %rax
               	cmpq	$0x84, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	0x30(%rax), %rcx
               	movq	%rcx, 0x18(%rax)
               	movq	<rip>, %rax # <addr>
               	movq	0x38(%rax), %rcx
               	movq	%rcx, 0x20(%rax)
               	movq	<rip>, %rax # <addr>
               	movq	0x40(%rax), %rcx
               	movq	%rcx, 0x28(%rax)
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	$0x83, 0x18(%rax)
               	movq	<rip>, %rax # <addr>
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, 0x28(%rax)
               	movq	<rip>, %rax # <addr>
               	addq	$0x8, %rax
               	movq	%rax, <rip> # <addr>
               	jmp	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x86, %rax
               	jne	<addr>
               	callq	<addr>
               	xorl	%r12d, %r12d
               	jmp	<addr>
               	cmpq	$0x88, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x7b, %rax
               	je	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x7b, %rax
               	jne	<addr>
               	callq	<addr>
               	xorl	%ebx, %ebx
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x7d, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x85, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x8e, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x80, %rax
               	jne	<addr>
               	movq	<rip>, %r13 # <addr>
               	callq	<addr>
               	movq	<rip>, %rax # <addr>
               	movq	$0x80, 0x18(%rax)
               	movq	<rip>, %rax # <addr>
               	movq	$0x1, 0x20(%rax)
               	movq	<rip>, %rax # <addr>
               	leaq	0x1(%r13), %rbx
               	movq	%r13, 0x28(%rax)
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	movq	%rbx, %r13
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	movq	<rip>, %rdx # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movq	<rip>, %rsi # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	0x30(%rsp), %r10
               	movq	0x28(%r10), %r13
               	testq	%r13, %r13
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x40000, %eax          # imm = 0x40000
               	addq	%rax, %r15
               	leaq	-0x8(%r15), %rax
               	movq	$0x26, (%rax)
               	addq	$-0x8, %rax
               	movq	$0xd, (%rax)
               	leaq	-0x8(%rax), %rcx
               	movq	0x38(%rsp), %r11
               	movq	%r11, (%rcx)
               	addq	$-0x8, %rcx
               	movq	%r14, (%rcx)
               	leaq	-0x8(%rcx), %rbx
               	movq	%rax, (%rbx)
               	xorl	%r10d, %r10d
               	movq	%r10, 0x38(%rsp)
               	addq	$0x8, %r13
               	movq	-0x8(%r13), %r14
               	movq	0x38(%rsp), %r10
               	incq	%r10
               	movq	%r10, 0x38(%rsp)
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	leaq	(%r14,%r14,4), %rcx
               	leaq	(%rax,%rcx), %rdx
               	movq	0x38(%rsp), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	$0x7, %r14
               	jg	<addr>
               	leaq	<rip>, %rdi
               	movq	(%r13), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	testq	%r14, %r14
               	jne	<addr>
               	addq	$0x8, %r13
               	movq	-0x8(%r13), %rax
               	shlq	$0x3, %rax
               	leaq	(%r15,%rax), %r12
               	jmp	<addr>
               	cmpq	$0x1, %r14
               	jne	<addr>
               	addq	$0x8, %r13
               	movq	-0x8(%r13), %r12
               	jmp	<addr>
               	cmpq	$0x2, %r14
               	jne	<addr>
               	movq	(%r13), %r13
               	jmp	<addr>
               	cmpq	$0x3, %r14
               	jne	<addr>
               	addq	$-0x8, %rbx
               	leaq	0x8(%r13), %rax
               	movq	%rax, (%rbx)
               	movq	-0x8(%rax), %r13
               	jmp	<addr>
               	cmpq	$0x4, %r14
               	jne	<addr>
               	testq	%r12, %r12
               	je	<addr>
               	addq	$0x8, %r13
               	jmp	<addr>
               	movq	(%r13), %r13
               	jmp	<addr>
               	cmpq	$0x5, %r14
               	jne	<addr>
               	testq	%r12, %r12
               	je	<addr>
               	movq	(%r13), %r13
               	jmp	<addr>
               	addq	$0x8, %r13
               	jmp	<addr>
               	cmpq	$0x6, %r14
               	jne	<addr>
               	leaq	-0x8(%rbx), %rax
               	movq	%r15, (%rax)
               	addq	$0x8, %r13
               	movq	-0x8(%r13), %rcx
               	shlq	$0x3, %rcx
               	movq	%rax, %rbx
               	subq	%rcx, %rbx
               	movq	%rax, %r15
               	jmp	<addr>
               	cmpq	$0x7, %r14
               	jne	<addr>
               	addq	$0x8, %r13
               	movq	-0x8(%r13), %rax
               	shlq	$0x3, %rax
               	addq	%rax, %rbx
               	jmp	<addr>
               	cmpq	$0x8, %r14
               	jne	<addr>
               	leaq	0x8(%r15), %rax
               	movq	-0x8(%rax), %r15
               	leaq	0x8(%rax), %rbx
               	movq	-0x8(%rbx), %r13
               	jmp	<addr>
               	cmpq	$0x9, %r14
               	jne	<addr>
               	movq	(%r12), %r12
               	jmp	<addr>
               	cmpq	$0xa, %r14
               	jne	<addr>
               	movsbq	(%r12), %r12
               	jmp	<addr>
               	cmpq	$0xb, %r14
               	jne	<addr>
               	addq	$0x8, %rbx
               	movq	-0x8(%rbx), %rax
               	movq	%r12, (%rax)
               	jmp	<addr>
               	cmpq	$0xc, %r14
               	jne	<addr>
               	addq	$0x8, %rbx
               	movq	-0x8(%rbx), %rax
               	movb	%r12b, (%rax)
               	movsbq	%r12b, %r12
               	jmp	<addr>
               	cmpq	$0xd, %r14
               	jne	<addr>
               	addq	$-0x8, %rbx
               	movq	%r12, (%rbx)
               	jmp	<addr>
               	cmpq	$0xe, %r14
               	jne	<addr>
               	addq	$0x8, %rbx
               	movq	-0x8(%rbx), %rax
               	orq	%rax, %r12
               	jmp	<addr>
               	cmpq	$0xf, %r14
               	jne	<addr>
               	addq	$0x8, %rbx
               	movq	-0x8(%rbx), %rax
               	xorq	%rax, %r12
               	jmp	<addr>
               	cmpq	$0x10, %r14
               	jne	<addr>
               	addq	$0x8, %rbx
               	movq	-0x8(%rbx), %rax
               	andq	%rax, %r12
               	jmp	<addr>
               	cmpq	$0x11, %r14
               	jne	<addr>
               	addq	$0x8, %rbx
               	movq	-0x8(%rbx), %rax
               	cmpq	%r12, %rax
               	sete	%r12b
               	movzbq	%r12b, %r12
               	jmp	<addr>
               	cmpq	$0x12, %r14
               	jne	<addr>
               	addq	$0x8, %rbx
               	movq	-0x8(%rbx), %rax
               	cmpq	%r12, %rax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	jmp	<addr>
               	cmpq	$0x13, %r14
               	jne	<addr>
               	addq	$0x8, %rbx
               	movq	-0x8(%rbx), %rax
               	cmpq	%r12, %rax
               	setl	%r12b
               	movzbq	%r12b, %r12
               	jmp	<addr>
               	cmpq	$0x14, %r14
               	jne	<addr>
               	addq	$0x8, %rbx
               	movq	-0x8(%rbx), %rax
               	cmpq	%r12, %rax
               	setg	%r12b
               	movzbq	%r12b, %r12
               	jmp	<addr>
               	cmpq	$0x15, %r14
               	jne	<addr>
               	addq	$0x8, %rbx
               	movq	-0x8(%rbx), %rax
               	cmpq	%r12, %rax
               	setle	%r12b
               	movzbq	%r12b, %r12
               	jmp	<addr>
               	cmpq	$0x16, %r14
               	jne	<addr>
               	addq	$0x8, %rbx
               	movq	-0x8(%rbx), %rax
               	cmpq	%r12, %rax
               	setge	%r12b
               	movzbq	%r12b, %r12
               	jmp	<addr>
               	cmpq	$0x17, %r14
               	jne	<addr>
               	addq	$0x8, %rbx
               	movq	-0x8(%rbx), %rax
               	shlxq	%r12, %rax, %r12
               	jmp	<addr>
               	cmpq	$0x18, %r14
               	jne	<addr>
               	addq	$0x8, %rbx
               	movq	-0x8(%rbx), %rax
               	sarxq	%r12, %rax, %r12
               	jmp	<addr>
               	cmpq	$0x19, %r14
               	jne	<addr>
               	addq	$0x8, %rbx
               	movq	-0x8(%rbx), %rax
               	addq	%rax, %r12
               	jmp	<addr>
               	cmpq	$0x1a, %r14
               	jne	<addr>
               	addq	$0x8, %rbx
               	movq	-0x8(%rbx), %rax
               	negq	%r12
               	addq	%rax, %r12
               	jmp	<addr>
               	cmpq	$0x1b, %r14
               	jne	<addr>
               	addq	$0x8, %rbx
               	movq	-0x8(%rbx), %rax
               	imulq	%rax, %r12
               	jmp	<addr>
               	cmpq	$0x1c, %r14
               	jne	<addr>
               	addq	$0x8, %rbx
               	movq	-0x8(%rbx), %rax
               	cqto
               	idivq	%r12
               	movq	%rax, %r12
               	jmp	<addr>
               	cmpq	$0x1d, %r14
               	jne	<addr>
               	addq	$0x8, %rbx
               	movq	-0x8(%rbx), %rcx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r12
               	movq	%rdx, %r12
               	jmp	<addr>
               	cmpq	$0x1e, %r14
               	jne	<addr>
               	movq	0x8(%rbx), %rdi
               	movq	(%rbx), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	jmp	<addr>
               	cmpq	$0x1f, %r14
               	jne	<addr>
               	movq	0x10(%rbx), %rdi
               	movq	0x8(%rbx), %rsi
               	movq	(%rbx), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	jmp	<addr>
               	cmpq	$0x20, %r14
               	jne	<addr>
               	movq	(%rbx), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	jmp	<addr>
               	cmpq	$0x21, %r14
               	jne	<addr>
               	movq	0x8(%r13), %rax
               	shlq	$0x3, %rax
               	addq	%rbx, %rax
               	movq	-0x8(%rax), %rdi
               	movq	-0x10(%rax), %rsi
               	movq	-0x18(%rax), %rdx
               	movq	-0x20(%rax), %rcx
               	movq	-0x28(%rax), %r8
               	movq	-0x30(%rax), %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	jmp	<addr>
               	cmpq	$0x22, %r14
               	jne	<addr>
               	movq	(%rbx), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	jmp	<addr>
               	cmpq	$0x23, %r14
               	jne	<addr>
               	movq	(%rbx), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	jmp	<addr>
               	cmpq	$0x24, %r14
               	jne	<addr>
               	movq	0x10(%rbx), %rdi
               	movq	0x8(%rbx), %rsi
               	movq	(%rbx), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	jmp	<addr>
               	cmpq	$0x25, %r14
               	jne	<addr>
               	movq	0x10(%rbx), %rdi
               	movq	0x8(%rbx), %rsi
               	movq	(%rbx), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	jmp	<addr>
               	cmpq	$0x26, %r14
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rbx), %rsi
               	movq	0x38(%rsp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	(%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	leaq	<rip>, %rdi
               	movq	%r14, %rsi
               	movq	0x38(%rsp), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
