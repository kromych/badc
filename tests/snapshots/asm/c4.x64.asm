
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
               	pushq	%r12
               	pushq	%rbx
               	jmp	<addr>
               	movq	(%rbx), %rcx
               	incq	%rcx
               	movq	%rcx, (%rbx)
               	movq	(%rax), %rcx
               	cmpq	$0xa, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpq	$0x0, (%rax)
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movq	(%rbx), %rax
               	leaq	<rip>, %r12
               	movq	(%r12), %rcx
               	movq	%rax, %rdx
               	subq	%rcx, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	(%rbx), %rax
               	movq	%rax, (%r12)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rcx
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	(%rax), %rax
               	leaq	(%rax,%rax,4), %rax
               	leaq	(%rcx,%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	(%rbx), %rax
               	movq	(%rax), %rax
               	cmpq	$0x7, %rax
               	jg	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	(%rcx), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	jae	<addr>
               	jmp	<addr>
               	movq	(%rax), %rax
               	cmpq	$0x23, %rax
               	jne	<addr>
               	movq	(%rbx), %rax
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	movq	(%rbx), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	movq	(%rbx), %rax
               	cmpb	$0x0, (%rax)
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	cmpq	$0x61, %rcx
               	jl	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x7a, %rcx
               	jle	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x41, %rcx
               	jl	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x5a, %rcx
               	jle	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x5f, %rcx
               	je	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x30, %rcx
               	jl	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x39, %rcx
               	jle	<addr>
               	movq	(%rax), %rax
               	cmpq	$0x2f, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x2f, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	movq	(%rax), %rcx
               	cmpb	$0x0, (%rcx)
               	je	<addr>
               	movq	(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0xa, %ecx
               	je	<addr>
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	movq	(%rax), %rcx
               	cmpb	$0x0, (%rcx)
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	cmpq	$0x27, %rcx
               	je	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x22, %rcx
               	je	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x3d, %rcx
               	je	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x2b, %rcx
               	je	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x2d, %rcx
               	je	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x21, %rcx
               	je	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x3c, %rcx
               	je	<addr>
               	movq	(%rax), %rax
               	cmpq	$0x3e, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	cmpq	$0x7c, %rcx
               	je	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x26, %rcx
               	je	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x5e, %rcx
               	je	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x25, %rcx
               	je	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x2a, %rcx
               	je	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x5b, %rcx
               	je	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x3f, %rcx
               	je	<addr>
               	movq	(%rax), %rax
               	cmpq	$0x7e, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	cmpq	$0x3b, %rcx
               	je	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x7b, %rcx
               	je	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x7d, %rcx
               	je	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x28, %rcx
               	je	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x29, %rcx
               	je	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x5d, %rcx
               	je	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x2c, %rcx
               	je	<addr>
               	movq	(%rax), %rax
               	cmpq	$0x3a, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rcx
               	movsbq	(%rcx), %rcx
               	movq	%rcx, (%rax)
               	testq	%rcx, %rcx
               	jne	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	$0x8f, (%rax)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	$0xa4, (%rax)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	$0x9f, (%rax)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	$0xa1, (%rax)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	$0x93, (%rax)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x26, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x91, (%rax)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	$0x94, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x7c, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x90, (%rax)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	$0x92, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x3d, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x9a, (%rax)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x3e, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x9c, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	$0x98, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x3d, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x99, (%rax)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x3c, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x9b, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	$0x97, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x3d, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x96, (%rax)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x2d, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	$0xa3, (%rax)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	$0x9e, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x2b, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	$0xa2, (%rax)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	$0x9d, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	cmpl	$0x3d, %ecx
               	jne	<addr>
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x95, (%rax)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	$0x8e, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	jmp	<addr>
               	movq	(%rax), %rcx
               	movsbq	(%rcx), %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rax), %rdx
               	leaq	0x1(%rdx), %rsi
               	movq	%rsi, (%rax)
               	movsbq	(%rdx), %rdx
               	movq	%rdx, (%rcx)
               	cmpl	$0x5c, %edx
               	jne	<addr>
               	movq	(%rax), %rdx
               	leaq	0x1(%rdx), %rsi
               	movq	%rsi, (%rax)
               	movsbq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	cmpl	$0x6e, %eax
               	jne	<addr>
               	movq	$0xa, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x22, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	leaq	0x1(%rcx), %rdx
               	movq	%rdx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movb	%al, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	cmpb	$0x0, (%rcx)
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	cmpq	$0x22, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	%rdi, (%rax)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	movq	$0x80, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	$0xa0, (%rax)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rax
               	subq	$0x30, %rax
               	movq	%rax, (%rcx)
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	movq	(%rax), %rdx
               	movsbq	(%rdx), %rdx
               	cmpl	$0x39, %edx
               	jg	<addr>
               	movq	(%rcx), %rdx
               	imulq	$0xa, %rdx, %rsi
               	movq	(%rax), %rdx
               	leaq	0x1(%rdx), %rdi
               	movq	%rdi, (%rax)
               	movsbq	(%rdx), %rax
               	addq	%rsi, %rax
               	subq	$0x30, %rax
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	movsbq	(%rdx), %rdx
               	cmpl	$0x30, %edx
               	jge	<addr>
               	leaq	<rip>, %rax
               	movq	$0x80, (%rax)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	movsbq	(%rdx), %rdx
               	cmpl	$0x78, %edx
               	je	<addr>
               	movq	(%rax), %rdx
               	movsbq	(%rdx), %rdx
               	cmpl	$0x58, %edx
               	jne	<addr>
               	jmp	<addr>
               	movq	(%rsi), %rcx
               	cmpq	$0x30, %rcx
               	jl	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x39, %rcx
               	jle	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	cmpq	$0x61, %rdx
               	jl	<addr>
               	movq	(%rcx), %rdx
               	cmpq	$0x66, %rdx
               	jle	<addr>
               	movq	(%rcx), %rdx
               	cmpq	$0x41, %rdx
               	jl	<addr>
               	movq	(%rcx), %rcx
               	cmpq	$0x46, %rcx
               	jg	<addr>
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rcx
               	movq	%rcx, %r8
               	shlq	$0x4, %r8
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdi
               	movq	%rdi, %r9
               	andq	$0xf, %r9
               	addq	%r9, %r8
               	cmpq	$0x41, %rdi
               	jl	<addr>
               	movl	$0x9, %ecx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	addq	%r8, %rcx
               	movq	%rcx, (%rdx)
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	movsbq	(%rcx), %rcx
               	movq	%rcx, (%rsi)
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	movq	(%rax), %rdx
               	movsbq	(%rdx), %rdx
               	cmpl	$0x37, %edx
               	jg	<addr>
               	movq	(%rcx), %rdx
               	movq	%rdx, %rdi
               	shlq	$0x3, %rdi
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	leaq	0x1(%rsi), %r8
               	movq	%r8, (%rdx)
               	movsbq	(%rsi), %rdx
               	addq	%rdi, %rdx
               	subq	$0x30, %rdx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rdx
               	movsbq	(%rdx), %rdx
               	cmpl	$0x30, %edx
               	jl	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rax
               	leaq	-0x1(%rax), %rbx
               	movq	(%rcx), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x61, %eax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x7a, %eax
               	jle	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	movsbq	(%rdx), %rdx
               	cmpl	$0x41, %edx
               	jl	<addr>
               	movq	(%rax), %rdx
               	movsbq	(%rdx), %rdx
               	cmpl	$0x5a, %edx
               	jle	<addr>
               	movq	(%rax), %rdx
               	movsbq	(%rdx), %rdx
               	cmpl	$0x30, %edx
               	jl	<addr>
               	movq	(%rax), %rdx
               	movsbq	(%rdx), %rdx
               	cmpl	$0x39, %edx
               	jle	<addr>
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x5f, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	imulq	$0x93, %rdx, %rsi
               	movq	(%rcx), %rdx
               	leaq	0x1(%rdx), %rdi
               	movq	%rdi, (%rcx)
               	movsbq	(%rdx), %rdx
               	addq	%rsi, %rdx
               	movq	%rdx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	shlq	$0x6, %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	subq	%rbx, %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	movq	(%rax), %rcx
               	movq	0x8(%rcx), %rcx
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	movq	(%rax), %rax
               	movq	0x10(%rax), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rdx
               	subq	%rbx, %rdx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x48, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	cmpq	$0x0, (%rcx)
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	%rbx, 0x10(%rcx)
               	movq	(%rax), %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	movq	%rsi, 0x8(%rcx)
               	movq	(%rax), %rcx
               	movq	$0x85, (%rcx)
               	movq	$0x85, (%rdx)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rax)
               	popq	%rbx
               	popq	%r12
               	popq	%rbp
               	retq

<expr>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r13
               	leaq	<rip>, %rax
               	cmpq	$0x0, (%rax)
               	jne	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	movq	(%rax), %rcx
               	cmpq	$0x80, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x1, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rbx
               	movq	(%rax), %rcx
               	cmpq	$0x8e, %rcx
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0xa, %rcx
               	je	<addr>
               	movq	(%rax), %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x9, %rcx
               	jne	<addr>
               	movq	(%rax), %rax
               	movq	$0xd, (%rax)
               	movl	$0x8e, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	%rbx, (%rax)
               	testq	%rbx, %rbx
               	jne	<addr>
               	movl	$0xc, %eax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movl	$0xb, %eax
               	jmp	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x8f, %rcx
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x4, (%rcx)
               	movq	(%rax), %rcx
               	leaq	0x8(%rcx), %r12
               	movq	%r12, (%rax)
               	movl	$0x8e, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3a, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x18, %rax
               	movq	%rax, (%r12)
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0x2, (%rax)
               	movq	(%rbx), %rax
               	leaq	0x8(%rax), %r12
               	movq	%r12, (%rbx)
               	movl	$0x8f, %edi
               	callq	<addr>
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	jmp	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x90, %rcx
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0x5, (%rax)
               	movq	(%rbx), %rax
               	leaq	0x8(%rax), %r12
               	movq	%r12, (%rbx)
               	movl	$0x91, %edi
               	callq	<addr>
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x91, %rcx
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0x4, (%rax)
               	movq	(%rbx), %rax
               	leaq	0x8(%rax), %r12
               	movq	%r12, (%rbx)
               	movl	$0x92, %edi
               	callq	<addr>
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rax), %rax
               	cmpq	$0x92, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0xd, (%rax)
               	movl	$0x93, %edi
               	callq	<addr>
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0xe, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	cmpq	$0x93, %rcx
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0xd, (%rax)
               	movl	$0x94, %edi
               	callq	<addr>
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0xf, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x94, %rcx
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0xd, (%rax)
               	movl	$0x95, %edi
               	callq	<addr>
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0x10, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x95, %rcx
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0xd, (%rax)
               	movl	$0x97, %edi
               	callq	<addr>
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0x11, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x96, %rcx
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0xd, (%rax)
               	movl	$0x97, %edi
               	callq	<addr>
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0x12, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x97, %rcx
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0xd, (%rax)
               	movl	$0x9b, %edi
               	callq	<addr>
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0x13, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rax), %rax
               	cmpq	$0x98, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0xd, (%rax)
               	movl	$0x9b, %edi
               	callq	<addr>
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0x14, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	cmpq	$0x99, %rcx
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0xd, (%rax)
               	movl	$0x9b, %edi
               	callq	<addr>
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0x15, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x9a, %rcx
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0xd, (%rax)
               	movl	$0x9b, %edi
               	callq	<addr>
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0x16, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x9b, %rcx
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0xd, (%rax)
               	movl	$0x9d, %edi
               	callq	<addr>
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0x17, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x9c, %rcx
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0xd, (%rax)
               	movl	$0x9d, %edi
               	callq	<addr>
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0x18, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x9d, %rcx
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0xd, (%rcx)
               	movl	$0x9f, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	%rbx, (%rax)
               	cmpq	$0x2, %rbx
               	jle	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0xd, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x1, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x8, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x1b, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x19, (%rcx)
               	jmp	<addr>
               	movq	(%rax), %rax
               	cmpq	$0x9e, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0xd, (%rcx)
               	movl	$0x9f, %edi
               	callq	<addr>
               	cmpq	$0x2, %rbx
               	jle	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rax
               	cmpq	%rax, %rbx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movq	$0x1a, (%rdx)
               	movq	(%rax), %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movq	$0xd, (%rdx)
               	movq	(%rax), %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movq	$0x1, (%rdx)
               	movq	(%rax), %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movq	$0x8, (%rdx)
               	movq	(%rax), %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	movq	$0x1c, (%rdx)
               	movq	$0x1, (%rcx)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	%rbx, (%rax)
               	cmpq	$0x2, %rbx
               	jle	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0xd, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x1, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x8, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x1b, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x1a, (%rcx)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x1a, (%rcx)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	cmpq	$0x9f, %rcx
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0xd, (%rax)
               	movl	$0xa2, %edi
               	callq	<addr>
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0x1b, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0xa0, %rcx
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0xd, (%rax)
               	movl	$0xa2, %edi
               	callq	<addr>
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0x1c, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0xa1, %rcx
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0xd, (%rax)
               	movl	$0xa2, %edi
               	callq	<addr>
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0x1d, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0xa2, %rcx
               	je	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0xa3, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0xa, %rcx
               	jne	<addr>
               	movq	(%rax), %rcx
               	movq	$0xd, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0xa, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0xd, (%rcx)
               	movq	(%rax), %rcx
               	leaq	0x8(%rcx), %rsi
               	movq	%rsi, (%rax)
               	movl	$0x1, %ecx
               	movq	%rcx, (%rsi)
               	movq	(%rax), %rsi
               	addq	$0x8, %rsi
               	movq	%rsi, (%rax)
               	leaq	<rip>, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x2, %r8
               	jle	<addr>
               	movl	$0x8, %ecx
               	movq	%rcx, (%rsi)
               	movq	(%rax), %rcx
               	leaq	0x8(%rcx), %rsi
               	movq	%rsi, (%rax)
               	leaq	<rip>, %r8
               	movq	(%r8), %rcx
               	cmpq	$0xa2, %rcx
               	jne	<addr>
               	movl	$0x19, %ecx
               	movq	%rcx, (%rsi)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	cmpq	$0x0, (%rdi)
               	jne	<addr>
               	movl	$0xc, %eax
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0xd, (%rcx)
               	movq	(%rax), %rcx
               	leaq	0x8(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movl	$0x1, %ecx
               	movq	%rcx, (%rdx)
               	movq	(%rax), %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rsi
               	cmpq	$0x2, %rsi
               	jle	<addr>
               	movl	$0x8, %ecx
               	movq	%rcx, (%rdx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	(%r8), %rax
               	cmpq	$0xa2, %rax
               	jne	<addr>
               	movl	$0x1a, %eax
               	movq	%rax, (%rcx)
               	callq	<addr>
               	jmp	<addr>
               	movl	$0x19, %eax
               	jmp	<addr>
               	movl	$0xb, %eax
               	jmp	<addr>
               	movl	$0x1a, %ecx
               	jmp	<addr>
               	movq	(%rax), %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x9, %rcx
               	jne	<addr>
               	movq	(%rax), %rcx
               	movq	$0xd, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x9, (%rcx)
               	jmp	<addr>
               	movq	(%rax), %rax
               	cmpq	$0xa4, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0xd, (%rcx)
               	movl	$0x8e, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5d, %rax
               	jne	<addr>
               	callq	<addr>
               	cmpq	$0x2, %rbx
               	jle	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0xd, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x1, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x8, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x1b, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x19, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rdx
               	leaq	-0x2(%rbx), %rax
               	movq	%rax, (%rdx)
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xa, %eax
               	jmp	<addr>
               	movl	$0x9, %eax
               	jmp	<addr>
               	cmpq	$0x2, %rbx
               	jge	<addr>
               	jmp	<addr>
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	cmpq	%r13, %rcx
               	jge	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	movq	(%rax), %rcx
               	cmpq	$0x22, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x1, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	callq	<addr>
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x22, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	andq	$-0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	$0x2, (%rax)
               	jmp	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x8c, %rcx
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x28, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	cmpq	$0x8a, %rcx
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x2, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9f, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x29, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	leaq	0x8(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movl	$0x1, %ecx
               	movq	%rcx, (%rdx)
               	movq	(%rax), %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	leaq	<rip>, %rax
               	cmpq	$0x0, (%rax)
               	jne	<addr>
               	movq	%rcx, %rsi
               	movq	%rsi, (%rdx)
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movl	$0x8, %esi
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	movq	(%rax), %rax
               	cmpq	$0x86, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	$0x0, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	movq	(%rax), %rcx
               	cmpq	$0x85, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r12
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x28, %rax
               	jne	<addr>
               	callq	<addr>
               	xorl	%ebx, %ebx
               	jmp	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0xd, (%rcx)
               	incq	%rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x29, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	0x18(%r12), %rax
               	cmpq	$0x82, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	0x28(%r12), %rax
               	movq	%rax, (%rcx)
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x7, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	%rbx, (%rcx)
               	leaq	<rip>, %rax
               	movq	0x20(%r12), %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	0x18(%r12), %rax
               	cmpq	$0x81, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x3, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	0x28(%r12), %rax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	movq	0x18(%r12), %rax
               	cmpq	$0x80, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x1, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	0x28(%r12), %rax
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	0x18(%r12), %rax
               	cmpq	$0x84, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x0, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	0x28(%r12), %rdx
               	subq	%rdx, %rax
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rdx
               	movq	0x20(%r12), %rax
               	movq	%rax, (%rdx)
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xa, %eax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movl	$0x9, %eax
               	jmp	<addr>
               	movq	0x18(%r12), %rax
               	cmpq	$0x83, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x1, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	0x28(%r12), %rax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	movq	(%rax), %rcx
               	cmpq	$0x28, %rcx
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	cmpq	$0x8a, %rcx
               	je	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x86, %rcx
               	jne	<addr>
               	movq	(%rax), %rax
               	cmpq	$0x8a, %rax
               	jne	<addr>
               	movl	$0x1, %ebx
               	callq	<addr>
               	jmp	<addr>
               	callq	<addr>
               	addq	$0x2, %rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9f, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x29, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	%rbx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	xorl	%ebx, %ebx
               	jmp	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x29, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	movq	(%rax), %rax
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	cmpq	$0x1, %rcx
               	jle	<addr>
               	movq	(%rax), %rcx
               	subq	$0x2, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rcx)
               	cmpq	$0x0, (%rax)
               	jne	<addr>
               	movl	$0xa, %eax
               	movq	%rax, (%rdx)
               	jmp	<addr>
               	movl	$0x9, %eax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	cmpq	$0x94, %rcx
               	jne	<addr>
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0xa, %rcx
               	je	<addr>
               	movq	(%rax), %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x9, %rcx
               	jne	<addr>
               	movq	(%rax), %rcx
               	addq	$-0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x2, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	movq	(%rax), %rcx
               	cmpq	$0x21, %rcx
               	jne	<addr>
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0xd, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x1, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x0, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x11, (%rcx)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x7e, %rcx
               	jne	<addr>
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0xd, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x1, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$-0x1, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0xf, (%rcx)
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x9d, %rcx
               	jne	<addr>
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0x9e, %rcx
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0x1, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x80, %rax
               	jne	<addr>
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	imulq	$-0x1, %rcx, %rcx
               	movq	%rcx, (%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	jmp	<addr>
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$-0x1, (%rax)
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0xd, (%rax)
               	movl	$0xa2, %edi
               	callq	<addr>
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0x1b, (%rax)
               	jmp	<addr>
               	movq	(%rax), %rcx
               	cmpq	$0xa2, %rcx
               	je	<addr>
               	movq	(%rax), %rax
               	cmpq	$0xa3, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rbx
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0xa, %rcx
               	jne	<addr>
               	movq	(%rax), %rcx
               	movq	$0xd, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0xa, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0xd, (%rcx)
               	movq	(%rax), %rcx
               	leaq	0x8(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movl	$0x1, %ecx
               	movq	%rcx, (%rdx)
               	movq	(%rax), %rdx
               	addq	$0x8, %rdx
               	movq	%rdx, (%rax)
               	leaq	<rip>, %rsi
               	movq	(%rsi), %rdi
               	cmpq	$0x2, %rdi
               	jle	<addr>
               	movl	$0x8, %ecx
               	movq	%rcx, (%rdx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	cmpq	$0xa2, %rbx
               	jne	<addr>
               	movl	$0x19, %eax
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	cmpq	$0x0, (%rsi)
               	jne	<addr>
               	movl	$0xc, %eax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movl	$0xb, %eax
               	jmp	<addr>
               	movl	$0x1a, %eax
               	jmp	<addr>
               	movq	(%rax), %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x9, %rcx
               	jne	<addr>
               	movq	(%rax), %rcx
               	movq	$0xd, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x9, (%rcx)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2

<stmt>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	cmpq	$0x89, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x28, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x29, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x4, (%rcx)
               	movq	(%rax), %rcx
               	leaq	0x8(%rcx), %rbx
               	movq	%rbx, (%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x87, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x18, %rcx
               	movq	%rcx, (%rbx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x2, (%rcx)
               	movq	(%rax), %rcx
               	leaq	0x8(%rcx), %rbx
               	movq	%rbx, (%rax)
               	callq	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	movq	(%rbx), %rax
               	cmpq	$0x8d, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	0x8(%rax), %r13
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x28, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x29, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0x4, (%rax)
               	movq	(%rbx), %rax
               	leaq	0x8(%rax), %r12
               	movq	%r12, (%rbx)
               	callq	<addr>
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	$0x2, (%rax)
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	%r13, (%rax)
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	movq	(%rbx), %rax
               	cmpq	$0x8b, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3b, %rax
               	je	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x8, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3b, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2
               	movq	(%rbx), %rax
               	cmpq	$0x7b, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x7d, %rax
               	je	<addr>
               	callq	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x7d, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x3b, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3b, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	leaq	-0x1(%rdi), %r15
               	leaq	0x8(%rsi), %r14
               	testq	%r15, %r15
               	jle	<addr>
               	movq	(%r14), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x2d, %eax
               	jne	<addr>
               	movq	(%r14), %rax
               	movsbq	0x1(%rax), %rax
               	cmpl	$0x73, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	decq	%r15
               	addq	$0x8, %r14
               	testq	%r15, %r15
               	jle	<addr>
               	movq	(%r14), %rax
               	movsbq	(%rax), %rax
               	cmpl	$0x2d, %eax
               	jne	<addr>
               	movq	(%r14), %rax
               	movsbq	0x1(%rax), %rax
               	cmpl	$0x64, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	decq	%r15
               	addq	$0x8, %r14
               	cmpq	$0x1, %r15
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
               	movl	$0x40000, %r10d         # imm = 0x40000
               	movq	%r10, 0x48(%rsp)
               	leaq	<rip>, %r12
               	movq	0x48(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, (%r12)
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	0x48(%rsp), %rsi
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
               	leaq	<rip>, %r12
               	leaq	<rip>, %r13
               	movq	0x48(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, (%r13)
               	movq	%rax, (%r12)
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	0x48(%rsp), %rsi
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
               	leaq	<rip>, %r12
               	movq	0x48(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, (%r12)
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	0x48(%rsp), %rsi
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
               	movq	0x48(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	testq	%r10, %r10
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	0x48(%rsp), %rsi
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
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	xorl	%r12d, %r12d
               	movq	%r12, %rsi
               	movq	0x48(%rsp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	movq	%r12, %rsi
               	movq	0x48(%rsp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	movq	%r12, %rsi
               	movq	0x48(%rsp), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	$0x86, (%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	$0x87, (%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	$0x88, (%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	$0x89, (%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	$0x8a, (%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	$0x8b, (%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	$0x8c, (%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	$0x8d, (%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	$0x82, 0x18(%rcx)
               	movq	(%rax), %rcx
               	movq	$0x1, 0x20(%rcx)
               	movq	(%rax), %rax
               	movq	$0x1e, 0x28(%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	$0x82, 0x18(%rcx)
               	movq	(%rax), %rcx
               	movq	$0x1, 0x20(%rcx)
               	movq	(%rax), %rax
               	movq	$0x1f, 0x28(%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	$0x82, 0x18(%rcx)
               	movq	(%rax), %rcx
               	movq	$0x1, 0x20(%rcx)
               	movq	(%rax), %rax
               	movq	$0x20, 0x28(%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	$0x82, 0x18(%rcx)
               	movq	(%rax), %rcx
               	movq	$0x1, 0x20(%rcx)
               	movq	(%rax), %rax
               	movq	$0x21, 0x28(%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	$0x82, 0x18(%rcx)
               	movq	(%rax), %rcx
               	movq	$0x1, 0x20(%rcx)
               	movq	(%rax), %rax
               	movq	$0x22, 0x28(%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	$0x82, 0x18(%rcx)
               	movq	(%rax), %rcx
               	movq	$0x1, 0x20(%rcx)
               	movq	(%rax), %rax
               	movq	$0x23, 0x28(%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	$0x82, 0x18(%rcx)
               	movq	(%rax), %rcx
               	movq	$0x1, 0x20(%rcx)
               	movq	(%rax), %rax
               	movq	$0x24, 0x28(%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	$0x82, 0x18(%rcx)
               	movq	(%rax), %rcx
               	movq	$0x1, 0x20(%rcx)
               	movq	(%rax), %rax
               	movq	$0x25, 0x28(%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	$0x82, 0x18(%rcx)
               	movq	(%rax), %rcx
               	movq	$0x1, 0x20(%rcx)
               	movq	(%rax), %rax
               	movq	$0x26, 0x28(%rax)
               	callq	<addr>
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	movq	$0x86, (%rax)
               	callq	<addr>
               	movq	(%r12), %r10
               	movq	%r10, 0x38(%rsp)
               	leaq	<rip>, %r12
               	leaq	<rip>, %r13
               	movq	0x48(%rsp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, (%r13)
               	movq	%rax, (%r12)
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	0x48(%rsp), %rsi
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
               	movslq	%ebx, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movl	$0x3ffff, %edx          # imm = 0x3FFFF
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
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movb	$0x0, (%rcx,%rax)
               	movslq	%ebx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	$0x1, (%rax)
               	callq	<addr>
               	jmp	<addr>
               	movl	$0x1, %r12d
               	movq	(%rax), %rax
               	cmpq	$0x8a, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	movq	(%rax), %rax
               	cmpq	$0x7d, %rax
               	je	<addr>
               	movq	%r12, %rbx
               	jmp	<addr>
               	callq	<addr>
               	addq	$0x2, %rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9f, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x85, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, 0x18(%rax)
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rbx, 0x20(%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x28, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	$0x81, 0x18(%rcx)
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, 0x28(%rax)
               	callq	<addr>
               	xorl	%r13d, %r13d
               	jmp	<addr>
               	movl	$0x1, %ebx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x8a, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	callq	<addr>
               	addq	$0x2, %rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9f, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x85, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	0x18(%rax), %rax
               	cmpq	$0x84, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x30(%rcx)
               	movq	(%rax), %rcx
               	movq	$0x84, 0x18(%rcx)
               	movq	(%rax), %rcx
               	movq	0x20(%rcx), %rdx
               	movq	%rdx, 0x38(%rcx)
               	movq	(%rax), %rcx
               	movq	%rbx, 0x20(%rcx)
               	movq	(%rax), %rcx
               	movq	0x28(%rcx), %rdx
               	movq	%rdx, 0x40(%rcx)
               	movq	(%rax), %rax
               	leaq	0x1(%r13), %rbx
               	movq	%r13, 0x28(%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x86, %rax
               	jne	<addr>
               	callq	<addr>
               	xorl	%ebx, %ebx
               	jmp	<addr>
               	movq	%rbx, %r13
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x29, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7b, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	incq	%r13
               	movq	%r13, (%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x8a, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x86, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x8a, %rax
               	jne	<addr>
               	movl	$0x1, %r12d
               	callq	<addr>
               	jmp	<addr>
               	movq	%r12, %rbx
               	jmp	<addr>
               	callq	<addr>
               	addq	$0x2, %rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9f, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x85, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	0x18(%rax), %rax
               	cmpq	$0x84, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x30(%rcx)
               	movq	(%rax), %rcx
               	movq	$0x84, 0x18(%rcx)
               	movq	(%rax), %rcx
               	movq	0x20(%rcx), %rdx
               	movq	%rdx, 0x38(%rcx)
               	movq	(%rax), %rcx
               	movq	%rbx, 0x20(%rcx)
               	movq	(%rax), %rcx
               	movq	0x28(%rcx), %rdx
               	movq	%rdx, 0x40(%rcx)
               	movq	(%rax), %rax
               	incq	%r13
               	movq	%r13, 0x28(%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3b, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	xorl	%r12d, %r12d
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x6, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%r13, %rdx
               	subq	%rax, %rdx
               	movq	%rdx, (%rcx)
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7d, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	$0x8, (%rcx)
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%rax), %rax
               	movq	0x18(%rax), %rax
               	cmpq	$0x84, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	0x30(%rcx), %rdx
               	movq	%rdx, 0x18(%rcx)
               	movq	(%rax), %rcx
               	movq	0x38(%rcx), %rdx
               	movq	%rdx, 0x20(%rcx)
               	movq	(%rax), %rcx
               	movq	0x40(%rcx), %rax
               	movq	%rax, 0x28(%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x48, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	cmpq	$0x0, (%rcx)
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	$0x83, 0x18(%rcx)
               	movq	(%rax), %rcx
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	movq	%rdx, 0x28(%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	cmpq	$0x3b, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	cmpq	$0x86, %rcx
               	jne	<addr>
               	callq	<addr>
               	xorl	%r12d, %r12d
               	jmp	<addr>
               	movq	(%rax), %rax
               	cmpq	$0x88, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7b, %rax
               	je	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7b, %rax
               	jne	<addr>
               	callq	<addr>
               	xorl	%ebx, %ebx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x85, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x8e, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x80, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r13
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	$0x80, 0x18(%rcx)
               	movq	(%rax), %rcx
               	movq	$0x1, 0x20(%rcx)
               	movq	(%rax), %rax
               	leaq	0x1(%r13), %rbx
               	movq	%r13, 0x28(%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	movq	%rbx, %r13
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7d, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	cmpq	$0x0, (%rax)
               	jne	<addr>
               	movq	0x38(%rsp), %r10
               	movq	0x28(%r10), %rax
               	testq	%rax, %rax
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
               	leaq	<rip>, %rcx
               	cmpq	$0x0, (%rcx)
               	je	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movq	0x40(%rsp), %r13
               	addq	0x48(%rsp), %r13
               	leaq	-0x8(%r13), %rcx
               	movq	$0x26, (%rcx)
               	addq	$-0x8, %rcx
               	movq	$0xd, (%rcx)
               	leaq	-0x8(%rcx), %rdx
               	movq	%r15, (%rdx)
               	addq	$-0x8, %rdx
               	movq	%r14, (%rdx)
               	leaq	-0x8(%rdx), %rbx
               	movq	%rcx, (%rbx)
               	xorl	%r15d, %r15d
               	leaq	0x8(%rax), %r14
               	movq	(%rax), %r12
               	incq	%r15
               	leaq	<rip>, %rax
               	cmpq	$0x0, (%rax)
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	leaq	(%r12,%r12,4), %rcx
               	leaq	(%rax,%rcx), %rdx
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	cmpq	$0x7, %r12
               	jg	<addr>
               	leaq	<rip>, %rdi
               	movq	(%r14), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	testq	%r12, %r12
               	jne	<addr>
               	leaq	0x8(%r14), %rax
               	movq	(%r14), %rcx
               	shlq	$0x3, %rcx
               	addq	%r13, %rcx
               	movq	%rcx, -0x8(%rbp)
               	jmp	<addr>
               	cmpq	$0x1, %r12
               	jne	<addr>
               	leaq	0x8(%r14), %rax
               	movq	(%r14), %rcx
               	movq	%rcx, -0x8(%rbp)
               	jmp	<addr>
               	cmpq	$0x2, %r12
               	jne	<addr>
               	movq	(%r14), %rax
               	jmp	<addr>
               	cmpq	$0x3, %r12
               	jne	<addr>
               	addq	$-0x8, %rbx
               	leaq	0x8(%r14), %rax
               	movq	%rax, (%rbx)
               	movq	(%r14), %rax
               	jmp	<addr>
               	cmpq	$0x4, %r12
               	jne	<addr>
               	cmpq	$0x0, -0x8(%rbp)
               	je	<addr>
               	leaq	0x8(%r14), %rax
               	jmp	<addr>
               	movq	(%r14), %rax
               	jmp	<addr>
               	cmpq	$0x5, %r12
               	jne	<addr>
               	cmpq	$0x0, -0x8(%rbp)
               	je	<addr>
               	movq	(%r14), %rax
               	jmp	<addr>
               	leaq	0x8(%r14), %rax
               	jmp	<addr>
               	cmpq	$0x6, %r12
               	jne	<addr>
               	leaq	-0x8(%rbx), %rcx
               	movq	%r13, (%rcx)
               	leaq	0x8(%r14), %rax
               	movq	(%r14), %rdx
               	shlq	$0x3, %rdx
               	movq	%rcx, %rbx
               	subq	%rdx, %rbx
               	movq	%rcx, %r13
               	jmp	<addr>
               	cmpq	$0x7, %r12
               	jne	<addr>
               	leaq	0x8(%r14), %rax
               	movq	(%r14), %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rbx
               	jmp	<addr>
               	cmpq	$0x8, %r12
               	jne	<addr>
               	leaq	0x8(%r13), %rax
               	movq	(%r13), %r13
               	leaq	0x8(%rax), %rbx
               	movq	(%rax), %rax
               	jmp	<addr>
               	cmpq	$0x9, %r12
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	movq	%rax, -0x8(%rbp)
               	movq	%r14, %rax
               	jmp	<addr>
               	cmpq	$0xa, %r12
               	jne	<addr>
               	movq	-0x8(%rbp), %rax
               	movsbq	(%rax), %rax
               	movq	%rax, -0x8(%rbp)
               	jmp	<addr>
               	cmpq	$0xb, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rax
               	movq	(%rbx), %rcx
               	movq	-0x8(%rbp), %rdx
               	movq	%rdx, (%rcx)
               	movq	%rax, %rbx
               	jmp	<addr>
               	cmpq	$0xc, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rcx
               	movq	(%rbx), %rdx
               	movq	-0x8(%rbp), %rax
               	movb	%al, (%rdx)
               	movsbq	%al, %rax
               	movq	%rax, -0x8(%rbp)
               	movq	%rcx, %rbx
               	jmp	<addr>
               	cmpq	$0xd, %r12
               	jne	<addr>
               	addq	$-0x8, %rbx
               	movq	-0x8(%rbp), %rax
               	movq	%rax, (%rbx)
               	jmp	<addr>
               	cmpq	$0xe, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rax
               	movq	(%rbx), %rcx
               	movq	-0x8(%rbp), %rdx
               	orq	%rdx, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	%rax, %rbx
               	jmp	<addr>
               	cmpq	$0xf, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rax
               	movq	(%rbx), %rcx
               	movq	-0x8(%rbp), %rdx
               	xorq	%rdx, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	%rax, %rbx
               	jmp	<addr>
               	cmpq	$0x10, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rax
               	movq	(%rbx), %rcx
               	movq	-0x8(%rbp), %rdx
               	andq	%rdx, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	%rax, %rbx
               	jmp	<addr>
               	cmpq	$0x11, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rax
               	movq	(%rbx), %rcx
               	movq	-0x8(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	sete	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	%rax, %rbx
               	jmp	<addr>
               	cmpq	$0x12, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rax
               	movq	(%rbx), %rcx
               	movq	-0x8(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	setne	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	%rax, %rbx
               	jmp	<addr>
               	cmpq	$0x13, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rax
               	movq	(%rbx), %rcx
               	movq	-0x8(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	setl	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	%rax, %rbx
               	jmp	<addr>
               	cmpq	$0x14, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rax
               	movq	(%rbx), %rcx
               	movq	-0x8(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	setg	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	%rax, %rbx
               	jmp	<addr>
               	cmpq	$0x15, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rax
               	movq	(%rbx), %rcx
               	movq	-0x8(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	setle	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	%rax, %rbx
               	jmp	<addr>
               	cmpq	$0x16, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rax
               	movq	(%rbx), %rcx
               	movq	-0x8(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	setge	%cl
               	movzbq	%cl, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	%rax, %rbx
               	jmp	<addr>
               	cmpq	$0x17, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rax
               	movq	(%rbx), %rdx
               	movq	-0x8(%rbp), %rcx
               	shlq	%cl, %rdx
               	movq	%rdx, -0x8(%rbp)
               	movq	%rax, %rbx
               	jmp	<addr>
               	cmpq	$0x18, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rax
               	movq	(%rbx), %rdx
               	movq	-0x8(%rbp), %rcx
               	sarq	%cl, %rdx
               	movq	%rdx, -0x8(%rbp)
               	movq	%rax, %rbx
               	jmp	<addr>
               	cmpq	$0x19, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rax
               	movq	(%rbx), %rcx
               	movq	-0x8(%rbp), %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	%rax, %rbx
               	jmp	<addr>
               	cmpq	$0x1a, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rax
               	movq	(%rbx), %rcx
               	movq	-0x8(%rbp), %rdx
               	subq	%rdx, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	%rax, %rbx
               	jmp	<addr>
               	cmpq	$0x1b, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rax
               	movq	(%rbx), %rcx
               	movq	-0x8(%rbp), %rdx
               	imulq	%rdx, %rcx
               	movq	%rcx, -0x8(%rbp)
               	movq	%rax, %rbx
               	jmp	<addr>
               	cmpq	$0x1c, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rax
               	movq	(%rbx), %rcx
               	movq	-0x8(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rdx
               	popq	%rax
               	movq	%rcx, -0x8(%rbp)
               	movq	%rax, %rbx
               	jmp	<addr>
               	cmpq	$0x1d, %r12
               	jne	<addr>
               	leaq	0x8(%rbx), %rdx
               	movq	(%rbx), %rcx
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %r10
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %rax
               	popq	%rdx
               	movq	%rax, -0x8(%rbp)
               	movq	%rdx, %rbx
               	jmp	<addr>
               	cmpq	$0x1e, %r12
               	jne	<addr>
               	movq	0x8(%rbx), %rdi
               	movq	(%rbx), %rax
               	movslq	%eax, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, -0x8(%rbp)
               	jmp	<addr>
               	cmpq	$0x1f, %r12
               	jne	<addr>
               	movq	0x10(%rbx), %rax
               	movslq	%eax, %rdi
               	movq	0x8(%rbx), %rsi
               	movq	(%rbx), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, -0x8(%rbp)
               	jmp	<addr>
               	cmpq	$0x20, %r12
               	jne	<addr>
               	movq	(%rbx), %rax
               	movslq	%eax, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, -0x8(%rbp)
               	jmp	<addr>
               	cmpq	$0x21, %r12
               	jne	<addr>
               	movq	0x8(%r14), %rax
               	shlq	$0x3, %rax
               	addq	%rbx, %rax
               	leaq	-0x8(%rax), %rcx
               	movq	(%rcx), %rdi
               	leaq	-0x10(%rax), %rcx
               	movq	(%rcx), %rsi
               	leaq	-0x18(%rax), %rcx
               	movq	(%rcx), %rdx
               	leaq	-0x20(%rax), %rcx
               	movq	(%rcx), %rcx
               	leaq	-0x28(%rax), %r8
               	movq	(%r8), %r8
               	addq	$-0x30, %rax
               	movq	(%rax), %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, -0x8(%rbp)
               	jmp	<addr>
               	cmpq	$0x22, %r12
               	jne	<addr>
               	movq	(%rbx), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, -0x8(%rbp)
               	jmp	<addr>
               	cmpq	$0x23, %r12
               	jne	<addr>
               	movq	(%rbx), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	jmp	<addr>
               	cmpq	$0x24, %r12
               	jne	<addr>
               	movq	0x10(%rbx), %rdi
               	movq	0x8(%rbx), %rax
               	movslq	%eax, %rsi
               	movq	(%rbx), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, -0x8(%rbp)
               	jmp	<addr>
               	cmpq	$0x25, %r12
               	jne	<addr>
               	movq	0x10(%rbx), %rdi
               	movq	0x8(%rbx), %rsi
               	movq	(%rbx), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, -0x8(%rbp)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	jmp	<addr>
               	cmpq	$0x26, %r12
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	(%rbx), %rsi
               	movq	%r15, %rdx
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
               	movq	%r12, %rsi
               	movq	%r15, %rdx
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
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
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
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
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
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
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
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
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
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
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
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
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
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
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
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
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
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
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
